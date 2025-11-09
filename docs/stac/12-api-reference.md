# API Reference

This section provides detailed API documentation for all Stac components, including widgets, actions, parsers, and utilities.

## Core Classes

### Stac

The main entry point for Stac functionality.

```dart
class Stac {
  static Future<void> initialize({
    List<StacParser>? parsers,
    List<StacActionParser>? actionParsers,
    StacNetworkConfig? networkConfig,
    bool debugMode = false,
    bool enableLogging = false,
  });
  
  static Widget fromJson(Map<String, dynamic> json, BuildContext context);
  static Widget fromAsset(String assetPath, BuildContext context);
  static Widget fromNetwork(StacNetworkRequest request, BuildContext context);
}
```

**Parameters:**
- `parsers`: List of custom widget parsers
- `actionParsers`: List of custom action parsers
- `networkConfig`: Network configuration
- `debugMode`: Enable debug mode
- `enableLogging`: Enable logging

### StacApp

A MaterialApp wrapper that provides Stac-specific functionality.

```dart
class StacApp extends StatelessWidget {
  const StacApp({
    Key? key,
    required this.title,
    required this.home,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.routes,
    this.onGenerateRoute,
    this.initialRoute,
    this.onUnknownRoute,
  });
  
  final String title;
  final Widget home;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final Map<String, WidgetBuilder>? routes;
  final RouteFactory? onGenerateRoute;
  final String? initialRoute;
  final RouteFactory? onUnknownRoute;
}
```

## Widget Parsers

### StacParser

Base class for all widget parsers.

```dart
abstract class StacParser<T> {
  String get type;
  T getModel(Map<String, dynamic> json);
  Widget parse(BuildContext context, T model);
}
```

**Methods:**
- `type`: Returns the widget type identifier
- `getModel`: Converts JSON to model object
- `parse`: Converts model to Flutter widget

### Built-in Widget Parsers

#### StacTextParser

Parses text widgets.

```dart
class StacTextParser extends StacParser<StacText> {
  @override
  String get type => 'text';
  
  @override
  StacText getModel(Map<String, dynamic> json) => StacText.fromJson(json);
  
  @override
  Widget parse(BuildContext context, StacText model) => Text(
    model.data,
    style: model.style?.toTextStyle(),
  );
}
```

#### StacContainerParser

Parses container widgets.

```dart
class StacContainerParser extends StacParser<StacContainer> {
  @override
  String get type => 'container';
  
  @override
  StacContainer getModel(Map<String, dynamic> json) => StacContainer.fromJson(json);
  
  @override
  Widget parse(BuildContext context, StacContainer model) => Container(
    width: model.width,
    height: model.height,
    padding: model.padding?.toEdgeInsets(),
    margin: model.margin?.toEdgeInsets(),
    decoration: model.decoration?.toBoxDecoration(),
    child: model.child != null ? Stac.fromJson(model.child!, context) : null,
  );
}
```

#### StacColumnParser

Parses column widgets.

```dart
class StacColumnParser extends StacParser<StacColumn> {
  @override
  String get type => 'column';
  
  @override
  StacColumn getModel(Map<String, dynamic> json) => StacColumn.fromJson(json);
  
  @override
  Widget parse(BuildContext context, StacColumn model) => Column(
    mainAxisAlignment: model.mainAxisAlignment?.toMainAxisAlignment() ?? MainAxisAlignment.start,
    crossAxisAlignment: model.crossAxisAlignment?.toCrossAxisAlignment() ?? CrossAxisAlignment.center,
    mainAxisSize: model.mainAxisSize?.toMainAxisSize() ?? MainAxisSize.max,
    children: model.children?.map((child) => Stac.fromJson(child, context)).toList() ?? [],
  );
}
```

#### StacRowParser

Parses row widgets.

```dart
class StacRowParser extends StacParser<StacRow> {
  @override
  String get type => 'row';
  
  @override
  StacRow getModel(Map<String, dynamic> json) => StacRow.fromJson(json);
  
  @override
  Widget parse(BuildContext context, StacRow model) => Row(
    mainAxisAlignment: model.mainAxisAlignment?.toMainAxisAlignment() ?? MainAxisAlignment.start,
    crossAxisAlignment: model.crossAxisAlignment?.toCrossAxisAlignment() ?? CrossAxisAlignment.center,
    mainAxisSize: model.mainAxisSize?.toMainAxisSize() ?? MainAxisSize.max,
    children: model.children?.map((child) => Stac.fromJson(child, context)).toList() ?? [],
  );
}
```

