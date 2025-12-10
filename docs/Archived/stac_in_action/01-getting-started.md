# Getting Started with STAC in Action

This guide will help you get started with the STAC Hybrid App Framework, understand the project structure, and create your first custom component.

## 📋 Prerequisites

Before you begin, ensure you have:

- **Flutter SDK**: ^3.9.0 or higher
- **Dart**: ^3.9.0 or higher
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA
- **Basic Knowledge**: Flutter, Dart, and JSON

## 🏗️ Project Structure Overview

### Understanding the Folder Structure

The project follows a clear separation between core STAC framework and custom implementations:

```
tobank_sdui/
├── .stac/                      # ⚠️ READ-ONLY: Original STAC package
│   ├── packages/stac/          # Core STAC framework
│   ├── examples/               # STAC examples
│   └── website/docs/           # STAC documentation
│
├── stac/                       # ✅ MODIFY HERE: Custom STAC components
│   ├── widgets/                # Custom widgets
│   ├── actions/                # Custom actions
│   ├── registry/               # Component registration
│   └── .build/                 # Build output (generated)
│
├── lib/                        # Application code
│   ├── core/                   # Core utilities
│   │   ├── api/                # API layer (mock, Firebase, custom)
│   │   ├── logging/            # STAC-specific logging
│   │   ├── validation/         # JSON validation
│   │   └── cache/              # Caching system
│   ├── debug_panel/            # Debug panel with STAC tools
│   ├── features/               # Feature modules
│   └── main.dart               # App entry point
│
├── docs/                       # Documentation
│   ├── stac/                   # Core STAC docs (70+ widgets)
│   ├── stac_core/              # Architecture docs
│   ├── debug_panel/            # Debug panel docs
│   └── stac_in_action/         # This documentation
│
└── test/                       # Test files
    ├── stac/                   # Custom component tests
    └── core/                   # Core functionality tests
```

### Critical Distinction: `.stac/` vs `stac/`

**⚠️ IMPORTANT**: Understanding this distinction is crucial for successful development.

#### `.stac/` - Original STAC Package (READ-ONLY)

- **Purpose**: Reference implementation of the STAC framework
- **Source**: Cloned from the official STAC GitHub repository
- **Usage**: Study patterns, understand core concepts, reference documentation
- **Rule**: **NEVER MODIFY** - Treat as read-only reference material

**Why Read-Only?**
- Prevents conflicts with upstream STAC updates
- Avoids accidental breaking changes
- Maintains clean separation of concerns
- Enables easy framework updates

#### `stac/` - Custom STAC Implementation (MODIFY HERE)

- **Purpose**: Project-specific custom widgets and actions
- **Source**: Your custom implementations
- **Usage**: Create custom components, extend framework functionality
- **Rule**: **ALL CUSTOM CODE GOES HERE**

**Why Separate?**
- Full control over custom components
- No conflicts with core framework
- Easier testing and debugging
- Clear ownership and maintenance

### Example: Where to Put Your Code

```dart
// ❌ WRONG: Do not create files in .stac/
// .stac/packages/stac/lib/widgets/my_custom_widget.dart

// ✅ CORRECT: Create files in stac/
// stac/widgets/my_custom_widget/my_custom_widget.dart
// stac/widgets/my_custom_widget/my_custom_widget_parser.dart
```

## 🚀 Quick Start

### Step 1: Install Dependencies

```bash
# Navigate to project root
cd tobank_sdui

# Get Flutter dependencies
flutter pub get

# Run code generation (for Riverpod, JSON serialization, etc.)
dart run build_runner build --delete-conflicting-outputs
```

### Step 2: Explore Existing Documentation

Before creating custom components, familiarize yourself with the core STAC framework:

```bash
# Read core STAC documentation
docs/stac/README.md              # Overview and widget reference
docs/stac/05-core-concepts.md    # Core concepts and architecture
docs/stac/06-widgets.md          # Built-in widgets (70+)
docs/stac/07-actions.md          # Built-in actions
docs/stac/08-parsers.md          # Parser patterns

# Read architecture documentation
docs/stac_core/README.md                        # Architecture overview
docs/stac_core/11-creating-custom-components.md # Custom component guide

# Read debug panel documentation
docs/debug_panel/README.md       # Debug panel features
```

