import messaging, { firebase } from '@react-native-firebase/messaging';
import { PermissionsAndroid, Platform } from 'react-native';
import { BoldDeskSupportSDK } from 'bd-support-sdk-react-native';
import { ToastAndroid } from 'react-native';

async function requestUserPermission() {
  if (Platform.OS === 'android') {
    const granted = await PermissionsAndroid.request(
      PermissionsAndroid.PERMISSIONS.POST_NOTIFICATIONS,
    );
    if (granted === PermissionsAndroid.RESULTS.GRANTED) {
      console.log('Android Notification permission granted');
    } else {
      console.log('Android Notification permission denied');
    }
  } else if (Platform.OS === 'ios') {
    const authStatus = await messaging().requestPermission();
    const enabled =
      authStatus === messaging.AuthorizationStatus.AUTHORIZED ||
      authStatus === messaging.AuthorizationStatus.PROVISIONAL;

    if (enabled) {
      console.log('iOS Authorization status:', authStatus);
    } else {
      console.log('iOS Authorization status denied:', authStatus);
    }
  }
}

async function getDeviceToken() {
  let fcmToken = await messaging().getToken();
  if (fcmToken) {
    ToastAndroid.show(`Device token - ${fcmToken}`, ToastAndroid.SHORT);
    console.log('FCM Device Token:', fcmToken);
    // You should save this token to your backend server for sending notifications
    BoldDeskSupportSDK.setFCMRegistrationToken(fcmToken)
  } else {
    console.log('Failed to get FCM token');
  }
}

function setupForegroundNotificationHandler() {
  messaging().onMessage(async remoteMessage => {
    console.log('Foreground Message:', remoteMessage);
    BoldDeskSupportSDK.showNotification("sample_app_logo", remoteMessage.data)
  });
}

export async function initializeNotifications() {
  try {

    // Request Notification permission
    await requestUserPermission()

    // Setup handlers
    if (Platform.OS === 'ios') {
      setupIosNotificationTapHandler();
    } else {
      setupForegroundNotificationHandler()
    }

    // Get token
    const token = await getDeviceToken()

    console.log("[FCM] Notifications initialized successfully and Here's the Token", token)
    return token
  } catch (error) {
    console.error("[FCM] Error initializing notifications:", error)
  }
}


export async function setupIosNotificationTapHandler() {
  // Handle notification tap when app is in background
  messaging().onNotificationOpenedApp(async remoteMessage => {
    await new Promise<void>(resolve => setTimeout(resolve, 500));
    if (remoteMessage?.data) {
      BoldDeskSupportSDK.handleNotification(remoteMessage.data);
    }
  });
  // Handle notification tap when app was terminated
  const initialNotification = await messaging().getInitialNotification();
  if (initialNotification?.data) {
    await new Promise<void>(resolve => setTimeout(resolve, 500));
    BoldDeskSupportSDK.handleNotification(initialNotification.data);
  }
}
