# ToBank SDUI - Project Overview

## Executive Summary

ToBank SDUI is a production-ready Flutter application built on the **STAC (Server-Driven UI)** framework. The application enables dynamic UI rendering from JSON configurations, combining Clean Architecture principles with server-driven UI capabilities to create a maintainable, testable, and flexible mobile application platform.

The project supports multiple API modes (Mock, Firebase, Custom REST), includes comprehensive development tools (Debug Panel, JSON Playground, Visual Editor), and implements production-ready features including security, performance optimization, and comprehensive testing.

---

## Architecture Overview

### System Architecture

The application follows a **modular, plugin-based architecture** built on Flutter's widget system, designed around three core principles:

1. **JSON-Driven**: UI defined as JSON configurations
2. **Registry-Based**: Central registration system for extensibility
3. **Parser Pattern**: Convert JSON to Flutter widgets at runtime

### High-Level Architecture

```
Application Layer
    ↓
STAC Framework
    ├── StacRegistry (State & Registration)
    ├── StacService (JSON Processing)
    └── Network Layer
        ↓
Parser Layer
    ├── Widget Parsers
    └── Action Parsers
        ↓
Core Layer (stac_core)
    ├── Widget Models
    ├── Action Models
    └── Foundation Types
        ↓
Flutter Layer
    ├── Flutter Widgets
    └── Render Objects
```

### Clean Architecture Implementation

The project implements Clean Architecture with three main layers:

#### 1. Domain Layer
- Business logic and entities
- Repository interfaces
- Use cases

#### 2. Data Layer
- Data access and external services
- Repository implementations
- Data models (DTOs with JSON serialization)
- Data sources (Remote/Local)

#### 3. Presentation Layer
- UI components and screens
- State management (Riverpod)
- Widgets and reusable components

### Package Architecture

The STAC framework consists of multiple packages:

```
.stac/packages/
├── stac_core/          # Pure Dart - Data models
├── stac/               # Flutter - Core framework
├── stac_framework/     # Parser interfaces
├── stac_logger/        # Logging utilities
└── stac_webview/       # WebView integration
```

### Design Patterns

1. **Registry Pattern**: Singleton pattern for managing widget parsers, action parsers, and state variables
2. **Factory Pattern**: Widget models use factory constructors for JSON deserialization
3. **Strategy Pattern**: Parsers implement a common interface with different strategies
4. **Repository Pattern**: Abstraction layer for data access
5. **Use Case Pattern**: Business logic encapsulation

---

## Project Structure

### Root Organization

```
tobank_sdui/
├── lib/                    # Main application code
│   ├── core/               # Shared utilities and services
│   ├── data/               # Data layer (repositories, models)
│   ├── debug_panel/        # Debug panel package
│   ├── features/           # Feature modules
│   ├── tools/              # Development tools
│   └── main.dart           # App entry point
├── stac/                   # Custom STAC components (project-specific)
│   ├── widgets/            # Custom widgets
│   ├── actions/            # Custom actions
│   └── registry/           # Component registry
├── .stac/                  # STAC framework reference (read-only)
├── assets/                  # Assets and mock data
│   └── mock_data/          # Mock JSON configurations
├── docs/                    # Project documentation
├── test/                   # Test files
├── android/                # Android platform code
├── ios/                    # iOS platform code
├── web/                    # Web platform code
├── linux/                  # Linux platform code
├── macos/                  # macOS platform code
└── windows/               # Windows platform code
```

### Core Directory Structure

