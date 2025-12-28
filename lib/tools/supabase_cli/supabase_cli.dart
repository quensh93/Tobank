// ignore_for_file: avoid_print
import 'dart:io';

import 'commands/delete_command.dart';
import 'commands/download_command.dart';
import 'commands/history_command.dart';
import 'commands/list_command.dart';
import 'commands/rollback_command.dart';
import 'commands/upload_command.dart';
import 'commands/validate_command.dart';
import 'supabase_cli_service.dart';

/// Supabase CLI tool for managing STAC JSON configurations
///
/// Usage:
///   Set environment variables:
///     SUPABASE_URL=https://your-project.supabase.co
///     SUPABASE_ANON_KEY=your-anon-key
///
///   Then run:
///     dart run lib/tools/supabase_cli/supabase_cli.dart `<command>` [options]
void main(List<String> arguments) async {
  try {
    // Check for help/version first
    if (arguments.contains('--help') || arguments.contains('-h')) {
      _printUsage();
      exit(0);
    }

    if (arguments.contains('--version') || arguments.contains('-v')) {
      _printVersion();
      exit(0);
    }

    if (arguments.isEmpty) {
      stderr.writeln('Error: No command specified');
      _printUsage();
      exit(1);
    }

    final command = arguments.first;
    final commandArgs = arguments.skip(1).toList();

    // Get credentials from environment variables
    final url = Platform.environment['SUPABASE_URL'];
    final key = Platform.environment['SUPABASE_ANON_KEY'];

    SupabaseCliService? service;
    if (command != 'validate') {
      if (url == null || key == null) {
        stderr.writeln(
          'Error: Supabase URL and Key are required for this command.',
        );
        stderr.writeln(
          'Set SUPABASE_URL and SUPABASE_ANON_KEY environment variables.',
        );
        exit(1);
      }
      service = SupabaseCliService(url: url, key: key);
      await service.initialize();
    }

    await _executeCommand(command, commandArgs, service);
  } catch (e, stackTrace) {
    stderr.writeln('Error: $e');
    if (Platform.environment['DEBUG'] == 'true') {
      stderr.writeln(stackTrace);
    }
    exit(1);
  }
}

/// Execute the specified command
Future<void> _executeCommand(
  String command,
  List<String> args,
  SupabaseCliService? service,
) async {
  switch (command.toLowerCase()) {
    case 'upload':
      await UploadCommand().execute(args, service: service);
      break;
    case 'download':
      await DownloadCommand().execute(args, service: service);
      break;
    case 'list':
      await ListCommand().execute(args, service: service);
      break;
    case 'delete':
      await DeleteCommand().execute(args, service: service);
      break;
    case 'validate':
      await ValidateCommand().execute(args, service: service);
      break;
    case 'history':
      await HistoryCommand().execute(args, service: service);
      break;
    case 'rollback':
      await RollbackCommand().execute(args, service: service);
      break;
    default:
      stderr.writeln('Error: Unknown command "$command"');
      _printUsage();
      exit(1);
  }
}

/// Print usage information
void _printUsage() {
  print('Supabase CLI Tool for STAC JSON Management');
  print('');
  print(
    'Usage: dart run lib/tools/supabase_cli/supabase_cli.dart <command> [options]',
  );
  print('');
  print('Commands:');
  print('  upload      Upload JSON file to Supabase');
  print('  download    Download JSON from Supabase');
  print('  list        List all screens in Supabase');
  print('  delete      Delete screen from Supabase');
  print('  validate    Validate JSON file structure');
  print('  history     Show version history for a screen');
  print('  rollback    Rollback screen to a specific version');
  print('');
  print('Environment Variables:');
  print('  SUPABASE_URL        Your Supabase project URL');
  print('  SUPABASE_ANON_KEY   Your Supabase anon/public key');
  print('');
  print('Examples:');
  print('  # Windows PowerShell');
  print('  \$env:SUPABASE_URL="https://your-project.supabase.co"');
  print('  \$env:SUPABASE_ANON_KEY="your-anon-key"');
  print(
    '  dart run lib/tools/supabase_cli/supabase_cli.dart upload --screen tobank_home --file stac/.build/tobank_home.json',
  );
}

/// Print version information
void _printVersion() {
  print('Supabase CLI Tool v1.0.0');
  print('STAC Hybrid App Framework');
}
