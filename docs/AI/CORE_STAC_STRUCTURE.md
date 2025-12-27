# Core STAC Structure - lib/core/stac

## 🎯 Overview

This document explains the structure and purpose of `lib/core/stac/`, which contains STAC framework extensions and custom components for the Tobank SDUI project.

## 📁 Directory Structure

```
lib/core/stac/
├── loaders/
│   └── tobank/
│       ├── tobank_colors_loader.dart
│       ├── tobank_strings_loader.dart
│       └── tobank_styles_loader.dart
├── mock/
│   └── stac_mock_dio_setup.dart
├── parsers/
│   ├── actions/
│   │   ├── close_dialog_action_parser.dart
│   │   ├── custom_navigate_action_parser.dart
│   │   ├── custom_set_value_action_parser.dart
│   │   ├── example_action_parser.dart
│   │   └── persian_date_picker_action_parser.dart
│   └── widgets/
│       ├── custom_text_form_field_parser.dart
│       └── example_card_parser.dart
├── registry/
│   ├── custom_component_registry.dart
│   └── register_custom_parsers.dart
├── services/
│   ├── navigation/
│   │   └── stac_navigation_service.dart
│   ├── path/
│   │   └── stac_path_normalizer.dart
│   ├── theme/
│   │   └── stac_theme_wrapper.dart
│   └── widget/
│       ├── stac_widget_loader.dart
│       └── stac_widget_resolver.dart
└── utils/
    ├── text_form_field_controller_registry.dart
    └── variable_resolver_debug.dart
```

## 📦 Component Details

### 1. Builders (`builders/`)

**Purpose**: Dart classes that simplify the creation of complex STAC JSON structures.

#### `stac_stateful_widget.dart`

**Purpose**: Defines a widget that supports lifecycle events, mirroring Flutter's StatefulWidget but defined in JSON.

**Key Features:**
- **Lifecycle Support**: `onInit`, `onBuild`, `onDispose`.
- **JSON Serialization**: Converts the Dart object structure into a valid "stateFull" STAC widget JSON.

**Usage:**
```dart
StacStatefulWidget(
  onInit: StacLogAction(message: 'Init'),
  child: StacScaffold(...),
)
```

#### `stac_custom_actions.dart`

**Purpose**: Type-safe Dart builders for custom STAC actions.

**Key Compontents:**
- `StacSequenceAction`: Chained actions.
- `StacNetworkRequestAction`: API calls with result handling.
- `StacCustomSetValueAction` / `StacGetFormValueAction`: Form state management.
- `StacPersianDatePickerAction`: Date picker integration.

**Why use them?**: They prevent syntax errors in JSON keys and ensure correct nesting of actions.

### 2. Loaders (`loaders/tobank/`)

**Purpose**: Load colors, strings, and styles from JSON files and store in `StacRegistry`.

#### `tobank_colors_loader.dart`

**Purpose**: Loads color schema for both light and dark themes.

**Key Features:**
- Loads colors from `GET_colors.json` via API
- Stores colors with dot-notation keys: `appColors.light.*`, `appColors.dark.*`
- Creates `appColors.current.*` aliases pointing to current theme
- Detects theme from system brightness or saved preference
- Updates aliases when theme changes

**Key Methods:**
- `loadColors(dio)` - Load colors and create aliases
- `updateCurrentTheme(newTheme, dio)` - Update theme aliases
- `setCurrentTheme(newTheme)` - Update theme without refetching
- `clearCache()` - Clear cached colors

**Usage:**
```dart
await TobankColorsLoader.loadColors(dio);
```

#### `tobank_strings_loader.dart`

**Purpose**: Loads localization strings.

**Key Features:**
- Loads strings from `GET_strings.json` via API
- Flattens nested structure to dot-notation keys
- Stores in registry: `appStrings.{section}.{key}`

**Key Methods:**
- `loadStrings(dio)` - Load strings and store in registry
- `clearCache()` - Clear cached strings
- `getString(key)` - Get specific string value

**Usage:**
```dart
await TobankStringsLoader.loadStrings(dio);
```

#### `tobank_styles_loader.dart`

**Purpose**: Loads component styles.

**Key Features:**
- Loads styles from `GET_styles.json` via API
- Resolves color variables (`{{appColors.*}}`) to actual values
- Stores styles with dot-notation keys
- Supports style aliases for complete style objects

**Key Methods:**
- `loadStyles(dio)` - Load styles, resolve colors, store in registry
- `clearCache()` - Clear cached styles
- `buildStyleObject(key)` - Build style object from registry keys

**Usage:**
```dart
await TobankStylesLoader.loadStyles(dio);
```

**Important**: Colors must be loaded before styles (for color resolution).

### 2. Mock (`mock/`)

#### `stac_mock_dio_setup.dart`

**Purpose**: Sets up Dio with mock interceptor for local development.

**Key Features:**
- Creates Dio instance with mock interceptor
- Maps API URLs to local JSON files
- Handles screen JSONs and data APIs
- Supports both wrapped and unwrapped JSON responses

**Usage:**
```dart
final stacDio = setupStacMockDio();
```

### 3. Parsers (`parsers/`)

**Purpose**: Custom action and widget parsers that extend STAC framework.

#### Actions (`parsers/actions/`)

