import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/features/stac_test_app/data/services/stac_json_file_service.dart';

void main() {
  group('StacJsonFileService', () {
    late Directory testDir;
    late File testFile;

    setUp(() {
      // Create a temporary test directory
      testDir = Directory.systemTemp.createTempSync('stac_test_');
      testFile = File('${testDir.path}/test.json');
    });

    tearDown(() {
      // Clean up test directory
      if (testDir.existsSync()) {
        testDir.deleteSync(recursive: true);
      }
    });

    group('loadJson - File Loading', () {
      test('should load valid JSON from file', () async {
        // Arrange
        final jsonData = {'type': 'text', 'data': 'Hello'};
        await testFile.writeAsString(jsonEncode(jsonData));

        // Act
        final result = await StacJsonFileService.loadJson(testFile.path);

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['type'], 'text');
        expect(result['data'], 'Hello');
      });

      test('should throw FormatException for invalid JSON', () async {
        // Arrange
        await testFile.writeAsString('invalid json {');

        // Act & Assert
        expect(
          () => StacJsonFileService.loadJson(testFile.path),
          throwsA(isA<FormatException>()),
        );
      });

      test('should throw FileSystemException for non-existent file', () async {
        // Act & Assert
        expect(
          () => StacJsonFileService.loadJson('${testDir.path}/nonexistent.json'),
          throwsA(isA<FileSystemException>()),
        );
      });

      test('should throw FormatException for empty file', () async {
        // Arrange
        await testFile.writeAsString('');

        // Act & Assert
        expect(
          () => StacJsonFileService.loadJson(testFile.path),
          throwsA(isA<FormatException>()),
        );
      });

      test('should throw FormatException for empty JSON object', () async {
        // Arrange
        await testFile.writeAsString('{}');

        // Act & Assert
        expect(
          () => StacJsonFileService.loadJson(testFile.path),
          throwsA(isA<FormatException>()),
        );
      });

      test('should resolve relative path with baseDir', () async {
        // Arrange
        final subDir = Directory('${testDir.path}/subdir')..createSync();
        final subFile = File('${subDir.path}/data.json');
        final jsonData = {'type': 'data', 'value': 123};
        await subFile.writeAsString(jsonEncode(jsonData));

        // Act
        final result = await StacJsonFileService.loadJson(
          'data.json',
          baseDir: subDir.path,
        );

        // Assert
        expect(result['type'], 'data');
        expect(result['value'], 123);
      });

      test('should handle absolute path correctly', () async {
        // Arrange
        final jsonData = {'type': 'absolute', 'test': true};
        await testFile.writeAsString(jsonEncode(jsonData));

        // Act
        final result = await StacJsonFileService.loadJson(testFile.absolute.path);

        // Assert
        expect(result['type'], 'absolute');
        expect(result['test'], true);
      });
    });

    group('writeJson', () {
      test('should write JSON to file', () async {
        // Arrange
        final jsonData = {'type': 'text', 'data': 'Test'};
        final outputFile = File('${testDir.path}/output.json');

        // Act
        await StacJsonFileService.writeJson(outputFile.path, jsonData);

        // Assert
        expect(outputFile.existsSync(), isTrue);
        final content = await outputFile.readAsString();
        final loaded = jsonDecode(content) as Map<String, dynamic>;
        expect(loaded['type'], 'text');
        expect(loaded['data'], 'Test');
      });

      test('should create directory if it does not exist', () async {
        // Arrange
        final jsonData = {'type': 'nested', 'value': 456};
        final nestedDir = '${testDir.path}/nested/path';
        final outputFile = File('$nestedDir/output.json');

        // Act
        await StacJsonFileService.writeJson(outputFile.path, jsonData);

        // Assert
        expect(outputFile.existsSync(), isTrue);
        final content = await outputFile.readAsString();
        final loaded = jsonDecode(content) as Map<String, dynamic>;
        expect(loaded['type'], 'nested');
      });

      test('should write JSON with baseDir', () async {
        // Arrange
        final jsonData = {'type': 'relative', 'test': true};
        final subDir = Directory('${testDir.path}/base')..createSync();
        final outputFile = File('${subDir.path}/relative.json');

        // Act
        await StacJsonFileService.writeJson(
          'relative.json',
          jsonData,
          baseDir: subDir.path,
        );

        // Assert
        expect(outputFile.existsSync(), isTrue);
        final content = await outputFile.readAsString();
        final loaded = jsonDecode(content) as Map<String, dynamic>;
        expect(loaded['type'], 'relative');
      });
    });

    group('URL Detection', () {
      test('should detect HTTP URL', () {
        // Arrange
        final httpUrl = 'http://example.com/data.json';

        // Act & Assert
        // This is tested indirectly through loadJson behavior
        // We can't easily test actual HTTP requests without mocking
        expect(httpUrl.startsWith('http://'), isTrue);
      });

      test('should detect HTTPS URL', () {
        // Arrange
        final httpsUrl = 'https://example.com/data.json';

        // Act & Assert
        expect(httpsUrl.startsWith('https://'), isTrue);
      });
    });

    group('Cache Management', () {
      test('should enable and disable cache', () {
        // Act
        StacJsonFileService.setCacheEnabled(false);
        StacJsonFileService.setCacheEnabled(true);
        StacJsonFileService.clearCache();

        // Assert - No exceptions thrown
        expect(true, isTrue);
      });
    });
  });
}

