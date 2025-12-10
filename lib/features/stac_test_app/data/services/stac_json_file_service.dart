import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/helpers/logger.dart';

/// Service for loading JSON files from local file system or URLs
/// 
/// Supports:
/// - Local file paths (relative to project root or base directory)
/// - Absolute file paths
/// - HTTP/HTTPS URLs (Supabase, etc.)
/// - Optional caching for URL-fetched JSON
class StacJsonFileService {
  /// Cache for URL-fetched JSON (optional, can be disabled)
  static final Map<String, Map<String, dynamic>> _urlCache = {};
  static bool _cacheEnabled = true;

  /// Enable or disable URL caching
  static void setCacheEnabled(bool enabled) {
    _cacheEnabled = enabled;
    if (!enabled) {
      _urlCache.clear();
    }
  }

  /// Clear the URL cache
  static void clearCache() {
    _urlCache.clear();
    AppLogger.i('✅ URL cache cleared');
  }
  /// Load JSON from file path or URL
  /// 
  /// Supports:
  /// - Local file paths (relative to project root or baseDir)
  /// - Absolute file paths
  /// - HTTP/HTTPS URLs (Supabase, etc.)
  /// 
  /// [path] - File path or URL
  /// [baseDir] - Optional base directory for resolving relative paths
  ///             (e.g., entry point directory for resolving template/data paths)
  static Future<Map<String, dynamic>> loadJson(
    String path, {
    String? baseDir,
  }) async {
    try {
      // Check if path is a URL
      if (path.startsWith('http://') || path.startsWith('https://')) {
        return await _loadFromUrl(path);
      } else {
        return await _loadFromFile(path, baseDir: baseDir);
      }
    } catch (e, stackTrace) {
      AppLogger.e('Failed to load JSON from: $path', e, stackTrace);
      rethrow;
    }
  }

