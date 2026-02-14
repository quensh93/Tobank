package com.gardeshpay.secure_plugin

import android.app.Activity
import android.content.Context
import android.os.Build
import com.google.gson.Gson
import com.tom_roush.pdfbox.android.PDFBoxResourceLoader

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SecurePlugin */
class SecurePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "secure_plugin")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${Build.VERSION.RELEASE}")
      }

      "isEnroll" -> {
        val phoneNumber = call.argument<String>("phoneNumber")
        val responseData = SecurityImplementation.isEnroll(phoneNumber!!)
        val gson = Gson()
        val responseDataString = gson.toJson(responseData)
        result.success(responseDataString)
      }

      "generateKeys" -> {
        val phoneNumber = call.argument<String>("phoneNumber")
        val nameEnglish = call.argument<String>("nameEnglish")
        val responseData =
          SecurityImplementation.generateKey(context, phoneNumber!!, nameEnglish!!)
        val gson = Gson()
        val responseDataString = gson.toJson(responseData)
        result.success(responseDataString)
      }

      "signText" -> {
        val plainText = call.argument<String>("plainText")
        val phoneNumber = call.argument<String>("phoneNumber")
        SecurityImplementation.signText(
          plainText!!,
          activity,
          context,
          phoneNumber!!,
          object : SignDataListener {
              override fun signedData(responseData: ResponseDataModel) {
              val gson = Gson()
              val responseDataString = gson.toJson(responseData)
              result.success(responseDataString)
            }
          })
      }

      "signBytes" -> {
        val bytesData = call.argument<ByteArray>("bytesData")
        val phoneNumber = call.argument<String>("phoneNumber")
        SecurityImplementation.signBytes(
          bytesData!!,
          activity,
          context,
          phoneNumber!!,
          object : SignDataListener {
              override fun signedData(responseData: ResponseDataModel) {
              val gson = Gson()
              val responseDataString = gson.toJson(responseData)
              result.success(responseDataString)
            }
          })
      }

      "getPublicKey" -> {
        val phoneNumber = call.argument<String>("phoneNumber")
        val responseData = SecurityImplementation.getPublicKey(phoneNumber!!)
        val gson = Gson()
        val responseDataString = gson.toJson(responseData)
        result.success(responseDataString)
      }

      "removeKey" -> {
        val phoneNumber = call.argument<String>("phoneNumber")
        val responseData = SecurityImplementation.removeKey(phoneNumber!!)
        val gson = Gson()
        val responseDataString = gson.toJson(responseData)
        result.success(responseDataString)
      }

      "verifyData" -> {
        val plainText = call.argument<String>("plainText")
        val signedText = call.argument<String>("signedText")
        val phoneNumber = call.argument<String>("phoneNumber")
        val responseData =
          SecurityImplementation.verifyData(plainText!!, signedText!!, phoneNumber!!)
        val gson = Gson()
        val responseDataString = gson.toJson(responseData)
        result.success(responseDataString)
      }

      "verifyBytes" -> {
        val bytesData = call.argument<ByteArray>("bytesData")
        val signedText = call.argument<String>("signedText")
        val phoneNumber = call.argument<String>("phoneNumber")
        val responseData =
          SecurityImplementation.verifyBytes(bytesData!!, signedText!!, phoneNumber!!)
        val gson = Gson()
        val responseDataString = gson.toJson(responseData)
        result.success(responseDataString)
      }

      "newSignPdf" -> {
        var isSigned = false
        PDFBoxResourceLoader.init(context)
        val phoneNumber = call.argument<String>("phoneNumber")
        val pdfBase64 = call.argument<String>("pdfBase64")
        val signatureBase64 = call.argument<String>("signatureBase64")
        val cert = call.argument<String>("cert")
        val name = call.argument<String>("name")
        val location = call.argument<String>("location")
        val reason = call.argument<String>("reason")
        val signatureX = call.argument<Int>("signatureX")
        val signatureY = call.argument<Int>("signatureY")
        val signatureWidth = call.argument<Int>("signatureWidth")
        val signatureHeight = call.argument<Int>("signatureHeight")
        val signaturePage = call.argument<Int>("signaturePage")
        val signatureNameFamily = call.argument<String>("signatureNameFamily")
        SecurityImplementation.newSignPdf(
          phoneNumber!!,
          pdfBase64!!,
          signatureBase64!!,
          signatureX!!,
          signatureY!!,
          signatureWidth!!,
          signatureHeight!!,
          signaturePage!!,
          cert!!,
          name,
          location,
          reason,
          signatureNameFamily,
          activity,
          context,
          object : SignPdfListener {
              override fun signedPdf(responseData: ResponseDataModel) {
              val gson = Gson()
              val responseDataString = gson.toJson(responseData)
              if (!isSigned) {
                result.success(responseDataString)
                isSigned = true
              }
            }
          }
        )
      }

      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
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
