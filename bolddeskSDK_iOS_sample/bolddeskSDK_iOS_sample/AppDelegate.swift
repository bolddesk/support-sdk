import UIKit
import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications
import BolddeskSupportSDK

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    // Called when the app finishes launching.
    // Configures Firebase, registers for notifications, and handles launch from a remote notification.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // Configure Firebase.
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        // Request permission to show alerts, badges, and sounds.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        
        // Register for push notifications.
        application.registerForRemoteNotifications()

        // Handle notification if app was launched from a terminated state via push.
        if let remoteNotification = launchOptions?[.remoteNotification] as? [AnyHashable: Any] {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                BolddeskSDK.processRemoteNotification(userInfo: remoteNotification)
            }
        }
        return true
    }

    // Called when the app successfully registers with APNs and receives the device token.
    // Links the APNs token with Firebase Messaging to enable FCM.
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        
        // Retrieve the FCM token associated with this device.
        Messaging.messaging().token { token, _ in
            if let token = token { print("FCM Token:", token) }
        }
    }

    // Called when a new FCM registration token is generated or updated.
    // You can send this token to your server or SDK.
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcmToken = fcmToken { print("Updated FCM Token:", fcmToken) }
    }

    // Called when a notification is received while the app is in the foreground.
    // Displays the notification banner, sound, and badge even if app is active.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }

    // Called when the user taps on a notification.
    // Posts the notification data so the app can respond (e.g., navigate to a detail screen).
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        NotificationCenter.default.post(name: Notification.Name("NotificationTapped"),
                                        object: response.notification.request.content.userInfo)
        completionHandler()
    }
}
