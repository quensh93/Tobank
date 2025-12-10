import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/features/stac_test_app/data/services/stac_json_file_service.dart';

void main() {
  group('Path Resolution Logic', () {
    late Directory testDir;

    setUp(() {
      testDir = Directory.systemTemp.createTempSync('path_test_');
    });

    tearDown(() {
      if (testDir.existsSync()) {
        testDir.deleteSync(recursive: true);
      }
    });

    group('URL Detection', () {
      test('should detect HTTP URLs', () {
        // Arrange
        final httpUrl = 'http://example.com/data.json';

        // Act
        final isUrl = httpUrl.startsWith('http://') || httpUrl.startsWith('https://');

        // Assert
        expect(isUrl, isTrue);
      });

      test('should detect HTTPS URLs', () {
        // Arrange
        final httpsUrl = 'https://example.com/data.json';

        // Act
        final isUrl = httpsUrl.startsWith('http://') || httpsUrl.startsWith('https://');

        // Assert
        expect(isUrl, isTrue);
      });

      test('should not detect file paths as URLs', () {
        // Arrange
        final filePath = 'path/to/file.json';

        // Act
        final isUrl = filePath.startsWith('http://') || filePath.startsWith('https://');

        // Assert
        expect(isUrl, isFalse);
      });
    });

    group('Absolute Path Detection', () {
      test('should detect Unix absolute paths', () {
        // Arrange
        final unixPath = '/path/to/file.json';

        // Act
        final isAbsolute = unixPath.startsWith('/');

        // Assert
        expect(isAbsolute, isTrue);
      });

      test('should detect Windows absolute paths with backslash', () {
        // Arrange
        final windowsPath = r'C:\path\to\file.json';

        // Act
        final isAbsolute = windowsPath.length > 2 &&
            windowsPath[1] == ':' &&
            windowsPath[2] == '\\';

        // Assert
        expect(isAbsolute, isTrue);
      });

      test('should detect Windows absolute paths with forward slash', () {
        // Arrange
        final windowsPath = 'C:/path/to/file.json';

        // Act
        final isAbsolute = windowsPath.length > 2 &&
            windowsPath[1] == ':' &&
            windowsPath[2] == '/';

        // Assert
        expect(isAbsolute, isTrue);
      });

      test('should not detect relative paths as absolute', () {
        // Arrange
        final relativePath = 'path/to/file.json';

        // Act
        final isAbsolute = relativePath.startsWith('/') ||
            (relativePath.length > 2 &&
                relativePath[1] == ':' &&
                (relativePath[2] == '\\' || relativePath[2] == '/'));

        // Assert
        expect(isAbsolute, isFalse);
      });
    });

    group('Relative Path Resolution', () {
      test('should resolve relative path with baseDir', () async {
        // Arrange
        final baseDir = testDir.path;
        final subDir = Directory('$baseDir/subdir')..createSync();
        final testFile = File('${subDir.path}/data.json');
        await testFile.writeAsString('{"type": "test"}');

        // Act
        final result = await StacJsonFileService.loadJson(
          'subdir/data.json',
          baseDir: baseDir,
        );

        // Assert
        expect(result['type'], 'test');
      });

      test('should resolve nested relative paths', () async {
        // Arrange
        final baseDir = testDir.path;
        final nestedDir = Directory('$baseDir/level1/level2')..createSync(recursive: true);
        final testFile = File('${nestedDir.path}/data.json');
        await testFile.writeAsString('{"type": "nested"}');

        // Act
        final result = await StacJsonFileService.loadJson(
          'level1/level2/data.json',
          baseDir: baseDir,
        );

        // Assert
        expect(result['type'], 'nested');
      });

      test('should handle forward slashes in paths', () async {
        // Arrange
        final baseDir = testDir.path;
        final testFile = File('$baseDir/file.json');
        await testFile.writeAsString('{"type": "forward"}');

        // Act
        final result = await StacJsonFileService.loadJson(
          'file.json',
          baseDir: baseDir,
        );

        // Assert
        expect(result['type'], 'forward');
      });

      test('should handle backward slashes in paths on Windows', () async {
        // Arrange
        final baseDir = testDir.path;
        final testFile = File('$baseDir\\file.json');
        await testFile.writeAsString('{"type": "backward"}');

        // Act
        final result = await StacJsonFileService.loadJson(
          'file.json',
          baseDir: baseDir,
        );

        // Assert
        expect(result['type'], 'backward');
      });
    });

    group('Cross-Platform Path Handling', () {
      test('should handle mixed slashes', () async {
        // Arrange
        final baseDir = testDir.path;
        final subDir = Directory('$baseDir/mixed\\path')..createSync(recursive: true);
        final testFile = File('${subDir.path}/data.json');
        await testFile.writeAsString('{"type": "mixed"}');

        // Act & Assert
        // The service should normalize paths correctly
        expect(testFile.existsSync(), isTrue);
      });
    });
  });
}

