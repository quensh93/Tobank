# Theme System Refactoring Task

## Overview

This task involves cleaning up and refactoring the theme system in the current app. The goal is to properly separate two distinct theme systems that currently exist in the application.

## Current Situation

The app currently has **two theme systems** that need to be properly separated:

### 1. General App Theme System
- **Location**: `lib/core/design_system/`
- **Purpose**: Used by the general app, debugger panel, and other non-STAC components
- **Current Files**:
  - `app_theme.dart` - Main theme builder
  - `color_schemes.dart` - Light and dark color schemes
  - `semantic_colors.dart` - Semantic color definitions
  - `tokens.dart` - Design tokens (spacing, radii, durations)
  - `typography.dart` - Typography definitions

### 2. STAC Theme System
- **Location**: Currently mixed with app theme
- **Purpose**: Should be completely isolated and only used for STAC pages
- **Current Usage**: 
  - `lib/features/tobank_mock_new/data/theme/tobank_theme_loader.dart` - Loads STAC themes
  - `lib/core/bootstrap/app_root.dart` - Uses StacApp with StacTheme
  - Theme JSON files in `stac/design_system/`:
    - `tobank_theme_light.json`
    - `tobank_theme_dark.json`

## Requirements

### General App Theme System
- Should remain in `lib/core/design_system/`
- Should handle all theme needs for:
  - General app components
  - Debug panel
  - Non-STAC pages
- Should be independent of STAC theme system

### STAC Theme System
- **MUST be completely isolated** from the general app theme
- Should only be used in STAC pages
- Should follow the STAC package structure for theme
- Should have its own custom system
- Should be located in a dedicated STAC-specific theme directory

## STAC Theme System Documentation

### Official Documentation
- **STAC Theming Guide**: https://docs.stac.dev/concepts/theming
- **Key Concept**: Stac theming functions similarly to Flutter's built-in theming. You define the theme in JSON and apply it using the `StacTheme` widget.

### Implementation Pattern
```dart
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

void main() async {
  await Stac.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StacApp(
      theme: StacTheme.fromJson(themeJson),
      homeBuilder: (context) => const HomeScreen(),
    );
  }
  
  Map<String, dynamic> themeJson = {
    "brightness": "light",
    "disabledColor": "#60FEF7FF",
    "fontFamily": "Handjet",
    "colorScheme": {
      "brightness": "light",
      "primary": "#6750a4",
      "onPrimary": "#FFFFFF",
      // ... more color scheme properties
    }
  };
}
```

## STAC Package Structure Reference

The following files from the STAC clone repository (`docs/Archived/.stac/`) provide the best source of knowledge for understanding the STAC theme system:

### Core Theme Files

#### Main Theme Classes
1. **`packages/stac/lib/src/parsers/theme/stac_theme/stac_theme.dart`**
   - Main `StacTheme` class definition
   - Contains all theme properties (colors, typography, component themes)
   - Has `fromJson` factory method for JSON deserialization
   - Has `parse` extension method that converts `StacTheme` to Flutter's `ThemeData`

2. **`packages/stac/lib/src/parsers/theme/themes.dart`**
   - Exports all theme-related classes
   - Central export file for theme system

3. **`packages/stac/lib/src/framework/stac_app.dart`**
   - `StacApp` widget implementation
   - Accepts `StacTheme` objects for `theme` and `darkTheme` parameters
   - Converts `StacTheme` to `ThemeData` using the `parse` method

#### Color Scheme
4. **`packages/stac/lib/src/parsers/theme/stac_color_scheme/stac_color_scheme.dart`**
   - `StacColorScheme` class definition
   - Complete Material 3 color scheme support
   - Includes all color properties (primary, secondary, tertiary, error, surface, etc.)
   - Has `parse` extension method to convert to Flutter's `ColorScheme`

5. **`packages/stac/lib/src/parsers/theme/stac_material_color/stac_material_color.dart`**
   - `StacMaterialColor` class for Material color swatches
   - Used for `primarySwatch` in theme

