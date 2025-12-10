import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_io/io.dart';

// Value Objects
class ImageValidationConfig {
  final double maxSizeInBytes;
  final List<String> allowedMimeTypes;
  final int? minWidth;
  final int? minHeight;
  final int? maxWidth;
  final int? maxHeight;

  const ImageValidationConfig({
    required this.maxSizeInBytes,
    this.allowedMimeTypes = const ['image/jpeg', 'image/png'],
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
  });
}

class ValidationResult {
  final bool isValid;
  final String? errorMessage;
  final String? base64Data;
  final Map<String, dynamic>? metadata;

  const ValidationResult({
    required this.isValid,
    this.errorMessage,
    this.base64Data,
    this.metadata,
  });

  factory ValidationResult.success({
    required String base64Data,
    Map<String, dynamic>? metadata,
  }) =>
      ValidationResult(
        isValid: true,
        base64Data: base64Data,
        metadata: metadata,
      );

  factory ValidationResult.failure(String message) => ValidationResult(
    isValid: false,
    errorMessage: message,
  );
}

// Abstract class for validation rules
abstract class ValidationRule {
  Future<bool> validate(File file, ImageValidationConfig config);
  String get errorMessage;
}

// Concrete validation rules
class FileSizeValidationRule implements ValidationRule {
  @override
  Future<bool> validate(File file, ImageValidationConfig config) async {
    final size = await _getFileSize(file);
    return size != null && size <= config.maxSizeInBytes;
  }

  Future<int?> _getFileSize(File file) async {
    print('🔵 Getting file size for: ${file.path}');
    try {
      if (kIsWeb) {
        print('🔵 Using web file size calculation');
        final blobUrl = file.path;
        final xhr = html.HttpRequest();
        final completer = Completer<int>();

        xhr.open('GET', blobUrl);
        xhr.responseType = 'blob';

        xhr.onLoad.listen((event) {
          final blob = xhr.response as html.Blob;
          print('🔵 Web file size: ${blob.size} bytes');
          completer.complete(blob.size);
        });

        xhr.onError.listen((event) {
          print('🔵 Error getting web file size: ${event.toString()}');
          completer.completeError('Failed to load blob');
        });

        xhr.send();

        return await completer.future;
      } else {
        final size = await file.length();
        print('🔵 Native file size: $size bytes');
        return size;
      }
    } catch (e, stackTrace) {
      print('🔵 Error getting file size: $e');
      await Sentry.captureException(e, stackTrace: stackTrace);
      return null;
    }
  }

  @override
  String get errorMessage => 'File size exceeds maximum allowed size';
}

// Main Service
class ImageValidationService {
  final List<ValidationRule> _validationRules;

  ImageValidationService({List<ValidationRule>? validationRules})
      : _validationRules = validationRules ?? [FileSizeValidationRule()];

  Future<ValidationResult> validateImage(
      File file,
      ImageValidationConfig config,
      ) async {
    try {
      // Run all validation rules
      for (final rule in _validationRules) {
        final isValid = await rule.validate(file, config);
        if (!isValid) {
          return ValidationResult.failure(rule.errorMessage);
        }
      }

      // If all validations pass, convert to base64
      print('🔵 All validation rules passed, converting to base64');
      final base64Data = await convertToBase64(file);
      if (base64Data == null) {
        print('🔵 Base64 conversion failed');
        return ValidationResult.failure('Failed to process image');
      }

      print('🔵 Image validation completed successfully');
      return ValidationResult.success(
        base64Data: base64Data,
        metadata: await _extractMetadata(file),
      );
    } catch (e, stackTrace) {
      print('🔵 Error in image validation process: $e');
      await Sentry.captureException(e, stackTrace: stackTrace);
      return ValidationResult.failure('Validation failed: ${e.toString()}');
    }
  }

  Future<String?> convertToBase64(File file) async {
    print('🔵 Converting file to base64: ${file.path}');
    try {
      if (kIsWeb) {
        print('🔵 Using web base64 conversion');
        final xhr = html.HttpRequest();
        final completer = Completer<String>();

        xhr.open('GET', file.path);
        xhr.responseType = 'blob';

        xhr.onLoad.listen((event) async {
          final blob = xhr.response as html.Blob;
          final reader = html.FileReader();

          reader.onLoadEnd.listen((event) {
            print('🔵 Web file successfully converted to base64');
            final String result = (reader.result as String)
                .replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
            completer.complete(result);
          });

          reader.readAsDataUrl(blob);
        });

        xhr.onError.listen((event) {
          print('🔵 Error in web base64 conversion: ${event.toString()}');
          completer.completeError('Failed to load blob');
        });

        xhr.send();

        return await completer.future;
      } else {
        print('🔵 Using native base64 conversion');
        final bytes = await file.readAsBytes();
        final result = base64Encode(bytes);
        print('🔵 Native file successfully converted to base64');
        return result;
      }
    } catch (e, stackTrace) {
      print('🔵 Error converting to base64: $e');
      await Sentry.captureException(e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<Map<String, dynamic>> _extractMetadata(File file) async {
    // Implement metadata extraction (size, dimensions, etc.)
    return {};
  }
}

// Usage Example
class ImageValidationPresets {
  static const ImageValidationConfig nationalIdFront = ImageValidationConfig(
    maxSizeInBytes: 2 * 1024 * 1024, // 2MB
    allowedMimeTypes: ['image/jpeg', 'image/png'],
    minWidth: 800,
    minHeight: 600,
  );

  static const ImageValidationConfig profilePhoto = ImageValidationConfig(
    maxSizeInBytes: 1 * 1024 * 1024, // 1MB
    allowedMimeTypes: ['image/jpeg'],
    minWidth: 400,
    minHeight: 400,
  );
}