### Step 3: Run the Application

```bash
# Run the app in debug mode
flutter run

# Run on specific device
flutter run -d chrome          # Web
flutter run -d windows         # Windows
flutter run -d <device_id>     # Specific device
```

### Step 4: Explore the Debug Panel

The application includes a comprehensive debug panel for development:

1. **Launch the app** in debug mode
2. **Access debug panel** (usually via a floating button or gesture)
3. **Explore tabs**:
   - **Device Preview**: Test different device sizes
   - **Logs**: View application logs
   - **Accessibility**: Check accessibility issues
   - **Performance**: Monitor performance metrics
   - **Network**: Simulate network conditions
   - **Settings**: Configure debug options

## 📁 Custom STAC Folder Structure

### Recommended Organization

```
stac/
├── widgets/                    # Custom widgets
│   ├── custom_card/
│   │   ├── custom_card_widget.dart       # Widget model
│   │   └── custom_card_parser.dart       # Widget parser
│   ├── product_list/
│   │   ├── product_list_widget.dart
│   │   └── product_list_parser.dart
│   └── README.md
│
├── actions/                    # Custom actions
│   ├── api_call/
│   │   ├── api_call_action.dart          # Action model
│   │   └── api_call_parser.dart          # Action parser
│   ├── analytics/
│   │   ├── analytics_action.dart
│   │   └── analytics_parser.dart
│   └── README.md
│
├── registry/                   # Component registration
│   └── custom_component_registry.dart
│
├── .build/                     # Build output (generated, git-ignored)
│   └── *.json
│
└── README.md                   # Custom STAC documentation
```

### Naming Conventions

- **Folders**: `snake_case` (e.g., `custom_card`, `api_call`)
- **Files**: `snake_case.dart` (e.g., `custom_card_widget.dart`)
- **Classes**: `PascalCase` (e.g., `CustomCardWidget`, `CustomCardParser`)
- **Variables**: `camelCase` (e.g., `customCard`, `apiCall`)

## 🎯 Your First Custom Widget

Let's create a simple custom widget to understand the workflow.

### Step 1: Create Widget Model

Create `stac/widgets/greeting_card/greeting_card_widget.dart`:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'greeting_card_widget.g.dart';

@JsonSerializable()
class GreetingCardWidget {
  final String name;
  final String message;
  final String? imageUrl;

  const GreetingCardWidget({
    required this.name,
    required this.message,
    this.imageUrl,
  });

  factory GreetingCardWidget.fromJson(Map<String, dynamic> json) =>
      _$GreetingCardWidgetFromJson(json);

  Map<String, dynamic> toJson() => _$GreetingCardWidgetToJson(this);
}
```

### Step 2: Create Widget Parser

Create `stac/widgets/greeting_card/greeting_card_parser.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:tobank_sdui/stac/widgets/greeting_card/greeting_card_widget.dart';

// Import STAC core (from .stac/ - read-only reference)
import 'package:stac_core/stac_core.dart';

class GreetingCardParser extends StacParser<GreetingCardWidget> {
  @override
  String get type => 'greetingCard';

  @override
  GreetingCardWidget getModel(Map<String, dynamic> json) =>
      GreetingCardWidget.fromJson(json);