#### Typography
6. **`packages/stac/lib/src/parsers/theme/stac_text_theme/stac_text_theme.dart`**
   - `StacTextTheme` class definition
   - Text theme properties for typography
   - Converts to Flutter's `TextTheme`

7. **`packages/stac/lib/src/parsers/theme/stac_icon_theme_data/stac_icon_theme_data.dart`**
   - `StacIconThemeData` class
   - Icon theme properties

#### Component Themes
8. **`packages/stac/lib/src/parsers/theme/stac_app_bar_theme/stac_app_bar_theme.dart`**
   - AppBar theme configuration

9. **`packages/stac/lib/src/parsers/theme/stac_badge_theme_data/stac_badge_theme_data.dart`**
   - Badge theme configuration

10. **`packages/stac/lib/src/parsers/theme/stac_bottom_app_bar_theme/stac_bottom_app_bar_theme.dart`**
    - Bottom app bar theme

11. **`packages/stac/lib/src/parsers/theme/stac_bottom_nav_bar_theme/stac_bottom_nav_bar_theme.dart`**
    - Bottom navigation bar theme

12. **`packages/stac/lib/src/parsers/theme/stac_bottom_sheet_theme/stac_bottom_sheet_theme.dart`**
    - Bottom sheet theme

13. **`packages/stac/lib/src/parsers/theme/stac_button_style/stac_button_style_parser.dart`**
    - Button style parser for all button types
    - Used for elevated, filled, outlined, text, icon buttons

14. **`packages/stac/lib/src/parsers/theme/stac_button_theme_data/stac_button_theme_data.dart`**
    - Legacy button theme data

15. **`packages/stac/lib/src/parsers/theme/stac_card_theme_data/stac_card_theme_data.dart`**
    - Card theme configuration

16. **`packages/stac/lib/src/parsers/theme/stac_checkbox_theme_data/stac_checkbox_theme_data.dart`**
    - Checkbox theme

17. **`packages/stac/lib/src/parsers/theme/stac_chip_theme_data/stac_chip_theme_data.dart`**
    - Chip theme

18. **`packages/stac/lib/src/parsers/theme/stac_date_picker_theme_data/stac_date_picker_theme_data.dart`**
    - Date picker theme

19. **`packages/stac/lib/src/parsers/theme/stac_dialog_theme/stac_dialog_theme.dart`**
    - Dialog theme

20. **`packages/stac/lib/src/parsers/theme/stac_divider_theme_data/stac_divider_theme_data.dart`**
    - Divider theme

21. **`packages/stac/lib/src/parsers/theme/stac_drawer_theme_data/stac_drawer_theme_data.dart`**
    - Drawer theme

22. **`packages/stac/lib/src/parsers/theme/stac_floating_action_button_theme_data/stac_floating_action_button_theme_data.dart`**
    - Floating action button theme

23. **`packages/stac/lib/src/parsers/theme/stac_list_tile_theme_data/stac_list_tile_theme_data.dart`**
    - List tile theme

24. **`packages/stac/lib/src/parsers/theme/stac_material_banner_theme_data/stac_material_banner_theme_data.dart`**
    - Material banner theme

25. **`packages/stac/lib/src/parsers/theme/stac_navigation_bar_theme_data/stac_navigation_bar_theme_data.dart`**
    - Navigation bar theme

26. **`packages/stac/lib/src/parsers/theme/stac_navigation_drawer_theme_data/stac_navigation_drawer_theme_data.dart`**
    - Navigation drawer theme

27. **`packages/stac/lib/src/parsers/theme/stac_scrollbar_theme_data/stac_scrollbar_theme_data.dart`**
    - Scrollbar theme

28. **`packages/stac/lib/src/parsers/theme/stac_snack_bar_theme_data/stac_snack_bar_theme_data.dart`**
    - Snackbar theme

29. **`packages/stac/lib/src/parsers/theme/stac_tab_bar_theme_data/stac_tab_bar_theme_data.dart`**
    - Tab bar theme

