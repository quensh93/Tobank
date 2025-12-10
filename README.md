# ToBank SDUI - STAC Hybrid App Framework

A production-ready Flutter application built on the **STAC (Server-Driven UI)** framework, enabling dynamic UI rendering from JSON configurations. This project combines Clean Architecture principles with server-driven UI capabilities to create maintainable, testable, and flexible mobile applications.

## 🌟 Key Features

### Server-Driven UI (STAC Framework)
- **Dynamic UI Rendering**: Render Flutter widgets from JSON configurations
- **70+ Built-in Widgets**: Comprehensive widget library out of the box
- **Custom Components**: Easy creation of project-specific widgets and actions
- **Hot Updates**: Update UI without app releases

### Multiple API Modes
- **Mock API**: Local JSON files for development and testing
- **Firebase Integration**: Cloud-based JSON storage with real-time updates
- **Custom REST API**: Production-ready API integration with retry logic

### Advanced Development Tools
- **Debug Panel**: Comprehensive debugging with STAC-specific logs
- **JSON Playground**: Interactive environment for testing JSON configurations
- **Visual Editor**: Drag-and-drop JSON editor with live preview
- **Firebase CLI**: Command-line tools for managing cloud configurations

### Production Ready
- **Clean Architecture**: Clear separation of concerns (data, domain, presentation)
- **State Management**: Riverpod for reactive state management
- **Testing Framework**: Unit, widget, and integration tests
- **Security**: HTTPS enforcement, input validation, secure storage
- **Performance**: Caching, lazy loading, and optimization strategies

## 🚀 Quick Start

### Prerequisites

- Flutter SDK ^3.9.0
- Dart ^3.9.0
- Firebase account (optional, for Firebase mode)

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd tobank_sdui

# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build

# Run the app
flutter run
```

### First Steps

1. **Explore the Demo**: Run the app to see STAC in action
2. **Read Documentation**: Start with [Getting Started Guide](docs/stac_in_action/01-getting-started.md)
3. **Try the Playground**: Test JSON configurations in the debug panel
4. **Create Custom Widget**: Follow [Custom Widgets Guide](docs/stac_in_action/02-custom-widgets-guide.md)

## 📚 Documentation

### Complete Guide Index

Comprehensive documentation is available in [`docs/stac_in_action/`](docs/stac_in_action/):

#### Getting Started
1. [Getting Started Guide](docs/stac_in_action/01-getting-started.md) - Project overview and setup
2. [Custom Widgets Guide](docs/stac_in_action/02-custom-widgets-guide.md) - Create custom STAC widgets
3. [Custom Actions Guide](docs/stac_in_action/03-custom-actions-guide.md) - Create custom STAC actions
4. [Testing Guide](docs/stac_in_action/04-testing-guide.md) - Testing strategies and patterns

#### API & Data Management
5. [API Layer Guide](docs/stac_in_action/05-api-layer-guide.md) - API configuration and switching
6. [Mock Data Guide](docs/stac_in_action/06-mock-data-guide.md) - Working with mock data
7. [Firebase Integration](docs/stac_in_action/07-firebase-integration.md) - Firebase setup and usage

#### Development Tools
8. [Debug Panel Guide](docs/stac_in_action/08-debug-panel-guide.md) - Debug panel features
9. [Visual Editor Guide](docs/stac_in_action/09-visual-editor-guide.md) - Visual JSON editor
10. [JSON Playground Guide](docs/stac_in_action/10-json-playground-guide.md) - Interactive testing
11. [CLI Tools Guide](docs/stac_in_action/11-cli-tools-guide.md) - Firebase CLI tools

#### Production & Advanced
12. [Production Deployment](docs/stac_in_action/12-production-deployment.md) - Production setup
13. [Troubleshooting Guide](docs/stac_in_action/13-troubleshooting.md) - Common issues and solutions
14. [Security Implementation](docs/stac_in_action/14-security-implementation.md) - Security best practices

### Additional Resources

- [Architecture Reference](docs/ARCHITECTURE_REFERENCE.md) - Clean Architecture guide
- [STAC Framework Docs](docs/stac/) - Core STAC framework documentation
- [Example Code](docs/stac_in_action/examples/) - Complete working examples

## 🏗️ Project Structure

```
tobank_sdui/
├── lib/
│   ├── core/                   # Shared utilities and services
│   │   ├── api/                # API layer (mock, Firebase, custom)
│   │   ├── logging/            # STAC-specific logging
│   │   ├── validation/         # JSON validation
│   │   └── cache/              # Caching system
│   ├── data/                   # Data layer (repositories, models)
│   ├── debug_panel/            # Debug panel package
│   ├── features/               # Feature modules
│   └── main.dart               # App entry point
├── stac/                       # Custom STAC components
│   ├── widgets/                # Custom widgets
│   ├── actions/                # Custom actions
│   └── registry/               # Component registry
├── .stac/                      # STAC framework reference (read-only)
├── assets/
│   └── mock_data/              # Mock JSON configurations
├── docs/
│   └── stac_in_action/         # Complete documentation
└── test/                       # Test files
```

## 🎯 Common Tasks

### Creating Custom Components

```bash
# 1. Create widget model and parser
# See: docs/stac_in_action/02-custom-widgets-guide.md

