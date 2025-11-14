//
//  bolddeskSDK_iOS_sampleApp.swift
//  bolddeskSDK_iOS_sample
//
//  Created by Balayogi Vellaikannu on 10/21/25.
//

import SwiftUI
import BolddeskSupportSDK

@main
struct bolddeskSDK_iOS_sampleApp: App {
    // Connects the custom AppDelegate class for handling push notifications and app lifecycle.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            Main()
            // Listens for a notification named "NotificationTapped" sent from AppDelegate.
            // Triggered when the user taps on a push notification.
            // Passes the notification payload to BolddeskSDK for navigation or handling.
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NotificationTapped"))) { notification in
                    if let data = notification.object as? [AnyHashable: Any] {
                        BolddeskSDK.processRemoteNotification(userInfo: data)
                    }
                }
        }
    }
}