```
lib/core/
├── api/                    # API layer (mock, Firebase, custom)
│   ├── api_config.dart
│   ├── stac_api_service.dart
│   ├── auth/              # Authentication
│   ├── cache/             # Caching
│   ├── connectivity/      # Network connectivity
│   ├── exceptions/        # API exceptions
│   ├── models/            # API models
│   ├── providers/         # API providers
│   └── services/         # API services
├── bootstrap/             # Application bootstrap system
│   ├── bootstrap.dart
│   ├── app_root.dart
│   ├── app_wrappers.dart
│   └── initializer/       # Initialization components
├── config/                # Application configuration
│   ├── build_config.dart
│   ├── debug_panel_config.dart
│   ├── environment_config.dart
│   └── feature_flags.dart
├── design_system/         # Design tokens and theme
│   ├── app_theme.dart
│   ├── color_schemes.dart
│   ├── semantic_colors.dart
│   ├── tokens.dart
│   └── typography.dart
├── errors/                # Error handling (Failure classes)
├── extensions/            # Dart extensions
├── helpers/               # Utility helpers
├── logging/               # STAC-specific logging
│   ├── stac_logger.dart
│   ├── stac_log_models.dart
│   ├── stac_log_interceptor.dart
│   └── production_error_logger.dart
├── monitoring/            # Performance monitoring
├── network/               # Network layer (Dio, Retrofit setup)
│   ├── dio_with_simulator.dart
│   ├── network_info.dart
│   ├── network_simulator_adapter.dart
│   ├── network_simulator_interceptor.dart
│   └── interceptors/      # Network interceptors
├── routing/               # Navigation and routing
├── security/              # Security features
│   ├── input_validator.dart
│   ├── secure_config_storage.dart
│   ├── secure_http_client.dart
│   └── supabase_auth_manager.dart
├── stac/                  # STAC integration
│   ├── custom_component_registry.dart
│   └── parsers/           # Custom parsers
├── storage/               # Local storage services
│   ├── secure_storage_service.dart
│   └── secure_storage_keys.dart
├── usecases/              # Base usecase interfaces
├── validation/            # JSON validation
│   ├── json_validator.dart
│   └── stac_json_validator.dart
├── widgets/               # Reusable core widgets
│   ├── error_widget.dart
│   ├── loading_widget.dart
│   ├── lazy_stac_screen.dart
│   ├── mock_mode_indicator.dart
│   └── optimized_stac_widget.dart
└── cache/                 # Caching system
    ├── cache_manager.dart
    └── json_parse_cache.dart
```

### Features Directory Structure

```
lib/features/
├── pre_launch/            # Pre-launch screen
│   ├── presentation/
│   │   ├── screens/
│   │   └── widgets/
│   └── providers/
└── stac_test_app/         # STAC test application
    ├── data/
    │   ├── services/
    │   └── utils/
    ├── domain/
    │   └── models/
    └── presentation/
        ├── actions/
        ├── providers/
        ├── screens/
        └── widgets/
```

### Debug Panel Structure

```
lib/debug_panel/
├── debug_panel_widget.dart
├── debug_panel.dart
├── state/                 # State management
│   ├── debug_panel_settings_state.dart
│   ├── device_preview_state.dart
│   ├── logs_state.dart
│   └── accessibility_state.dart
├── widgets/               # Debug panel widgets
│   ├── device_preview_tab.dart
│   ├── logs_tab.dart
│   ├── accessibility_tab.dart
│   ├── settings_tab.dart
│   ├── playground_tab.dart
│   └── [47 additional widget files]
├── screens/               # Debug panel screens
│   ├── json_playground_screen.dart
│   ├── stac_test_app_playground_screen.dart
│   └── visual_editor_screen.dart
├── themes/                # Debug panel theming
└── models/                # Debug panel models
```

### Tools Directory Structure

```
lib/tools/
├── supabase_cli/          # Firebase/Supabase CLI tools
│   ├── supabase_cli.dart
│   ├── supabase_cli_service.dart
│   └── commands/          # CLI commands
│       ├── upload_command.dart
│       ├── download_command.dart
│       ├── list_command.dart
│       ├── delete_command.dart
│       ├── history_command.dart
│       ├── rollback_command.dart
│       └── validate_command.dart
└── supabase_crud/         # Firebase CRUD interface
    ├── supabase_crud_app.dart
    ├── services/
    ├── providers/
    ├── models/
    └── screens/
```

---

## Complete File Inventory

### Dart Source Files

