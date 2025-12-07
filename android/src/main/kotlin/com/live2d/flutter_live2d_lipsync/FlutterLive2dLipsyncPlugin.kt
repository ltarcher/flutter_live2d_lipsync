package com.live2d.flutter_live2d_lipsync

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterLive2dLipsyncPlugin */
class FlutterLive2dLipsyncPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var live2DManager: Live2DManager? = null
  private var context: Context? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_live2d_lipsync")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
    live2DManager = Live2DManager.getInstance()
    live2DManager?.initializeFramework(context!!)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "initializeModel" -> {
        val modelPath = call.argument<String>("modelPath")
        if (modelPath != null) {
          val success = live2DManager?.loadModel(modelPath) ?: false
          result.success(success)
        } else {
          result.error("INVALID_ARGUMENT", "Model path is null", null)
        }
      }
      "updateLipSync" -> {
        val audioLevel = call.argument<Double>("audioLevel")
        if (audioLevel != null) {
          live2DManager?.updateLipSync(audioLevel.toFloat())
          result.success(null)
        } else {
          result.error("INVALID_ARGUMENT", "Audio level is null", null)
        }
      }
      "renderModel" -> {
        live2DManager?.renderModel()
        result.success(null)
      }
      "setParameter" -> {
        val parameterId = call.argument<String>("parameterId")
        val value = call.argument<Double>("value")
        if (parameterId != null && value != null) {
          live2DManager?.setParameter(parameterId, value.toFloat())
          result.success(null)
        } else {
          result.error("INVALID_ARGUMENT", "Parameter ID or value is null", null)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    context = null
    live2DManager = null
  }
}