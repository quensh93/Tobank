import 'package:args/args.dart';

import 'base_command.dart';

/// Delete command - deletes screen from Supabase
class DeleteCommand extends BaseCommand {
  @override
  String get name => 'delete';

  @override
  String get description => 'Delete screen from Supabase Firestore';

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
        mandatory: true,
        help: 'Screen name (document ID in Firestore)',
      )
      ..addOption(
        'project',
        abbr: 'p',
        help: 'Supabase project ID (optional, uses default if not specified)',
      )
      ..addFlag(
        'force',
        abbr: 'f',
        negatable: false,
        help: 'Skip confirmation prompt',
      )
      ..addFlag(
        'backup',
        abbr: 'b',
        negatable: false,
        help: 'Create backup before deletion',
      );
  }

  @override
  Future<void> run(ArgResults results) async {
    await printUnsupportedAndExit();
  }
}