#### Core Module (81 files)
- **API Layer**: 15 files (config, services, providers, models, exceptions)
- **Bootstrap**: 4 files (bootstrap, app_root, app_wrappers, initializer)
- **Configuration**: 4 files (build_config, environment_config, feature_flags, debug_panel_config)
- **Design System**: 5 files (theme, colors, typography, tokens)
- **Logging**: 4 files (stac_logger, log_models, interceptors, production_logger)
- **Network**: 9 files (dio, interceptors, network_info, simulator)
- **Security**: 4 files (input_validator, secure_storage, secure_http, auth_manager)
- **Storage**: 3 files (secure_storage_service, keys, examples)
- **STAC Integration**: 3 files (component_registry, parsers)
- **Validation**: 2 files (json_validator, stac_json_validator)
- **Widgets**: 5 files (error_widget, loading_widget, lazy_stac_screen, mock_indicator, optimized_widget)
- **Extensions**: 2 files (context_extensions, string_extensions)
- **Helpers**: 2 files (date_helper, logger)
- **Errors**: 1 file (failures)
- **Routing**: 1 file (routing_provider)
- **Monitoring**: 1 file (performance_monitor)
- **Cache**: 2 files (cache_manager, json_parse_cache)
- **Usecases**: 1 file (usecase)
- **Constants**: 1 file (app_constants)

#### Data Module (8 files)
- **Data Sources**: 1 file (api_service)
- **Models**: 2 files (user_model)
- **Providers**: 2 files (api_providers)
- **Repositories**: 1 file (user_repository)

#### Debug Panel Module (77 files)
- **Main**: 3 files (debug_panel_widget, debug_panel, debug_panel_main)
- **State**: 4 files (settings_state, device_preview_state, logs_state, accessibility_state)
- **Widgets**: 47 files (tabs, editors, previews, components)
- **Screens**: 3 files (json_playground, stac_test_app_playground, visual_editor)
- **Themes**: 1 file (debug_panel_theme)
- **Models**: 4 files (component_item, device_info, menu_item, navigation_route, widget_node)
- **Data**: 1 file (playground_templates)
- **Extensions**: 4 files (stac_logs_screen, stac_log_viewer, additional widgets)

#### Features Module (15 files)
- **Pre-Launch**: 6 files (screen, widgets, providers)
- **STAC Test App**: 9 files (screen, providers, services, models, actions, utils)

#### Tools Module (24 files)
- **Supabase CLI**: 11 files (cli, service, commands)
- **Supabase CRUD**: 13 files (app, services, providers, models, screens, widgets)

#### Dummy Module (13 files)
- Test pages and widgets for development

### Configuration Files

- `pubspec.yaml` - Project dependencies and configuration
- `analysis_options.yaml` - Linter configuration
- `stac.yaml` - STAC framework configuration
- `BUILD_VARIANTS.md` - Build configuration documentation
- Platform-specific configurations (Android, iOS, Web, Linux, macOS, Windows)

### Documentation Files

- `README.md` - Main project documentation
- `docs/ARCHITECTURE_REFERENCE.md` - Architecture guide
- `docs/stac_core/` - STAC core documentation (6 files)
- `docs/stac_in_action/` - STAC implementation guides (14+ files)
- `docs/debug_panel/` - Debug panel documentation (5 files)
- `docs/retrofit/` - Retrofit documentation (5 files)
- `docs/dio/` - Dio documentation (44 files)
- `docs/riverpod/` - Riverpod documentation (31 files)
- `docs/stac/` - STAC framework documentation (117 files)

### Test Files

- **Core Tests**: 8 files (API, security, logging, validation)
- **Debug Panel Tests**: 5 files
- **Feature Tests**: 6 files (pre_launch, stac_test_app)
- **Integration Tests**: 3 files
- **Regression Tests**: 1 file
- **STAC Tests**: 3 files
- **Tools Tests**: 2 files

### Asset Files

- **Mock Data**: JSON configurations for screens and configs
- **Fonts**: Custom font files
- **Images**: App icons and assets for multiple platforms

---

## Features

### Server-Driven UI (STAC Framework)

#### Core STAC Capabilities
- **Dynamic UI Rendering**: Render Flutter widgets from JSON configurations
- **70+ Built-in Widgets**: Comprehensive widget library out of the box
- **Custom Components**: Easy creation of project-specific widgets and actions
- **Hot Updates**: Update UI without app releases
- **Template-Data Separation**: Separate UI structure from data binding
- **Variable Resolution**: Dynamic data binding with `{{variable}}` syntax
- **Action System**: Comprehensive action framework for user interactions

#### STAC Test App Feature
- **Entry Point System**: Multiple entry point JSON files support
- **Screen Management**: Dynamic screen loading from JSON templates
- **Login Flow**: Mock authentication with JSON-driven UI
- **Home Screen**: Grid-based layout with STAC widgets
- **Hot Reload**: Real-time screen updates without restart
- **Restart Capability**: Full app reset to initial state

