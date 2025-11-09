# Project Structure

## Root Organization

```
tobank_sdui/
├── lib/                    # Main application code
├── stac/                   # Custom STAC components (project-specific)
├── .stac/                  # STAC framework reference (do not modify)
├── docs/                   # Project documentation
├── test/                   # Test files
├── android/                # Android platform code
├── ios/                    # iOS platform code
├── web/                    # Web platform code
├── linux/                  # Linux platform code
├── macos/                  # macOS platform code
├── windows/                # Windows platform code
└── .kiro/                  # Kiro AI assistant configuration
```

## Main Application Structure (lib/)

### Clean Architecture Layers

```
lib/
├── core/                   # Shared utilities and services
│   ├── bootstrap/          # App initialization
│   ├── config/             # App configuration
│   ├── constants/          # App-wide constants
│   ├── design_system/      # Design tokens and theme
│   ├── errors/             # Error handling (Failure classes)
│   ├── extensions/         # Dart extensions (String, BuildContext, etc.)
│   ├── helpers/            # Utility helpers (logger, date, etc.)
│   ├── network/            # Network layer (Dio, Retrofit setup)
│   ├── routing/            # Navigation and routing
│   ├── storage/            # Local storage services
│   ├── usecases/           # Base usecase interfaces
│   └── widgets/            # Reusable core widgets
│
├── data/                   # Data layer (Clean Architecture)
│   ├── datasources/        # Remote/Local data sources
│   ├── models/             # DTOs with JSON serialization
│   ├── providers/          # Data-layer Riverpod providers
│   └── repositories/       # Repository implementations
│
├── debug_panel/            # Debug panel package (local)
│   ├── widgets/            # Debug UI components
│   ├── state/              # Debug panel state
│   └── models/             # Debug panel models
│
├── dummy/                  # Example/test pages
│   ├── models/             # Example models
│   ├── providers/          # Example providers
│   ├── services/           # Example services
│   └── *_page.dart         # Demo pages
│
└── main.dart               # App entry point
```

## Feature-First Organization Pattern

When adding features, follow this structure:

```
lib/features/<feature_name>/
├── data/
│   ├── datasources/
│   │   ├── <feature>_remote_data_source.dart
│   │   └── <feature>_local_data_source.dart
│   ├── models/
│   │   └── <model>_model.dart          # DTOs with @JsonSerializable
│   └── repositories/
│       └── <feature>_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   └── <entity>.dart               # Business models
│   ├── repositories/
│   │   └── <feature>_repository.dart   # Abstract interfaces
│   └── usecases/
│       └── <action>_usecase.dart       # Business logic
│
└── presentation/
    ├── providers/
    │   └── <feature>_provider.dart     # Riverpod providers
    ├── screens/
    │   └── <screen>_screen.dart        # Full screen widgets
    └── widgets/
        └── <widget>.dart               # Feature-specific widgets
```

## STAC Components

### Custom STAC (stac/)

Project-specific STAC extensions:

```
stac/
├── widgets/                # Custom STAC widgets
├── actions/                # Custom STAC actions
├── examples/               # Usage examples
├── .build/                 # Build output (generated)
└── README.md
```

### STAC Framework Reference (.stac/)

Core STAC framework (read-only reference):

```
.stac/
├── packages/
│   └── stac/               # Core STAC package
├── examples/               # STAC examples
└── website/
    └── docs/               # STAC documentation
```

## Documentation (docs/)

```
docs/
├── agents_chats/           # AI agent conversation logs
├── ARCHITECTURE_REFERENCE.md  # Clean Architecture guide
├── todo.md                 # Project todos
└── <library>/              # Library-specific docs
    ├── dio/
    ├── retrofit/
    ├── riverpod/
    ├── stac/
    └── ...
```

## Key Conventions

### File Naming

- **Dart files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/functions**: `camelCase`
- **Constants**: `camelCase` or `SCREAMING_SNAKE_CASE` for compile-time constants
- **Private members**: Prefix with `_`

### Code Generation Files

Generated files have `.g.dart` or `.freezed.dart` suffixes:
- `model.g.dart` - JSON serialization
- `provider.g.dart` - Riverpod providers
- `api_client.g.dart` - Retrofit clients

### Import Organization

1. Dart/Flutter imports
2. Package imports
3. Local imports
4. Separate with blank lines

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:tobank_sdui/core/core.dart';
```

### Folder Rules

- **Do not modify**: `.stac/`, `.flutter_riverpod_clean_architecture_template/`, `VeTransfer/`
- **Reference only**: `.stac/` contains STAC framework documentation
- **Local packages**: `lib/debug_panel/` is a local package with its own pubspec.yaml
- **Custom STAC**: Add custom components to `stac/`, not `.stac/`

## State Management Pattern

- Use `@riverpod` annotations for code generation
- Providers go in `providers/` folders
- Run `dart run build_runner build` after adding/modifying providers
- Use `ref.watch()` in widgets, `ref.read()` in callbacks

## Error Handling Pattern

- Use `Either<Failure, Success>` from fpdart
- Define custom `Failure` classes in `core/errors/`
- Repository methods return `Future<Either<Failure, Data>>`
- Use `fold()` or pattern matching to handle results

## Testing Structure

```
test/
├── core/                   # Core utilities tests
├── data/                   # Data layer tests
├── features/               # Feature tests (mirror lib/features/)
└── widget_test.dart        # Widget tests
```

## Platform-Specific Code

- Keep platform code in respective folders (android/, ios/, etc.)
- Use platform channels when needed
- Configure platform-specific settings in respective build files
