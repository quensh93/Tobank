# Debug Panel Package

A comprehensive Flutter debug panel inspired by device_preview, designed for internal debugging and development tools.

## Features

- **Material 3 Theming**: Beautiful Material 3 design with light, dark, and system theme modes
- **Device Preview**: Test your app on different device sizes and orientations
- **Logs Viewer**: Integrated logs display with filtering and search capabilities
- **Accessibility Tools**: Comprehensive accessibility testing and validation
- **Responsive Layout**: Adapts to different screen sizes (desktop/mobile)
- **Extensible Architecture**: Easy to add new debug tools and features

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  debug_panel:
    path: ./lib/debug_panel
```

## Usage

### Basic Usage

```dart
import 'package:debug_panel/debug_panel.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DebugPanel(
      enabled: kDebugMode, // Only enable in debug mode
      child: MaterialApp(
        title: 'My App',
        home: MyHomePage(),
      ),
    );
  }
}
```

### Customizing Theme

The debug panel uses Material 3 theming with built-in light, dark, and system theme support. You can customize the theme in the Settings tab:

- **Light Mode**: Bright and clean interface for daylight use
- **Dark Mode**: Dark interface to reduce eye strain
- **System Mode**: Automatically follows your system theme preference

The theme preference is automatically saved and persisted across app sessions.

## Architecture

The debug panel is built with a modular architecture:

- **Core**: Main debug panel widget and layout management
- **State**: Riverpod-based state management for different tools
- **Themes**: Material 3 theme system with light/dark modes
- **Widgets**: Individual tab implementations
- **Models**: Data models for devices, logs, and accessibility issues

## Development

### Project Structure

```
lib/debug_panel/
├── debug_panel.dart          # Main debug panel widget
├── themes/
│   └── debug_panel_theme.dart # Material 3 theme system
├── models/
│   └── device_info.dart     # Device information models
├── state/
│   ├── debug_panel_state.dart
│   ├── debug_panel_settings_state.dart
│   ├── device_preview_state.dart
│   ├── logs_state.dart
│   └── accessibility_state.dart
└── widgets/
    ├── device_preview_tab.dart
    ├── logs_tab.dart
    ├── accessibility_tab.dart
    └── settings_tab.dart
```

### Adding New Tools

1. Create a new state file in `state/`
2. Create a new widget file in `widgets/`
3. Add the tab to the main debug panel
4. Update the tab count in `ToolPanel`

## License

This package is part of the internal development tools and is not intended for external distribution.
