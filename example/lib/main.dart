import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_live2d_lipsync/flutter_live2d_lipsync.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterLive2dLipsyncPlugin = FlutterLive2dLipsync();
  double _lipSyncValue = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterLive2dLipsyncPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Live2D Lip Sync Plugin'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              const SizedBox(height: 20),
              const Text(
                'Live2D Lip Sync Demo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Lip Sync Value: ${_lipSyncValue.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Slider(
                value: _lipSyncValue,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: _lipSyncValue.toStringAsFixed(2),
                onChanged: (double value) {
                  setState(() {
                    _lipSyncValue = value;
                    // Update Live2D model lip sync
                    _flutterLive2dLipsyncPlugin.updateLipSync(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Simulate automatic lip sync
                  _timer?.cancel();
                  _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
                    setState(() {
                      _lipSyncValue = (DateTime.now().millisecond % 1000) / 1000;
                      _flutterLive2dLipsyncPlugin.updateLipSync(_lipSyncValue);
                    });
                  });
                },
                child: const Text('Start Auto Lip Sync'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Stop automatic lip sync
                  _timer?.cancel();
                },
                child: const Text('Stop Auto Lip Sync'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}