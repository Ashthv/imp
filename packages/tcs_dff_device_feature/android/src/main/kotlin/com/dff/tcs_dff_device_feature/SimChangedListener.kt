package com.dff.tcs_dff_device_feature

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import androidx.annotation.RequiresPermission
import androidx.core.content.ContextCompat.getSystemService
import io.flutter.plugin.common.EventChannel
import org.json.JSONArray
import java.util.concurrent.Executor


@SuppressLint("NewApi")
class SimChangedListener(context: Context) :
    EventChannel.StreamHandler {
    private var subscriptionManager: SubscriptionManager
    private lateinit var subscriptionChangedListener: SubscriptionManager.OnSubscriptionsChangedListener
    private val mainHandler: Handler = Handler(Looper.getMainLooper())

    init {
        subscriptionManager = getSystemService(context, SubscriptionManager::class.java)!!
    }


    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        subscriptionChangedListener = SubscriptionChangedListenerImpl(subscriptionManager) { data ->
            val runnable = Runnable { events?.success(data) }
            mainHandler.post(runnable)
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            subscriptionManager.addOnSubscriptionsChangedListener(
                SubscriptionChangedListenerExecutor(),
                subscriptionChangedListener,
            )
        } else {
            subscriptionManager.addOnSubscriptionsChangedListener(
                subscriptionChangedListener,
            )
        }
    }

    override fun onCancel(arguments: Any?) {
        subscriptionManager.removeOnSubscriptionsChangedListener(subscriptionChangedListener)
    }
}

class SubscriptionChangedListenerExecutor : Executor {

    override fun execute(command: Runnable?) {
        command?.run()
    }
}

@SuppressLint("NewApi")
class SubscriptionChangedListenerImpl(
    private val subscriptionManager: SubscriptionManager,
    val onSubscriptionIdChanged: (data: String) -> Unit,
) :
    SubscriptionManager.OnSubscriptionsChangedListener() {


    @RequiresPermission(value = "android.permission.READ_PHONE_STATE")
    override fun onSubscriptionsChanged() {
        val subscriptionInfoList: List<SubscriptionInfo> =
            subscriptionManager.activeSubscriptionInfoList

        val listOfSim = mutableListOf<Map<String, String>>()

        for (subscriptionInfo in subscriptionInfoList) {
            val subscriptionId = subscriptionInfo.subscriptionId
            val displayName = subscriptionInfo.displayName
            val carrierName = subscriptionInfo.carrierName
            val simSlotIndex = subscriptionInfo.simSlotIndex

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

        onSubscriptionIdChanged(jsonString)
    }
}
