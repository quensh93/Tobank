# STAC Directory Structure Reorganization Proposal

## Current Structure Analysis

### Current Issues:
1. **Mixed Concerns**: Generic STAC code mixed with Tobank-specific loaders at root level
2. **Unclear Hierarchy**: Files with different purposes all at the same level
3. **Large Files**: `stac_mock_dio_setup.dart` is 416 lines - could be split
4. **Naming Inconsistency**: `tobank_*_loader.dart` files in generic `core/stac` directory
5. **Unclear Separation**: Services vs loaders distinction is not clear

### Current Structure:
```
lib/core/stac/
├── custom_component_registry.dart          # Registry (218 lines)
├── register_custom_parsers.dart            # Registration (178 lines)
├── stac_mock_dio_setup.dart                # Mock setup (416 lines - TOO LARGE)
├── tobank_colors_loader.dart               # Color loading (361 lines)
├── tobank_strings_loader.dart              # String loading (145 lines)
├── tobank_styles_loader.dart               # Style loading (307 lines)
├── variable_resolver_debug.dart            # Debug utility (39 lines)
├── parsers/
│   ├── custom_navigate_action_parser.dart  # Navigation (79 lines)
│   ├── custom_set_value_action_parser.dart # SetValue (65 lines)
│   ├── example_action_parser.dart         # Example action (124 lines)
│   └── example_card_parser.dart           # Example widget (165 lines)
└── services/
    ├── stac_navigation_service.dart        # Navigation (75 lines)
    ├── stac_path_normalizer.dart           # Path normalization (60 lines)
    ├── stac_theme_wrapper.dart             # Theme wrapper (83 lines)
    ├── stac_widget_loader.dart             # Widget loader (47 lines)
    └── stac_widget_resolver.dart           # Widget resolver (99 lines)
```

## Proposed Structure

```
lib/core/stac/
├── registry/
│   ├── custom_component_registry.dart
│   └── register_custom_parsers.dart
│
├── mock/
│   ├── stac_mock_dio_setup.dart
│   ├── mock_interceptor.dart (extracted from stac_mock_dio_setup)
│   └── variable_resolver.dart (extracted from stac_mock_dio_setup)
│
├── loaders/
│   ├── base/
│   │   └── stac_config_loader.dart (base class for all loaders)
│   └── tobank/
│       ├── tobank_colors_loader.dart
│       ├── tobank_strings_loader.dart
│       └── tobank_styles_loader.dart
│
├── parsers/
│   ├── actions/
│   │   ├── custom_navigate_action_parser.dart
│   │   ├── custom_set_value_action_parser.dart
│   │   └── example_action_parser.dart
│   └── widgets/
│       └── example_card_parser.dart
│
├── services/
│   ├── navigation/
│   │   └── stac_navigation_service.dart
│   ├── theme/
│   │   └── stac_theme_wrapper.dart
│   ├── widget/
│   │   ├── stac_widget_loader.dart
│   │   └── stac_widget_resolver.dart
│   └── path/
│       └── stac_path_normalizer.dart
│
└── utils/
    └── variable_resolver_debug.dart
```

## Benefits of Proposed Structure

### 1. **Clear Separation of Concerns**
- **Generic STAC code** (registry, mock, services) clearly separated from **Tobank-specific** (loaders)
- Each directory has a single, clear purpose

### 2. **Logical Grouping**
- **Registry**: All registration logic together
- **Mock**: All mock/interceptor setup together
- **Loaders**: All data loading logic together (with base class for reuse)
- **Parsers**: Separated by type (actions vs widgets)
- **Services**: Grouped by domain (navigation, theme, widget, path)
- **Utils**: Debug and utility functions

### 3. **Scalability**
- Easy to add new loaders (extend base class, add to `loaders/tobank/`)
- Easy to add new parsers (add to appropriate subdirectory)
- Easy to add new services (add to appropriate domain directory)

### 4. **Maintainability**
- Easier to find files (clear directory structure)
- Easier to understand dependencies (clear hierarchy)
- Easier to test (isolated components)

### 5. **SOLID Principles**
- **Single Responsibility**: Each directory has one clear purpose
- **Open/Closed**: Base loader class allows extension without modification
- **Dependency Inversion**: Services depend on abstractions

## Migration Plan

### Phase 1: Create New Structure
1. Create new directory structure
2. Move files to new locations
3. Update imports in moved files

### Phase 2: Update Dependencies
1. Update imports in `main.dart`
2. Update imports in `app_root.dart`
3. Update imports in all files that reference moved files

### Phase 3: Refactor Large Files
1. Extract `mock_interceptor.dart` from `stac_mock_dio_setup.dart`
2. Extract `variable_resolver.dart` from `stac_mock_dio_setup.dart`
3. Create base `StacConfigLoader` class for loaders

