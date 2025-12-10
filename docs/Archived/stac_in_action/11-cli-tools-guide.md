# Firebase CLI Tools Guide

## Overview

The Firebase CLI tool provides command-line utilities for managing STAC JSON configurations in Firebase Firestore. This tool enables developers to upload, download, list, validate, and manage version history of screen configurations without using the Firebase Console.

## Installation

The CLI tool is included in the project and requires no additional installation. Ensure you have:

1. Flutter SDK installed
2. Firebase project configured
3. Firebase credentials set up (service account or user authentication)

## Prerequisites

### Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Firestore Database
3. Set up authentication (see [Firebase Integration Guide](07-firebase-integration.md))
4. Configure security rules (see below)

### Required Firestore Collections

The CLI tool uses the following Firestore collections:

- `stac_screens`: Main collection for screen configurations
- `stac_versions`: Version history for screens

## Commands

### Global Options

All commands support these global options:

- `-h, --help`: Show usage information
- `-v, --version`: Show version information
- `-p, --project <id>`: Specify Firebase project ID

## Upload Command

Upload a JSON file to Firebase Firestore.

### Syntax

```bash
dart run lib/tools/firebase_cli/firebase_cli.dart upload [options]
```

### Options

- `-s, --screen <name>`: Screen name (required)
- `-f, --file <path>`: Path to JSON file (required)
- `-p, --project <id>`: Firebase project ID (optional)
- `--skip-validation`: Skip JSON validation before upload
- `-d, --description <text>`: Optional description for this screen
- `-t, --tags <tag1,tag2>`: Tags for categorizing the screen

### Examples

```bash
# Basic upload
dart run lib/tools/firebase_cli/firebase_cli.dart upload \
  --screen home_screen \
  --file assets/mock_data/screens/home_screen.json

# Upload with description and tags
dart run lib/tools/firebase_cli/firebase_cli.dart upload \
  --screen home_screen \
  --file assets/mock_data/screens/home_screen.json \
  --description "Main home screen" \
  --tags home,main,v2

# Upload to specific project
dart run lib/tools/firebase_cli/firebase_cli.dart upload \
  --screen home_screen \
  --file assets/mock_data/screens/home_screen.json \
  --project my-firebase-project

# Skip validation (faster, but risky)
dart run lib/tools/firebase_cli/firebase_cli.dart upload \
  --screen home_screen \
  --file assets/mock_data/screens/home_screen.json \
  --skip-validation
```

### Behavior

- Validates JSON structure before upload (unless `--skip-validation` is used)
- Automatically increments version number
- Saves previous version to version history
- Updates `updated_at` timestamp
- Displays file size and upload status

## Download Command

Download a JSON configuration from Firebase Firestore.

### Syntax

```bash
dart run lib/tools/firebase_cli/firebase_cli.dart download [options]
```

### Options

- `-s, --screen <name>`: Screen name (required)
- `-o, --output <path>`: Output file path (required)
- `-p, --project <id>`: Firebase project ID (optional)
- `--pretty`: Format JSON with indentation (default: true)
- `-m, --metadata`: Include metadata in output

### Examples

```bash
# Basic download
dart run lib/tools/firebase_cli/firebase_cli.dart download \
  --screen home_screen \
  --output home_screen.json

# Download with metadata
dart run lib/tools/firebase_cli/firebase_cli.dart download \
  --screen home_screen \
  --output home_screen_full.json \
  --metadata

# Download without formatting
dart run lib/tools/firebase_cli/firebase_cli.dart download \
  --screen home_screen \
  --output home_screen.json \
  --no-pretty
```

### Behavior

- Downloads JSON from Firestore
- Creates output directory if it doesn't exist
- Displays file size and version information
- By default, only downloads the JSON content (not metadata)
- With `--metadata`, includes version, updated_at, description, and tags

## List Command

List all screens in Firebase Firestore.

### Syntax

```bash
dart run lib/tools/firebase_cli/firebase_cli.dart list [options]
```

### Options

- `-p, --project <id>`: Firebase project ID (optional)
- `-v, --verbose`: Show detailed information for each screen
- `-t, --tag <tag>`: Filter by tag
- `-s, --sort <field>`: Sort by field (name, version, updated)

### Examples

```bash
# List all screens
dart run lib/tools/firebase_cli/firebase_cli.dart list

# List with details
dart run lib/tools/firebase_cli/firebase_cli.dart list --verbose

# Filter by tag
dart run lib/tools/firebase_cli/firebase_cli.dart list --tag home

# Sort by version
dart run lib/tools/firebase_cli/firebase_cli.dart list --sort version

# Sort by last updated
dart run lib/tools/firebase_cli/firebase_cli.dart list --sort updated
```

### Output

**Simple mode:**
```
Screen Name                Version    Updated
────────────────────────────────────────────────────────────
home_screen                v3         2h ago
profile_screen             v1         1d ago
settings_screen            v2         3d ago
```

