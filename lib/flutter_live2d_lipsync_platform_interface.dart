import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_live2d_lipsync_method_channel.dart';

abstract class FlutterLive2dLipsyncPlatform extends PlatformInterface {
  /// Constructs a FlutterLive2dLipsyncPlatform.
  FlutterLive2dLipsyncPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLive2dLipsyncPlatform _instance = MethodChannelFlutterLive2dLipsync();

  /// The default instance of [FlutterLive2dLipsyncPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLive2dLipsync].
  static FlutterLive2dLipsyncPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterLive2dLipsyncPlatform] when
  /// they register themselves.
  static set instance(FlutterLive2dLipsyncPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// 初始化Live2D模型
  Future<bool> initializeModel(String modelPath) {
    throw UnimplementedError('initializeModel() has not been implemented.');
  }

  /// 更新口型同步参数
  Future<void> updateLipSync(double audioLevel) {
    throw UnimplementedError('updateLipSync() has not been implemented.');
  }

  /// 渲染模型
  Future<void> renderModel() {
    throw UnimplementedError('renderModel() has not been implemented.');
  }

  /// 设置模型参数
  Future<void> setParameter(String parameterId, double value) {
    throw UnimplementedError('setParameter() has not been implemented.');
  }
}