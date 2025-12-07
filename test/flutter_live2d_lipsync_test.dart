import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_live2d_lipsync/flutter_live2d_lipsync.dart';
import 'package:flutter_live2d_lipsync/flutter_live2d_lipsync_platform_interface.dart';
import 'package:flutter_live2d_lipsync/flutter_live2d_lipsync_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterLive2dLipsyncPlatform
    with MockPlatformInterfaceMixin
    implements FlutterLive2dLipsyncPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterLive2dLipsyncPlatform initialPlatform = FlutterLive2dLipsyncPlatform.instance;

  test('$MethodChannelFlutterLive2dLipsync is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterLive2dLipsync>());
  });

  test('getPlatformVersion', () async {
    FlutterLive2dLipsync flutterLive2dLipsyncPlugin = FlutterLive2dLipsync();
    MockFlutterLive2dLipsyncPlatform fakePlatform = MockFlutterLive2dLipsyncPlatform();
    FlutterLive2dLipsyncPlatform.instance = fakePlatform;

    expect(await flutterLive2dLipsyncPlugin.getPlatformVersion(), '42');
  });
}
