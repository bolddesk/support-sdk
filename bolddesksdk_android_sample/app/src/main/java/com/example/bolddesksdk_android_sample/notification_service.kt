package com.example.bolddesksdk_android_sample

import android.content.Context
import android.util.Log
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.FirebaseApp
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.syncfusion.bolddeskmobileSDK.BoldDeskSupportSDK

// A service to handle incoming FCM messages and new token generation
class NotificationService : FirebaseMessagingService() {

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        if (BoldDeskSupportSDK.isFromMobileSDK(remoteMessage.getData())) {
            // Call this method to handle the incoming push notification
            BoldDeskSupportSDK.handlePushNotifications(
                this,
                remoteMessage.getData(),
                icon = com.syncfusion.bolddeskmobileSDK.R.drawable.bolddesk_logo
            )
        }
    }


    override fun onNewToken(token: String) {
        // If token updated then send the new token to BoldDesk SDK
        super.onNewToken(token)
        fcm_token = token
        BoldDeskSupportSDK.setFCMRegistrationToken(this, token)
    }

}


fun getToken() {
    try {
        FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
            if (!task.isSuccessful) {
                return@OnCompleteListener
            }
            val token = task.result
            fcm_token = token
        })
    } catch (e: Exception) {
        Log.d("Firebase", e.toString())
    }
}