**`persian_date_picker_action_parser.dart`**
- Shows Persian date picker dialog
- Updates form field value
- Updates TextFormField controller via registry

**`close_dialog_action_parser.dart`**
- Closes current dialog using `Navigator.pop()`

**`custom_navigate_action_parser.dart`**
- Overrides default navigate parser
- Supports navigation to Dart STAC screens via `widgetType`
- Applies consistent theme to navigated screens

**`custom_set_value_action_parser.dart`**
- Overrides default setValue parser
- Resolves `StacGetFormValue` actions before storing values

**`example_action_parser.dart`**
- Example action parser for reference

#### Widgets (`parsers/widgets/`)

**`custom_text_form_field_parser.dart`**
- Overrides default TextFormField parser
- Registers `TextEditingController` in registry
- Allows external actions to update field values

**`example_card_parser.dart`**
- Example widget parser for reference

### 4. Registry (`registry/`)

#### `custom_component_registry.dart`

**Purpose**: Central registry for custom components before registering with STAC.

**Key Features:**
- Stores custom action parsers
- Stores custom widget parsers
- Provides access methods for registered components

**Key Methods:**
- `registerAction(parser)` - Register custom action parser
- `registerWidget(parser)` - Register custom widget parser
- `getActionParser(type)` - Get action parser by type
- `getWidgetParser(type)` - Get widget parser by type
- `getSummary()` - Get summary of registered components

#### `register_custom_parsers.dart`

**Purpose**: Main registration function for all custom parsers.

**Key Features:**
- Registers all custom parsers with STAC framework
- Handles conflicts with built-in parsers
- Overrides default parsers when needed

**Key Functions:**
- `registerCustomParsers()` - Main registration function
- `_registerExampleParsers()` - Register example parsers
- `unregisterCustomParsers()` - Unregister all custom parsers

**Usage:**
```dart
await registerCustomParsers();
```

### 5. Services (`services/`)

#### Navigation (`services/navigation/`)

**`stac_navigation_service.dart`**
- Handles STAC navigation logic
- Manages navigation stack
- Applies navigation styles

#### Path (`services/path/`)

**`stac_path_normalizer.dart`**
- Normalizes file paths for STAC
- Handles relative and absolute paths
- Resolves path conflicts

#### Theme (`services/theme/`)

**`stac_theme_wrapper.dart`**
- Wraps STAC widgets with theme
- Applies consistent theming
- Handles theme switching

#### Widget (`services/widget/`)

**`stac_widget_loader.dart`**
- Loads widget JSON from Dart files
- Maps widget types to Dart functions
- Returns JSON for rendering

**Key Methods:**
- `registerWidgetLoader(widgetType, loader)` - Register widget loader
- `loadWidgetJson(widgetType)` - Load widget JSON

**Usage:**
```dart
StacWidgetLoader.registerWidgetLoader(
  'tobank_login_dart',
  () => tobankLoginDart().toJson(),
);
```

**`stac_widget_resolver.dart`**
- Resolves widget types to loaders
- Handles widget type mapping
- Manages widget resolution

### 6. Utils (`utils/`)

#### `text_form_field_controller_registry.dart`

**Purpose**: Registry for TextFormField controllers.

**Key Features:**
- Stores controllers by field ID
- Allows external access to controllers
- Enables programmatic field updates

**Key Methods:**
- `register(id, controller)` - Register controller
- `unregister(id)` - Unregister controller
- `get(id)` - Get controller by ID
- `updateValue(id, value)` - Update field value

**Usage:**
```dart
// In CustomTextFormFieldParser
TextFormFieldControllerRegistry.instance.register(
  widget.model.id!,
  _controller,
);

// In date picker action
TextFormFieldControllerRegistry.instance.updateValue(
  'birthdate',
  selectedDate,
);
```

#### `variable_resolver_debug.dart`

**Purpose**: Debug utilities for variable resolution.

**Key Features:**
- Logs variable resolution
- Tracks variable access
- Helps debug variable issues

## 🔄 Initialization Flow

```
1. WidgetsFlutterBinding.ensureInitialized()
   ↓
2. setupStacMockDio() - Create Dio with mock interceptor
   ↓
3. Stac.initialize(options, dio)
   ↓
4. registerCustomParsers() - Register custom components
   ↓
5. TobankColorsLoader.loadColors() - Load colors
   ↓
6. TobankStringsLoader.loadStrings() - Load strings
   ↓
7. TobankStylesLoader.loadStyles() - Load styles (after colors)
   ↓
8. App ready
```

## 🚨 Important Notes

1. **Load Order Matters**: Colors must be loaded before styles
2. **Registration Required**: Custom parsers must be registered
3. **Registry Access**: Use `StacRegistry` for variable access
4. **Controller Registry**: Use for external field updates
5. **Theme Aliases**: `appColors.current.*` auto-updates with theme

## 📚 Related Documentation

- **Custom Components**: `docs/AI/CUSTOM_COMPONENTS.md`
- **Data Binding**: `docs/AI/DATA_BINDING_SYSTEM.md`
- **Development Workflow**: `docs/AI/DEVELOPMENT_WORKFLOW.md`
- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`

---

**Next Steps**: Read [REFERENCE_LOCATIONS.md](./REFERENCE_LOCATIONS.md) to know where to find documentation and resources.

