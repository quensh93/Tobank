# Troubleshooting Guide

This guide provides solutions to common issues you may encounter when working with the STAC Hybrid App Framework.

## Table of Contents

- [Common Errors](#common-errors)
- [API Layer Issues](#api-layer-issues)
- [Custom Component Issues](#custom-component-issues)
- [Debug Panel Issues](#debug-panel-issues)
- [Firebase Integration Issues](#firebase-integration-issues)
- [Performance Issues](#performance-issues)
- [Build and Code Generation Issues](#build-and-code-generation-issues)
- [Debugging Tips](#debugging-tips)
- [FAQ](#faq)

---

## Common Errors

### Error: "Widget type not found"

**Symptom**: JSON parsing fails with message "Unknown widget type: customWidget"

**Cause**: Custom widget parser not registered in the component registry

**Solution**:
```dart
// In your app initialization (main.dart or bootstrap)
void registerCustomComponents() {
  final registry = CustomComponentRegistry.instance;
  
  // Register your custom widget parser
  registry.registerWidget(CustomWidgetParser());
  
  // Register your custom action parser
  registry.registerAction(CustomActionParser());
}

// Call before running the app
void main() {
  registerCustomComponents();
  runApp(MyApp());
}
```

**Prevention**: Always register custom parsers during app initialization before any STAC screens are loaded.

---

### Error: "JSON serialization failed"

**Symptom**: `JsonSerializationException` when parsing JSON

**Cause**: Missing or incorrect `@JsonSerializable()` annotation, or missing generated code

**Solution**:
1. Ensure your model has the correct annotations:
```dart
import 'package:json_annotation/json_annotation.dart';

part 'my_model.g.dart';

@JsonSerializable()
class MyModel {
  final String title;
  final String? subtitle;
  
  MyModel({required this.title, this.subtitle});
  
  factory MyModel.fromJson(Map<String, dynamic> json) => 
      _$MyModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyModelToJson(this);
}
```

2. Run code generation:
```bash
dart run build_runner build --delete-conflicting-outputs
```

**Prevention**: Always run `build_runner` after creating or modifying models with `@JsonSerializable()`.

---

### Error: "Screen not found"

**Symptom**: `ScreenNotFoundException` when fetching a screen

**Cause**: Screen JSON file doesn't exist or has incorrect name

**Solution**:

For Mock API:
```bash
# Check if file exists
ls assets/mock_data/screens/

# Ensure filename matches exactly (case-sensitive)
# If fetching "home_screen", file must be "home_screen.json"
```

For Firebase:
```bash
# Check Firestore collection
# Collection: stac_screens
# Document ID must match screen name exactly
```

**Prevention**: Use consistent naming conventions and verify file/document names match exactly.

---

### Error: "Circular reference detected"

**Symptom**: Stack overflow or infinite loop during JSON parsing

**Cause**: JSON structure contains circular references (widget references itself)

**Solution**:
```json
// ❌ WRONG - Circular reference
{
  "type": "container",
  "child": {
    "type": "container",
    "child": "..." // References parent
  }
}

// ✅ CORRECT - No circular references
{
  "type": "container",
  "child": {
    "type": "text",
    "data": "Hello"
  }
}
```

**Prevention**: Use the JSON validator before saving configurations:
```dart
final validator = StacJsonValidator();
final result = validator.validate(json);
if (!result.isValid) {
  print('Validation errors: ${result.errors}');
}
```

---

## API Layer Issues

### Issue: API not switching between mock and real

**Symptom**: App continues using mock data even when configured for Firebase/custom API

**Cause**: API configuration not properly initialized or cached

**Solution**:
```dart
// Clear any cached API service instances
final container = ProviderContainer();
container.invalidate(apiServiceProvider);

// Ensure configuration is set before app starts
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set API configuration
  final apiConfig = ApiConfig.firebase('your-project-id');
  
  runApp(
    ProviderScope(
      overrides: [
        apiConfigProvider.overrideWithValue(apiConfig),
      ],
      child: MyApp(),
    ),
  );
}
```

---

### Issue: Firebase connection timeout

**Symptom**: Requests to Firebase take too long or timeout

**Cause**: Network issues, Firebase configuration, or security rules blocking access

**Solution**:
1. Check Firebase initialization:
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

2. Verify security rules allow read access:
```javascript
allow read: if request.auth != null;
```

3. Check network connectivity:
```dart
final connectivityResult = await Connectivity().checkConnectivity();
if (connectivityResult == ConnectivityResult.none) {
  // Handle offline state
}
```

---

### Issue: Cache not clearing

**Symptom**: Old data persists even after calling `clearCache()`

**Cause**: Multiple cache layers not all being cleared

**Solution**:
```dart
// Clear all cache layers
await apiService.clearCache();        // API cache
await CacheManager.instance.clear();  // Memory cache
await SharedPreferences.getInstance().then((prefs) {
  prefs.getKeys()
      .where((key) => key.startsWith('cache_'))
      .forEach((key) => prefs.remove(key));
});
```

---

## Custom Component Issues

### Issue: Custom widget not rendering

**Symptom**: Custom widget appears blank or shows error

**Cause**: Parser not returning a valid Flutter widget

**Solution**:
```dart
class CustomWidgetParser extends StacParser<CustomWidgetModel> {
  @override
  Widget parse(BuildContext context, CustomWidgetModel model) {
    // ❌ WRONG - Returning null
    // return null;
    
    // ✅ CORRECT - Always return a widget
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(model.title),
    );
  }
  
  @override
  String get type => 'customWidget';
  
  @override
  CustomWidgetModel fromJson(Map<String, dynamic> json) {
    return CustomWidgetModel.fromJson(json);
  }
}
```

---

### Issue: Custom action not executing

**Symptom**: Action defined in JSON but nothing happens when triggered

**Cause**: Action parser not registered or not handling execution properly

**Solution**:
```dart
class CustomActionParser extends StacActionParser<CustomActionModel> {
  @override
  Future<void> execute(BuildContext context, CustomActionModel model) async {
    // Ensure action logic is implemented
    print('Executing custom action: ${model.actionType}');
    
    // Perform action
    await performAction(model);
    
    // Log completion
    StacLogger.logComponentRender(
      componentType: 'customAction',
      properties: model.toJson(),
      duration: Duration.zero,
    );
  }
  
  @override
  String get actionType => 'customAction';
  
  @override
  CustomActionModel fromJson(Map<String, dynamic> json) {
    return CustomActionModel.fromJson(json);
  }
}
```

---

### Issue: Properties not updating

**Symptom**: Changing JSON properties doesn't update the rendered widget

**Cause**: Widget not rebuilding when properties change

**Solution**:
```dart
// Use StatefulWidget for dynamic content
class CustomWidget extends StatefulWidget {
  final CustomWidgetModel model;
  
  const CustomWidget({Key? key, required this.model}) : super(key: key);
  
  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  void didUpdateWidget(CustomWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Rebuild when model changes
    if (oldWidget.model != widget.model) {
      setState(() {});
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(widget.model.title);
  }
}
```

---

## Debug Panel Issues

### Issue: Debug panel not showing

**Symptom**: Debug panel button or overlay not visible

**Cause**: Debug panel disabled in configuration or not properly initialized

**Solution**:
```dart
// Ensure debug panel is enabled
const bool ENABLE_DEBUG_PANEL = true;

final config = StacAppConfig(
  apiConfig: ApiConfig.mock(),
  enableDebugPanel: ENABLE_DEBUG_PANEL,
);

// Wrap app with debug panel
@override
Widget build(BuildContext context) {
  return DebugPanelWrapper(
    enabled: ENABLE_DEBUG_PANEL,
    child: MaterialApp(
      home: HomeScreen(),
    ),
  );
}
```

---

### Issue: STAC logs not appearing

**Symptom**: STAC logs tab is empty even though screens are loading

**Cause**: STAC logger not integrated into API services or parsers

**Solution**:
```dart
// Add logging to your API service
@override
Future<Map<String, dynamic>> fetchScreen(String screenName) async {
  final startTime = DateTime.now();
  
  try {
    final data = await _fetchFromSource(screenName);
    final duration = DateTime.now().difference(startTime);
    
    // Log successful fetch
    StacLogger.logScreenFetch(
      screenName: screenName,
      source: ApiSource.mock,
      duration: duration,
      jsonSize: jsonEncode(data).length,
    );
    
    return data;
  } catch (e) {
    // Log error
    StacLogger.logError(
      operation: 'fetchScreen',
      error: e.toString(),
      suggestion: 'Check if screen exists',
    );
    rethrow;
  }
}
```

---

### Issue: JSON playground not rendering

**Symptom**: Entering JSON in playground doesn't show preview

**Cause**: JSON syntax error or invalid STAC structure

**Solution**:
1. Check JSON syntax:
```json
// ❌ WRONG - Missing quotes, trailing comma
{
  type: "text",
  data: "Hello",
}

// ✅ CORRECT
{
  "type": "text",
  "data": "Hello"
}
```

2. Validate structure:
```dart
try {
  final json = jsonDecode(jsonInput);
  final validator = StacJsonValidator();
  final result = validator.validate(json);
  
  if (!result.isValid) {
    print('Validation errors:');
    for (final error in result.errors) {
      print('  ${error.path}: ${error.message}');
    }
  }
} catch (e) {
  print('JSON parse error: $e');
}
```

---

## Firebase Integration Issues

### Issue: Firebase initialization failed

**Symptom**: `FirebaseException` during app startup

**Cause**: Missing Firebase configuration files or incorrect setup

**Solution**:

For Android:
```bash
# Ensure google-services.json exists
ls android/app/google-services.json

# Check build.gradle has plugin
# android/app/build.gradle
apply plugin: 'com.google.gms.google-services'
```

For iOS:
```bash
# Ensure GoogleService-Info.plist exists
ls ios/Runner/GoogleService-Info.plist

# Check it's added to Xcode project
```

For Web:
```dart
// Ensure firebase config is in index.html
// web/index.html
<script src="/__/firebase/init.js"></script>
```

---

### Issue: Firestore permission denied

**Symptom**: `PermissionDeniedException` when reading/writing to Firestore

**Cause**: Security rules blocking access or user not authenticated

**Solution**:
1. Check authentication:
```dart
final user = FirebaseAuth.instance.currentUser;
if (user == null) {
  // User not authenticated
  await FirebaseAuth.instance.signInAnonymously();
}
```

2. Update security rules:
```javascript
// Allow authenticated reads
allow read: if request.auth != null;

// For development only (NOT for production)
allow read, write: if true;
```

---

### Issue: Firebase CLI commands not working

**Symptom**: CLI tool fails to upload/download screens

**Cause**: Firebase not initialized or incorrect project configuration

**Solution**:
```bash
# Initialize Firebase in your project
firebase login
firebase init firestore

# Set active project
firebase use your-project-id

# Test connection
firebase firestore:get stac_screens
```

---

## Performance Issues

### Issue: Slow JSON parsing

**Symptom**: Screens take several seconds to load

**Cause**: Large JSON files or inefficient parsing

**Solution**:
1. Enable JSON parse caching:
```dart
final cacheManager = JsonParseCache.instance;
final cachedModel = cacheManager.get(cacheKey);

if (cachedModel != null) {
  return cachedModel;
}

final model = parseJson(json);
cacheManager.set(cacheKey, model);
return model;
```

2. Break large screens into smaller components:
```json
// Instead of one large screen
{
  "type": "scaffold",
  "body": {
    "type": "column",
    "children": [/* 100+ widgets */]
  }
}

// Split into multiple lazy-loaded sections
{
  "type": "scaffold",
  "body": {
    "type": "lazyColumn",
    "sections": [
      {"ref": "header_section"},
      {"ref": "content_section"},
      {"ref": "footer_section"}
    ]
  }
}
```

---

### Issue: High memory usage

**Symptom**: App crashes or becomes sluggish after loading multiple screens

**Cause**: Cache not being cleared or too many widgets in memory

**Solution**:
```dart
// Implement cache size limits
class CacheManager {
  static const MAX_CACHE_SIZE = 50; // Maximum cached items
  final Map<String, CachedData> _cache = {};
  
  void cache(String key, dynamic data) {
    if (_cache.length >= MAX_CACHE_SIZE) {
      // Remove oldest item
      final oldestKey = _cache.entries
          .reduce((a, b) => a.value.timestamp.isBefore(b.value.timestamp) ? a : b)
          .key;
      _cache.remove(oldestKey);
    }
    
    _cache[key] = CachedData(data: data, timestamp: DateTime.now());
  }
}

// Clear cache when navigating away
@override
void dispose() {
  CacheManager.instance.clearOldEntries();
  super.dispose();
}
```

---

### Issue: Slow widget rendering

**Symptom**: UI feels laggy or drops frames

**Cause**: Expensive widget builds or unnecessary rebuilds

**Solution**:
1. Use const constructors:
```dart
// ❌ WRONG
return Container(
  child: Text('Hello'),
);

// ✅ CORRECT
return const Text('Hello');
```

2. Implement shouldRebuild:
```dart
class OptimizedWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptimizedWidget &&
          runtimeType == other.runtimeType &&
          data == other.data;
  
  @override
  int get hashCode => data.hashCode;
}
```

3. Use performance monitoring:
```dart
final stopwatch = Stopwatch()..start();
final widget = parseJson(json);
stopwatch.stop();

if (stopwatch.elapsedMilliseconds > 16) {
  print('Warning: Slow widget build (${stopwatch.elapsedMilliseconds}ms)');
}
```

---

## Build and Code Generation Issues

### Issue: Build runner fails

**Symptom**: `build_runner` command fails with errors

**Cause**: Conflicting generated files or syntax errors in source files

**Solution**:
```bash
# Clean build artifacts
flutter clean
flutter pub get

# Delete conflicting outputs
dart run build_runner build --delete-conflicting-outputs

# If still failing, check for syntax errors
flutter analyze
```

---

### Issue: Generated files not updating

**Symptom**: Changes to models not reflected in `.g.dart` files

**Cause**: Build runner not detecting changes or cached build

**Solution**:
```bash
# Force rebuild
dart run build_runner build --delete-conflicting-outputs

# Use watch mode during development
dart run build_runner watch

# Clean and rebuild
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

### Issue: Import errors after code generation

**Symptom**: `part 'file.g.dart' not found` error

**Cause**: Generated file not created or incorrect part directive

**Solution**:
```dart
// Ensure part directive matches filename exactly
// File: my_model.dart
part 'my_model.g.dart'; // ✅ CORRECT

// Common mistakes:
// part 'MyModel.g.dart';  // ❌ Wrong case
// part 'model.g.dart';    // ❌ Wrong name
```

---

## Debugging Tips

### Enable Verbose Logging

```dart
// In main.dart
void main() {
  // Enable verbose logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  
  runApp(MyApp());
}
```

### Use Debug Panel Effectively

1. **STAC Logs Tab**: Monitor all STAC operations in real-time
2. **JSON Playground**: Test JSON configurations in isolation
3. **Visual Editor**: Inspect widget hierarchy and properties
4. **Network Tab**: Monitor API calls and responses

### Inspect JSON at Runtime

```dart
// Add breakpoint and inspect JSON
debugger();
print('JSON: ${jsonEncode(data)}');

// Use JSON viewer in debug panel
DebugPanel.showJson(context, data);
```

### Test with Mock Data First

Always test new features with mock data before integrating with real APIs:

```dart
// Start with mock
final apiService = MockApiService();

// Test thoroughly
await testAllScreens(apiService);

// Then switch to real API
final apiService = FirebaseApiService();
```

### Use Flutter DevTools

```bash
# Launch DevTools
flutter pub global activate devtools
flutter pub global run devtools

# Run app with DevTools
flutter run --observatory-port=9200
```

---

## FAQ

### Q: How do I add a new custom widget?

**A**: Follow these steps:
1. Create widget model with `@JsonSerializable()`
2. Create widget parser extending `StacParser`
3. Register parser in `CustomComponentRegistry`
4. Run `build_runner` to generate code
5. Test in JSON playground

See [Custom Widgets Guide](02-custom-widgets-guide.md) for detailed instructions.

---

### Q: Can I use STAC with existing Flutter widgets?

**A**: Yes! STAC can wrap any Flutter widget. Create a custom parser that returns your existing widget:

```dart
class MyExistingWidgetParser extends StacParser<MyWidgetModel> {
  @override
  Widget parse(BuildContext context, MyWidgetModel model) {
    return MyExistingFlutterWidget(
      title: model.title,
      onTap: () => handleTap(context, model),
    );
  }
}
```

---

### Q: How do I handle navigation in STAC?

**A**: Use navigation actions in your JSON:

```json
{
  "type": "elevatedButton",
  "child": {"type": "text", "data": "Go to Profile"},
  "onPressed": {
    "actionType": "navigate",
    "route": "/profile",
    "arguments": {"userId": "123"}
  }
}
```

---

### Q: Can I use STAC in production?

**A**: Yes, but follow these guidelines:
- Disable debug panel in production builds
- Use custom API (not mock or Firebase for production data)
- Implement proper error handling and fallbacks
- Test thoroughly with real data
- Monitor performance metrics
- Implement security best practices

See [Production Deployment Guide](12-production-deployment.md) for details.

---

### Q: How do I update JSON without redeploying the app?

**A**: Use Firebase or custom API:
1. Upload new JSON to Firebase/API
2. App fetches updated JSON on next launch
3. Use refresh mechanism for immediate updates
4. Implement version checking for compatibility

---

### Q: What happens if JSON parsing fails?

**A**: The framework provides multiple fallback mechanisms:
1. Error is logged to STAC logs
2. Error widget is displayed with details
3. Previous cached version is used if available
4. User can retry or navigate back

```dart
try {
  final widget = StacService.fromJson(json, context);
  return widget;
} catch (e) {
  StacLogger.logError(
    operation: 'parseJson',
    error: e.toString(),
  );
  return ErrorWidget(error: e);
}
```

---

### Q: How do I test custom components?

**A**: Write unit and widget tests:

```dart
// Unit test
test('should serialize to JSON', () {
  final model = MyModel(title: 'Test');
  final json = model.toJson();
  expect(json['title'], 'Test');
});

// Widget test
testWidgets('should render widget', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: MyWidget(model: MyModel(title: 'Test'))),
  );
  expect(find.text('Test'), findsOneWidget);
});
```

See [Testing Guide](04-testing-guide.md) for comprehensive testing strategies.

---

### Q: Can I use STAC with state management libraries?

**A**: Yes! STAC works with Riverpod, Provider, Bloc, and other state management solutions:

```dart
class MyWidgetParser extends StacParser<MyModel> {
  @override
  Widget parse(BuildContext context, MyModel model) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(myStateProvider);
        return MyWidget(model: model, state: state);
      },
    );
  }
}
```

---

### Q: How do I handle authentication in STAC screens?

**A**: Use custom actions for authentication:

```json
{
  "type": "elevatedButton",
  "child": {"type": "text", "data": "Login"},
  "onPressed": {
    "actionType": "authenticate",
    "provider": "google",
    "onSuccess": {
      "actionType": "navigate",
      "route": "/home"
    }
  }
}
```

---

### Q: What's the difference between `.stac/` and `stac/`?

**A**: 
- `.stac/`: Original STAC framework (read-only reference)
- `stac/`: Your custom STAC components (modify here)

Always add custom widgets and actions to `stac/`, never modify `.stac/`.

---

### Q: How do I optimize for large JSON files?

**A**:
1. Enable JSON parse caching
2. Use lazy loading for lists
3. Split large screens into smaller components
4. Implement pagination for data
5. Use compression for network transfer

---

### Q: Can I preview STAC screens before deploying?

**A**: Yes! Use the JSON playground:
1. Open debug panel
2. Go to Playground tab
3. Paste or edit JSON
4. See live preview
5. Export to mock data or Firebase when ready

---

## Getting Help

If you're still experiencing issues:

1. **Check Documentation**: Review all guides in `docs/stac_in_action/`
2. **Search Logs**: Use debug panel to search STAC logs for errors
3. **Test in Playground**: Isolate the issue in JSON playground
4. **Check Examples**: Review example code in `docs/stac_in_action/examples/`
5. **Enable Verbose Logging**: Turn on detailed logging to see what's happening

For additional support, refer to:
- [Getting Started Guide](01-getting-started.md)
- [API Layer Guide](05-api-layer-guide.md)
- [Debug Panel Guide](08-debug-panel-guide.md)

---

**Last Updated**: 2025-01-11
