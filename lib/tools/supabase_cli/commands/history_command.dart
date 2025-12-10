import 'package:args/args.dart';

import 'base_command.dart';

/// Version history command placeholder.
class HistoryCommand extends BaseCommand {
  @override
  String get name => 'history';

  @override
  String get description =>
      'List version history for a STAC screen (not yet implemented)';

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
      ..addOption(
        'limit',
        abbr: 'l',
        help: 'Maximum number of versions to show',
        defaultsTo: '10',
      )
      ..addOption('project', abbr: 'p', help: 'Supabase project ID');
  }

  @override
  Future<void> run(ArgResults results) async {
    await printUnsupportedAndExit();
  }
}
