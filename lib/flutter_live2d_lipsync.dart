
import 'flutter_live2d_lipsync_platform_interface.dart';

class FlutterLive2dLipsync {
  Future<String?> getPlatformVersion() {
    return FlutterLive2dLipsyncPlatform.instance.getPlatformVersion();
  }

  /// 初始化Live2D模型
  Future<bool> initializeModel(String modelPath) {
    return FlutterLive2dLipsyncPlatform.instance.initializeModel(modelPath);
  }

  /// 更新口型同步参数
  Future<void> updateLipSync(double audioLevel) {
    return FlutterLive2dLipsyncPlatform.instance.updateLipSync(audioLevel);
  }

  /// 渲染模型
  Future<void> renderModel() {
    return FlutterLive2dLipsyncPlatform.instance.renderModel();
  }

  /// 设置模型参数
  Future<void> setParameter(String parameterId, double value) {
    return FlutterLive2dLipsyncPlatform.instance.setParameter(parameterId, value);
  }
}