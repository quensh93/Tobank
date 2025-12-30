# STAC Framework Limitations & Workarounds

> **Purpose**: Document known limitations of the STAC framework and the workarounds implemented in this project.

## Overview

STAC (Server-Driven UI) is powerful for dynamic UI, but has gaps between models and parsers. This document tracks these limitations and our solutions.

---

## Limitation 1: InputDecoration Borders Not Parsed 🚨

### Problem

`StacInputDecorationTheme` model defines border properties, but the parser doesn't use them:

**Model** (`stac_core`):
```dart
// File: packages/stac_core/lib/foundation/theme/stac_input_decoration_theme/stac_input_decoration_theme.dart
class StacInputDecorationTheme extends StacElement {
  final StacInputBorder? errorBorder;       // Line 71
  final StacInputBorder? focusedBorder;     // Line 72
  final StacInputBorder? focusedErrorBorder; // Line 73
  final StacInputBorder? disabledBorder;    // Line 74
  final StacInputBorder? enabledBorder;     // Line 75
  final StacInputBorder? border;            // Line 76
  // ...
}
```

**Parser** (`stac`):
```dart
// File: packages/stac/lib/src/parsers/foundation/theme/stac_input_decoration_theme_parser.dart
// Lines 30-55 - NO border properties are parsed!
return InputDecorationTheme(
  labelStyle: this?.labelStyle?.parse(context),
  // ... other properties
  filled: this?.filled ?? false,
  fillColor: this?.fillColor.toColor(context),
  // MISSING: enabledBorder, focusedBorder, errorBorder, etc.
);
```

### Impact

- TextFormField borders cannot be customized via STAC JSON theme
- Default Flutter borders are used instead
- No way to match custom design requirements

### Workaround: StacThemeWrapper

**Solution**: Wrap all STAC widgets with a Flutter `Theme` widget that provides `InputDecorationTheme`.

**Implementation**:
```
lib/core/stac/services/theme/stac_theme_wrapper.dart
lib/core/stac/services/widget/stac_widget_resolver.dart
```

**How it works**:
1. `StacWidgetResolver` calls `StacThemeWrapper.wrapWithTheme()` for ALL STAC widgets
2. `StacThemeWrapper` creates a `Theme` widget with custom `InputDecorationTheme`
3. All TextFormField children inherit these border styles

**Server-Driven Approach**:
```dart
// Read colors from StacRegistry (loaded from server)
final borderEnabled = StacRegistry.instance.getValue('appColors.current.input.borderEnabled');
final borderFocused = StacRegistry.instance.getValue('appColors.current.input.borderFocused');
```

### Related Colors in GET_colors.json

```json
{
  "light": {
    "input": {
      "borderEnabled": "#d0d5dd",
      "borderFocused": "#344054"
    }
  },
  "dark": {
    "input": {
      "borderEnabled": "#77839b",
      "borderFocused": "#f9fafb"
    }
  }
}
```

---

## Limitation 2: No Direct Theme Mode Switching in STAC

### Problem

STAC's `StacApp` supports `theme` and `darkTheme`, but there's no built-in action to toggle between them at runtime.

### Workaround: Custom Theme Toggle Action

Create a custom action that:
1. Accesses `ThemeController` (Riverpod provider)
2. Toggles between light/dark mode
3. Updates color aliases in `StacRegistry`

**Files**:
- `lib/core/stac/parsers/actions/theme_toggle_action_model.dart`
- `lib/core/stac/parsers/actions/theme_toggle_action_parser.dart`

---

## Limitation 3: Style Variables in Numeric Fields

### Problem

Some STAC model properties expect `double` or `bool` types, making it impossible to use variable references like `{{appStyles.spacing.x}}`.

**Example in Dart STAC**:
```dart
StacSizedBox(
  height: 16.0, // Can't use '{{appStyles.spacing.betweenSections}}' here
)
```

### Workaround: Post-Processing JSON

After `stac build`, manually edit generated JSON to use variables where needed. Or preprocess JSON before parsing.

