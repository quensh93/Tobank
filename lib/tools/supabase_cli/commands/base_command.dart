import 'dart:io';

import 'package:args/args.dart';
import '../supabase_cli_service.dart';

/// Base class for all CLI commands
abstract class BaseCommand {
  /// Command name
  String get name;

  /// Command description
  String get description;

  /// Service instance
  SupabaseCliService? service;

  /// Configure command-specific arguments
  ArgParser configureParser();

  /// Execute the command
  Future<void> run(ArgResults results);

  /// Execute command with argument parsing
  Future<void> execute(List<String> args, {SupabaseCliService? service}) async {
    this.service = service;
    final parser = configureParser()
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Show usage information',
      );

    try {
      final results = parser.parse(args);

      if (results.wasParsed('help') && results['help'] as bool) {
        printUsage(parser);
        exit(0);
      }

      await run(results);
    } on FormatException catch (e) {
      stderr.writeln('Error: ${e.message}');
      printUsage(parser);
      exit(1);
    } catch (e, stackTrace) {
      stderr.writeln('Error executing $name command: $e');
      if (stdout.hasTerminal) {
        stderr.writeln(stackTrace);
      }
      exit(1);
    }
  }

  /// Print command usage
  void printUsage(ArgParser parser) {
    print('$name - $description');
    print('');
    print(
      'Usage: dart run lib/tools/supabase_cli/supabase_cli.dart $name [options]',
    );
    print('');
    print('Options:');
    print(parser.usage);
  }

  /// Print success message
  void printSuccess(String message) {
    if (stdout.hasTerminal) {
      stdout.writeln('\x1B[32m✓\x1B[0m $message');
    } else {
      stdout.writeln('✓ $message');
    }
  }

  /// Print error message
  void printError(String message) {
    if (stderr.hasTerminal) {
      stderr.writeln('\x1B[31m✗\x1B[0m $message');
    } else {
      stderr.writeln('✗ $message');
    }
  }

  /// Print info message
  void printInfo(String message) {
    if (stdout.hasTerminal) {
      stdout.writeln('\x1B[34mℹ\x1B[0m $message');
    } else {
      stdout.writeln('ℹ $message');
    }
  }

  /// Print warning message
  void printWarning(String message) {
    if (stdout.hasTerminal) {
      stdout.writeln('\x1B[33m⚠\x1B[0m $message');
    } else {
      stdout.writeln('⚠ $message');
    }
  }

  /// Helper for commands that are not yet implemented.
  Future<void> printUnsupportedAndExit() async {
    printWarning('Supabase CLI commands are not implemented yet.');
  }
}
