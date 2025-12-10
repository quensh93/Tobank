import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

/// Error handler for STAC Test App operations
/// 
/// Provides user-friendly error messages and error categorization
class StacErrorHandler {
  /// Get user-friendly error message from exception
  static String getUserFriendlyMessage(dynamic error) {
    if (error is FileSystemException) {
      return _handleFileSystemError(error);
    } else if (error is FormatException) {
      return _handleFormatError(error);
    } else if (error is DioException) {
      return _handleNetworkError(error);
    } else if (error is EntryPointValidationException) {
      return error.message;
    } else if (error is ScreenValidationException) {
      return error.message;
    } else {
      return 'An unexpected error occurred: ${error.toString()}';
    }
  }

  /// Handle file system errors
  static String _handleFileSystemError(FileSystemException error) {
    final message = error.message;
    final path = error.path ?? 'unknown path';

    if (message.contains('not found') || message.contains('File not found')) {
      return 'File not found: $path\n\nPlease check that the file exists and the path is correct.';
    } else if (message.contains('Permission denied')) {
      return 'Permission denied: $path\n\nPlease check file permissions and try again.';
    } else if (message.contains('directory')) {
      return 'Directory error: $path\n\n$message';
    } else {
      return 'File system error: $message\n\nPath: $path';
    }
  }

  /// Handle format/JSON errors
  static String _handleFormatError(FormatException error) {
    final message = error.message;
    final offset = error.offset;
    final source = error.source;

    String locationInfo = '';
    if (offset != null && source != null) {
      // Calculate line and column
      final lines = source.toString().split('\n');
      int currentOffset = 0;
      int lineNumber = 1;
      int columnNumber = 1;

      for (final line in lines) {
        if (currentOffset + line.length >= offset) {
          columnNumber = offset - currentOffset + 1;
          break;
        }
        currentOffset += line.length + 1; // +1 for newline
        lineNumber++;
      }

      locationInfo = '\n\nError at line $lineNumber, column $columnNumber';
      if (lineNumber <= lines.length) {
        final errorLine = lines[lineNumber - 1];
        locationInfo += ':\n$errorLine';
        if (columnNumber <= errorLine.length) {
          locationInfo += '\n${' ' * (columnNumber - 1)}^';
        }
      }
    }

    return 'Invalid JSON format: $message$locationInfo';
  }

  /// Handle network errors
  static String _handleNetworkError(DioException error) {
    final url = error.requestOptions.path;
    
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'Network timeout: Failed to load from URL\n\n$url\n\nPlease check your internet connection and try again.';
    } else if (error.type == DioExceptionType.connectionError) {
      return 'Connection error: Cannot reach URL\n\n$url\n\nPlease check your internet connection.';
    } else if (error.response != null) {
      final statusCode = error.response!.statusCode;
      return 'HTTP error $statusCode: Failed to load from URL\n\n$url\n\nServer returned an error.';
    } else {
      return 'Network error: Failed to load from URL\n\n$url\n\n${error.message}';
    }
  }

  /// Validate entry point JSON structure
  static void validateEntryPoint(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw EntryPointValidationException('Entry point file is empty');
    }

    if (!json.containsKey('initial_screen')) {
      throw EntryPointValidationException(
        'Entry point is missing required field: "initial_screen"',
      );
    }

    if (!json.containsKey('screens')) {
      throw EntryPointValidationException(
        'Entry point is missing required field: "screens"',
      );
    }

    final screens = json['screens'];
    if (screens is! Map || screens.isEmpty) {
      throw EntryPointValidationException(
        'Entry point has no screens defined',
      );
    }

    final initialScreen = json['initial_screen'] as String;
    if (!screens.containsKey(initialScreen)) {
      throw EntryPointValidationException(
        'Initial screen "$initialScreen" is not defined in screens',
      );
    }

    // Validate each screen configuration
    for (final entry in screens.entries) {
      final screenName = entry.key;
      final screenConfig = entry.value;

      if (screenConfig is! Map) {
        throw EntryPointValidationException(
          'Screen "$screenName" has invalid configuration',
        );
      }

      if (!screenConfig.containsKey('template')) {
        throw EntryPointValidationException(
          'Screen "$screenName" is missing required field: "template"',
        );
      }

      if (!screenConfig.containsKey('data')) {
        throw EntryPointValidationException(
          'Screen "$screenName" is missing required field: "data"',
        );
      }
    }
  }

  /// Validate screen JSON structure
  static void validateScreenJson(Map<String, dynamic> json, String screenName) {
    if (json.isEmpty) {
      throw ScreenValidationException(
        'Screen "$screenName" template or data file is empty',
      );
    }

    // Basic validation - check if it's a valid JSON object
    // More specific STAC validation can be added later
  }

  /// Check for empty file content
  static bool isEmptyFile(String content) {
    return content.trim().isEmpty;
  }

  /// Check if JSON is too large (optional limit)
  static bool isJsonTooLarge(String content, {int maxSizeMB = 10}) {
    final sizeInBytes = utf8.encode(content).length;
    final sizeInMB = sizeInBytes / (1024 * 1024);
    return sizeInMB > maxSizeMB;
  }

  /// Validate file path for special characters
  static bool hasInvalidPathCharacters(String path) {
    // Check for invalid characters in file paths
    // Windows: < > : " | ? * \
    // Unix: / (but / is allowed in paths, just not at the end for filenames)
    final invalidChars = RegExp(r'[<>:"|?*\x00-\x1f]');
    return invalidChars.hasMatch(path);
  }
}

/// Custom exception for entry point validation errors
class EntryPointValidationException implements Exception {
  final String message;

  EntryPointValidationException(this.message);

  @override
  String toString() => message;
}

/// Custom exception for screen validation errors
class ScreenValidationException implements Exception {
  final String message;

  ScreenValidationException(this.message);

  @override
  String toString() => message;
}

