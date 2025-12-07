# Flutter Live2D Lip Sync

A Flutter plugin for Live2D lip sync functionality on Android.

## Features

This plugin enables lip sync capabilities for Live2D models in Flutter applications on Android. It allows you to:
- Load Live2D models
- Control lip sync parameters based on audio input levels
- Render Live2D models with synchronized mouth movements

## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_live2d_lipsync: ^0.0.1
```

Then run:
```bash
flutter pub get
```

## Android Setup

This plugin requires Android SDK versions 30-35.

Add the following to your android/app/build.gradle file:

```gradle
android {
    compileSdk = 35
    
    defaultConfig {
        minSdk = 30
        targetSdk = 35
    }
}
```

## Usage

Import the package:
```dart
import 'package:flutter_live2d_lipsync/flutter_live2d_lipsync.dart';
```

Initialize and use the plugin:
```dart
final live2dLipSync = FlutterLive2dLipsync();

// Initialize a Live2D model
bool success = await live2dLipSync.initializeModel('path/to/model.model3.json');

// Update lip sync based on audio level (0.0 to 1.0)
await live2dLipSync.updateLipSync(0.7);

// Set specific parameter values
await live2dLipSync.setParameter('ParamMouthOpenY', 0.5);

// Render the model
await live2dLipSync.renderModel();
```

## Example

See the example directory for a complete sample implementation that demonstrates lip sync functionality with a slider control.

## Supported Platforms

Currently only supports Android SDK versions 30-35.

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## License

This plugin is available under the MIT license. See the LICENSE file for more info.