### Phase 4: Testing
1. Verify all imports work
2. Run app to ensure functionality
3. Check for any broken references

## File Movement Details

### Registry Files
- `custom_component_registry.dart` → `registry/custom_component_registry.dart`
- `register_custom_parsers.dart` → `registry/register_custom_parsers.dart`

### Mock Files
- `stac_mock_dio_setup.dart` → `mock/stac_mock_dio_setup.dart` (then split)
- Extract `mock_interceptor.dart` from `stac_mock_dio_setup.dart`
- Extract `variable_resolver.dart` from `stac_mock_dio_setup.dart`

### Loader Files
- `tobank_colors_loader.dart` → `loaders/tobank/tobank_colors_loader.dart`
- `tobank_strings_loader.dart` → `loaders/tobank/tobank_strings_loader.dart`
- `tobank_styles_loader.dart` → `loaders/tobank/tobank_styles_loader.dart`
- Create `loaders/base/stac_config_loader.dart` (base class)

### Parser Files
- `parsers/custom_navigate_action_parser.dart` → `parsers/actions/custom_navigate_action_parser.dart`
- `parsers/custom_set_value_action_parser.dart` → `parsers/actions/custom_set_value_action_parser.dart`
- `parsers/example_action_parser.dart` → `parsers/actions/example_action_parser.dart`
- `parsers/example_card_parser.dart` → `parsers/widgets/example_card_parser.dart`

### Service Files
- `services/stac_navigation_service.dart` → `services/navigation/stac_navigation_service.dart`
- `services/stac_theme_wrapper.dart` → `services/theme/stac_theme_wrapper.dart`
- `services/stac_widget_loader.dart` → `services/widget/stac_widget_loader.dart`
- `services/stac_widget_resolver.dart` → `services/widget/stac_widget_resolver.dart`
- `services/stac_path_normalizer.dart` → `services/path/stac_path_normalizer.dart`

### Utility Files
- `variable_resolver_debug.dart` → `utils/variable_resolver_debug.dart`

## Import Path Updates Required

### main.dart
```dart
// OLD
import 'core/stac/register_custom_parsers.dart';
import 'core/stac/stac_mock_dio_setup.dart';
import 'core/stac/tobank_strings_loader.dart';
import 'core/stac/tobank_styles_loader.dart';
import 'core/stac/tobank_colors_loader.dart';
import 'core/stac/variable_resolver_debug.dart';

// NEW
import 'core/stac/registry/register_custom_parsers.dart';
import 'core/stac/mock/stac_mock_dio_setup.dart';
import 'core/stac/loaders/tobank/tobank_strings_loader.dart';
import 'core/stac/loaders/tobank/tobank_styles_loader.dart';
import 'core/stac/loaders/tobank/tobank_colors_loader.dart';
import 'core/stac/utils/variable_resolver_debug.dart';
```

### app_root.dart
```dart
// OLD
import '../stac/tobank_colors_loader.dart';

// NEW
import '../stac/loaders/tobank/tobank_colors_loader.dart';
```

### Parser Files
```dart
// OLD (in custom_navigate_action_parser.dart)
import '../services/stac_widget_loader.dart';
import '../services/stac_widget_resolver.dart';
import '../services/stac_navigation_service.dart';

// NEW
import '../../services/widget/stac_widget_loader.dart';
import '../../services/widget/stac_widget_resolver.dart';
import '../../services/navigation/stac_navigation_service.dart';
```

## Additional Improvements

### 1. Extract Mock Interceptor
Split `stac_mock_dio_setup.dart` into:
- `stac_mock_dio_setup.dart` - Main setup function
- `mock_interceptor.dart` - Interceptor logic
- `variable_resolver.dart` - Variable resolution utilities

### 2. Create Base Loader Class
Create `StacConfigLoader` base class to reduce code duplication:
```dart
abstract class StacConfigLoader {
  static bool _loaded = false;
  static final List<String> _storedKeys = [];
  
  Future<void> load(Dio dio, {bool forceReload = false});
  void _clearStoredKeys();
  void _storeData(Map<String, dynamic> data, String prefix);
}
```

### 3. Better Service Organization
Group services by domain:
- **Navigation**: All navigation-related services
- **Theme**: All theming-related services
- **Widget**: All widget-related services
- **Path**: Path normalization utilities

## Conclusion

This reorganization will:
- ✅ Make the codebase more maintainable
- ✅ Make it easier to find files
- ✅ Improve scalability
- ✅ Better adhere to SOLID principles
- ✅ Separate generic STAC code from Tobank-specific code

The migration can be done incrementally, ensuring the app continues to work at each step.
