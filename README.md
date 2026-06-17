# ToBank SDUI - STAC Hybrid App Framework

## 🏗️ Build Commands & Modes

This project ships local Dart screens + mock JSON for development, but can build a lean **server-driven (API-only)** APK that excludes them. Two independent switches control what lands in the APK:

| Switch | Controls | Mechanism |
|--------|----------|-----------|
| `--flavor` | JSON assets (`flows/*/json/`, `flows/*/api/`) | pubspec `flavors: [dev]` tags |
| `--dart-define=API=true` | Dart screen code (`flows/*/dart/` via `StacWidgetLoader`) | `bool.fromEnvironment('API')` tree-shake |

> Only the dev-only mock dirs (`flows/*/json`, `flows/*/api`) are tagged `flavors: [dev]`. Shared assets (`config/`, `design_system/`, `.build/`) are **untagged**, so they bundle in every build — a no-flavor build won't crash, it just omits the dev mock JSON. Pass `--flavor dev` to get the local JSON/Dart flows.

### Entry screen (which screen shows on launch)

Controlled by `SduiConfig.startFromApi`, default = `kReleaseMode`:

| Build | Default entry | Override |
|-------|---------------|----------|
| `--release` (end-user APK) | **API flow** — fetches `login_real_splash` from backend | `--dart-define=START_APP_FROM_API=false` |
| debug (`flutter run`) | `PreLaunchScreen` (dev menu) | `--dart-define=START_APP_FROM_API=true` |

End-user release APK auto-starts the server-driven API flow — no flag needed.

### Build matrix — what each command excludes

| State | Command | JSON assets (`json/`+`api/`) | Dart screens (`dart/`) | Shared config | Use case |
|-------|---------|:--:|:--:|:--:|----------|
| **1. Full dev** | `flutter build apk --flavor dev --release` | ✅ in | ✅ in | ✅ in | everything bundled |
| **2. Dev, API code path** | `flutter build apk --flavor dev --release --dart-define=API=true` | ✅ in | ❌ out | ✅ in | test API mode, keep mock assets |
| **3. Prod, assets-only strip** | `flutter build apk --flavor prod --release` | ❌ out | ✅ in | ✅ in | mocks gone, dart code dead weight |
| **4. Lean production ✅** | `flutter build apk --flavor prod --release --dart-define=API=true` | ❌ out | ❌ out | ✅ in | **end-user server-driven APK** |

✅ in = bundled in APK   ❌ out = excluded from APK

### Recommended end-user build

```bash
flutter build apk --flavor prod --release --dart-define=API=true
```

**Excludes:** all `lib/stac/tobank/flows/*/json/`, all `lib/stac/tobank/flows/*/api/`, all `dart/` screen code.
**Keeps:** `lib/stac_core/` (engine), `lib/stac/config/` + `lib/stac/design_system/` (shared, tagged `[dev,prod]`), promissory service parsers, `lib/core/`.
**Entry:** auto-starts API flow (release default — no `START_APP_FROM_API` flag needed).

> iOS: swap `apk` for `ios` — same flags (iOS flavor schemes must be configured first; not yet set up). **Web is different — see the Web / PWA section below** (no `--flavor`, requires `--no-tree-shake-icons`).

### Dev / Debug — run on device or emulator

> Pass `--flavor dev` on every `flutter run` so the dev-only mock JSON (`flows/*/json`, `flows/*/api`) is bundled — otherwise local-JSON/Dart nav flows fail to load. Shared config is untagged so the app still starts without a flavor, just without those flows. `.vscode/launch.json` configs already include `--flavor dev`.

#### A) Everything active — JSON + Dart files all bundled (normal dev)

```bash
flutter run --flavor dev
```

- ✅ Local JSON screens (`navMode: localJson`) work
- ✅ Dart screens (`navMode: dart`) work
- ✅ Mock API files + shared config bundled
- Use for: building/testing flows locally without backend

#### B) Simulate end-user app — no JSON, no Dart files (server-driven only)

```bash
flutter run --flavor prod --dart-define=API=true --dart-define=START_APP_FROM_API=true
```

- ❌ Local JSON screens excluded
- ❌ Dart screens excluded
- ✅ Only `apiJson` nav works — all screens fetched from backend
- ✅ Starts from API flow (`START_APP_FROM_API=true` needed — debug run defaults to dev menu)
- Use for: verifying the real end-user behaves correctly before a release build

> Note: `flutter run` is debug mode, so `startFromApi` defaults to `false` (dev menu). Pass `START_APP_FROM_API=true` to force the API entry. A real `--release` APK starts from API automatically.

> VS Code: add matching launch configs — `"toolArgs": ["--flavor","dev"]` for (A) and `"toolArgs": ["--flavor","prod","--dart-define=API=true","--dart-define=START_APP_FROM_API=true"]` for (B).

### Web / PWA builds — NOT the same as Android

⚠️ The `--flavor` **flag** is not accepted by `flutter build web` — passing it fails with `"Could not find an option named 'flavor'."` So **omit `--flavor`** on web builds.

**But** the pubspec `flavors: [dev]` **tags** are still honored by the web asset bundler. A no-flavor build = "no flavor active" ⇒ all `flavors:[dev]` assets are **automatically excluded**. So the dev-only mock JSON drops out of a web build with no extra work — no post-build cleanup needed. (Verified: 0 `flows/*/json` + `flows/*/api` entries in `build/web`.)

⚠️ `--no-tree-shake-icons` is **required** — the SDUI engine constructs `IconData` dynamically from JSON codepoints; web icon tree-shaking rejects non-const `IconData` and the build fails without this flag.

| Switch | Android | Web (`build web`) |
|--------|:--:|:--:|
| `--dart-define=API=true` (strip Dart screens) | ✅ | ✅ |
| `--dart-define=START_APP_FROM_API` (entry) | ✅ | ✅ |
| `kReleaseMode` auto-entry (release) | ✅ | ✅ |
| pubspec `flavors:[dev]` tag (strip JSON assets) | ✅ (needs `--flavor`) | ✅ (auto — no flavor = excluded) |
| `--flavor` **flag** | ✅ | ❌ build error — omit it |

#### Web end-user build

```bash
flutter build web --release --dart-define=API=true --no-tree-shake-icons
```

- ✅ Dart screen code stripped (`API=true`)
- ✅ Entry auto-starts API flow (release default)
- ✅ JSON mock files (`flows/*/json/`, `*/api/`) **auto-excluded** (no flavor active ⇒ dev-tagged assets dropped)
- ✅ Shared config (`config/`, `design_system/`) kept (untagged)

> Note: because `flutter build web` can't take `--flavor dev`, you **cannot** produce a web build that *includes* the dev mock JSON. For local web dev with mock JSON use `flutter run -d chrome --flavor dev` (run accepts the flag). Web release = server-driven only, which is the intended web target.

> Security note: on web, **all** bundled assets are HTTP-downloadable via the browser. Keeping SDUI JSON fully off-client = serve screens from the backend (`apiJson`), never bundle them — which this build already does.

---

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