### Multiple API Modes

#### Mock API Mode
- **Local JSON Files**: Development and testing with local files
- **File System Access**: Read/write JSON configurations
- **Path Resolution**: Relative and absolute path support
- **Hot Reload**: Instant updates from file changes

#### Firebase Integration
- **Cloud Storage**: JSON configurations stored in Firebase/Supabase
- **Real-time Updates**: Live configuration updates
- **CLI Tools**: Command-line interface for managing configurations
- **CRUD Interface**: Web-based interface for managing JSON files
- **Version History**: Track changes and rollback capabilities
- **Validation**: JSON validation before upload

#### Custom REST API
- **Production API**: Integration with custom backend
- **Retry Logic**: Automatic retry on failures
- **Error Handling**: Comprehensive error management
- **Caching**: Response caching for performance
- **Network Simulation**: Test network conditions

### Advanced Development Tools

#### Debug Panel
- **Device Preview**: Realistic device mockups with device_frame
- **Logs Viewer**: Real-time log viewing with filtering
- **Accessibility Audit**: Comprehensive accessibility testing
- **Settings Management**: Theme, text scale, UI size controls
- **Responsive Layout**: Adapts to desktop and mobile screen sizes
- **State Persistence**: Settings saved across sessions
- **Tabbed Interface**: Organized debug tools

#### JSON Playground
- **Interactive Editor**: Edit JSON configurations in real-time
- **Syntax Validation**: JSON syntax checking
- **Entry Point Selection**: Choose from multiple entry point files
- **Hot Reload Button**: Refresh current screen
- **Restart Button**: Reset app to initial state
- **File Discovery**: Automatic scanning of entry point files

#### Visual Editor
- **Drag-and-Drop**: Visual JSON editor with drag-and-drop
- **Live Preview**: Real-time preview of changes
- **Component Palette**: Available widgets and components
- **Property Editor**: Edit component properties
- **Canvas System**: Visual canvas for layout design

#### Firebase CLI Tools
- **Upload Command**: Upload JSON files to Firebase
- **Download Command**: Download JSON files from Firebase
- **List Command**: List all available screens
- **Delete Command**: Delete screens from Firebase
- **History Command**: View version history
- **Rollback Command**: Rollback to previous versions
- **Validate Command**: Validate JSON before upload

#### Firebase CRUD Interface
- **Screen Management**: Create, read, update, delete screens
- **Bulk Operations**: Batch operations on multiple screens
- **JSON Editor**: Built-in JSON editor
- **Error Display**: User-friendly error messages
- **Loading Indicators**: Progress feedback

### Production Features

#### Security
- **HTTPS Enforcement**: Secure network communication
- **Input Validation**: Comprehensive input validation
- **Secure Storage**: Flutter Secure Storage for sensitive data
- **Token Management**: Secure authentication token handling
- **Supabase Auth**: Integration with Supabase authentication

#### Performance
- **Caching System**: JSON parsing and response caching
- **Lazy Loading**: Efficient resource loading
- **Optimized Widgets**: Performance-optimized STAC widgets
- **Performance Monitoring**: Real-time performance tracking
- **Network Optimization**: Efficient network usage

#### Error Handling
- **Comprehensive Error Types**: Structured error handling
- **User-Friendly Messages**: Clear error communication
- **Error Logging**: Detailed error logging
- **Recovery Mechanisms**: Automatic error recovery
- **Validation**: JSON and STAC validation

#### Testing Framework
- **Unit Tests**: Component-level testing
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end testing
- **Regression Tests**: Prevent regressions
- **Test Coverage**: Comprehensive test coverage

### Custom Components

#### Custom Widgets
- **Digital Clock**: Custom clock widget example
- **Component Registry**: Centralized component registration
- **Parser System**: Custom widget parser support
- **JSON Configuration**: Widget configuration via JSON

#### Custom Actions
- **Login Action**: Custom authentication action
- **Action Parser System**: Custom action parser support
- **Business Logic**: Project-specific action implementations

### State Management

#### Riverpod Integration
- **State Providers**: Feature-specific state management
- **Global Providers**: Shared state across app
- **Async Notifiers**: Asynchronous state management
- **State Notifiers**: Synchronous state management
- **Provider Generation**: Code generation for providers

