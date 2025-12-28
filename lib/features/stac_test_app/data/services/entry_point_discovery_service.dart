import 'package:universal_io/io.dart';
import '../../../../core/helpers/logger.dart';
import 'package:flutter/foundation.dart';

/// Service for discovering entry point JSON files in the mock/ folder
class EntryPointDiscoveryService {
  /// Entry point file names to search for
  static const List<String> entryPointNames = [
    'app_entry_point.json',
    'config.json', // Backward compatibility
  ];

  /// Discover all entry point files in the mock/ folder
  ///
  /// Returns a list of entry point file paths (relative to project root)
  /// Returns empty list if mock/ folder doesn't exist or on error
  static Future<List<String>> discoverEntryPoints() async {
    try {
      if (kIsWeb) {
        AppLogger.w(
          'Entry point discovery is not supported on web (no file system access)',
        );
        return [];
      }
      final mockDir = Directory('mock');

      if (!await mockDir.exists()) {
        AppLogger.w('mock/ folder does not exist');
        return [];
      }

      final entryPoints = <String>[];
      await _scanDirectory(mockDir, entryPoints);

      AppLogger.i('✅ Discovered ${entryPoints.length} entry point files');
      return entryPoints;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to discover entry point files', e, stackTrace);
      return [];
    }
  }

  /// Recursively scan directory for entry point files
  static Future<void> _scanDirectory(
    Directory directory,
    List<String> entryPoints,
  ) async {
    try {
      await for (final entity in directory.list()) {
        if (entity is File) {
          final fileName = entity.path.split(Platform.pathSeparator).last;
          if (entryPointNames.contains(fileName)) {
            // Store relative path from project root
            final relativePath = _getRelativePath(entity.path);
            entryPoints.add(relativePath);
            AppLogger.d('Found entry point: $relativePath');
          }
        } else if (entity is Directory) {
          // Recursively scan subdirectories
          await _scanDirectory(entity, entryPoints);
        }
      }
    } catch (e) {
      AppLogger.w('Error scanning directory ${directory.path}: $e');
      // Continue scanning other directories
    }
  }

  /// Get relative path from project root
  static String _getRelativePath(String absolutePath) {
    final currentDir = Directory.current.path;

    // Normalize paths
    final normalizedAbsolute = absolutePath.replaceAll('\\', '/');
    final normalizedCurrent = currentDir.replaceAll('\\', '/');

    if (normalizedAbsolute.startsWith(normalizedCurrent)) {
      // Remove project root prefix
      var relative = normalizedAbsolute.substring(normalizedCurrent.length);
      // Remove leading slash
      if (relative.startsWith('/')) {
        relative = relative.substring(1);
      }
      // Convert back to platform-specific separator
      return relative.replaceAll('/', Platform.pathSeparator);
    }

    // If we can't determine relative path, return as is
    return absolutePath;
  }

  /// Refresh the entry point file list
  ///
  /// This is the same as discoverEntryPoints() but provided for clarity
  static Future<List<String>> refreshEntryPoints() async {
    return discoverEntryPoints();
  }
}
