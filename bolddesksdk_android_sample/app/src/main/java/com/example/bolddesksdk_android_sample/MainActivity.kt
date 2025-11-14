package com.example.bolddesksdk_android_sample

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.clickable
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.example.bolddesksdk_android_sample.ui.theme.BolddeskSDK_android_sampleTheme
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.FirebaseApp
import com.google.firebase.messaging.FirebaseMessaging
import com.syncfusion.bolddeskmobileSDK.BoldDeskSupportSDK

var fcm_token = ""

class MyAppMainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Initialize Firebase
        try {
            FirebaseApp.initializeApp(this)
            FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
                if (!task.isSuccessful) {
                    return@OnCompleteListener
                }
                val token = task.result
                fcm_token = token
                // Once Token is generated, Register the token with BoldDesk SDK
                BoldDeskSupportSDK.setFCMRegistrationToken(this, token)
            })
        } catch (e: Exception) {
            Log.d("BoldDeskSample", e.toString())
        }

        enableEdgeToEdge()
        setContent {
            BolddeskSDK_android_sampleTheme {
                // Request Notification Permission
                NotificationPermissionScreen()
                LoginScreen()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
    }

    override fun onResume() {
        super.onResume()
    }
}

@Composable
fun Greeting(name: String, onClick: () -> Unit) {
    Text(
        text = name,
        modifier = Modifier.clickable(onClick = {
            onClick()
        })
    )
}

