import 'package:args/args.dart';

import 'base_command.dart';

/// Download command - downloads JSON from Supabase
class DownloadCommand extends BaseCommand {
  @override
  String get name => 'download';

  @override
  String get description => 'Download JSON from Supabase Firestore';

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
        'output',
        abbr: 'o',
        mandatory: true,
        help: 'Output file path',
      )
      ..addOption(
        'project',
        abbr: 'p',
        help: 'Supabase project ID (optional, uses default if not specified)',
      )
      ..addFlag(
        'pretty',
        negatable: false,
        defaultsTo: true,
        help: 'Format JSON with indentation',
      )
      ..addFlag(
        'metadata',
        abbr: 'm',
        negatable: false,
        help: 'Include metadata (version, updated_at, etc.) in output',
      );
  }

  @override
  Future<void> run(ArgResults results) async {
    await printUnsupportedAndExit();
  }
}
