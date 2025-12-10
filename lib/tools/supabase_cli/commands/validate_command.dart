import 'package:args/args.dart';

import 'base_command.dart';

/// Placeholder command for validating Supabase data.
class ValidateCommand extends BaseCommand {
  @override
  String get name => 'validate';

  @override
  String get description =>
      'Validate Supabase data integrity (not yet implemented)';

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
        'file',
        abbr: 'f',
        help: 'Path to the JSON file to validate',
        mandatory: true,
      )
      ..addFlag(
        'verbose',
        abbr: 'v',
        negatable: false,
        help: 'Enable verbose output',
      )
      ..addFlag(
        'strict',
        abbr: 's',
        negatable: false,
        help: 'Enable strict validation mode',
      );
  }

  @override
  Future<void> run(ArgResults results) async {
    await printUnsupportedAndExit();
  }
}
