package com.dff.security

import androidx.annotation.NonNull
import android.annotation.SuppressLint

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkRequest
import android.net.NetworkCapabilities
import android.net.wifi.ScanResult
import android.net.wifi.WifiInfo
import android.net.wifi.WifiManager
import android.os.Build
import androidx.core.content.ContextCompat
import androidx.core.content.ContextCompat.getSystemService
import com.google.gson.Gson
import android.provider.Settings
import android.provider.Settings.NameValueTable
import android.provider.Settings.Global

/** TcsDffSecurityPlugin */
class TcsDffSecurityPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var context: Context
//  private lateinit var activity: Activity

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.dff.security")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    //switch
    when (call.method) {
      "getConnectedWifiInfo" -> {
        getConnectedWifiInfo(context, result)
      }

      "checkVulnerableApps" -> {
         val vulnerableApps = call.arguments as List<String>
         result.success(checkVulnerableApps(vulnerableApps))
      }

      "isUSBDebuggingEnabled" -> {
         isUSBDebuggingEnabled(context, result)
      }

      "isDeveloperModeEnabled" -> {
         isDeveloperModeEnabled(context, result)
      }

      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  @SuppressLint("MissingPermission")
  fun getConnectedWifiInfo(context: Context, result:MethodChannel.Result){
    val connManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    val networkCapabilities = connManager.getNetworkCapabilities(connManager.activeNetwork)
    var wifiSecurityType = ""
    var jsonString = ""
         if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
          val wifiInfo: WifiInfo? = networkCapabilities?.transportInfo as WifiInfo
          val wifiSecurityTypeValue = wifiInfo?.currentSecurityType ?: -1
            wifiSecurityType = getSecurityTypeFromWifiInfo(wifiSecurityTypeValue)
          var nativeWifiInfoFor31 = NativeWifiInfo(wifiInfo?.ssid, wifiInfo?.bssid, wifiInfo?.macAddress,
                wifiSecurityType, wifiInfo?.frequency, null, wifiInfo?.networkId)
            jsonString = Gson().toJson(nativeWifiInfoFor31)
        } else {
            val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
            val wifiInfoFor30AndBelow = wifiManager.connectionInfo
            val networkList: List<ScanResult> = wifiManager.scanResults
            if (networkList != null) {
              var ssid = wifiInfoFor30AndBelow.ssid.substring( 1, wifiInfoFor30AndBelow.ssid.length - 1 ) 
              for (network in networkList) {
                if(network.SSID.equals(ssid)){
                  wifiSecurityType = network.capabilities.toString()
                  var nativeWifiInfoFor30AndBelow = NativeWifiInfo(ssid, network.BSSID, wifiInfoFor30AndBelow.getMacAddress(),
                      wifiSecurityType, network.frequency, network.level, null)
                  jsonString = Gson().toJson(nativeWifiInfoFor30AndBelow)
                  break
                }
              }
            }
          }
        result.success(jsonString)
  }

  private fun getSecurityTypeFromWifiInfo(value: Int):String{
        return when(value){
            WifiInfo.SECURITY_TYPE_OPEN -> "Open"
            WifiInfo.SECURITY_TYPE_UNKNOWN -> "Unknown"
            WifiInfo.SECURITY_TYPE_EAP -> "EAP"
            WifiInfo.SECURITY_TYPE_PSK -> "PSK"
            WifiInfo.SECURITY_TYPE_WEP -> "WEP"
            WifiInfo.SECURITY_TYPE_SAE -> "SAE"
            WifiInfo.SECURITY_TYPE_OWE -> "OWE"
            else -> "Unknown"
        }
    }

  private fun checkVulnerableApps(vulnerableApps: List<String>): Boolean {
      var isVulnerableApp = false

      for (packageName in vulnerableApps) {
          isVulnerableApp = isAppInstalled(packageName)

          if (isVulnerableApp) break
      }

      return isVulnerableApp
  }

    private fun isUSBDebuggingEnabled(context: Context, result: MethodChannel.Result) {
        if (Settings.Global.getInt(
                context.getContentResolver(),
                Settings.Global.ADB_ENABLED,
                0
            ) === 1
        ) {
            // debugging enabled
            result.success(true)
        } else {
            //debugging is not enabled
            result.success(false)
        }
    }

    private fun isDeveloperModeEnabled(context: Context, result: MethodChannel.Result) {
        if (Settings.Global.getInt(
                context.getContentResolver(),
                Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
                0
            ) === 1
        ) {
            // dev mode enabled
            result.success(true)
        } else {
            //dev mode not enabled
            result.success(false)
        }
    }

  private fun isAppInstalled(packageName: String): Boolean {
    try {
      context.packageManager.getPackageInfo(packageName, 0);
      return true;
    } catch (e: PackageManager.NameNotFoundException) {
      return false;
    }
  }

}

class NativeWifiInfo(
  public val ssid: String?,
  public val bssid: String?,
  public val macAddress: String?,
  public val securityType: String?,
  public val frequency: Int?,
  public val level: Int?,
  public val netWorkId: Int?
  )