# 2. Run code generation
dart run build_runner build

# 3. Register in component registry
# See: docs/stac_in_action/examples/custom-widget-example.dart

# 4. Test in JSON playground
# Open debug panel → Playground tab
```

### Switching API Modes

```dart
// In your app configuration
const bool USE_MOCK_API = true;  // Development
const bool USE_FIREBASE = false; // Staging
const bool USE_CUSTOM_API = false; // Production

// See: docs/stac_in_action/05-api-layer-guide.md
```

### Managing Firebase JSON

```bash
# Upload screen to Supabase
dart run lib/tools/supabase_cli/supabase_cli.dart upload \
  --screen tobank_home \
  --file stac/.build/tobank_home.json

# List all screens
dart run lib/tools/firebase_cli/firebase_cli.dart list

# See: docs/stac_in_action/11-cli-tools-guide.md
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/stac/widgets/custom_card_test.dart

# See: docs/stac_in_action/04-testing-guide.md
```

## 🔧 Development

### Code Generation

```bash
# Generate code (Riverpod, JSON serialization, Retrofit)
dart run build_runner build

# Watch mode (auto-regenerate)
dart run build_runner watch

# Clean and rebuild
dart run build_runner build --delete-conflicting-outputs
```

### Debug Panel

Access the debug panel in development mode:
- Tap the floating debug button
- View STAC logs, network requests, and state
- Test JSON in the playground
- Use visual editor for drag-and-drop UI creation

## 🚢 Production Deployment

### Build for Production

```bash
# Android
flutter build apk --release --dart-define=ENVIRONMENT=production

# iOS
flutter build ios --release --dart-define=ENVIRONMENT=production

# Web
flutter build web --release --dart-define=ENVIRONMENT=production
```

### Production Checklist

- [ ] Disable debug panel (`ENABLE_DEBUG_PANEL = false`)
- [ ] Switch to custom API (`USE_CUSTOM_API = true`)
- [ ] Enable security features (HTTPS, input validation)
- [ ] Configure error monitoring (Sentry, Firebase Crashlytics)
- [ ] Test with production data
- [ ] Review security rules (Firebase)
- [ ] Enable caching and performance optimizations

See [Production Deployment Guide](docs/stac_in_action/12-production-deployment.md) for complete checklist.

## 🛠️ Tech Stack

### Core Framework
- **Flutter**: ^3.9.0
- **Dart**: ^3.9.0
- **STAC Framework**: Server-Driven UI (local package)

### State Management & Architecture
- **hooks_riverpod**: ^3.0.3 - State management
- **flutter_hooks**: Hooks for Flutter
- **fpdart**: ^1.1.1 - Functional programming

### Network & API
- **dio**: ^5.7.0 - HTTP client
- **retrofit**: ^4.7.3 - Type-safe REST client
- **json_annotation**: ^4.9.0 - JSON serialization

### Storage & Security
- **flutter_secure_storage**: ^9.2.4 - Secure storage
- **path_provider**: ^2.1.5 - File system paths

### Debugging & Monitoring
- **ispect**: ^4.4.8-dev02 - Inspector
- **talker**: ^5.0.0 - Logging
- **debug_panel**: Local package

See [Tech Stack Guide](.kiro/steering/tech.md) for complete list.

## 📖 Learning Resources

### For Developers
- Start with [Getting Started Guide](docs/stac_in_action/01-getting-started.md)
- Follow [Custom Widgets Guide](docs/stac_in_action/02-custom-widgets-guide.md)
- Review [Example Code](docs/stac_in_action/examples/)
- Check [Troubleshooting Guide](docs/stac_in_action/13-troubleshooting.md)

### For AI Agents
- Documentation is optimized for AI consumption
- Complete, working code examples
- Clear requirements and constraints
- Step-by-step instructions
- See [README](docs/stac_in_action/README.md#for-ai-agents)

## 🤝 Contributing

Contributions are welcome! Please:

1. Follow the existing code style and architecture
2. Write tests for new features
3. Update documentation
4. Follow [Clean Architecture](docs/ARCHITECTURE_REFERENCE.md) principles

## 📄 License

[Add your license here]

## 🆘 Support

### Getting Help

1. Check [Troubleshooting Guide](docs/stac_in_action/13-troubleshooting.md)
2. Review [Example Code](docs/stac_in_action/examples/)
3. Consult [STAC Documentation](docs/stac/)
4. Open an issue on GitHub

### Common Issues

- **Widget not rendering**: [Troubleshooting - Custom Components](docs/stac_in_action/13-troubleshooting.md#custom-component-issues)
- **API not working**: [Troubleshooting - API Layer](docs/stac_in_action/13-troubleshooting.md#api-layer-issues)
- **Build errors**: [Troubleshooting - Build Issues](docs/stac_in_action/13-troubleshooting.md#build-and-code-generation-issues)

## 🎉 Acknowledgments

- STAC Framework for server-driven UI capabilities
- Flutter team for the amazing framework
- Riverpod for state management
- All contributors and maintainers

---

**Built with ❤️ using Flutter and STAC**

For detailed documentation, visit [`docs/stac_in_action/`](docs/stac_in_action/)
