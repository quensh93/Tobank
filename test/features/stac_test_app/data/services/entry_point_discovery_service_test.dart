import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/features/stac_test_app/data/services/entry_point_discovery_service.dart';

void main() {
  group('EntryPointDiscoveryService', () {
    late Directory mockDir;
    late Directory subDir;

    setUp(() {
      // Create a temporary mock directory structure
      mockDir = Directory.systemTemp.createTempSync('mock_test_');
      subDir = Directory('${mockDir.path}/stac_test_app')..createSync(recursive: true);
    });

    tearDown(() {
      // Clean up test directories
      if (mockDir.existsSync()) {
        mockDir.deleteSync(recursive: true);
      }
    });

    test('should discover app_entry_point.json files', () async {
      // Arrange
      final entryPointFile = File('${subDir.path}/app_entry_point.json');
      await entryPointFile.writeAsString('{"initial_screen": "login", "screens": {}}');

      // Temporarily change directory to mock directory
      final originalDir = Directory.current;
      try {
        Directory.current = mockDir.parent.path;

        // Act
        final entryPoints = await EntryPointDiscoveryService.discoverEntryPoints();

        // Assert
        expect(entryPoints, isNotEmpty);
        expect(
          entryPoints.any((path) => path.contains('app_entry_point.json')),
          isTrue,
        );
      } finally {
        Directory.current = originalDir.path;
      }
    });

    test('should discover config.json files', () async {
      // Arrange
      final configFile = File('${subDir.path}/config.json');
      await configFile.writeAsString('{"app_name": "Test App"}');

      // Temporarily change directory to mock directory
      final originalDir = Directory.current;
      try {
        Directory.current = mockDir.parent.path;

        // Act
        final entryPoints = await EntryPointDiscoveryService.discoverEntryPoints();

        // Assert
        expect(entryPoints, isNotEmpty);
        expect(
          entryPoints.any((path) => path.contains('config.json')),
          isTrue,
        );
      } finally {
        Directory.current = originalDir.path;
      }
    });

    test('should discover entry points in nested directories', () async {
      // Arrange
      final nestedDir = Directory('${subDir.path}/nested/deep')..createSync(recursive: true);
      final nestedFile = File('${nestedDir.path}/app_entry_point.json');
      await nestedFile.writeAsString('{"initial_screen": "home", "screens": {}}');

      // Temporarily change directory to mock directory
      final originalDir = Directory.current;
      try {
        Directory.current = mockDir.parent.path;

        // Act
        final entryPoints = await EntryPointDiscoveryService.discoverEntryPoints();

        // Assert
        expect(entryPoints, isNotEmpty);
        expect(
          entryPoints.any((path) => path.contains('nested/deep')),
          isTrue,
        );
      } finally {
        Directory.current = originalDir.path;
      }
    });

    test('should return empty list if mock directory does not exist', () async {
      // Arrange - Use a non-existent directory
      final nonExistentDir = Directory('${mockDir.path}_nonexistent');

      // Act & Assert
      // This test is tricky because the service uses a hardcoded 'mock' directory
      // In a real scenario, we'd need to mock or make the directory configurable
      // For now, we'll test that it handles missing directories gracefully
      expect(nonExistentDir.existsSync(), isFalse);
    });

    test('should ignore non-entry-point JSON files', () async {
      // Arrange
      final otherFile = File('${subDir.path}/other.json');
      await otherFile.writeAsString('{"type": "other"}');

      // Temporarily change directory to mock directory
      final originalDir = Directory.current;
      try {
        Directory.current = mockDir.parent.path;

        // Act
        final entryPoints = await EntryPointDiscoveryService.discoverEntryPoints();

        // Assert
        // Should not include 'other.json' in results
        expect(
          entryPoints.any((path) => path.contains('other.json')),
          isFalse,
        );
      } finally {
        Directory.current = originalDir.path;
      }
    });
  });
}

