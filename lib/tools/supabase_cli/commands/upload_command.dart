import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

import 'base_command.dart';

/// Command for uploading STAC screens to Supabase.
class UploadCommand extends BaseCommand {
  @override
  String get name => 'upload';

  @override
  String get description => 'Upload a screen definition to Supabase';

  @override
  ArgParser configureParser() {
    return ArgParser()
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Show usage information',
      )
      ..addOption(
        'screen',
        abbr: 's',
        help: 'Name of the screen',
        mandatory: true,
      )
      ..addOption(
        'file',
        abbr: 'f',
        help: 'Path to the JSON file',
        mandatory: true,
      )
      ..addOption(
        'description',
        abbr: 'd',
        help: 'Description of the screen version',
      )
      ..addOption('tags', abbr: 't', help: 'Comma-separated tags')
      ..addOption(
        'project',
        abbr: 'p',
        help: 'Supabase project ID (optional, uses default if not specified)',
      )
      ..addFlag(
        'skip-validation',
        negatable: false,
        help: 'Skip JSON validation before upload',
      );
  }

  @override
  Future<void> run(ArgResults results) async {
    final screenName = results['screen'] as String;
    final filePath = results['file'] as String;
    final description = results['description'] as String?;
    final tagsStr = results['tags'] as String?;
    final tags = tagsStr?.split(',').map((e) => e.trim()).toList();

    final file = File(filePath);
    if (!file.existsSync()) {
      printError('File not found: $filePath');
      exit(1);
    }

    try {
      final content = await file.readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;

      printInfo('Uploading screen "$screenName" from "$filePath"...');

      if (service == null) {
        printError('Supabase service not initialized');
        exit(1);
      }

      await service!.uploadScreen(
        screenName: screenName,
        jsonData: json,
        description: description,
        tags: tags,
      );

      printSuccess('Screen "$screenName" uploaded successfully!');
    } catch (e) {
      printError('Failed to upload screen: $e');
      exit(1);
    }
  }
}
