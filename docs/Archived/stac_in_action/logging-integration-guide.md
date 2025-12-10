# STAC Logging Integration Guide

## Overview

This guide explains how to integrate STAC logging into custom widgets and actions. The logging system provides comprehensive monitoring of STAC operations including screen fetching, JSON parsing, component rendering, and errors.

## Why Add Logging?

Logging provides several benefits:

1. **Performance Monitoring**: Track how long operations take
2. **Error Debugging**: Detailed error information with suggestions
3. **Debug Panel Integration**: View logs in the debug panel
4. **Production Monitoring**: Track issues in production builds

## Logging Components

### 1. StacLogger

The main logger class with static methods for logging different operations:

- `logScreenFetch()` - Log API fetch operations
- `logJsonParsing()` - Log JSON parsing operations
- `logComponentRender()` - Log widget/action rendering
- `logError()` - Log errors with suggestions

### 2. StacLogInterceptor

Utility class that wraps operations with automatic logging:

- `interceptFetch()` - Wrap API fetch operations
- `interceptParsing()` / `interceptParsingSync()` - Wrap JSON parsing
- `interceptRender()` - Wrap component rendering

### 3. StacLogModels

Data models for log entries:

- `StacLogEntry` - A single log entry
- `StacOperationType` - Type of operation (fetch, parse, render, error)
- `ApiSource` - Source of data (mock, firebase, custom)

## Integrating Logging into Custom Widgets

### Step 1: Create Your Widget Model

```dart
import 'package:json_annotation/json_annotation.dart';

part 'my_custom_widget.g.dart';

@JsonSerializable()
class MyCustomWidget {
  final String title;
  final String? subtitle;
  
  const MyCustomWidget({
    required this.title,
    this.subtitle,
  });
  
  factory MyCustomWidget.fromJson(Map<String, dynamic> json) =>
      _$MyCustomWidgetFromJson(json);
  
  Map<String, dynamic> toJson() => _$MyCustomWidgetToJson(this);
  
  // Add this for logging
  Map<String, dynamic> get properties => {
    'title': title,
    'subtitle': subtitle,
  };
}
```

### Step 2: Create Your Parser with Logging

```dart
import 'package:flutter/material.dart';
import 'package:tobank_sdui/core/logging/stac_log_interceptor.dart';
import 'my_custom_widget.dart';

class MyCustomWidgetParser {
  static const String type = 'myCustomWidget';
  
  static Widget parse(
    BuildContext context,
    Map<String, dynamic> json, {
    String? screenName,
  }) {
    // Parse JSON with logging
    final model = StacLogInterceptor.interceptParsingSync<MyCustomWidget>(
      screenName: screenName ?? 'unknown',
      json: json,
      operation: () => MyCustomWidget.fromJson(json),
      additionalMetadata: {
        'widget_type': type,
      },
    );
    
    // Render widget with logging
    return StacLogInterceptor.interceptRender<Widget>(
      componentType: type,
      properties: model.properties,
      screenName: screenName,
      operation: () => _buildWidget(context, model),
    );
  }
  
  static Widget _buildWidget(BuildContext context, MyCustomWidget model) {
    return Card(
      child: ListTile(
        title: Text(model.title),
        subtitle: model.subtitle != null ? Text(model.subtitle!) : null,
      ),
    );
  }
}
```

### Key Points for Widget Logging

1. **Use `interceptParsingSync`** for synchronous JSON parsing
2. **Use `interceptRender`** for widget building
3. **Pass `screenName`** when available for better tracking
4. **Add `additionalMetadata`** for extra context
5. **Implement `properties` getter** on your model for logging

## Integrating Logging into Custom Actions

### Step 1: Create Your Action Model

```dart
import 'package:json_annotation/json_annotation.dart';

part 'my_custom_action.g.dart';

@JsonSerializable()
class MyCustomAction {
  static const String actionType = 'myCustomAction';
  
  final String name;
  final Map<String, dynamic>? parameters;
  
  const MyCustomAction({
    required this.name,
    this.parameters,
  });
  
  factory MyCustomAction.fromJson(Map<String, dynamic> json) =>
      _$MyCustomActionFromJson(json);
  
  Map<String, dynamic> toJson() => _$MyCustomActionToJson(this);
  
  // Add this for logging
  Map<String, dynamic> get properties => {
    'name': name,
    'parameters': parameters,
  };
}
```

### Step 2: Create Your Action Parser with Logging

