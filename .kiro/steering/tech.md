# Tech Stack

## Core Framework

- **Flutter SDK**: ^3.9.0
- **Dart**: ^3.9.0
- **STAC Framework**: Server-Driven UI framework (local package at `.stac/packages/stac`)

## State Management & Architecture

- **hooks_riverpod**: ^3.0.3 - State management and dependency injection
- **flutter_hooks**: Hooks for Flutter widgets
- **riverpod_annotation**: ^3.0.3 - Code generation for Riverpod
- **fpdart**: ^1.1.1 - Functional programming (Either, TaskEither for error handling)

## Network & API

- **dio**: ^5.7.0 - HTTP client
- **retrofit**: ^4.7.3 - Type-safe REST client
- **json_annotation**: ^4.9.0 - JSON serialization annotations

## Storage & Security

- **flutter_secure_storage**: ^9.2.4 - Secure key-value storage
- **path_provider**: ^2.1.5 - File system paths

## Debugging & Monitoring

- **ispect**: ^4.4.8-dev02 - Inspector for debugging
- **ispectify**: ^4.4.8-dev02 - Ispect integration
- **ispectify_dio**: ^4.4.8-dev02 - Dio integration for Ispect
- **talker**: ^5.0.0 - Logging and error handling
- **talker_flutter**: ^5.0.0 - Flutter integration for Talker
- **logger**: ^2.6.0 - Logging utility
- **slow_net_simulator**: ^1.0.0 - Network simulation for testing
- **flutter_performance_pulse**: ^1.0.6 - Performance monitoring
- **debug_panel**: Local package at `lib/debug_panel`

## Code Generation

- **build_runner**: Code generation runner
- **riverpod_generator**: ^3.0.3 - Generates Riverpod providers
- **retrofit_generator**: ^10.0.0 - Generates Retrofit API clients
- **json_serializable**: ^6.10.0 - Generates JSON serialization code

## Linting & Analysis

- **flutter_lints**: ^5.0.0 - Recommended Flutter lints
- **custom_lint**: Custom lint rules
- **riverpod_lint**: ^3.0.3 - Riverpod-specific lints

## Common Commands

### Development

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Run with specific device
flutter run -d <device_id>

# Hot reload (press 'r' in terminal while app is running)
# Hot restart (press 'R' in terminal while app is running)
```

### Code Generation

```bash
# Generate code (Riverpod providers, Retrofit clients, JSON serialization)
dart run build_runner build

# Watch mode (auto-regenerate on file changes)
dart run build_runner watch

# Clean and rebuild
dart run build_runner build --delete-conflicting-outputs
```

### Analysis & Linting

```bash
# Analyze code
flutter analyze

# Run custom lints
dart run custom_lint
```

### Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/path/to/test_file.dart

# Run with coverage
flutter test --coverage
```

### Build

```bash
# Build APK (Android)
flutter build apk

# Build App Bundle (Android)
flutter build appbundle

# Build iOS
flutter build ios

# Build for web
flutter build web
```

### STAC-Specific

```bash
# STAC configuration is in stac.yaml
# Source: stac/
# Output: stac/.build/
```

## Platform Support

- Android
- iOS
- Linux
- macOS
- Windows
- Web

## Key Dependencies Notes

- **Riverpod**: Use code generation with `@riverpod` annotations, run build_runner after changes
- **Retrofit**: API clients are generated, define interfaces with annotations
- **JSON Serialization**: Models use `@JsonSerializable()`, requires build_runner
- **STAC**: Custom widgets/actions go in `stac/` folder, core framework is in `.stac/`