**Note**: This is tracked in login dart file with `// TODO:` comments.

---

## Limitation 4: Color Names Limited to Material ColorScheme

### Problem

Native STAC color parsing (e.g., `"color": "primary"`) only works with Material ColorScheme names:
- primary, onPrimary, primaryContainer, onPrimaryContainer
- secondary, onSecondary, etc.
- surface, onSurface, etc.

Custom colors like "brandGold" or "statusWarning" won't resolve.

### Workaround: appColors System

Use the `{{appColors.current.*}}` system:
1. Define all colors in `GET_colors.json` (server-driven)
2. Load into `StacRegistry` via `TobankColorsLoader`
3. Access in JSON via `"color": "{{appColors.current.brandGold}}"`

---

## Best Practices

### 1. Always Wrap STAC Widgets

Ensure `StacWidgetResolver` or equivalent always wraps STAC output with `StacThemeWrapper` for consistent styling.

### 2. Server-Driven Colors

All colors should come from server (`GET_colors.json`) to enable:
- Theme changes without app updates
- A/B testing of color schemes
- Customer-specific branding

### 3. Logging for Debugging

Add logging at key points to verify theme application:

```dart
AppLogger.d('🎨 StacThemeWrapper: borderEnabled=$borderEnabled');
AppLogger.i('🌓 ThemeToggle: Switching to $theme theme');
AppLogger.d('📦 WidgetResolver: Wrapping widget with theme');
```

### 4. Fallback Values

Always provide fallbacks when reading from registry:

```dart
final color = _hexToColor(registryValue) ?? defaultColor;
```

---

## Future Improvements

### Option A: Fork STAC and Fix Parser

Modify `stac_input_decoration_theme_parser.dart` to parse border properties. Requires maintaining a fork.

### Option B: Contribute to STAC

Submit PR to STAC repository to fix the parser gap. Cleaner long-term solution.

### Option C: Custom STAC Extension

Create local extension that overrides the parser. More complex but doesn't require fork.


---

## Limitation 5: `StacImage` Missing `errorBuilder` & `registryKey` Support

### Problem

The standard `StacImage` class provided by `stac` package often lacks support for advanced properties supported by custom parsers, specifically:
- `errorBuilder`: To show fallback widgets when image fails to load.
- `registryKey`: A custom property we added to `CustomImageParser` to bypass STAC's template caching for reactive updates.

### Workaround: Local `StacCustomImage` Class

When using Dart to define STAC UI, you must create a local `StacCustomImage` class (or similar wrapper) that includes these fields, so they are serialized into the JSON.

```dart
class StacCustomImage extends StacWidget {
  // ... fields like src, registryKey, errorBuilder
  
  @override
  String get type => 'image'; // Maps to our CustomImageParser

  @override
  Map<String, dynamic> get jsonData => {
        'src': src,
        if (registryKey != null) 'registryKey': registryKey,
        if (errorBuilder != null) 'errorBuilder': errorBuilder!.toJson(),
        // ...
      };
}
```

**Why `registryKey` is needed**:
Even with `StacRegistryReactive` wrapper, the `src` string might be processed by STAC's templating engine *once* and cached. Passing `registryKey` tells the parser to fetch the value fresh from the registry at build time, ensuring the image actually changes.

---

## Reference Locations

- **STAC Model**: `docs/Archived/.stac/packages/stac_core/lib/foundation/theme/`
- **STAC Parser**: `docs/Archived/.stac/packages/stac/lib/src/parsers/foundation/theme/`
- **StacThemeWrapper**: `lib/core/stac/services/theme/stac_theme_wrapper.dart`
- **StacWidgetResolver**: `lib/core/stac/services/widget/stac_widget_resolver.dart`
- **Colors Loader**: `lib/core/stac/loaders/tobank/tobank_colors_loader.dart`
- **Server Colors**: `lib/stac/design_system/GET_colors.json`

---

**Last Updated**: 2025-12-30
**Related Tasks**: `docs/AI/Tasks/add-theme-toggle-to-menu.md`, `docs/AI/Tasks/image-picker.md`