#### Foundation Theme
30. **`packages/stac/lib/src/parsers/foundation/theme/stac_input_decoration_theme_parser.dart`**
    - Input decoration theme parser
    - Used for text fields and form inputs

### Utility Files
31. **`packages/stac/lib/src/utils/color_utils.dart`**
    - Color utility functions
    - String to Color conversion
    - Used throughout theme parsers

### Generated Files (Reference Only)
- All `*.freezed.dart` files - Generated by freezed package
- All `*.g.dart` files - Generated by json_serializable package
- These show the structure but should not be edited directly

## Current App Files to Review

### STAC Theme Usage
1. **`lib/core/bootstrap/app_root.dart`**
   - Currently uses `StacApp` with `StacTheme`
   - Loads themes using `TobankThemeLoader`
   - Needs to be refactored to isolate STAC theme usage

2. **`lib/features/tobank_mock_new/data/theme/tobank_theme_loader.dart`**
   - Loads STAC theme JSON files
   - Converts JSON to `StacTheme` objects
   - Should be moved to STAC-specific location

3. **`lib/core/stac/tobank_colors_loader.dart`**
   - STAC color aliases loader
   - Needs review for proper isolation

### General App Theme
4. **`lib/core/design_system/app_theme.dart`**
   - Main theme builder for general app
   - Should remain independent

5. **`lib/core/design_system/color_schemes.dart`**
   - Material 3 color schemes
   - Should remain for general app use

6. **`lib/core/design_system/tokens.dart`**
   - Design tokens (spacing, radii, durations)
   - Should remain for general app use

7. **`lib/core/design_system/typography.dart`**
   - Typography definitions
   - Should remain for general app use

8. **`lib/core/design_system/semantic_colors.dart`**
   - Semantic color definitions
   - Should remain for general app use

## Task Breakdown

### Phase 1: Analysis
- [ ] Review current theme usage across the app
- [ ] Identify all places where STAC theme is used
- [ ] Identify all places where general app theme is used
- [ ] Document dependencies and relationships

### Phase 2: STAC Theme Isolation
- [ ] Create dedicated STAC theme directory structure
- [ ] Move STAC theme files to isolated location
- [ ] Ensure STAC theme system follows STAC package structure
- [ ] Update imports and references

### Phase 3: General App Theme Cleanup
- [ ] Ensure general app theme is complete and self-contained
- [ ] Remove any STAC dependencies from general theme
- [ ] Verify debug panel and other components work with general theme

### Phase 4: Integration & Testing
- [ ] Ensure STAC pages use only STAC theme
- [ ] Ensure non-STAC pages use only general app theme
- [ ] Test theme switching (light/dark mode)
- [ ] Verify no theme conflicts or leaks

## Key Principles

1. **Complete Isolation**: STAC theme system must be completely isolated from general app theme
2. **STAC Package Structure**: STAC theme should follow the structure found in the STAC package
3. **Single Responsibility**: Each theme system should handle only its own domain
4. **No Cross-Contamination**: General app components should never use STAC theme, and vice versa
5. **Maintainability**: Both systems should be easy to maintain and extend independently

## Notes

- The STAC clone repository in `docs/Archived/.stac/` is the best reference for understanding STAC theme structure
- The theme folder structure in `docs/Archived/.stac/packages/stac/lib/src/parsers/theme/` shows all available theme components
- The `StacTheme` class is the central theme object that contains all theme properties
- Theme JSON files should follow the structure defined by `StacTheme.fromJson()`
- The `StacApp` widget is the entry point that applies STAC themes to the app

## References

- [STAC Theming Documentation](https://docs.stac.dev/concepts/theming)
- STAC Clone Repository: `docs/Archived/.stac/`
- STAC Theme Parser Files: `docs/Archived/.stac/packages/stac/lib/src/parsers/theme/`
- STAC Foundation Theme: `docs/Archived/.stac/packages/stac/lib/src/parsers/foundation/theme/`
- Current App Design System: `lib/core/design_system/`
- Current STAC Theme Loader: `lib/features/tobank_mock_new/data/theme/tobank_theme_loader.dart`
