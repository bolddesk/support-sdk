import 'dart:io';

import 'package:bolddesk_support_sdk/bolddesk_support_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma("vm:entry-point")
class NotificationService {
  // Initialize FirebaseMessingService to listen Messages
  static firebaseMessagingInitialize() {
    onBackgroundMessage();
    onMessage();

    if (Platform.isIOS) {
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        BoldDeskSupportSDK.handleIOSNotification(message.data);
      });
    }
  }

  // this used to receive message when app in background
  @pragma("vm:entry-point")
  static Future<void> backgroundHandler(RemoteMessage message) async {
    // Icon should be Drawable source
    if (Platform.isAndroid) {
      BoldDeskSupportSDK.handleAndroidNotification(message.data, "sample_app_logo");
    }
  }

  static void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  static Future<void> getFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    BoldDeskSupportSDK.setFCMRegistrationToken(fcmToken ?? "");
  }

  static onMessage() {
    FirebaseMessaging.onMessage.listen((message) async {
      if (Platform.isAndroid) {
        // Icon should be Drawable source
        BoldDeskSupportSDK.handleAndroidNotification(message.data, "sample_app_logo");
      }
    });
  }
}
