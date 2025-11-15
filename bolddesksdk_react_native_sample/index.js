/**
 * @format
 */

import { AppRegistry } from 'react-native';
import App from './App';
import { name as appName } from './app.json';
import messaging from '@react-native-firebase/messaging';
import { BoldDeskSupportSDK} from 'bolddesk_support_sdk';


messaging().setBackgroundMessageHandler(async remoteMessage => {
  try {
    BoldDeskSupportSDK.showNotification("sample_app_logo",remoteMessage.data)
    console.log('[FCM Background Handler] Notification shown successfully');
  } catch (error) {
    console.error('[FCM Background Handler] Error showing notification:', error);
  }
});

AppRegistry.registerComponent(appName, () => App);
