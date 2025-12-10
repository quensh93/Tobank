import 'package:tobank_sdui/core/logging/stac_log_models.dart';
import 'package:tobank_sdui/core/logging/stac_logger.dart';

/// Interceptor for STAC operations to automatically log them
///
/// This class provides utility methods to wrap STAC operations with logging.
/// It measures execution time and logs the results automatically.
class StacLogInterceptor {
  /// Intercept and log an API fetch operation
  ///
  /// Wraps an API fetch operation, measures its duration, and logs the result.
  ///
  /// Example:
  /// ```dart
  /// final json = await StacLogInterceptor.interceptFetch(
  ///   screenName: 'home_screen',
  ///   source: ApiSource.mock,
  ///   operation: () => apiService.fetchScreen('home_screen'),
  /// );
  /// ```
  static Future<Map<String, dynamic>> interceptFetch({
    required String screenName,
    required ApiSource source,
    required Future<Map<String, dynamic>> Function() operation,
    Map<String, dynamic>? additionalMetadata,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      final result = await operation();
      stopwatch.stop();

      // Calculate JSON size
      final jsonSize = result.toString().length;

      // Log the successful fetch
      StacLogger.logScreenFetch(
        screenName: screenName,
        source: source,
        duration: stopwatch.elapsed,
        jsonSize: jsonSize,
        additionalMetadata: additionalMetadata,
      );

      return result;
    } catch (error, stackTrace) {
      stopwatch.stop();

      // Log the error
      StacLogger.logError(
        operation: 'Screen Fetch',
        error: error,
        screenName: screenName,
        suggestion: 'Check network connection and API configuration',
        stackTrace: stackTrace,
        additionalMetadata: {
          'source': source.name,
          ...?additionalMetadata,
        },
      );

      rethrow;
    }
  }

  /// Intercept and log a JSON parsing operation
  ///
  /// Wraps a JSON parsing operation, measures its duration, extracts widget types,
  /// and logs the result.
  ///
  /// Example:
  /// ```dart
  /// final widget = await StacLogInterceptor.interceptParsing(
  ///   screenName: 'home_screen',
  ///   json: jsonData,
  ///   operation: () => parseStacJson(jsonData),
  /// );
  /// ```
  static Future<T> interceptParsing<T>({
    required String screenName,
    required Map<String, dynamic> json,
    required Future<T> Function() operation,
    Map<String, dynamic>? additionalMetadata,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      final result = await operation();
      stopwatch.stop();

      // Extract widget types from JSON
      final widgetTypes = _extractWidgetTypes(json);

      // Check for validation warnings
      final warnings = _checkForWarnings(json);

      // Log the successful parsing
      StacLogger.logJsonParsing(
        screenName: screenName,
        widgetTypes: widgetTypes,
        duration: stopwatch.elapsed,
        warnings: warnings.isNotEmpty ? warnings : null,
        additionalMetadata: additionalMetadata,
      );

      return result;
    } catch (error, stackTrace) {
      stopwatch.stop();

      // Try to determine where in the JSON the error occurred
      final jsonPath = _findErrorPath(json, error);

      // Log the error
      StacLogger.logError(
        operation: 'JSON Parsing',
        error: error,
        screenName: screenName,
        jsonPath: jsonPath,
        suggestion: 'Check JSON structure matches STAC schema',
        stackTrace: stackTrace,
        additionalMetadata: additionalMetadata,
      );

      rethrow;
    }
  }

  /// Intercept and log a synchronous JSON parsing operation
  ///
  /// Similar to [interceptParsing] but for synchronous operations.
  static T interceptParsingSync<T>({
    required String screenName,
    required Map<String, dynamic> json,
    required T Function() operation,
    Map<String, dynamic>? additionalMetadata,
  }) {
    final stopwatch = Stopwatch()..start();

    try {
      final result = operation();
      stopwatch.stop();

      // Extract widget types from JSON
      final widgetTypes = _extractWidgetTypes(json);

      // Check for validation warnings
      final warnings = _checkForWarnings(json);

      // Log the successful parsing
      StacLogger.logJsonParsing(
        screenName: screenName,
        widgetTypes: widgetTypes,
        duration: stopwatch.elapsed,
        warnings: warnings.isNotEmpty ? warnings : null,
        additionalMetadata: additionalMetadata,
      );

      return result;
    } catch (error, stackTrace) {
      stopwatch.stop();

      // Try to determine where in the JSON the error occurred
      final jsonPath = _findErrorPath(json, error);

      // Log the error
      StacLogger.logError(
        operation: 'JSON Parsing',
        error: error,
        screenName: screenName,
        jsonPath: jsonPath,
        suggestion: 'Check JSON structure matches STAC schema',
        stackTrace: stackTrace,
        additionalMetadata: additionalMetadata,
      );

      rethrow;
    }
  }

