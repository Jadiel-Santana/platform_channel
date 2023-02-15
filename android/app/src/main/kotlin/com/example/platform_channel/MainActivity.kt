package com.example.platform_channel

import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import java.text.SimpleDateFormat
import java.util.*

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity: FlutterActivity() {
    private val BATTERY_CHANNEL = "br.com.platform.channel/battery"
    private val PALINDROME_CHANNEL = "br.com.platform.channel/palindrome"

    private val TIMER_EVENT = "br.com.platform.channel/timer"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PALINDROME_CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "isPalindrome") {
                val word: String? = call.argument("word")
                result.success(word!!.isPalindrome())
            } else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, TIMER_EVENT).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(args: Any?, events: EventChannel.EventSink) {
                    val handler = Handler(Looper.getMainLooper())
                    handler.postDelayed(object : Runnable {
                        @SuppressLint("SimpleDateFormat")
                        override fun run() {
                            val sdf = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                            val currentDate = sdf.format(Date())
                            events.success(currentDate)
                            handler.postDelayed(this, 1000)
                        }
                    }, 0)
                }

                override fun onCancel(arguments: Any?) {
                    println("cancelling listener")
                }
            }
        )
    }


    @TargetApi(VERSION_CODES.ECLAIR)
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            if(intent != null) {
                batteryLevel = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
            } else {
                batteryLevel = -1
            }
        }

        return batteryLevel
    }


    private fun String.isPalindrome(): String{
        return if(this.lowercase() == this.lowercase().reversed())
            "${this.lowercase()} é um palíndromo"
        else
            "${this.lowercase()} NÃO é um palíndromo"
    }
}
