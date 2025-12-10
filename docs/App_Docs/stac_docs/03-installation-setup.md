# Installation & Setup

This guide will walk you through installing and setting up Stac in your Flutter project.

## Prerequisites

Before you begin, make sure you have:

- **Flutter SDK**: Version 3.1.0 or higher
- **Dart SDK**: Version 3.1.0 or higher
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA with Flutter plugins
- **Basic Flutter knowledge**: Familiarity with Flutter widgets and basic concepts

## Installation

### 1. Add Stac to Your Project

Add the Stac dependency to your `pubspec.yaml` file:

```bash
flutter pub add stac
```

This will add the latest version of Stac to your project and run `flutter pub get` automatically.

Alternatively, you can manually add the dependency:

```yaml
dependencies:
  flutter:
    sdk: flutter
  stac: ^<latest-version>
```

Replace `<latest-version>` with the latest version of Stac. You can find the latest version on the [Stac pub.dev page](https://pub.dev/packages/stac).

### 2. Install Dependencies

Run the following command to install the package:

```bash
flutter pub get
```

### 3. Import Stac

Import the Stac package in your Dart file:

```dart
import 'package:stac/stac.dart';
```

## Basic Setup

### 1. Initialize Stac

In your `main.dart` file, initialize Stac before running your app:

```dart
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Stac
  await Stac.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stac Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
```

### 2. Create Your First Stac Widget

Create a simple Stac widget to test your setup:

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample JSON for a simple UI
    final json = {
      "type": "scaffold",
      "appBar": {
        "type": "appBar",
        "title": {
          "type": "text",
          "data": "Welcome to Stac!"
        }
      },
      "body": {
        "type": "center",
        "child": {
          "type": "column",
          "mainAxisAlignment": "center",
          "children": [
            {
              "type": "text",
              "data": "Hello, Stac!",
              "style": {
                "fontSize": 24,
                "fontWeight": "bold"
              }
            },
            {
              "type": "sizedBox",
              "height": 20
            },
            {
              "type": "elevatedButton",
              "child": {
                "type": "text",
                "data": "Get Started"
              },
              "onPressed": {
                "actionType": "snackBar",
                "message": "Welcome to Stac!"
              }
            }
          ]
        }
      }
    };

    return Stac.fromJson(json, context);
  }
}
```

### 3. Run Your App

Run your Flutter app to see Stac in action:

```bash
flutter run
```

## Advanced Setup

### Using StacApp

For a more integrated experience, use `StacApp` instead of `MaterialApp`:

```dart
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Stac.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StacApp(
      title: 'Stac Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stac.fromNetwork(
        StacNetworkRequest(
          url: 'https://api.example.com/ui.json',
        ),
      ),
    );
  }
}
```

### Loading UI from Assets

You can also load UI from JSON files in your assets:

1. Add the JSON file to your `assets` folder:

```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/ui/
```

2. Use `Stac.fromAsset` to load the UI:

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stac.fromAsset('assets/ui/home.json', context);
  }
}
```

### Loading UI from Network

Load UI from a remote server:

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stac.fromNetwork(
      StacNetworkRequest(
        url: 'https://api.example.com/ui.json',
        method: Method.get,
        headers: {
          'Authorization': 'Bearer your-token',
        },
      ),
      context,
    );
  }
}
```

## Optional Packages

### Stac WebView

If you need web view functionality, add the Stac WebView package:

```bash
flutter pub add stac_webview
```

Then register the parser:

```dart
void main() async {
  await Stac.initialize(
    parsers: const [
      StacWebViewParser(),
    ],
  );
  
  runApp(const MyApp());
}
```

### Stac Logger

For enhanced logging capabilities:

```bash
flutter pub add stac_logger
```

```dart
import 'package:stac_logger/stac_logger.dart';

void main() {
  Log.d('Debug message');
  Log.i('Info message');
  Log.w('Warning message');
  Log.e('Error message');
}
```

## Configuration Options

### Custom Parsers

Register custom parsers during initialization:

```dart
void main() async {
  await Stac.initialize(
    parsers: const [
      CustomWidgetParser(),
      CustomActionParser(),
    ],
  );
  
  runApp(const MyApp());
}
```

### Custom Action Parsers

Register custom action parsers:

```dart
void main() async {
  await Stac.initialize(
    actionParsers: const [
      CustomActionParser(),
    ],
  );
  
  runApp(const MyApp());
}
```

### Network Configuration

Configure network settings:

```dart
void main() async {
  await Stac.initialize(
    networkConfig: StacNetworkConfig(
      baseUrl: 'https://api.example.com',
      timeout: Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  
  runApp(const MyApp());
}
```

## Troubleshooting

### Common Issues

1. **Import Error**: Make sure you've added Stac to your `pubspec.yaml` and run `flutter pub get`.

2. **Initialization Error**: Ensure you're calling `Stac.initialize()` before `runApp()`.

3. **JSON Parsing Error**: Check that your JSON structure matches the expected Stac widget format.

4. **Network Error**: Verify your network request configuration and URL.

### Debug Mode

Enable debug mode for more detailed error messages:

```dart
void main() async {
  await Stac.initialize(
    debugMode: true,
  );
  
  runApp(const MyApp());
}
```

### Logging

Enable logging to see what's happening under the hood:

```dart
void main() async {
  await Stac.initialize(
    enableLogging: true,
  );
  
  runApp(const MyApp());
}
```

## Next Steps

Now that you have Stac set up, you can:

- [Quick Start Guide](./04-quickstart.md) - Build your first complete Stac app
- [Core Concepts](./05-core-concepts.md) - Understand how Stac works
- [Widgets](./06-widgets.md) - Explore available widgets
- [Actions](./07-actions.md) - Learn about actions and interactions

## Support

If you encounter any issues during setup:

- Check the [GitHub Issues](https://github.com/StacDev/stac/issues)
- Join our [Discord Community](https://discord.com/invite/vTGsVRK86V)
- Read the [API Documentation](./12-api-reference.md)