  @override
  Widget parse(BuildContext context, GreetingCardWidget model) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  model.imageUrl!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Text(
              'Hello, ${model.name}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              model.message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
```

### Step 3: Generate Code

```bash
# Generate JSON serialization code
dart run build_runner build --delete-conflicting-outputs

# This creates: greeting_card_widget.g.dart
```

### Step 4: Register the Parser

Create or update `stac/registry/custom_component_registry.dart`:

```dart
import 'package:tobank_sdui/stac/widgets/greeting_card/greeting_card_parser.dart';

class CustomComponentRegistry {
  static final CustomComponentRegistry instance = CustomComponentRegistry._();
  CustomComponentRegistry._();

  final Map<String, dynamic> _widgetParsers = {};
  final Map<String, dynamic> _actionParsers = {};

  void registerWidget(dynamic parser) {
    final type = parser.type as String;
    _widgetParsers[type] = parser;
  }

  void registerAction(dynamic parser) {
    final actionType = parser.actionType as String;
    _actionParsers[actionType] = parser;
  }

  dynamic getWidgetParser(String type) => _widgetParsers[type];
  dynamic getActionParser(String actionType) => _actionParsers[actionType];

  List<String> getRegisteredWidgets() => _widgetParsers.keys.toList();
  List<String> getRegisteredActions() => _actionParsers.keys.toList();

  // Register all custom components
  void registerAll() {
    // Register custom widgets
    registerWidget(GreetingCardParser());
    
    // Register custom actions (when created)
    // registerAction(CustomActionParser());
  }
}
```

### Step 5: Initialize in App

Update your app initialization to register custom components:

```dart
import 'package:flutter/material.dart';
import 'package:tobank_sdui/stac/registry/custom_component_registry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register custom STAC components
  CustomComponentRegistry.instance.registerAll();

  runApp(const MyApp());
}
```

### Step 6: Use in JSON

Create a JSON file to test your widget:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Greeting Card Demo"
    }
  },
  "body": {
    "type": "greetingCard",
    "name": "Developer",
    "message": "Welcome to STAC in Action! You've successfully created your first custom widget.",
    "imageUrl": "https://picsum.photos/400/200"
  }
}
```

### Step 7: Render from JSON

```dart
import 'package:flutter/material.dart';
import 'package:stac_core/stac_core.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Load JSON (from assets, network, or hardcoded)
    final json = {
      "type": "scaffold",
      "appBar": {
        "type": "appBar",
        "title": {"type": "text", "data": "Greeting Card Demo"}
      },
      "body": {
        "type": "greetingCard",
        "name": "Developer",
        "message": "Welcome to STAC in Action!",
        "imageUrl": "https://picsum.photos/400/200"
      }
    };

    // Render from JSON
    return Stac.fromJson(json, context);
  }
}
```

## 🧪 Testing Your Widget

Create `test/stac/widgets/greeting_card_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/stac/widgets/greeting_card/greeting_card_widget.dart';
import 'package:tobank_sdui/stac/widgets/greeting_card/greeting_card_parser.dart';

void main() {
  group('GreetingCardWidget', () {
    test('should serialize to JSON correctly', () {
      final widget = GreetingCardWidget(
        name: 'Test User',
        message: 'Test Message',
        imageUrl: 'https://example.com/image.jpg',
      );

      final json = widget.toJson();

      expect(json['name'], 'Test User');
      expect(json['message'], 'Test Message');
      expect(json['imageUrl'], 'https://example.com/image.jpg');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'name': 'Test User',
        'message': 'Test Message',
        'imageUrl': 'https://example.com/image.jpg',
      };

      final widget = GreetingCardWidget.fromJson(json);

      expect(widget.name, 'Test User');
      expect(widget.message, 'Test Message');
      expect(widget.imageUrl, 'https://example.com/image.jpg');
    });

    test('should handle optional imageUrl', () {
      final json = {
        'name': 'Test User',
        'message': 'Test Message',
      };

      final widget = GreetingCardWidget.fromJson(json);

      expect(widget.name, 'Test User');
      expect(widget.message, 'Test Message');
      expect(widget.imageUrl, null);
    });
  });

  group('GreetingCardParser', () {
    test('should have correct type', () {
      final parser = GreetingCardParser();
      expect(parser.type, 'greetingCard');
    });

    test('should parse model from JSON', () {
      final parser = GreetingCardParser();
      final json = {
        'name': 'Test User',
        'message': 'Test Message',
      };

      final model = parser.getModel(json);

      expect(model.name, 'Test User');
      expect(model.message, 'Test Message');
    });
  });
}
```

Run tests:

```bash
flutter test test/stac/widgets/greeting_card_test.dart
```

## 📚 Next Steps

Now that you've created your first custom widget, explore more advanced topics:

1. **[Custom Widgets Guide](./02-custom-widgets-guide.md)** - Advanced widget patterns
2. **[Custom Actions Guide](./03-custom-actions-guide.md)** - Create interactive actions
3. **[Testing Guide](./04-testing-guide.md)** - Comprehensive testing strategies
4. **[API Layer Guide](./05-api-layer-guide.md)** - Set up API layer for dynamic content

## 🔍 Common Patterns

### Loading JSON from Assets

```dart
import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadJsonFromAssets(String path) async {
  final jsonString = await rootBundle.loadString(path);
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

// Usage
final json = await loadJsonFromAssets('assets/screens/home.json');
final widget = Stac.fromJson(json, context);
```

### Loading JSON from Network

```dart
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> loadJsonFromNetwork(String url) async {
  final dio = Dio();
  final response = await dio.get(url);
  return response.data as Map<String, dynamic>;
}

// Usage
final json = await loadJsonFromNetwork('https://api.example.com/screen/home');
final widget = Stac.fromJson(json, context);
```

### Error Handling

```dart
Widget buildStacScreen(Map<String, dynamic> json, BuildContext context) {
  try {
    return Stac.fromJson(json, context);
  } catch (e) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Failed to load screen: $e'),
          ],
        ),
      ),
    );
  }
}
```

## 💡 Tips and Best Practices

### 1. Use Descriptive Names

```dart
// ❌ Bad
class CW extends StacParser<CW> { ... }

// ✅ Good
class CustomCardWidget extends StacParser<CustomCardWidget> { ... }
```

### 2. Keep Models Simple

```dart
// ✅ Good: Simple, focused model
@JsonSerializable()
class ButtonWidget {
  final String text;
  final String? icon;
  
  const ButtonWidget({required this.text, this.icon});
}

// ❌ Bad: Too complex, should be split
@JsonSerializable()
class ComplexWidget {
  final String text;
  final List<Item> items;
  final Map<String, dynamic> config;
  final Function? callback;  // Functions can't be serialized!
}
```

### 3. Handle Null Safety

```dart
@JsonSerializable()
class SafeWidget {
  final String title;           // Required
  final String? subtitle;       // Optional
  final String description;     // Required
  
  const SafeWidget({
    required this.title,
    this.subtitle,
    required this.description,
  });
}
```

### 4. Use Const Constructors

```dart
class MyParser extends StacParser<MyWidget> {
  @override
  Widget parse(BuildContext context, MyWidget model) {
    return const Card(  // Use const when possible
      child: Padding(
        padding: EdgeInsets.all(16),  // const EdgeInsets
        child: Text('Static text'),
      ),
    );
  }
}
```

### 5. Document Your Components

```dart
/// A custom card widget that displays a greeting message.
///
/// This widget shows a personalized greeting with an optional image.
///
/// Example JSON:
/// ```json
/// {
///   "type": "greetingCard",
///   "name": "John",
///   "message": "Welcome!",
///   "imageUrl": "https://example.com/image.jpg"
/// }
/// ```
@JsonSerializable()
class GreetingCardWidget {
  /// The name of the person to greet
  final String name;
  