#### StacElevatedButtonParser

Parses elevated button widgets.

```dart
class StacElevatedButtonParser extends StacParser<StacElevatedButton> {
  @override
  String get type => 'elevatedButton';
  
  @override
  StacElevatedButton getModel(Map<String, dynamic> json) => StacElevatedButton.fromJson(json);
  
  @override
  Widget parse(BuildContext context, StacElevatedButton model) => ElevatedButton(
    onPressed: model.onPressed != null ? () => _handleAction(context, model.onPressed!) : null,
    style: model.style?.toButtonStyle(),
    child: model.child != null ? Stac.fromJson(model.child!, context) : null,
  );
}
```

## Action Parsers

### StacActionParser

Base class for all action parsers.

```dart
abstract class StacActionParser<T> {
  String get actionType;
  T getModel(Map<String, dynamic> json);
  FutureOr onCall(BuildContext context, T model);
}
```

**Methods:**
- `actionType`: Returns the action type identifier
- `getModel`: Converts JSON to model object
- `onCall`: Executes the action

### Built-in Action Parsers

#### StacNavigateActionParser

Handles navigation actions.

```dart
class StacNavigateActionParser implements StacActionParser<StacNavigateAction> {
  @override
  String get actionType => 'navigate';
  
  @override
  StacNavigateAction getModel(Map<String, dynamic> json) => StacNavigateAction.fromJson(json);
  
  @override
  FutureOr onCall(BuildContext context, StacNavigateAction model) async {
    if (model.route != null) {
      Navigator.pushNamed(context, model.route!, arguments: model.arguments);
    }
  }
}
```

#### StacSnackBarActionParser

Handles snack bar actions.

```dart
class StacSnackBarActionParser implements StacActionParser<StacSnackBarAction> {
  @override
  String get actionType => 'snackBar';
  
  @override
  StacSnackBarAction getModel(Map<String, dynamic> json) => StacSnackBarAction.fromJson(json);
  
  @override
  FutureOr onCall(BuildContext context, StacSnackBarAction model) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(model.message),
        duration: Duration(milliseconds: model.duration ?? 3000),
        backgroundColor: model.backgroundColor?.toColor(),
        action: model.action != null ? SnackBarAction(
          label: model.action!.label,
          onPressed: () => _handleAction(context, model.action!.onPressed),
        ) : null,
      ),
    );
  }
}
```

#### StacNetworkRequestActionParser

Handles network request actions.

```dart
class StacNetworkRequestActionParser implements StacActionParser<StacNetworkRequestAction> {
  @override
  String get actionType => 'networkRequest';
  
  @override
  StacNetworkRequestAction getModel(Map<String, dynamic> json) => StacNetworkRequestAction.fromJson(json);
  
  @override
  FutureOr onCall(BuildContext context, StacNetworkRequestAction model) async {
    try {
      final response = await http.Request(
        model.method,
        Uri.parse(model.url),
      )
        ..headers.addAll(model.headers ?? {})
        ..body = jsonEncode(model.body ?? {});
      
      final streamedResponse = await response.send();
      final responseBody = await streamedResponse.stream.bytesToString();
      
      if (streamedResponse.statusCode >= 200 && streamedResponse.statusCode < 300) {
        if (model.onSuccess != null) {
          await _handleAction(context, model.onSuccess!);
        }
      } else {
        if (model.onError != null) {
          await _handleAction(context, model.onError!);
        }
      }
    } catch (e) {
      if (model.onError != null) {
        await _handleAction(context, model.onError!);
      }
    }
  }
}
```

## Registry

### StacRegistry

Manages parsers and actions.

```dart
class StacRegistry {
  static StacRegistry get instance => _instance;
  static final StacRegistry _instance = StacRegistry._internal();
  
  void register(StacParser parser);
  void registerAll(List<StacParser> parsers);
  void registerAction(StacActionParser actionParser);
  void registerAllActions(List<StacActionParser> actionParsers);
  
  StacParser? getParser(String type);
  StacActionParser? getActionParser(String actionType);
}
```

**Methods:**
- `register`: Register a single parser
- `registerAll`: Register multiple parsers
- `registerAction`: Register a single action parser
- `registerAllActions`: Register multiple action parsers
- `getParser`: Get parser by type
- `getActionParser`: Get action parser by type

## Network Configuration

### StacNetworkConfig

Configuration for network requests.