**Verbose mode:**
```
1. home_screen
   Version: v3
   Updated: 2024-01-15 14:30:00
   Description: Main home screen
   Tags: home, main, v2
   Widgets: 15

2. profile_screen
   Version: v1
   Updated: 2024-01-14 10:15:00
   Tags: profile, user
   Widgets: 8
```

## Delete Command

Delete a screen from Firebase Firestore.

### Syntax

```bash
dart run lib/tools/firebase_cli/firebase_cli.dart delete [options]
```

### Options

- `-s, --screen <name>`: Screen name (required)
- `-p, --project <id>`: Firebase project ID (optional)
- `-f, --force`: Skip confirmation prompt
- `-b, --backup`: Create backup before deletion

### Examples

```bash
# Delete with confirmation
dart run lib/tools/firebase_cli/firebase_cli.dart delete \
  --screen home_screen

# Delete without confirmation
dart run lib/tools/firebase_cli/firebase_cli.dart delete \
  --screen home_screen \
  --force

# Delete with backup
dart run lib/tools/firebase_cli/firebase_cli.dart delete \
  --screen home_screen \
  --backup
```

### Behavior

- Prompts for confirmation (unless `--force` is used)
- Displays screen information before deletion
- Optionally creates backup file
- Deletes screen document and version history
- Backup file format: `backup_<screen>_<timestamp>.json`

## Validate Command

Validate JSON file structure without uploading.

### Syntax

```bash
dart run lib/tools/firebase_cli/firebase_cli.dart validate [options]
```

### Options

- `-f, --file <path>`: Path to JSON file (required)
- `-v, --verbose`: Show detailed validation information
- `-s, --strict`: Enable strict validation mode

### Examples

```bash
# Basic validation
dart run lib/tools/firebase_cli/firebase_cli.dart validate \
  --file home_screen.json

# Verbose validation
dart run lib/tools/firebase_cli/firebase_cli.dart validate \
  --file home_screen.json \
  --verbose

# Strict validation
dart run lib/tools/firebase_cli/firebase_cli.dart validate \
  --file home_screen.json \
  --strict
```

### Output

**Success:**
```
✓ JSON syntax is valid
✓ JSON structure is valid

Validation Details:
────────────────────────────────────────────────────────────
Total widgets: 15
Widget types: scaffold, column, text, elevatedButton, container
Total actions: 3
Action types: navigate, showDialog
```

**Failure:**
```
✓ JSON syntax is valid
✗ JSON validation failed with 2 error(s):

1. root.body.children[0]
   Missing required field: type
   Value: {"data": "Hello"}

2. root.appBar.actions[1]
   Invalid action type: unknownAction
   Value: unknownAction
```

## History Command

Show version history for a screen.

### Syntax

```bash
dart run lib/tools/firebase_cli/firebase_cli.dart history [options]
```

### Options

- `-s, --screen <name>`: Screen name (required)
- `-p, --project <id>`: Firebase project ID (optional)
- `-l, --limit <number>`: Maximum number of versions to show (default: 10)

### Examples

```bash
# Show version history
dart run lib/tools/firebase_cli/firebase_cli.dart history \
  --screen home_screen

# Show last 20 versions
dart run lib/tools/firebase_cli/firebase_cli.dart history \
  --screen home_screen \
  --limit 20
```

### Output

```
Found 5 version(s) (showing 5)

Version    Archived                Description
──────────────────────────────────────────────────────────────────────
v5         2024-01-15 14:30        Updated button styles
v4         2024-01-15 10:15        Added new section
v3         2024-01-14 16:45        Fixed layout issues
v2         2024-01-14 09:30        Initial redesign
v1         2024-01-13 14:00        First version

ℹ Use "rollback" command to restore a specific version
```

## Rollback Command

Rollback a screen to a specific version.

### Syntax

```bash
dart run lib/tools/firebase_cli/firebase_cli.dart rollback [options]
```

### Options

- `-s, --screen <name>`: Screen name (required)
- `-v, --version <number>`: Version number to rollback to (required)
- `-p, --project <id>`: Firebase project ID (optional)
- `-f, --force`: Skip confirmation prompt

### Examples

```bash
# Rollback with confirmation
dart run lib/tools/firebase_cli/firebase_cli.dart rollback \
  --screen home_screen \
  --version 3

# Rollback without confirmation
dart run lib/tools/firebase_cli/firebase_cli.dart rollback \
  --screen home_screen \
  --version 3 \
  --force
```

### Behavior

- Prompts for confirmation (unless `--force` is used)
- Displays current and target version information
- Saves current version to history before rollback
- Creates new version with content from target version
- New version number is incremented (not reset to target version)

### Example Flow

```
Current version: v5
Rollback to: v3
Result: New v6 created with content from v3
```

## Version History

### How It Works

1. **Initial Upload**: Creates version 1
2. **Subsequent Uploads**: Increments version, saves previous to history
3. **Version History**: Stored in `stac_versions` collection
4. **Rollback**: Creates new version with old content

### Version Data Structure

