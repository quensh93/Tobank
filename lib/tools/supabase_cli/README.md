# Supabase CLI Tool

Command-line interface for managing STAC JSON configurations in Supabase Firestore.

## Quick Start

```bash
# Show help
dart run lib/tools/supabase_cli/supabase_cli.dart --help

# Upload a screen
dart run lib/tools/supabase_cli/supabase_cli.dart upload \
  --screen tobank_home \
  --file stac/.build/tobank_home.json

# List all screens
dart run lib/tools/supabase_cli/supabase_cli.dart list

# Download a screen
dart run lib/tools/supabase_cli/supabase_cli.dart download \
  --screen home_screen \
  --output home_screen.json

# Validate JSON
dart run lib/tools/supabase_cli/supabase_cli.dart validate \
  --file home_screen.json

# Show version history
dart run lib/tools/supabase_cli/supabase_cli.dart history \
  --screen home_screen

# Rollback to previous version
dart run lib/tools/supabase_cli/supabase_cli.dart rollback \
  --screen home_screen \
  --version 3

# Delete a screen
dart run lib/tools/supabase_cli/supabase_cli.dart delete \
  --screen home_screen
```

## Documentation

For complete documentation, see [CLI Tools Guide](../../../docs/stac_in_action/11-cli-tools-guide.md).

## Commands

- `upload` - Upload JSON file to Supabase
- `download` - Download JSON from Supabase
- `list` - List all screens in Supabase
- `delete` - Delete screen from Supabase
- `validate` - Validate JSON file structure
- `history` - Show version history for a screen
- `rollback` - Rollback screen to a specific version

## Features

- ✅ JSON validation before upload
- ✅ Version history tracking
- ✅ Rollback to previous versions
- ✅ Backup before deletion
- ✅ Detailed error messages
- ✅ Colored terminal output
- ✅ Confirmation prompts for destructive operations

## Requirements

- Flutter SDK
- Supabase project configured
- Supabase authentication set up

## Structure

```
lib/tools/supabase_cli/
├── supabase_cli.dart              # Main CLI entry point
├── supabase_cli_service.dart      # Supabase operations service
├── commands/
│   ├── base_command.dart          # Base command class
│   ├── upload_command.dart        # Upload command
│   ├── download_command.dart      # Download command
│   ├── list_command.dart          # List command
│   ├── delete_command.dart        # Delete command
│   ├── validate_command.dart      # Validate command
│   ├── history_command.dart       # History command
│   └── rollback_command.dart      # Rollback command
└── README.md                      # This file
```
