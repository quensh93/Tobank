import 'dart:io';

import 'package:args/args.dart';

import 'base_command.dart';

/// Lists STAC screens stored in Supabase.
class ListCommand extends BaseCommand {
  @override
  String get name => 'list';

  @override
  String get description => 'List screens stored in Supabase';

  @override
  ArgParser configureParser() {
    return ArgParser()
      ..addFlag(
        'verbose',
        abbr: 'v',
        negatable: false,
        help: 'Show detailed information',
      )
      ..addOption('tag', abbr: 't', help: 'Filter screens by tag')
      ..addOption(
        'sort',
        abbr: 's',
        help: 'Sort by field',
        defaultsTo: 'name',
        allowed: ['name', 'version', 'updated'],
      )
      ..addOption('project', abbr: 'p', help: 'Supabase project ID (optional)');
  }

  @override
  Future<void> run(ArgResults results) async {
    final verbose = results['verbose'] as bool;

    if (service == null) {
      printError('Supabase service not initialized');
      exit(1);
    }

    try {
      printInfo('Fetching screens from Supabase...');

      final screens = await service!.listScreens();

      if (screens.isEmpty) {
        printWarning('No screens found in Supabase');
        printInfo(
          'Upload a screen using: dart run lib/tools/supabase_cli/supabase_cli.dart upload --screen <name> --file <path>',
        );
        return;
      }

      printSuccess('Found ${screens.length} screen(s):');
      print('');

      for (final screen in screens) {
        final name = screen['name'] as String;
        final updatedAt = screen['updated_at'] as String?;

        if (verbose) {
          print('📄 $name');
          if (updatedAt != null) {
            print('   Updated: $updatedAt');
          }
          print('');
        } else {
          print('  • $name');
        }
      }
    } catch (e) {
      printError('Failed to list screens: $e');
      exit(1);
    }
  }
}