  /// The greeting message to display
  final String message;
  
  /// Optional image URL to display above the greeting
  final String? imageUrl;
  
  const GreetingCardWidget({
    required this.name,
    required this.message,
    this.imageUrl,
  });
}
```

## 🐛 Troubleshooting

### Issue: "Type 'X' is not a subtype of type 'Y'"

**Solution**: Run code generation:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Issue: "Parser not found for type 'customWidget'"

**Solution**: Ensure parser is registered:
```dart
CustomComponentRegistry.instance.registerWidget(CustomWidgetParser());
```

### Issue: "JSON serialization error"

**Solution**: Check that:
1. Model has `@JsonSerializable()` annotation
2. `fromJson` and `toJson` methods are implemented
3. Code generation has been run
4. All fields are serializable (no Functions, Widgets, etc.)

### Issue: "Widget not rendering"

**Solution**: Check that:
1. Parser's `type` matches JSON's `"type"` field
2. Parser is registered before use
3. JSON structure is valid
4. All required fields are present in JSON

## 📖 Additional Resources

- **[STAC Core Docs](../stac/README.md)** - 70+ built-in widgets
- **[Architecture Reference](../ARCHITECTURE_REFERENCE.md)** - Clean Architecture guide
- **[Debug Panel](../debug_panel/README.md)** - Debug tools documentation

---

**Next**: [Custom Widgets Guide](./02-custom-widgets-guide.md) - Learn advanced widget patterns