  /// Load JSON from local file
  /// 
  /// [filePath] - File path (relative or absolute)
  /// [baseDir] - Optional base directory for resolving relative paths
  static Future<Map<String, dynamic>> _loadFromFile(
    String filePath, {
    String? baseDir,
  }) async {
    try {
      // Resolve path relative to baseDir or project root
      final resolvedPath = _resolvePath(filePath, baseDir: baseDir);
      final file = File(resolvedPath);

      if (!await file.exists()) {
        throw FileSystemException(
          'File not found: $resolvedPath',
          resolvedPath,
        );
      }

      // Check read permissions
      try {
        await file.readAsString();
      } on FileSystemException catch (e) {
        if (e.osError?.errorCode == 13 || e.osError?.errorCode == 5) {
          // Permission denied (Unix: 13, Windows: 5)
          throw FileSystemException(
            'Permission denied: Cannot read file $resolvedPath',
            resolvedPath,
            e.osError,
          );
        }
        rethrow;
      }

      final content = await file.readAsString();
      
      // Check for empty file
      if (content.trim().isEmpty) {
        throw FormatException(
          'File is empty: $resolvedPath',
        );
      }
      
      // Check file size (warn if very large, but don't block)
      final sizeInMB = utf8.encode(content).length / (1024 * 1024);
      if (sizeInMB > 10) {
        AppLogger.w('⚠️ Large JSON file detected: ${sizeInMB.toStringAsFixed(2)} MB - $resolvedPath');
      }
      
      // Validate JSON format
      try {
        final json = jsonDecode(content) as Map<String, dynamic>;
        
        // Validate it's a Map (not a List or primitive)
        if (json.isEmpty) {
          throw FormatException(
            'JSON file is empty (no content): $resolvedPath',
          );
        }
        
        AppLogger.i('✅ Loaded JSON from file: $resolvedPath');
        return json;
      } on FormatException catch (e) {
        throw FormatException(
          'Invalid JSON format in file $resolvedPath: ${e.message}',
          e.source,
          e.offset,
        );
      }
    } on FileSystemException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      AppLogger.e('Failed to load JSON from file: $filePath', e);
      rethrow;
    }
  }

  /// Load JSON from URL
  /// 
  /// Supports caching to reduce network requests
  static Future<Map<String, dynamic>> _loadFromUrl(String url) async {
    // Check cache first
    if (_cacheEnabled && _urlCache.containsKey(url)) {
      AppLogger.d('📦 Loaded JSON from cache: $url');
      return _urlCache[url]!;
    }

    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      final response = await dio.get(url);

      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: RequestOptions(path: url),
          response: response,
          message: 'Failed to load JSON from URL: $url (Status: ${response.statusCode})',
        );
      }

      // Validate response data
      if (response.data == null) {
        throw DioException(
          requestOptions: RequestOptions(path: url),
          message: 'Empty response from URL: $url',
        );
      }

      // Parse JSON
      Map<String, dynamic> json;
      try {
        if (response.data is Map) {
          json = response.data as Map<String, dynamic>;
        } else if (response.data is String) {
          json = jsonDecode(response.data as String) as Map<String, dynamic>;
        } else {
          throw FormatException('Invalid response format from URL: $url');
        }
      } on FormatException catch (e) {
        throw FormatException(
          'Invalid JSON format in response from URL $url: ${e.message}',
          e.source,
          e.offset,
        );
      }

      // Cache the result
      if (_cacheEnabled) {
        _urlCache[url] = json;
      }

      AppLogger.i('✅ Loaded JSON from URL: $url');
      return json;
    } on DioException catch (e) {
      // Provide user-friendly error messages
      String errorMessage;
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Network timeout: Failed to load JSON from URL: $url';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'Connection error: Cannot reach URL: $url';
      } else if (e.response != null) {
        errorMessage =
            'HTTP error ${e.response!.statusCode}: Failed to load JSON from URL: $url';
      } else {
        errorMessage = 'Network error: Failed to load JSON from URL: $url';
      }

      AppLogger.e(errorMessage, e);
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.error,
        message: errorMessage,
      );
    } catch (e) {
      AppLogger.e('Failed to load JSON from URL: $url', e);
      rethrow;
    }
  }

  /// Resolve relative path to absolute path
  /// 
  /// If path is relative, resolves it relative to baseDir (if provided) or project root
  /// If path is absolute, returns as is
  /// 
  /// [path] - File path to resolve
  /// [baseDir] - Optional base directory for resolving relative paths
  ///            (e.g., entry point directory for resolving template/data paths)
  static String _resolvePath(String path, {String? baseDir}) {
    // If path starts with /, it's already absolute (Unix-style)
    // On Windows, absolute paths start with drive letter (C:\, D:\, etc.)
    if (_isAbsolutePath(path)) {
      return path;
    }

    // Determine base directory
    final baseDirectory = baseDir ?? Directory.current.path;
    
    // Handle both forward and backward slashes
    final normalizedPath = path.replaceAll('/', Platform.pathSeparator);
    final normalizedBase = baseDirectory.replaceAll('/', Platform.pathSeparator);
    
    // Resolve relative to base directory
    // Remove trailing separator from base if present
    final cleanBase = normalizedBase.endsWith(Platform.pathSeparator)
        ? normalizedBase.substring(0, normalizedBase.length - 1)
        : normalizedBase;
    
    return '$cleanBase${Platform.pathSeparator}$normalizedPath';
  }

  /// Check if path is absolute
  static bool _isAbsolutePath(String path) {
    // Unix-style absolute path
    if (path.startsWith('/')) {
      return true;
    }
    
    // Windows-style absolute path (C:\, D:\, etc.)
    if (path.length > 2 && path[1] == ':' && path[2] == '\\') {
      return true;
    }
    
    // Windows-style absolute path with forward slash (C:/, D:/, etc.)
    if (path.length > 2 && path[1] == ':' && path[2] == '/') {
      return true;
    }
    
    return false;
  }

  /// Write JSON to file
  /// 
  /// [filePath] - File path (relative or absolute)
  /// [json] - JSON data to write
  /// [baseDir] - Optional base directory for resolving relative paths
  static Future<void> writeJson(
    String filePath,
    Map<String, dynamic> json, {
    String? baseDir,
  }) async {
    try {
      final resolvedPath = _resolvePath(filePath, baseDir: baseDir);
      final file = File(resolvedPath);
      
      // Ensure directory exists
      try {
        await file.parent.create(recursive: true);
      } on FileSystemException catch (e) {
        if (e.osError?.errorCode == 13 || e.osError?.errorCode == 5) {
          // Permission denied
          throw FileSystemException(
            'Permission denied: Cannot create directory for file $resolvedPath',
            resolvedPath,
            e.osError,
          );
        }
        rethrow;
      }

      // Encode JSON
      final content = jsonEncode(json);
      
      // Write file
      try {
        await file.writeAsString(content);
      } on FileSystemException catch (e) {
        if (e.osError?.errorCode == 13 || e.osError?.errorCode == 5) {
          // Permission denied
          throw FileSystemException(
            'Permission denied: Cannot write to file $resolvedPath',
            resolvedPath,
            e.osError,
          );
        }
        rethrow;
      }
      
      AppLogger.i('✅ Wrote JSON to file: $resolvedPath');
    } on FileSystemException {
      rethrow;
    } catch (e) {
      AppLogger.e('Failed to write JSON to file: $filePath', e);
      rethrow;
    }
  }
}