```json
{
  "screen_name": "home_screen",
  "version": 3,
  "json": { /* screen JSON */ },
  "updated_at": "2024-01-15T14:30:00Z",
  "description": "Updated button styles",
  "tags": ["home", "main"],
  "archived_at": "2024-01-15T16:45:00Z"
}
```

## Firebase Security Rules

Required security rules for CLI tool:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Helper functions
    function isAuthenticated() {
      return request.auth != null;
    }
    
    function isAdmin() {
      return isAuthenticated() && 
             request.auth.token.admin == true;
    }
    
    // STAC screens collection
    match /stac_screens/{screen} {
      allow read: if isAuthenticated();
      allow write: if isAdmin();
    }
    
    // Version history
    match /stac_versions/{version} {
      allow read: if isAuthenticated();
      allow write: if isAdmin();
    }
  }
}
```

## Authentication

### Service Account (Recommended for CI/CD)

1. Download service account key from Firebase Console
2. Set environment variable:
   ```bash
   export GOOGLE_APPLICATION_CREDENTIALS="/path/to/service-account-key.json"
   ```

### User Authentication

1. Run `firebase login` to authenticate
2. CLI tool will use your user credentials

## Common Workflows

### Development Workflow

```bash
# 1. Create and validate JSON locally
dart run lib/tools/firebase_cli/firebase_cli.dart validate \
  --file assets/mock_data/screens/home_screen.json

# 2. Upload to Firebase
dart run lib/tools/firebase_cli/firebase_cli.dart upload \
  --screen home_screen \
  --file assets/mock_data/screens/home_screen.json \
  --description "Development version"

# 3. Test in app (switch to Firebase mode)

# 4. If issues, rollback
dart run lib/tools/firebase_cli/firebase_cli.dart rollback \
  --screen home_screen \
  --version 2
```

### Backup Workflow

```bash
# Download all screens for backup
dart run lib/tools/firebase_cli/firebase_cli.dart list | \
  while read screen; do
    dart run lib/tools/firebase_cli/firebase_cli.dart download \
      --screen $screen \
      --output backup/$screen.json \
      --metadata
  done
```

### Migration Workflow

```bash
# 1. Download from old project
dart run lib/tools/firebase_cli/firebase_cli.dart download \
  --screen home_screen \
  --output temp.json \
  --project old-project

# 2. Upload to new project
dart run lib/tools/firebase_cli/firebase_cli.dart upload \
  --screen home_screen \
  --file temp.json \
  --project new-project
```

## Troubleshooting

### Permission Denied

**Error:** `Firebase error: Permission denied`

**Solution:**
- Verify Firebase authentication is set up
- Check security rules allow your user/service account
- Ensure you have admin privileges

### Screen Not Found

**Error:** `Screen "home_screen" not found in Firebase`

**Solution:**
- Verify screen name is correct (case-sensitive)
- Check you're connected to the correct Firebase project
- Use `list` command to see available screens

### Validation Errors

**Error:** `JSON validation failed`

**Solution:**
- Review error messages for specific issues
- Check JSON syntax is valid
- Verify all required fields are present
- Ensure widget types are registered
- Use `--verbose` flag for detailed information

### Network Issues

**Error:** `Network error` or timeout

**Solution:**
- Check internet connection
- Verify Firebase project is accessible
- Try again with retry logic
- Check Firebase status page

## Best Practices

1. **Always Validate**: Use `validate` command before uploading
2. **Use Descriptions**: Add meaningful descriptions to track changes
3. **Tag Screens**: Use tags for organization and filtering
4. **Regular Backups**: Download screens periodically
5. **Version History**: Review history before rollback
6. **Test Locally**: Validate with mock data before uploading
7. **Confirmation Prompts**: Don't use `--force` in production
8. **Service Accounts**: Use service accounts for CI/CD

## Integration with CI/CD

### GitHub Actions Example

```yaml
name: Deploy STAC Screens

on:
  push:
    branches: [main]
    paths:
      - 'assets/mock_data/screens/**'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.9.0'
      
      - name: Setup Firebase
        env:
          FIREBASE_SERVICE_ACCOUNT: ${{ secrets.FIREBASE_SERVICE_ACCOUNT }}
        run: echo "$FIREBASE_SERVICE_ACCOUNT" > service-account.json
      
      - name: Upload screens
        run: |
          for file in assets/mock_data/screens/*.json; do
            screen=$(basename "$file" .json)
            dart run lib/tools/firebase_cli/firebase_cli.dart upload \
              --screen "$screen" \
              --file "$file" \
              --description "Deployed from CI/CD"
          done
```

## Related Documentation

- [Firebase Integration Guide](07-firebase-integration.md)
- [API Layer Guide](05-api-layer-guide.md)
- [Mock Data Guide](06-mock-data-guide.md)
- [Testing Guide](04-testing-guide.md)

## Summary

The Firebase CLI tool provides a powerful command-line interface for managing STAC JSON configurations. Key features include:

- Upload/download screens with validation
- Version history and rollback capabilities
- List and filter screens
- Backup and restore functionality
- CI/CD integration support

Use this tool to streamline your development workflow and maintain version control of your server-driven UI configurations.
