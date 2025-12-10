import 'package:args/args.dart';

import 'base_command.dart';

/// Placeholder command for rolling back Supabase screens.
class RollbackCommand extends BaseCommand {
  @override
  String get name => 'rollback';

  @override
  String get description =>
      'Rollback a screen to a previous version (not yet implemented)';

  @override
  ArgParser configureParser() {
    return ArgParser()
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Show usage information',
      )
      ..addOption('screen', abbr: 's', help: 'Screen name')
      ..addOption('version', abbr: 'v', help: 'Version number to rollback to')
      ..addFlag(
        'force',
        abbr: 'f',
        negatable: false,
        help: 'Skip confirmation prompt',
      )
      ..addOption('project', abbr: 'p', help: 'Supabase project ID');
  }

  @override
  Future<void> run(ArgResults results) async {
    await printUnsupportedAndExit();
  }
}
