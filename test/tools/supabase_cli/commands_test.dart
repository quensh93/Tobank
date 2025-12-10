import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/tools/supabase_cli/commands/delete_command.dart';
import 'package:tobank_sdui/tools/supabase_cli/commands/download_command.dart';
import 'package:tobank_sdui/tools/supabase_cli/commands/history_command.dart';
import 'package:tobank_sdui/tools/supabase_cli/commands/list_command.dart';
import 'package:tobank_sdui/tools/supabase_cli/commands/rollback_command.dart';
import 'package:tobank_sdui/tools/supabase_cli/commands/upload_command.dart';
import 'package:tobank_sdui/tools/supabase_cli/commands/validate_command.dart';
import 'package:tobank_sdui/tools/supabase_cli/supabase_cli_service.dart';

void main() {
  late Directory tempDir;
  late File testJsonFile;

  setUp(() async {
    // Create temporary directory for test files
    tempDir = await Directory.systemTemp.createTemp('supabase_cli_test_');

    // Create a test JSON file
    testJsonFile = File('${tempDir.path}/test_screen.json');
    final testJson = {
      'type': 'container',
      'child': {'type': 'text', 'data': 'Test Screen'},
    };
    await testJsonFile.writeAsString(jsonEncode(testJson));
  });

  tearDown(() async {
    // Clean up temporary directory
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('ValidateCommand', () {
    test('should have correct command name and description', () {
      // Arrange
      final command = ValidateCommand();

      // Assert
      expect(command.name, equals('validate'));
      expect(command.description, isNotEmpty);
    });

    test('should have file option', () {
      // Arrange
      final command = ValidateCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['file'], isNotNull);
    });

    test('should support verbose flag', () {
      // Arrange
      final command = ValidateCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['verbose'], isNotNull);
    });

    test('should support strict flag', () {
      // Arrange
      final command = ValidateCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['strict'], isNotNull);
    });

    test('should support help flag', () {
      // Arrange
      final command = ValidateCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['help'], isNotNull);
    });
  });

  group('UploadCommand', () {
    test('should have correct command name and description', () {
      // Arrange
      final command = UploadCommand();

      // Assert
      expect(command.name, equals('upload'));
      expect(command.description, isNotEmpty);
    });

    test('should have screen and file options', () {
      // Arrange
      final command = UploadCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['screen'], isNotNull);
      expect(parser.options['file'], isNotNull);
    });

    test('should support optional project option', () {
      // Arrange
      final command = UploadCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['project'], isNotNull);
    });

    test('should support skip-validation flag', () {
      // Arrange
      final command = UploadCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['skip-validation'], isNotNull);
    });

    test('should support description and tags options', () {
      // Arrange
      final command = UploadCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['description'], isNotNull);
      expect(parser.options['tags'], isNotNull);
    });
  });

  group('DownloadCommand', () {
    test('should have correct command name and description', () {
      // Arrange
      final command = DownloadCommand();

      // Assert
      expect(command.name, equals('download'));
      expect(command.description, isNotEmpty);
    });

    test('should have screen option', () {
      // Arrange
      final command = DownloadCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['screen'], isNotNull);
    });

    test('should support optional output option', () {
      // Arrange
      final command = DownloadCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['output'], isNotNull);
    });

    test('should support optional project option', () {
      // Arrange
      final command = DownloadCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['project'], isNotNull);
    });
  });

  group('ListCommand', () {
    test('should have correct command name and description', () {
      // Arrange
      final command = ListCommand();

      // Assert
      expect(command.name, equals('list'));
      expect(command.description, isNotEmpty);
    });

    test('should support verbose flag', () {
      // Arrange
      final command = ListCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['verbose'], isNotNull);
    });

    test('should support tag filter option', () {
      // Arrange
      final command = ListCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['tag'], isNotNull);
    });

    test('should support sort option with allowed values', () {
      // Arrange
      final command = ListCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['sort'], isNotNull);
      expect(parser.options['sort']?.defaultsTo, equals('name'));
      expect(parser.options['sort']?.allowed, contains('name'));
      expect(parser.options['sort']?.allowed, contains('version'));
      expect(parser.options['sort']?.allowed, contains('updated'));
    });

    test('should support optional project option', () {
      // Arrange
      final command = ListCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['project'], isNotNull);
    });
  });

  group('DeleteCommand', () {
    test('should have correct command name and description', () {
      // Arrange
      final command = DeleteCommand();

      // Assert
      expect(command.name, equals('delete'));
      expect(command.description, isNotEmpty);
    });

    test('should have screen option', () {
      // Arrange
      final command = DeleteCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['screen'], isNotNull);
    });

    test('should support force flag', () {
      // Arrange
      final command = DeleteCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['force'], isNotNull);
    });

    test('should support optional project option', () {
      // Arrange
      final command = DeleteCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['project'], isNotNull);
    });
  });

  group('HistoryCommand', () {
    test('should have correct command name and description', () {
      // Arrange
      final command = HistoryCommand();

      // Assert
      expect(command.name, equals('history'));
      expect(command.description, isNotEmpty);
    });

    test('should have screen option', () {
      // Arrange
      final command = HistoryCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['screen'], isNotNull);
    });

    test('should support limit option', () {
      // Arrange
      final command = HistoryCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['limit'], isNotNull);
      expect(parser.options['limit']?.defaultsTo, equals('10'));
    });

    test('should support optional project option', () {
      // Arrange
      final command = HistoryCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['project'], isNotNull);
    });
  });

  group('RollbackCommand', () {
    test('should have correct command name and description', () {
      // Arrange
      final command = RollbackCommand();

      // Assert
      expect(command.name, equals('rollback'));
      expect(command.description, isNotEmpty);
    });

    test('should have screen and version options', () {
      // Arrange
      final command = RollbackCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['screen'], isNotNull);
      expect(parser.options['version'], isNotNull);
    });

    test('should support force flag', () {
      // Arrange
      final command = RollbackCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['force'], isNotNull);
    });

    test('should support optional project option', () {
      // Arrange
      final command = RollbackCommand();
      final parser = command.configureParser();

      // Assert
      expect(parser.options['project'], isNotNull);
    });
  });

  group('SupabaseCliService', () {
    test('should create service with url and key', () {
      // Arrange & Act
      final service = SupabaseCliService(
        url: 'https://test-project.supabase.co',
        key: 'test-key',
      );

      // Assert
      expect(service, isNotNull);
      expect(service.url, equals('https://test-project.supabase.co'));
      expect(service.key, equals('test-key'));
    });

    test('should throw error when calling methods before initialization', () {
      // Arrange
      final service = SupabaseCliService(
        url: 'https://test-project.supabase.co',
        key: 'test-key',
      );

      // Act & Assert
      expect(
        () async =>
            await service.uploadScreen(screenName: 'test', jsonData: {}),
        throwsStateError,
      );
    });
  });

  group('Command Parser Configuration', () {
    test('all commands should have help flag', () {
      // Arrange
      final commands = [
        UploadCommand(),
        DownloadCommand(),
        ListCommand(),
        DeleteCommand(),
        HistoryCommand(),
        RollbackCommand(),
        ValidateCommand(),
      ];

      // Act & Assert
      for (final command in commands) {
        final parser = command.configureParser();
        expect(
          parser.options['help'],
          isNotNull,
          reason: '${command.name} should have help flag',
        );
      }
    });

    test('all commands should have name and description', () {
      // Arrange
      final commands = [
        UploadCommand(),
        DownloadCommand(),
        ListCommand(),
        DeleteCommand(),
        HistoryCommand(),
        RollbackCommand(),
        ValidateCommand(),
      ];

      // Act & Assert
      for (final command in commands) {
        expect(
          command.name,
          isNotEmpty,
          reason: '${command.runtimeType} should have a name',
        );
        expect(
          command.description,
          isNotEmpty,
          reason: '${command.name} should have a description',
        );
      }
    });
  });

  group('Command Parser Validation', () {
    test('upload command parser should have mandatory options configured', () {
      // Arrange
      final command = UploadCommand();
      final parser = command.configureParser();

      // Assert - Verify that screen and file options exist
      expect(parser.options['screen'], isNotNull);
      expect(parser.options['file'], isNotNull);
    });

    test('list command parser should reject invalid sort option', () {
      // Arrange
      final command = ListCommand();
      final parser = command.configureParser();

      // Act & Assert - Parser should throw FormatException for invalid allowed value
      expect(
        () => parser.parse(['--sort', 'invalid_sort_option']),
        throwsA(isA<FormatException>()),
      );
    });

    test('validate command parser should accept valid file argument', () {
      // Arrange
      final command = ValidateCommand();
      final parser = command.configureParser();

      // Act
      final result = parser.parse(['--file', 'test.json']);

      // Assert
      expect(result['file'], equals('test.json'));
    });

    test('upload command parser should accept all valid arguments', () {
      // Arrange
      final command = UploadCommand();
      final parser = command.configureParser();

      // Act
      final result = parser.parse([
        '--screen',
        'test_screen',
        '--file',
        'test.json',
        '--description',
        'Test description',
        '--tags',
        'tag1,tag2',
      ]);

      // Assert
      expect(result['screen'], equals('test_screen'));
      expect(result['file'], equals('test.json'));
      expect(result['description'], equals('Test description'));
    });

    test('download command parser should accept screen and output', () {
      // Arrange
      final command = DownloadCommand();
      final parser = command.configureParser();

      // Act
      final result = parser.parse([
        '--screen',
        'test_screen',
        '--output',
        'output.json',
      ]);

      // Assert
      expect(result['screen'], equals('test_screen'));
      expect(result['output'], equals('output.json'));
    });

    test('delete command parser should accept screen and force flag', () {
      // Arrange
      final command = DeleteCommand();
      final parser = command.configureParser();

      // Act
      final result = parser.parse(['--screen', 'test_screen', '--force']);

      // Assert
      expect(result['screen'], equals('test_screen'));
      expect(result['force'], isTrue);
    });

    test('history command parser should accept screen and limit', () {
      // Arrange
      final command = HistoryCommand();
      final parser = command.configureParser();

      // Act
      final result = parser.parse(['--screen', 'test_screen', '--limit', '20']);

      // Assert
      expect(result['screen'], equals('test_screen'));
      expect(result['limit'], equals('20'));
    });

    test('rollback command parser should accept screen and version', () {
      // Arrange
      final command = RollbackCommand();
      final parser = command.configureParser();

      // Act
      final result = parser.parse([
        '--screen',
        'test_screen',
        '--version',
        '5',
      ]);

      // Assert
      expect(result['screen'], equals('test_screen'));
      expect(result['version'], equals('5'));
    });
  });
}