```dart
class StacNetworkConfig {
  const StacNetworkConfig({
    this.baseUrl,
    this.timeout,
    this.headers,
    this.validateCertificate = true,
  });
  
  final String? baseUrl;
  final Duration? timeout;
  final Map<String, String>? headers;
  final bool validateCertificate;
}
```

### StacNetworkRequest

Network request configuration.

```dart
class StacNetworkRequest {
  const StacNetworkRequest({
    required this.url,
    this.method = Method.get,
    this.headers,
    this.body,
    this.timeout,
  });
  
  final String url;
  final Method method;
  final Map<String, String>? headers;
  final Map<String, dynamic>? body;
  final Duration? timeout;
}
```

## Utility Classes

### StacStyle

Text and container styling utilities.

```dart
class StacStyle {
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  
  TextStyle? toTextStyle();
  BoxDecoration? toBoxDecoration();
  EdgeInsets? toEdgeInsets();
}
```

### StacAlignment

Alignment utilities.

```dart
class StacAlignment {
  static MainAxisAlignment toMainAxisAlignment(String? alignment);
  static CrossAxisAlignment toCrossAxisAlignment(String? alignment);
  static MainAxisSize toMainAxisSize(String? size);
  static Alignment toAlignment(String? alignment);
}
```

### StacColor

Color utilities.

```dart
class StacColor {
  static Color? toColor(String? colorString);
  static String? toHex(Color color);
  static Color? fromHex(String hex);
}
```

## Error Handling

### StacError

Base error class for Stac.

```dart
class StacError implements Exception {
  const StacError(this.message, [this.details]);
  
  final String message;
  final String? details;
  
  @override
  String toString() => 'StacError: $message${details != null ? ' ($details)' : ''}';
}
```

### StacParseError

Error thrown during JSON parsing.

```dart
class StacParseError extends StacError {
  const StacParseError(super.message, [super.details]);
}
```

### StacRenderError

Error thrown during widget rendering.

```dart
class StacRenderError extends StacError {
  const StacRenderError(super.message, [super.details]);
}
```

## Logging

### StacLogger

Logging utilities for Stac.

```dart
class StacLogger {
  static void debug(String message, [Object? error, StackTrace? stackTrace]);
  static void info(String message, [Object? error, StackTrace? stackTrace]);
  static void warning(String message, [Object? error, StackTrace? stackTrace]);
  static void error(String message, [Object? error, StackTrace? stackTrace]);
}
```

## Validation

### StacValidator

Validation utilities for forms and data.

```dart
class StacValidator {
  static String? required(String? value);
  static String? email(String? value);
  static String? minLength(String? value, int minLength);
  static String? maxLength(String? value, int maxLength);
  static String? pattern(String? value, String pattern);
  static String? custom(String? value, bool Function(String?) validator);
}
```

## Performance

### StacPerformance

Performance monitoring utilities.

```dart
class StacPerformance {
  static void startTimer(String name);
  static void endTimer(String name);
  static Map<String, Duration> getTimers();
  static void clearTimers();
}
```

## Testing

### StacTestUtils

Testing utilities for Stac.

```dart
class StacTestUtils {
  static Widget createTestWidget(Map<String, dynamic> json);
  static void mockAction(String actionType, FutureOr Function() handler);
  static void mockNetworkRequest(String url, Map<String, dynamic> response);
  static void resetMocks();
}
```

## Best Practices

### 1. Error Handling

Always handle errors gracefully:

```dart
class SafeStacParser extends StacParser<StacWidget> {
  @override
  Widget parse(BuildContext context, StacWidget model) {
    try {
      return _buildWidget(context, model);
    } catch (e) {
      return ErrorWidget('Failed to parse widget: $e');
    }
  }
}
```

### 2. Performance

Optimize for performance:

```dart
class OptimizedStacParser extends StacParser<StacWidget> {
  final Map<String, Widget> _cache = {};
  
  @override
  Widget parse(BuildContext context, StacWidget model) {
    final key = model.hashCode.toString();
    return _cache.putIfAbsent(key, () => _buildWidget(context, model));
  }
}
```

### 3. Testing

Write comprehensive tests:

```dart
void main() {
  group('StacParser Tests', () {
    test('should parse JSON correctly', () {
      final json = {'type': 'text', 'data': 'Hello'};
      final parser = StacTextParser();
      final model = parser.getModel(json);
      expect(model.data, 'Hello');
    });
  });
}
```

## Next Steps

- [Contributing](./13-contributing.md) - Contribute to Stac
- [Community](./14-community.md) - Join the community