### Design System

#### Theming
- **Material Design 3**: Modern Material Design implementation
- **Dynamic Theming**: Light and dark mode support
- **Color Schemes**: Comprehensive color system
- **Typography**: Consistent typography scale
- **Design Tokens**: Centralized design tokens

#### Components
- **Reusable Widgets**: Core widget library
- **Error Widgets**: Standardized error displays
- **Loading Widgets**: Consistent loading indicators
- **Form Components**: Form input components

### Network Layer

#### HTTP Client
- **Dio Integration**: Advanced HTTP client
- **Retrofit**: Type-safe REST client
- **Interceptors**: Request/response interceptors
- **Error Handling**: Network error management
- **Retry Logic**: Automatic retry mechanisms

#### Network Simulation
- **Slow Network**: Simulate slow network conditions
- **Network Adapter**: Network condition simulation
- **Testing Support**: Network testing utilities

### Logging System

#### STAC Logging
- **STAC-Specific Logs**: Framework-specific logging
- **Log Interceptors**: Automatic log capture
- **Log Models**: Structured log data
- **Production Logger**: Production error logging

#### General Logging
- **Talker Integration**: Advanced logging library
- **Log Levels**: Debug, info, warning, error
- **Log Export**: Export logs for analysis

### Build System

#### Build Variants
- **Development**: Full debug features enabled
- **Staging**: Production-like with debug features
- **Production**: Optimized production build

#### Feature Flags
- **Runtime Configuration**: Feature toggling
- **Build-Time Flags**: Compile-time feature control
- **Environment-Specific**: Environment-based features

---

## Technical Stack

### Core Framework
- **Flutter**: ^3.9.0
- **Dart**: ^3.9.0
- **STAC Framework**: Server-Driven UI (local package)

### State Management & Architecture
- **hooks_riverpod**: ^3.0.3 - State management
- **flutter_hooks**: Hooks for Flutter
- **fpdart**: ^1.1.1 - Functional programming
- **riverpod_annotation**: ^3.0.3 - Riverpod annotations
- **riverpod_generator**: ^3.0.3 - Code generation

### Network & API
- **dio**: ^5.7.0 - HTTP client
- **retrofit**: ^4.7.3 - Type-safe REST client
- **json_annotation**: ^4.9.0 - JSON serialization
- **json_serializable**: ^6.10.0 - Code generation
- **supabase_flutter**: ^2.10.3 - Supabase integration
- **supabase**: ^2.10.0 - Supabase client

### Storage & Security
- **flutter_secure_storage**: ^9.2.4 - Secure storage
- **path_provider**: ^2.1.5 - File system paths
- **shared_preferences**: ^2.2.0 - Shared preferences

### Debugging & Monitoring
- **ispect**: ^4.4.8-dev02 - Inspector
- **ispectify**: ^4.4.8-dev02 - Inspector extensions
- **ispectify_dio**: ^4.4.8-dev02 - Dio inspector
- **talker**: ^5.0.0 - Logging
- **talker_flutter**: ^5.0.0 - Flutter logging
- **slow_net_simulator**: ^1.0.0 - Network simulation
- **flutter_performance_pulse**: ^1.0.6 - Performance monitoring

### UI & Design
- **device_frame**: ^1.2.0 - Device mockups
- **material_color_utilities**: ^0.11.1 - Material colors
- **cupertino_icons**: ^1.0.8 - iOS icons

### Utilities
- **uuid**: ^4.5.1 - UUID generation
- **crypto**: ^3.0.3 - Cryptographic functions
- **intl**: ^0.20.2 - Internationalization
- **meta**: ^1.12.0 - Metadata annotations
- **file_picker**: ^10.3.6 - File picking
- **share_plus**: ^12.0.1 - Sharing functionality
- **args**: ^2.4.2 - Command-line arguments

### Development Tools
- **build_runner**: Code generation
- **flutter_lints**: ^5.0.0 - Linting
- **custom_lint**: Custom linting rules
- **retrofit_generator**: ^10.0.0 - Retrofit code generation

---

## Platform Support

### Supported Platforms
- **iOS**: Full support with native integration
- **Android**: Full support with native integration
- **Web**: Web application support
- **Linux**: Desktop Linux support
- **macOS**: Desktop macOS support
- **Windows**: Desktop Windows support

