import 'dart:async';
import 'package:universal_html/html.dart' as html;
import 'package:sentry_flutter/sentry_flutter.dart';

/// Service for handling web-specific file processing operations
class WebFileProcessingService {
  static final WebFileProcessingService _instance = WebFileProcessingService._internal();

  factory WebFileProcessingService() {
    return _instance;
  }

  WebFileProcessingService._internal();

  /// Processes a web file and returns its base64 representation
  ///
  /// Parameters:
  /// - [path]: The blob URL or path to the file
  /// - [type]: The type of file being processed (for logging)
  ///
  /// Returns a Future that completes with the base64 string
  ///
  /// Throws an error if file processing fails
  Future<String> processWebFile({
    required String path,
    required String type,
  }) async {
    print('🌐 Starting web file processing for $type: $path');

    if (path.isEmpty) {
      throw Exception('File path is empty');
    }

    final completer = Completer<String>();
    final xhr = html.HttpRequest();
    StreamSubscription? loadSubscription;
    StreamSubscription? errorSubscription;
    StreamSubscription? readerSubscription;

    try {
      xhr.open('GET', path);
      xhr.responseType = 'blob';

      loadSubscription = xhr.onLoad.listen((event) {
        try {
          if (xhr.response == null) {
            throw Exception('XHR Response is null');
          }

          final blob = xhr.response as html.Blob;
          final reader = html.FileReader();

          readerSubscription = reader.onLoadEnd.listen((event) {
            try {
              if (reader.result == null) {
                throw Exception('FileReader result is null');
              }

              final result = reader.result as String;
              if (!result.contains('base64,')) {
                throw Exception('Invalid base64 data');
              }

              final String base64Data = result.split('base64,')[1];
              completer.complete(base64Data);
            } catch (e) {
              _handleError('Error in FileReader onLoadEnd', e);
              completer.completeError(e);
            }
          });

          reader.onError.listen((event) {
            final error = Exception('FileReader error: ${reader.error}');
            _handleError('FileReader error', error);
            completer.completeError(error);
          });

          reader.readAsDataUrl(blob);
        } catch (e) {
          _handleError('Error in XHR onLoad', e);
          completer.completeError(e);
        }
      });

      errorSubscription = xhr.onError.listen((event) {
        final error = Exception('Failed to load $type: ${xhr.statusText}');
        _handleError('XHR error', error);
        completer.completeError(error);
      });

      xhr.send();
    } catch (e) {
      _handleError('General error in web file processing', e);
      completer.completeError(e);
    }

    try {
      return await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw TimeoutException('File processing timed out'),
      );
    } finally {
      // Clean up subscriptions
      loadSubscription?.cancel();
      errorSubscription?.cancel();
      readerSubscription?.cancel();
    }
  }

  /// Process multiple web files concurrently
  ///
  /// Parameters:
  /// - [files]: List of file paths and their types to process
  ///
  /// Returns a Future that completes with a list of base64 strings
  Future<List<String>> processMultipleWebFiles(
      List<({String path, String type})> files,
      ) async {
    print('🌐 Processing multiple web files: ${files.length} files');

    try {
      final results = await Future.wait(
        files.map((file) => processWebFile(
          path: file.path,
          type: file.type,
        )),
        eagerError: true,
      );

      print('🌐 Successfully processed ${results.length} files');
      return results;
    } catch (e) {
      _handleError('Error processing multiple files', e);
      rethrow;
    }
  }

  void _handleError(String context, Object error) {
    print('🔴 $context: $error');
    Sentry.captureException(
      error,
      stackTrace: StackTrace.current,
    );
  }
}

/// Extension to provide more convenient access to the service
extension WebFileProcessingServiceExtension on WebFileProcessingService {
  /// Processes an image file and returns its base64 representation
  Future<String> processImageFile(String path) {
    return processWebFile(
      path: path,
      type: 'image',
    );
  }

  /// Processes a video file and returns its base64 representation
  Future<String> processVideoFile(String path) {
    return processWebFile(
      path: path,
      type: 'video',
    );
  }
}