import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_live2d_lipsync_platform_interface.dart';

/// An implementation of [FlutterLive2dLipsyncPlatform] that uses method channels.
class MethodChannelFlutterLive2dLipsync extends FlutterLive2dLipsyncPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_live2d_lipsync');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> initializeModel(String modelPath) async {
    final result = await methodChannel.invokeMethod<bool>('initializeModel', {'modelPath': modelPath});
    return result ?? false;
  }

  @override
  Future<void> updateLipSync(double audioLevel) async {
    await methodChannel.invokeMethod<void>('updateLipSync', {'audioLevel': audioLevel});
  }

  @override
  Future<void> renderModel() async {
    await methodChannel.invokeMethod<void>('renderModel');
  }

  @override
  Future<void> setParameter(String parameterId, double value) async {
    await methodChannel.invokeMethod<void>('setParameter', {
      'parameterId': parameterId,
      'value': value,
    });
  }
}