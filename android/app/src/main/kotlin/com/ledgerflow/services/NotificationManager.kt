package com.ledgerflow.services

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.core.app.NotificationCompat
import com.ledgerflow.R

class NotificationManager private constructor(private val context: Context) {
    private val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    
    companion object {
        private const val CHANNEL_ID = "ledger_flow_notifications"
        private const val CHANNEL_NAME = "Ledger Flow"
        
        @Volatile
        private var instance: NotificationManager? = null
        
        fun getInstance(context: Context) =
            instance ?: synchronized(this) {
                instance ?: NotificationManager(context).also { instance = it }
            }
    }
    
    init {
        createNotificationChannel()
    }
    
    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                CHANNEL_NAME,
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                description = "Notifications for Ledger Flow transactions and updates"
                enableVibration(true)
                enableLights(true)
            }
            notificationManager.createNotificationChannel(channel)
        }
    }
    
    fun sendNotification(
        title: String,
        message: String,
        notificationId: Int = System.currentTimeMillis().toInt()
    ) {
        val notification = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_notification)
            .setContentTitle(title)
            .setContentText(message)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setAutoCancel(true)
            .build()
        
        notificationManager.notify(notificationId, notification)
    }
    
    fun sendDataUploadNotification(itemName: String) {
        sendNotification(
            title = "Data Uploaded",
            message = "$itemName has been successfully uploaded."
        )
    }
    
    fun sendTransactionNotification(type: String, amount: Double, currency: String) {
        val title = if (type == "income") "Income Recorded" else "Expense Recorded"
        val message = "$currency $amount has been recorded."
        sendNotification(title, message)
    }
    
    fun sendInventoryNotification(itemName: String, quantity: Int) {
        sendNotification(
            title = "Inventory Updated",
            message = "$itemName quantity is now $quantity."
        )
    }
}