```dart
import 'package:flutter/material.dart';
import 'package:tobank_sdui/core/logging/stac_log_interceptor.dart';
import 'package:tobank_sdui/core/logging/stac_logger.dart';
import 'my_custom_action.dart';

class MyCustomActionParser {
  static Future<void> parse(
    BuildContext context,
    Map<String, dynamic> json, {
    String? screenName,
  }) async {
    // Parse JSON with logging
    final model = StacLogInterceptor.interceptParsingSync<MyCustomAction>(
      screenName: screenName ?? 'unknown',
      json: json,
      operation: () => MyCustomAction.fromJson(json),
      additionalMetadata: {
        'action_type': MyCustomAction.actionType,
      },
    );
    
    // Execute action with logging
    await _executeAction(context, model, screenName);
  }
  
  static Future<void> _executeAction(
    BuildContext context,
    MyCustomAction model,
    String? screenName,
  ) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      // Your action logic here
      await _doSomething(model);
      
      stopwatch.stop();
      
      // Log successful execution
      StacLogger.logComponentRender(
        componentType: MyCustomAction.actionType,
        properties: model.properties,
        duration: stopwatch.elapsed,
        screenName: screenName,
        additionalMetadata: {
          'action_name': model.name,
        },
      );
    } catch (error, stackTrace) {
      stopwatch.stop();
      
      // Log error
      StacLogger.logError(
        operation: 'Action Execution',
        error: error,
        screenName: screenName,
        suggestion: 'Check action parameters',
        stackTrace: stackTrace,
        additionalMetadata: {
          'action_type': MyCustomAction.actionType,
          'action_name': model.name,
        },
      );
      
      rethrow;
    }
  }
  
  static Future<void> _doSomething(MyCustomAction model) async {
    // Your implementation
  }
}
```

### Key Points for Action Logging

1. **Use `interceptParsingSync`** for JSON parsing
2. **Manually log execution** using `StacLogger.logComponentRender()`
3. **Always log errors** using `StacLogger.logError()`
4. **Measure execution time** with `Stopwatch`
5. **Provide helpful suggestions** in error logs

## API Service Logging

API services automatically log fetch operations when using `StacLogInterceptor.interceptFetch()`:

```dart
@override
Future<Map<String, dynamic>> fetchScreen(String screenName) async {
  return StacLogInterceptor.interceptFetch(
    screenName: screenName,
    source: ApiSource.mock, // or firebase, custom
    operation: () async {
      // Your fetch logic here
      return await _actualFetch(screenName);
    },
    additionalMetadata: {
      'cached': _isCached(screenName),
    },
  );
}
```

## Viewing Logs

### In Debug Panel

1. Open the debug panel
2. Navigate to the "STAC Logs" tab
3. Filter by operation type, source, or screen name
4. Click on a log entry to see details

### In Console

All STAC logs are also output to the console via `AppLogger`:

- 📱 Screen Fetch
- 🔄 JSON Parsing
- 🎨 Component Render
- ❌ Errors

### Programmatically

```dart
// Get all logs
final logs = StacLogger.instance.logEntries;

// Get logs by type
final fetchLogs = StacLogger.instance.getLogsByType(StacOperationType.fetch);

// Get errors
final errors = StacLogger.instance.getErrors();

// Get slow operations
final slowOps = StacLogger.instance.getSlowOperations();

// Get statistics
final stats = StacLogger.instance.getStatistics();
```

## Performance Thresholds

The logging system automatically warns about slow operations:

- **Screen Fetch**: > 1000ms
- **JSON Parsing**: > 100ms
- **Component Render**: > 16ms (60fps threshold)

## Best Practices

1. **Always add logging** to custom components
2. **Use descriptive metadata** for better debugging
3. **Provide helpful error suggestions** when logging errors
4. **Keep operation names consistent** across your codebase
5. **Test logging** in development before deploying
6. **Monitor slow operations** and optimize as needed
7. **Clear logs periodically** in long-running apps

## Example: Complete Custom Widget with Logging

See `stac/widgets/example_card/` for a complete example of a custom widget with integrated logging.

## Example: Complete Custom Action with Logging

See `stac/actions/example_action/` for a complete example of a custom action with integrated logging.

## Troubleshooting

### Logs not appearing in debug panel

- Ensure debug panel is enabled in your app configuration
- Check that you're using the correct logging methods
- Verify the STAC logs tab is implemented in your debug panel

### Performance warnings

- Review the operation that's slow
- Consider caching or optimization
- Check for unnecessary rebuilds or re-parsing

### Missing metadata in logs

- Ensure you implement the `properties` getter on your models
- Pass `additionalMetadata` when calling logging methods
- Include `screenName` parameter when available

## Summary

Integrating logging into your custom STAC components:

1. ✅ Add `properties` getter to your models
2. ✅ Use `StacLogInterceptor` for parsing and rendering
3. ✅ Manually log action execution with `StacLogger`
4. ✅ Always log errors with helpful suggestions
5. ✅ Include relevant metadata for debugging
6. ✅ Test logging in development

With proper logging integration, you'll have comprehensive visibility into your STAC application's behavior and performance.
