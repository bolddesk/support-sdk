package com.example.bolddesksdk_android_sample

import android.util.Log
import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import java.util.Date

object JWTUtils {
    internal fun generateJwt(userEmail: String, secretKey: String): String {
        try {
            val currentTimeMillis = System.currentTimeMillis()
            val fiveMinutesInMillis = 5 * 60 * 1000 // 5 minutes in milliseconds

            // The algorithm is created using the secret key
            val algorithm = Algorithm.HMAC256(secretKey)

            // Build and sign the JWT token
            return JWT.create()
                .withClaim("email", userEmail)
                .withClaim("name", "")
                .withIssuedAt(Date(currentTimeMillis))
                .withExpiresAt(Date(currentTimeMillis + fiveMinutesInMillis))
                .sign(algorithm)
        } catch (e: Exception) {
            Log.d("JWTUtils", e.toString())
            return ""
        }
    }
}