package com.dff.tcs_dff_device_feature

import android.annotation.SuppressLint
import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.provider.Telephony
import android.telephony.SmsManager
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat.getSystemService
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONArray
import java.util.UUID
import org.json.JSONObject


/** TcsDffDeviceFeaturePlugin */
class TcsDffDeviceFeaturePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var receiver: BroadcastReceiver

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var methodChannel: MethodChannel

    /// The EventChannel that will subscribe and listen to sim change
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var eventChannel: EventChannel

    private lateinit var simChangedListener: SimChangedListener

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.dff.device_feature")
        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "com.dff.device_feature/sim_change")
        simChangedListener = SimChangedListener(context)

        methodChannel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(simChangedListener)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        //switch
        when (call.method) {
            "sendSMS" -> {
                val phoneNumber = call.argument<String>("phoneNumber")
                val message = call.argument<String>("message")
                val simSubscriptionId = call.argument<String>("simSubscriptionId")
                sendSMS(phoneNumber, message, simSubscriptionId, result)
            }

            "registerToListenSMS" -> {
                registerToListenSMS(result)
            }
            "unRegisterToListenSMS" ->{
                unRegisterToListenSMS()
            }
            "getSimInfo" -> {
                processForSimDetails(result)
            }

            "getUniqueDeviceId" -> {
                getUniqueDeviceId(result)
            }

            "getAndroidUUIDId" -> {
                getAndroidUUIDId(result)
            }

            else -> {
                result.notImplemented()
            }
        }

    }

    @SuppressLint("SuspiciousIndentation")
    @RequiresApi(Build.VERSION_CODES.M)
    private fun sendSMS(
        phoneNumber: String?,
        message: String?,
        simSubscriptionId: String?,
        result: MethodChannel.Result
    ) {
        try {

            val smsManager: SmsManager
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {

                if (!simSubscriptionId.isNullOrEmpty()) {
                    if (Build.VERSION.SDK_INT >= 31) {
                        smsManager = context.getSystemService(SmsManager::class.java)
                            .createForSubscriptionId(simSubscriptionId.toInt())
                    } else {
                        smsManager =
                            SmsManager.getSmsManagerForSubscriptionId(simSubscriptionId.toInt())
                    }

                } else {
                    result.error("100", "SIM subscription id is empty", null)
                    return
                }

            } else {
                //if user's SDK is less than 23 then
                //SmsManager will be initialized like this
                smsManager = SmsManager.getDefault()
            }

            // on below line we are sending text message.
            smsManager.sendTextMessage(phoneNumber, null, message, null, null)

        } catch (e: Exception) {
            result.error("SMS", e.message, e.localizedMessage)
        }
    }

    private fun registerToListenSMS(result: MethodChannel.Result) {
         receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {

                if (intent?.action == Telephony.Sms.Intents.SMS_RECEIVED_ACTION) {
                    val bundle: Bundle? = intent.extras
                    bundle?.let {
                        val pdus = it.get("pdus") as Array<*>
                        val messages = arrayOfNulls<android.telephony.SmsMessage>(pdus.size)
                        for (i in messages.indices) {
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                messages[i] = android.telephony.SmsMessage.createFromPdu(
                                    pdus[i] as ByteArray,
                                    it.getString("format")
                                )
                            } else {
                                messages[i] =
                                    android.telephony.SmsMessage.createFromPdu(pdus[i] as ByteArray)
                            }
                        }

                        val smsBody = messages[0]?.messageBody
                        val phoneNumber = messages[0]?.originatingAddress
                        val timeStamp = messages[0]?.timestampMillis
                        val serviceCenterAddress = messages[0]?.serviceCenterAddress
                        val displayAddress = messages[0]?.displayOriginatingAddress
                        val messageStatus = messages[0]?.status

                        val smsDetails =
                            "MessageBody:".plus(smsBody).plus("\nPhoneNumber:").plus(phoneNumber)
                                .plus("\ntimeStamp:").plus(timeStamp)
                                .plus("\nserviceCenterAddress:").plus(serviceCenterAddress)
                                .plus("\ndisplayAddress:").plus(displayAddress)
                                .plus("\nmessageStatus:").plus(messageStatus)
                        val smsJsonObject=JSONObject()
                        smsJsonObject.put("messageBody",smsBody)
                        smsJsonObject.put("phoneNumber",phoneNumber)
                        smsJsonObject.put("timeStamp",timeStamp)
                        smsJsonObject.put("displayAddress",displayAddress)
                        smsJsonObject.put("serviceCenterAddress",serviceCenterAddress)
                        smsJsonObject.put("messageStatus",messageStatus)
                        sendMessageReceivedToFlutter(smsJsonObject.toString())
                   

                    }
                }
            }
        }
        context.registerReceiver(receiver, IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION))
    }

    private fun unRegisterToListenSMS(){
        context.unregisterReceiver(receiver)
    }

    private fun sendMessageReceivedToFlutter(messageDetails: String) {
        if (methodChannel != null) {
            methodChannel.invokeMethod("messageReceived", messageDetails)
        }
    }


    @RequiresApi(Build.VERSION_CODES.M)
    fun processForSimDetails(result: MethodChannel.Result) {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            var subscriptionManager =
                getSystemService(context, SubscriptionManager::class.java) as SubscriptionManager


            val subscriptionInfoList: List<SubscriptionInfo> =
                subscriptionManager.activeSubscriptionInfoList
            val listOfSim = mutableListOf<Map<String, String>>()
            if (subscriptionInfoList.isNotEmpty()) {

                val listOfSim = mutableListOf<Map<String, String>>()

                for (subscriptionInfo in subscriptionInfoList) {
                    var subscriptionId = subscriptionInfo.subscriptionId
                    var displayName = subscriptionInfo.displayName
                    var carrierName = subscriptionInfo.carrierName
                    var simSlotIndex = subscriptionInfo.simSlotIndex

                    listOfSim.add(
                        mapOf(
                            "simSlotIndex" to simSlotIndex.toString(),
                            "subscriptionID" to subscriptionId.toString(),
                            "displayName" to displayName.toString(),
                            "carrierName" to carrierName.toString()
                        )
                    )
                }
                val jsonString = JSONArray(listOfSim).toString()
                result.success(jsonString)
            } else {
                // Empty list
            }
            val jsonString = JSONArray(listOfSim).toString()
            result.success(jsonString)

            subscriptionManager.activeSubscriptionInfoList

        }

    }

    @RequiresApi(Build.VERSION_CODES.M)
    fun getUniqueDeviceId(result: Result) {
        val uniqueDeviceID =
            Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)

        result.success(uniqueDeviceID);

    }

    @RequiresApi(Build.VERSION_CODES.M)
    fun getAndroidUUIDId(result: Result) {
        val uuid = UUID.randomUUID().toString();

        result.success(uuid);
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }
}