  /// Intercept and log a component rendering operation
  ///
  /// Wraps a component rendering operation, measures its duration, and logs the result.
  ///
  /// Example:
  /// ```dart
  /// final widget = StacLogInterceptor.interceptRender(
  ///   componentType: 'CustomCard',
  ///   properties: {'title': 'Hello', 'subtitle': 'World'},
  ///   operation: () => CustomCardWidget(title: 'Hello', subtitle: 'World'),
  /// );
  /// ```
  static T interceptRender<T>({
    required String componentType,
    required Map<String, dynamic> properties,
    required T Function() operation,
    String? screenName,
    Map<String, dynamic>? additionalMetadata,
  }) {
    final stopwatch = Stopwatch()..start();

    try {
      final result = operation();
      stopwatch.stop();

      // Log the successful render
      StacLogger.logComponentRender(
        componentType: componentType,
        properties: properties,
        duration: stopwatch.elapsed,
        screenName: screenName,
        additionalMetadata: additionalMetadata,
      );

      return result;
    } catch (error, stackTrace) {
      stopwatch.stop();

      // Log the error
      StacLogger.logError(
        operation: 'Component Render',
        error: error,
        screenName: screenName,
        suggestion: 'Check component properties and implementation',
        stackTrace: stackTrace,
        additionalMetadata: {
          'component_type': componentType,
          'properties': properties.keys.join(', '),
          ...?additionalMetadata,
        },
      );

      rethrow;
    }
  }

  /// Extract widget types from JSON recursively
  static List<String> _extractWidgetTypes(Map<String, dynamic> json) {
    final types = <String>[];

    void extractTypes(dynamic value) {
      if (value is Map<String, dynamic>) {
        // Check if this map represents a widget
        if (value.containsKey('type')) {
          final type = value['type'];
          if (type is String) {
            types.add(type);
          }
        }

        // Recursively check all values
        for (final v in value.values) {
          extractTypes(v);
        }
      } else if (value is List) {
        // Recursively check list items
        for (final item in value) {
          extractTypes(item);
        }
      }
    }

    extractTypes(json);
    return types;
  }

  /// Check for common validation warnings in JSON
  static List<String> _checkForWarnings(Map<String, dynamic> json) {
    final warnings = <String>[];

    void checkNode(dynamic value, String path) {
      if (value is Map<String, dynamic>) {
        // Check for missing type
        if (!value.containsKey('type')) {
          warnings.add('Missing "type" field at $path');
        }

        // Check for unknown fields (this is a simplified check)
        // In a real implementation, you'd validate against a schema

        // Recursively check children
        value.forEach((key, val) {
          checkNode(val, '$path.$key');
        });
      } else if (value is List) {
        for (var i = 0; i < value.length; i++) {
          checkNode(value[i], '$path[$i]');
        }
      }
    }

    checkNode(json, 'root');
    return warnings;
  }

  /// Try to find the path in JSON where an error occurred
  static String _findErrorPath(Map<String, dynamic> json, dynamic error) {
    // This is a simplified implementation
    // In a real implementation, you'd parse the error message to extract the path
    final errorStr = error.toString().toLowerCase();

    // Look for common error patterns
    if (errorStr.contains('type')) {
      return 'root.type';
    } else if (errorStr.contains('child')) {
      return 'root.child';
    } else if (errorStr.contains('children')) {
      return 'root.children';
    }

    return 'unknown';
  }

  /// Measure and log the duration of any operation
  ///
  /// Generic utility for measuring and logging any operation.
  static T measureOperation<T>({
    required String operationName,
    required T Function() operation,
    void Function(Duration duration)? onComplete,
  }) {
    final stopwatch = Stopwatch()..start();

    try {
      final result = operation();
      stopwatch.stop();

      onComplete?.call(stopwatch.elapsed);

      return result;
    } catch (error) {
      stopwatch.stop();
      rethrow;
    }
  }

  /// Measure and log the duration of any async operation
  static Future<T> measureOperationAsync<T>({
    required String operationName,
    required Future<T> Function() operation,
    void Function(Duration duration)? onComplete,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      final result = await operation();
      stopwatch.stop();

      onComplete?.call(stopwatch.elapsed);

      return result;
    } catch (error) {
      stopwatch.stop();
      rethrow;
    }
  }
}