### Platform-Specific Features
- **iOS**: Native iOS components and integrations
- **Android**: Native Android components and integrations
- **Web**: Web-specific optimizations and features
- **Desktop**: Desktop-specific UI adaptations

---

## Development Workflow

### Code Generation
- **Riverpod Providers**: Automatic provider generation
- **JSON Serialization**: Model serialization code
- **Retrofit Clients**: API client code generation

### Testing
- **Unit Tests**: Component-level testing
- **Widget Tests**: UI testing
- **Integration Tests**: End-to-end testing
- **Test Coverage**: Coverage reporting

### Build Process
- **Development Builds**: Debug builds with all features
- **Staging Builds**: Release builds with debug features
- **Production Builds**: Optimized release builds
- **Platform-Specific**: Platform-specific build configurations

---

## Documentation

### Architecture Documentation
- **Architecture Reference**: Clean Architecture guide
- **STAC Core Docs**: Framework architecture
- **Debug Panel Architecture**: Debug panel technical docs
- **Project Structure**: Complete project organization

### Implementation Guides
- **Getting Started**: Project setup and first steps
- **Custom Widgets**: Creating custom STAC widgets
- **Custom Actions**: Creating custom STAC actions
- **Testing Guide**: Testing strategies and patterns
- **API Layer Guide**: API configuration and switching
- **Mock Data Guide**: Working with mock data
- **Firebase Integration**: Firebase setup and usage
- **Debug Panel Guide**: Debug panel features
- **Visual Editor Guide**: Visual JSON editor
- **JSON Playground Guide**: Interactive testing
- **CLI Tools Guide**: Firebase CLI tools
- **Production Deployment**: Production setup
- **Troubleshooting**: Common issues and solutions
- **Security Implementation**: Security best practices

### API Documentation
- **Dio Documentation**: HTTP client documentation (44 files)
- **Retrofit Documentation**: REST client documentation (5 files)
- **Riverpod Documentation**: State management docs (31 files)
- **STAC Documentation**: Framework documentation (117 files)

---

## Project Status

### Completed Features
- ✅ STAC Framework Integration
- ✅ Multiple API Modes (Mock, Firebase, Custom)
- ✅ Debug Panel with comprehensive tools
- ✅ JSON Playground
- ✅ Visual Editor (basic implementation)
- ✅ Firebase CLI Tools
- ✅ Firebase CRUD Interface
- ✅ STAC Test App
- ✅ Custom Component System
- ✅ Security Features
- ✅ Performance Optimization
- ✅ Comprehensive Testing
- ✅ Documentation

### In Progress
- ⏳ Visual Editor enhancements
- ⏳ Additional custom widgets
- ⏳ Performance monitoring improvements
- ⏳ Additional test coverage

### Future Enhancements
- 🔮 Advanced visual editor features
- 🔮 STAC schema validation
- 🔮 Enhanced performance monitoring
- 🔮 Additional platform optimizations
- 🔮 Advanced debugging tools

---

## Key Metrics

### Codebase Statistics
- **Total Dart Files**: ~249 source files
- **Core Module**: 81 files
- **Debug Panel**: 77 files
- **Features**: 15 files
- **Tools**: 24 files
- **Tests**: 30+ test files
- **Documentation**: 200+ documentation files

### Dependencies
- **Production Dependencies**: 25+ packages
- **Development Dependencies**: 6+ packages
- **Local Packages**: 2 (debug_panel, stac)

### Platform Support
- **Supported Platforms**: 6 (iOS, Android, Web, Linux, macOS, Windows)
- **Build Variants**: 3 (Development, Staging, Production)

---

## Conclusion

ToBank SDUI represents a comprehensive, production-ready implementation of a Server-Driven UI framework built on Flutter. The project demonstrates:

- **Architectural Excellence**: Clean Architecture with clear separation of concerns
- **Framework Integration**: Deep integration with STAC Server-Driven UI framework
- **Developer Experience**: Comprehensive development tools and debugging capabilities
- **Production Readiness**: Security, performance, and testing best practices
- **Extensibility**: Custom component system for project-specific needs
- **Documentation**: Extensive documentation for developers and AI agents

The application provides a solid foundation for building maintainable, testable, and flexible mobile applications with server-driven UI capabilities.

