package com.dff.cipher

import androidx.annotation.NonNull
import com.dff.cipher.Cipher
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.security.InvalidKeyException
import java.security.NoSuchAlgorithmException
import javax.crypto.BadPaddingException
import javax.crypto.IllegalBlockSizeException
import javax.crypto.NoSuchPaddingException

/** CipherPlugin */
class CipherPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.dff.cipher")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "generateAESKey" ->{
        try {
          result.success(Cipher.generateAESKey(
            call.argument<Int>("keySize")!!.toInt()))
        }catch (e: NoSuchAlgorithmException){
          result.error("100",e.message, e);
        }

      }
      "encrypt" -> {
        try{
          result.success(
            Cipher.encrypt(
              call.argument("plainText")!!,
              call.argument("key")!!,
              call.argument("algorithmName")!!,
              call.argument("transformation")!!,
              call.argument("initializationVector")!!,
            ))
        }catch (e: NoSuchPaddingException){
          result.error("101",e.message, e);
        }catch (e:NoSuchAlgorithmException){
          result.error("100",e.message, e);
        }catch (e: InvalidKeyException){
          result.error("102",e.message, e);
        }catch (e: IllegalBlockSizeException){
          result.error("103",e.message, e);
        }catch (e: BadPaddingException){
          result.error("104",e.message, e);
        }
      }
      "decrypt" ->{
        try{
          result.success(
            Cipher.decrypt(
              call.argument("cipherText")!!,
              call.argument("key")!!,
              call.argument("algorithmName")!!,
              call.argument("transformation")!!,
              call.argument("initializationVector")!!,
            )
          )
        }catch (e: NoSuchPaddingException){
          result.error("101",e.message, e);
        }catch (e:NoSuchAlgorithmException){
          result.error("100",e.message, e);
        }catch (e: InvalidKeyException){
          result.error("102",e.message, e);
        }catch (e: IllegalBlockSizeException){
          result.error("103",e.message, e);
        }catch (e: BadPaddingException){
          result.error("104",e.message, e);
        }
      }
      else -> {
        result.error("105","Method not found","method not found");

      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
