# Task: Create Splash Screen for Tobank SDUI

**Status**: In Progress  
**Created**: 2025-12-15  
**Figma Design**: https://www.figma.com/design/G0vx068PwQB3ZOMm8jFdlR/TOBANK---Application-Develop-?node-id=9665-1807&m=dev

## Overview

Create a splash screen for the Tobank SDUI app that displays the Tobank logo and app version number, following the STAC framework patterns and matching the Figma design.

## Requirements

- Follow STAC SDUI structure and workflow (Dart → JSON → API JSON)
- Match Figma design specifications
- Use existing logo asset: `assets/icons/ToBank_Red_1.svg`
- **Read version dynamically using `package_info_plus` package**
- Add localization strings to `GET_strings.json`
- Add menu item for navigation (title: "اسپلش")
- Focus on Dart STAC syntax
- Use RTL text direction
- Use theme-aware colors
- Use style aliases

## Dependencies

### package_info_plus
Add to `pubspec.yaml`:
```yaml
dependencies:
  package_info_plus: ^9.0.0
```

**Usage:**
```dart
import 'package:package_info_plus/package_info_plus.dart';

// In main.dart or initialization code:
WidgetsFlutterBinding.ensureInitialized();
PackageInfo packageInfo = await PackageInfo.fromPlatform();
String version = packageInfo.version;
String buildNumber = packageInfo.buildNumber;

// Store in StacRegistry for STAC widget access:
StacRegistry.instance.set('appData.version', version);
StacRegistry.instance.set('appData.buildNumber', buildNumber);
```

## Implementation Steps

### 1. Add package_info_plus Dependency
Add `package_info_plus: ^9.0.0` to `pubspec.yaml` dependencies.

### 2. Create Version Loader
Create `lib/core/stac/loaders/tobank/tobank_version_loader.dart`:
```dart
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stac/stac.dart';

class TobankVersionLoader {
  static Future<void> loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    
    // Store version info in StacRegistry for STAC widget access
    StacRegistry.instance.set('appData.version', packageInfo.version);
    StacRegistry.instance.set('appData.buildNumber', packageInfo.buildNumber);
    StacRegistry.instance.set('appData.appName', packageInfo.appName);
    StacRegistry.instance.set('appData.packageName', packageInfo.packageName);
  }
}
```

### 3. Update main.dart Initialization
Call `TobankVersionLoader.loadVersion()` during app initialization (after `WidgetsFlutterBinding.ensureInitialized()`).

### 4. Create Folder Structure
- Create `lib/stac/tobank/splash/dart/` directory
- Create `lib/stac/tobank/splash/json/` directory
- Create `lib/stac/tobank/splash/api/` directory

### 5. Add Localization Strings
Update `lib/stac/config/GET_strings.json` to add:
```json
"splash": {
  "title": "اسپلش",
  "version": "نسخه"
}
```

### 6. Create Dart STAC Widget
Create `lib/stac/tobank/splash/dart/tobank_splash.dart` with:
- `@StacScreen(screenName: 'tobank_splash_dart')` annotation
- Centered layout with logo and version
- RTL text direction
- Theme-aware colors (`{{appColors.current.*}}`)
- String variables (`{{appStrings.splash.*}}`)
- **Version from registry: `{{appData.version}}`**

### 7. Update Menu
Add splash screen entry to `lib/stac/tobank/menu/api/GET_menu-items.json`:
```json
{
  "title": "{{appStrings.splash.title}}",
  "dartPath": "lib/stac/tobank/splash/dart/tobank_splash.dart",
  "jsonPath": "lib/stac/.build/tobank_splash.json",
  "apiPath": "lib/stac/tobank/splash/api/GET_tobank_splash.json",
  "widgetType": "tobank_splash_dart"
}
```

### 8. Verification
- Preview in app
- Verify UI matches Figma design
- Test navigation from menu
- Test in both light and dark themes
- Verify version displays correctly from pubspec.yaml

## Assets

- Logo: `assets/icons/ToBank_Red_1.svg` (already added)

## Version Access in STAC

The version is accessible via `{{appData.version}}` variable after `TobankVersionLoader.loadVersion()` is called.

Example usage in STAC widget:
```dart
StacText(
  data: '{{appStrings.splash.version}} {{appData.version}}',
  // ...
)
```

## Notes

- Following STAC workflow: Dart → JSON (via `stac build`) → API JSON
- Version is loaded at app startup and stored in StacRegistry
- Version format: "نسخه 1.0.0" (using `{{appStrings.splash.version}} {{appData.version}}`)
- Menu item title: "اسپلش"

## Related Documentation

- Project Overview: `docs/AI/PROJECT_OVERVIEW.md`
- Development Workflow: `docs/AI/DEVELOPMENT_WORKFLOW.md`
- Core STAC Structure: `docs/AI/CORE_STAC_STRUCTURE.md`
- package_info_plus: https://pub.dev/packages/package_info_plus
