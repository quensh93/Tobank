# Mock Data Guide

## Overview

The Mock API system enables development and testing of STAC applications without requiring a live backend. It loads JSON configurations from local assets, simulates network delays, and provides caching capabilities for a realistic development experience.

## Table of Contents

1. [Mock Data Structure](#mock-data-structure)
2. [Creating Mock Screens](#creating-mock-screens)
3. [Configuration Files](#configuration-files)
4. [Using MockApiService](#using-mockapiservice)
5. [Hot Reload Workflow](#hot-reload-workflow)
6. [Mock Mode Indicator](#mock-mode-indicator)
7. [Best Practices](#best-practices)
8. [Troubleshooting](#troubleshooting)

## Mock Data Structure

Mock data is organized in the `assets/mock_data/` directory:

```
assets/mock_data/
├── screens/              # Screen JSON files
│   ├── home_screen.json
│   ├── profile_screen.json
│   └── ...
└── config/               # Configuration files
    ├── navigation_config.json
    └── theme_config.json
```

### Directory Structure

- **screens/**: Contains JSON files for individual screens
- **config/**: Contains app-wide configuration files (navigation, theme, etc.)

## Creating Mock Screens

### Basic Screen Structure

Every STAC screen JSON must have a `type` field and follow the STAC widget schema:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "My Screen"
    }
  },
  "body": {
    "type": "container",
    "child": {
      "type": "text",
      "data": "Hello World"
    }
  }
}
```

### Example: Home Screen

Create `assets/mock_data/screens/home_screen.json`:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Home Screen"
    },
    "backgroundColor": "#2196F3"
  },
  "body": {
    "type": "singleChildScrollView",
    "child": {
      "type": "padding",
      "padding": {
        "all": 16
      },
      "child": {
        "type": "column",
        "crossAxisAlignment": "start",
        "children": [
          {
            "type": "text",
            "data": "Welcome to STAC",
            "style": {
              "fontSize": 24,
              "fontWeight": "bold",
              "color": "#333333"
            }
          },
          {
            "type": "sizedBox",
            "height": 16
          },
          {
            "type": "elevatedButton",
            "child": {
              "type": "text",
              "data": "View Profile"
            },
            "onPressed": {
              "actionType": "navigate",
              "route": "/profile"
            }
          }
        ]
      }
    }
  }
}
```

### Example: Profile Screen

Create `assets/mock_data/screens/profile_screen.json`:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Profile"
    },
    "leading": {
      "type": "iconButton",
      "icon": {
        "type": "icon",
        "icon": "arrow_back"
      },
      "onPressed": {
        "actionType": "pop"
      }
    }
  },
  "body": {
    "type": "padding",
    "padding": {
      "all": 16
    },
    "child": {
      "type": "column",
      "children": [
        {
          "type": "text",
          "data": "John Doe",
          "style": {
            "fontSize": 24,
            "fontWeight": "bold"
          }
        },
        {
          "type": "text",
          "data": "john.doe@example.com",
          "style": {
            "fontSize": 16,
            "color": "#666666"
          }
        }
      ]
    }
  }
}
```

## Configuration Files

### Navigation Configuration

Create `assets/mock_data/config/navigation_config.json`:

```json
{
  "routes": [
    {
      "path": "/",
      "name": "home",
      "screen": "home_screen"
    },
    {
      "path": "/profile",
      "name": "profile",
      "screen": "profile_screen"
    }
  ],
  "initialRoute": "/",
  "transitionDuration": 300,
  "defaultTransition": "fade"
}
```

### Theme Configuration

Create `assets/mock_data/config/theme_config.json`:

```json
{
  "primaryColor": "#2196F3",
  "accentColor": "#4CAF50",
  "backgroundColor": "#FFFFFF",
  "scaffoldBackgroundColor": "#F5F5F5",
  "textTheme": {
    "headline1": {
      "fontSize": 32,
      "fontWeight": "bold",
      "color": "#333333"
    },
    "bodyText1": {
      "fontSize": 16,
      "color": "#666666"
    }
  }
}
```

## Using MockApiService

### Basic Usage

```dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/core/api/providers/mock_api_service_provider.dart';

class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiService = ref.watch(mockApiServiceProvider);
    
    return FutureBuilder<Map<String, dynamic>>(
      future: apiService.fetchScreen('home_screen'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Render STAC JSON
          return StacWidget(json: snapshot.data!);
        } else if (snapshot.hasError) {
          return ErrorWidget(snapshot.error!);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
```

### Using the Generic API Service Provider

The recommended approach is to use the generic `stacApiServiceProvider`, which automatically selects the appropriate service based on configuration:

```dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/core/api/providers/mock_api_service_provider.dart';

class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiService = ref.watch(stacApiServiceProvider);
    
    return FutureBuilder<Map<String, dynamic>>(
      future: apiService.fetchScreen('home_screen'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StacWidget(json: snapshot.data!);
        } else if (snapshot.hasError) {
          return ErrorWidget(snapshot.error!);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
```

### Fetching Configuration

```dart
final apiService = ref.watch(mockApiServiceProvider);

// Fetch navigation config
final navConfig = await apiService.fetchConfig('navigation_config');

// Fetch theme config
final themeConfig = await apiService.fetchConfig('theme_config');
```

### Checking Cache Status

```dart
final apiService = ref.watch(mockApiServiceProvider);

// Check if screen is cached
if (apiService.isCached('home_screen')) {
  print('Home screen is cached');
}

// Get cached data
final cachedData = apiService.getCached('home_screen');
if (cachedData != null) {
  print('Using cached data');
}

// Get cache statistics
final stats = apiService.getCacheStats();
print('Total cached: ${stats['total_cached']}');
print('Valid cached: ${stats['valid_cached']}');
```

## Hot Reload Workflow

### Manual Hot Reload

Trigger a hot reload of mock data programmatically:

```dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/core/api/providers/mock_api_service_provider.dart';

class ReloadButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final notifier = ref.read(mockDataReloadNotifierProvider.notifier);
        await notifier.reloadMockData();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mock data reloaded')),
        );
      },
      child: Text('Reload Mock Data'),
    );
  }
}
```

### Automatic Reload on File Changes

During development, you can modify JSON files in `assets/mock_data/` and trigger a hot reload:

1. Edit a JSON file in `assets/mock_data/screens/`
2. Save the file
3. Trigger hot reload in your app (press 'r' in terminal or use the reload button)
4. The MockApiService will automatically clear its cache and reload the data

### Monitoring Reload Events

```dart
class ReloadMonitor extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reloadCount = ref.watch(mockDataReloadCountProvider);
    
    return Text('Reloaded $reloadCount times');
  }
}
```

## Mock Mode Indicator

### Using the Mock Mode Indicator

The mock mode indicator shows when the app is running in mock API mode and provides quick actions:

#### Banner Style

```dart
import 'package:tobank_sdui/debug_panel/widgets/mock_mode_indicator.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            MockModeIndicator(
              showAsBanner: true,
              showReloadButton: true,
              showModeSwitcher: true,
            ),
            Expanded(
              child: MyContent(),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### Badge Style

```dart
MockModeIndicator(
  showAsBanner: false,
  showReloadButton: true,
  showModeSwitcher: true,
)
```

#### Floating Indicator

```dart
Stack(
  children: [
    MyContent(),
    FloatingMockModeIndicator(),
  ],
)
```

### Indicator Features

- **Visual Status**: Shows current API mode (Mock, Firebase, Custom)
- **Reload Button**: Quick access to reload mock data
- **Mode Switcher**: Switch between API modes without restarting the app
- **Reload Counter**: Displays how many times data has been reloaded

## Best Practices

### 1. Organize Mock Data by Feature

```
assets/mock_data/screens/
├── auth/
│   ├── login_screen.json
│   └── signup_screen.json
├── home/
│   └── home_screen.json
└── profile/
    ├── profile_screen.json
    └── edit_profile_screen.json
```

### 2. Use Consistent Naming

- Screen files: `{feature}_{screen}_screen.json`
- Config files: `{feature}_config.json`
- Example: `home_screen.json`, `navigation_config.json`

### 3. Validate JSON Before Committing

Use a JSON validator to ensure your mock data is valid:

```bash
# Using jq (if installed)
jq . assets/mock_data/screens/home_screen.json

# Or use online validators
# https://jsonlint.com/
```

### 4. Keep Mock Data Realistic

- Use realistic data that matches production scenarios
- Include edge cases (empty lists, long text, etc.)
- Test error states with invalid data

### 5. Document Mock Data Structure

Add comments in a separate markdown file explaining the structure:

```markdown
# Mock Data Documentation

## home_screen.json
- Purpose: Main landing screen
- Features: Welcome message, quick actions
- Navigation: Links to profile screen
```

### 6. Version Control Mock Data

- Commit mock data files to version control
- Update mock data when API contracts change
- Keep mock data in sync with backend schema

### 7. Use Environment-Specific Mock Data

```dart
// In api_config_provider.dart
const environment = String.fromEnvironment('ENVIRONMENT');

if (environment == 'development') {
  return ApiConfig.mock();
}
```

## Troubleshooting

### Screen Not Found Error

**Problem**: `ScreenNotFoundException: Screen "my_screen" was not found`

**Solutions**:
1. Check that the file exists: `assets/mock_data/screens/my_screen.json`
2. Verify the file is listed in `pubspec.yaml` under `assets:`
3. Run `flutter clean` and `flutter pub get`
4. Restart the app (hot reload may not pick up new assets)

### Invalid JSON Format

**Problem**: `JsonParsingException: Invalid JSON format`

**Solutions**:
1. Validate JSON syntax using a JSON validator
2. Check for:
   - Missing commas
   - Trailing commas (not allowed in JSON)
   - Unquoted keys
   - Single quotes instead of double quotes
3. Use a JSON formatter to fix formatting issues

### Cache Not Clearing

**Problem**: Changes to mock data not reflected in app

**Solutions**:
1. Manually clear cache:
   ```dart
   final apiService = ref.read(mockApiServiceProvider);
   await apiService.clearCache();
   ```
2. Use the reload button in the mock mode indicator
3. Restart the app completely

### Assets Not Loading

**Problem**: `FlutterError: Unable to load asset`

**Solutions**:
1. Verify `pubspec.yaml` includes the assets directory:
   ```yaml
   flutter:
     assets:
       - assets/mock_data/screens/
       - assets/mock_data/config/
   ```
2. Run `flutter pub get` after modifying `pubspec.yaml`
3. Perform a hot restart (not just hot reload)

### Slow Performance

**Problem**: App feels slow when loading mock data

**Solutions**:
1. Reduce simulated network delay:
   ```dart
   MockApiService(
     networkDelay: Duration(milliseconds: 100),
   )
   ```
2. Disable network delay simulation:
   ```dart
   MockApiService(
     simulateDelay: false,
   )
   ```
3. Enable caching:
   ```dart
   ApiConfig.mock(
     enableCaching: true,
     cacheExpiry: Duration(minutes: 10),
   )
   ```

### Type Mismatch Errors

**Problem**: Type errors when parsing JSON

**Solutions**:
1. Ensure JSON values match expected types:
   - Numbers: `"fontSize": 24` (not `"fontSize": "24"`)
   - Booleans: `"enabled": true` (not `"enabled": "true"`)
   - Colors: `"color": "#FF0000"` (hex string format)
2. Check STAC widget documentation for correct property types
3. Use the JSON playground to test and validate JSON structure

## Next Steps

- [Custom Widgets Guide](02-custom-widgets-guide.md) - Learn to create custom STAC widgets
- [Custom Actions Guide](03-custom-actions-guide.md) - Learn to create custom STAC actions
- [API Layer Guide](05-api-layer-guide.md) - Understand the complete API layer architecture
- [Firebase Integration](07-firebase-integration.md) - Set up Firebase for cloud-based JSON storage

## Additional Resources

- [STAC Framework Documentation](../../docs/stac/)
- [JSON Playground Guide](10-json-playground-guide.md)
- [Debug Panel Guide](08-debug-panel-guide.md)

