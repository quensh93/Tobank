# Tobank STAC SDUI - Complete Guide

> **Comprehensive documentation for the Tobank Server-Driven UI project built with STAC framework.**
> 
> This guide covers structure, workflow, rules, custom components, and how everything works together.
> **Read this first** before starting any new task or facing issues.

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture & Structure](#architecture--structure)
3. [Development Workflow](#development-workflow)
4. [File Organization Rules](#file-organization-rules)
5. [Data Binding & Variables](#data-binding--variables)
6. [Theme System](#theme-system)
7. [Localization System](#localization-system)
8. [Custom Components](#custom-components)
9. [Mock API System](#mock-api-system)
10. [Common Patterns & Rules](#common-patterns--rules)
11. [Troubleshooting](#troubleshooting)
12. [Issues Reference](#issues-reference)

---

## 🎯 Project Overview

### What is This Project?

**Tobank STAC SDUI** is a Flutter banking application built using the **STAC (Server-Driven UI)** framework. The UI is defined in JSON and can be updated server-side without app releases.

### Key Principles

1. **Server-Driven**: UI comes from JSON (local files or remote APIs)
2. **Three Sources**: Dart → JSON → API JSON (workflow explained below)
3. **Mock-First Development**: All APIs are mocked using local JSON files
4. **Theme-Aware**: Automatic light/dark mode support
5. **Persian Localization**: Full RTL and Persian language support

### Technology Stack

- **Framework**: Flutter 3.9+
- **SDUI Framework**: STAC (local package)
- **State Management**: Riverpod
- **Network**: Dio with custom mock interceptor
- **Date Picker**: `persian_datetime_picker` for Persian calendar

---

## 🏗️ Architecture & Structure

### Project Directory Structure

```
tobank_sdui/
├── lib/
│   ├── core/
│   │   ├── bootstrap/              # App initialization
│   │   │   └── app_root.dart       # Main app widget with localization
│   │   ├── stac/                   # STAC framework extensions
│   │   │   ├── loaders/            # Data loaders (colors, strings, styles)
│   │   │   │   └── tobank/
│   │   │   ├── mock/               # Mock Dio interceptor setup
│   │   │   ├── parsers/            # Custom parsers
│   │   │   │   ├── actions/        # Custom action parsers
│   │   │   │   │   ├── persian_date_picker_action_parser.dart
│   │   │   │   │   ├── close_dialog_action_parser.dart
│   │   │   │   │   ├── custom_navigate_action_parser.dart
│   │   │   │   │   └── custom_set_value_action_parser.dart
│   │   │   │   └── widgets/        # Custom widget parsers
│   │   │   │       └── custom_text_form_field_parser.dart
│   │   │   ├── registry/           # Component registration
│   │   │   │   └── register_custom_parsers.dart
│   │   │   ├── services/           # STAC services
│   │   │   │   ├── navigation/
│   │   │   │   ├── theme/
│   │   │   │   └── widget/
│   │   │   └── utils/              # Utilities
│   │   │       └── text_form_field_controller_registry.dart
│   │   └── helpers/                # Shared utilities
│   └── stac/                       # STAC source files
│       ├── .build/                 # Generated JSON (from stac build)
│       ├── config/                  # Configuration files
│       │   ├── GET_colors.json     # Color definitions (light/dark)
│       │   ├── GET_strings.json    # All app strings
│       │   └── GET_styles.json     # Component styles
│       ├── design_system/           # Theme files
│       │   ├── tobank_theme_light.json
│       │   └── tobank_theme_dark.json
│       ├── tobank/                  # Feature-based screens
│       │   ├── login/
│       │   │   ├── dart/            # Dart STAC widget definitions
│       │   │   │   └── tobank_login.dart
│       │   │   ├── json/            # Manual JSON files
│       │   │   │   └── tobank_login.json
│       │   │   └── api/             # API JSON files (mock responses)
│       │   │       ├── GET_tobank_login.json
│       │   │       └── POST_verify-identity.json
│       │   ├── home/
│       │   ├── account/
│       │   └── ... (other features)
│       └── default_stac_options.dart  # STAC CLI config
├── docs/
│   ├── AI/
│   │   └── Issues/                 # Issues log (read before starting tasks!)
│   └── TOBANK_STAC_SDUI_COMPLETE_GUIDE.md  # This file
└── pubspec.yaml
```

### Key Directories Explained

#### `lib/stac/tobank/{feature}/dart/`
- **Purpose**: STAC Dart widget definitions
- **Usage**: Write screens using `StacWidget`, `StacContainer`, etc.
- **Workflow**: These are the **source of truth** - design here first

#### `lib/stac/tobank/{feature}/json/`
- **Purpose**: Manual JSON files (alternative to Dart)
- **Usage**: Direct JSON definitions (less common)
- **Note**: Can be manually edited or generated

#### `lib/stac/tobank/{feature}/api/`
- **Purpose**: API mock response files
- **Naming**: `{METHOD}_{endpoint}.json` (e.g., `GET_tobank_login.json`)
- **Format**: Wrapped in `{"GET": {"statusCode": 200, "data": {...}}}`

#### `lib/stac/.build/`
- **Purpose**: Generated JSON from `stac build` command
- **Source**: Generated from `dart/` files
- **Rule**: **DO NOT manually edit** - regenerated on each build

#### `lib/stac/config/`
- **Purpose**: Global configuration files
- **Files**:
  - `GET_colors.json` - Color definitions for both themes
  - `GET_strings.json` - All localization strings
  - `GET_styles.json` - Component style definitions

#### `lib/core/stac/parsers/`
- **Purpose**: Custom STAC parsers (extend framework)
- **Actions**: Custom action parsers (e.g., `persianDatePicker`, `closeDialog`)
- **Widgets**: Custom widget parsers (e.g., `CustomTextFormFieldParser`)

---

## 🔄 Development Workflow

### Standard Workflow: Creating a New Screen

**The workflow is: Dart → Build JSON → Use in App**

#### Step 1: Create Dart Widget

1. **Create feature folder** (if doesn't exist):
   ```
   lib/stac/tobank/new_feature/
   ├── dart/
   └── json/
   ```

2. **Write Dart widget** in `dart/new_feature.dart`:
   ```dart
   import 'package:stac/stac.dart';
   
   @StacScreen(screenName: 'new_feature')
   StacWidget newFeature() {
     return StacScaffold(
       appBar: StacAppBar(
         title: StacText(
           data: '{{appStrings.newFeature.title}}',
           textDirection: StacTextDirection.rtl,
         ),
       ),
       body: StacColumn(
         children: [
           // Your STAC widgets here
         ],
       ),
     );
   }
   ```

3. **Preview in app**:
   - Navigate to the screen using Dart path
   - Verify UI design and behavior
   - Test interactions

#### Step 2: Build JSON

4. **Run STAC build command**:
   ```bash
   stac build
   ```
   - Reads Dart files from `lib/stac/tobank/`
   - Generates JSON in `lib/stac/.build/`
   - Output: `tobank_new_feature.json`

5. **Verify generated JSON**:
   - Check `lib/stac/.build/tobank_new_feature.json`
   - Ensure all widgets converted correctly
   - Variables should be preserved: `{{appStrings.*}}`, `{{appColors.*}}`

#### Step 3: Create API JSON (Mock Response)

6. **Create API mock file**:
   ```
   lib/stac/tobank/new_feature/api/GET_tobank_new_feature.json
   ```

7. **Format as API response**:
   ```json
   {
     "GET": {
       "statusCode": 200,
       "data": {
         // Copy content from .build/tobank_new_feature.json here
         // OR reference it if using dynamicView
       }
     }
   }
   ```

8. **Update pubspec.yaml** (if new folder):
   ```yaml
   flutter:
     assets:
       - lib/stac/tobank/new_feature/api/
   ```

#### Step 4: Use in App

9. **Load from API** (recommended):
   ```dart
   // In navigation action
   StacNavigateAction(
     request: StacNetworkRequest(
       url: 'https://api.tobank.com/screens/tobank_new_feature',
       method: Method.get,
     ),
     navigationStyle: NavigationStyle.push,
   )
   ```

10. **Or load from asset** (alternative):
    ```dart
    StacNavigateAction(
      assetPath: 'lib/stac/.build/tobank_new_feature.json',
      navigationStyle: NavigationStyle.push,
    )
    ```

### Workflow Summary

```
┌─────────────────────────────────────────────────────────┐
│ 1. DESIGN (Dart)                                         │
│    lib/stac/tobank/{feature}/dart/{feature}.dart        │
│    ↓                                                      │
│    Write STAC widgets, preview in app                   │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 2. BUILD (JSON Generation)                              │
│    stac build                                            │
│    ↓                                                      │
│    lib/stac/.build/{feature}.json                       │
│    (Auto-generated, DO NOT edit manually)               │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 3. MOCK API (API JSON)                                   │
│    lib/stac/tobank/{feature}/api/GET_{feature}.json     │
│    ↓                                                      │
│    Wrapped in {"GET": {"data": {...}}}                  │
│    (Manual copy from .build/ or reference)              │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 4. USE IN APP                                            │
│    Navigation loads from API URL or asset path           │
│    Mock interceptor maps URL → API JSON file            │
└─────────────────────────────────────────────────────────┘
```

### Important Rules

1. **Always start with Dart** - Design and preview in Dart first
2. **Build before using** - Run `stac build` after Dart changes
3. **Three versions exist**:
   - **Dart**: Source of truth (`dart/` folder)
   - **JSON**: Manual JSON (`json/` folder) - optional
   - **API JSON**: Mock response (`api/` folder) - for runtime
4. **Keep in sync**: When updating Dart, rebuild JSON and update API JSON

---

## 📁 File Organization Rules

### Feature Folder Structure

**Every feature MUST follow this structure:**

```
lib/stac/tobank/{feature_name}/
├── dart/
│   └── {feature_name}.dart        # STAC Dart widget
├── json/
│   └── {feature_name}.json         # Manual JSON (optional)
└── api/
    ├── GET_{feature_name}.json     # Screen JSON (mock API response)
    └── POST_{endpoint}.json        # Data API responses (if needed)
```

### File Naming Conventions

#### Dart Files
- **Pattern**: `{feature_name}.dart`
- **Example**: `tobank_login.dart`, `home.dart`
- **Location**: `lib/stac/tobank/{feature}/dart/`

#### JSON Files
- **Pattern**: `{feature_name}.json`
- **Example**: `tobank_login.json`
- **Location**: `lib/stac/tobank/{feature}/json/`

#### API Mock Files
- **Pattern**: `{METHOD}_{endpoint}.json`
- **Examples**:
  - `GET_tobank_login.json` - Screen JSON
  - `POST_verify-identity.json` - Data API
  - `GET_menu-items.json` - Data API
- **Location**: `lib/stac/tobank/{feature}/api/`

### Configuration Files

All global configs are organized as follows:

- `lib/stac/design_system/GET_styles.json` - Component style definitions (including style aliases)
- `lib/stac/design_system/GET_colors.json` - Color definitions (light/dark themes)
- `lib/stac/localization/GET_strings.json` - All localization strings

**Rule**: These are loaded at app startup and cached in `StacRegistry`.

### Generated Files

- **Location**: `lib/stac/.build/`
- **Naming**: `tobank_{feature_name}.json`
- **Rule**: **NEVER manually edit** - regenerated by `stac build`

---

## 🔗 Data Binding & Variables

### Variable Syntax

STAC uses `{{variable}}` syntax for data binding:

```json
{
  "type": "text",
  "data": "{{appStrings.login.validationTitle}}"
}
```

### Variable Resolution Flow

```
JSON Template
  ↓
{{appStrings.login.validationTitle}}
  ↓
StacRegistry.getValue("appStrings.login.validationTitle")
  ↓
"اعتبار سنجی"
  ↓
Widget displays: "اعتبار سنجی"
```

### Available Variable Namespaces

#### 1. Strings: `{{appStrings.*}}`
- **Source**: `lib/stac/config/GET_strings.json`
- **Loaded**: At app startup via `TobankStringsLoader`
- **Format**: `appStrings.{section}.{key}`
- **Examples**:
  - `{{appStrings.login.validationTitle}}`
  - `{{appStrings.common.loading}}`
  - `{{appStrings.menu.appBarTitle}}`

#### 2. Colors: `{{appColors.*}}`
- **Source**: `lib/stac/config/GET_colors.json`
- **Loaded**: At app startup via `TobankColorsLoader`
- **Format**: `appColors.{theme}.{category}.{property}`
- **Themes**: `light`, `dark`, `current`
- **Examples**:
  - `{{appColors.current.text.title}}` ← **Use this!** (theme-aware)
  - `{{appColors.light.button.primary.backgroundColor}}`
  - `{{appColors.dark.background.onSurface}}`

**Important**: Always use `appColors.current.*` for theme-aware colors!

#### 3. Styles: `{{appStyles.*}}`
- **Source**: `lib/stac/design_system/GET_styles.json`
- **Loaded**: At app startup via `TobankStylesLoader`
- **Format**: `appStyles.{component}.{property}` OR `appStyles.{styleAlias}` (for complete style objects)
- **Examples**:
  - `{{appStyles.button.primary.backgroundColor}}` - Individual property
  - `{{appStyles.input.login.textStyleColor}}` - Individual property
  - `{{appStyles.text.label.color}}` - Individual property
  - `{{appStyles.appbarStyle}}` - **Style alias (complete style object)** ⭐

**⭐ Style Alias Pattern (Recommended for JSON Size Reduction):**

Instead of defining full style objects inline, use style aliases to reduce JSON size:

**❌ OLD WAY** (large JSON):
```json
{
  "style": {
    "type": "custom",
    "color": "{{appStyles.text.pageTitle.color}}",
    "fontSize": 20.0,
    "fontWeight": "w400"
  }
}
```

**✅ NEW WAY** (smaller JSON):
```json
{
  "style": "{{appStyles.appbarStyle}}"
}
```

**In Dart:**
```dart
StacText(
  data: '{{appStrings.login.validationTitle}}',
  style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
)
```

**Style Definition** (in `GET_styles.json`):
```json
{
  "appbarStyle": {
    "color": "{{appColors.current.text.title}}",
    "fontSize": 20.0,
    "fontWeight": "w400"
  }
}
```

**Rule**: Always use style aliases for complete style objects to reduce JSON payload size. Define reusable styles once in `GET_styles.json` and reference them throughout the app.

#### 4. Form Data: `{{form.*}}`
- **Source**: Form field values
- **Updated**: When user types or actions update fields
- **Format**: `form.{fieldId}`
- **Examples**:
  - `{{form.mobile_number}}`
  - `{{form.birthdate}}`
  - `{{form.national_code}}`

### Variable Resolution Rules

1. **Dot Notation**: Use dots for nested access (`appStrings.login.title`)
2. **Case Sensitive**: Variable names are case-sensitive
3. **Type Preservation**: Numbers stay numbers, strings stay strings
4. **Fallback**: If variable not found, shows `{{variable}}` as literal text
5. **Registry Storage**: All variables stored in `StacRegistry` with dot-notation keys

### Using Variables in JSON

```json
{
  "type": "text",
  "data": "{{appStrings.login.validationTitle}}",
  "style": {
    "color": "{{appColors.current.text.title}}"
  }
}
```

### Using Variables in Dart

```dart
StacText(
  data: '{{appStrings.login.validationTitle}}',
  style: StacCustomTextStyle(
    color: '{{appColors.current.text.title}}',
  ),
)
```

---

## 🎨 Theme System

### How Theme System Works

1. **Load Colors**: `TobankColorsLoader.loadColors()` loads both light and dark themes
2. **Detect Theme**: System brightness detected at startup
3. **Create Aliases**: `appColors.current.*` aliases point to detected theme
4. **Use in JSON**: Always use `{{appColors.current.*}}` for theme-aware colors
5. **Auto-Update**: When theme changes, aliases update automatically

### Color Structure

```json
// GET_colors.json
{
  "data": {
    "light": {
      "text": { "title": "#101828" },
      "button": { "primary": { "backgroundColor": "#d61f2c" } }
    },
    "dark": {
      "text": { "title": "#f9fafb" },
      "button": { "primary": { "backgroundColor": "#d61f2c" } }
    }
  }
}
```

### Theme-Aware Color Usage

**✅ CORRECT** (theme-aware):
```json
{
  "color": "{{appColors.current.text.title}}"
}
```

**❌ WRONG** (hardcoded theme):
```json
{
  "color": "{{appColors.light.text.title}}"
}
```

### Theme Detection

- **At Startup**: Uses `PlatformDispatcher.instance.platformBrightness`
- **Default**: Falls back to `light` if detection fails
- **Storage**: `appTheme.current = "light"` or `"dark"` in registry

### Theme Switching

When user changes theme:
```dart
await TobankColorsLoader.updateCurrentTheme('dark', dio);
```

This:
1. Removes old `appColors.current.*` aliases
2. Creates new aliases pointing to new theme
3. All colors automatically update (no JSON changes needed!)

---

## 🌐 Localization System

### How Localization Works

1. **Load Strings**: `TobankStringsLoader.loadStrings()` loads all strings
2. **Flatten Structure**: Nested JSON flattened to dot-notation keys
3. **Store in Registry**: All strings stored in `StacRegistry`
4. **Use in JSON**: Access via `{{appStrings.*}}` syntax

### String Structure

```json
// GET_strings.json
{
  "data": {
    "common": {
      "loading": "در حال بارگذاری...",
      "error": "خطا"
    },
    "login": {
      "validationTitle": "اعتبار سنجی",
      "mobileNumberLabel": "شماره همراه"
    }
  }
}
```

### String Usage

```json
{
  "type": "text",
  "data": "{{appStrings.login.validationTitle}}"
}
```

### String Organization

- **`common`**: Shared strings (loading, error, buttons)
- **`login`**: Login/validation screen strings
- **`menu`**: Menu screen strings
- **`home`**: Home screen strings
- **`account`**: Account overview strings
- **`transfer`**: Transfer form strings
- **`transactions`**: Transaction history strings
- **`profile`**: Profile screen strings

---

## 🛠️ Custom Components

### Creating Custom Actions

Custom actions extend STAC's action system to add project-specific behaviors.

#### Example: Persian Date Picker Action

**File**: `lib/core/stac/parsers/actions/persian_date_picker_action_parser.dart`

**Structure**:
```dart
// 1. Action Model
class PersianDatePickerActionModel {
  final String formFieldId;
  final String? firstDate;
  final String? lastDate;
  
  factory PersianDatePickerActionModel.fromJson(Map<String, dynamic> json) {
    return PersianDatePickerActionModel(
      formFieldId: json['formFieldId'] as String,
      firstDate: json['firstDate'] as String?,
      lastDate: json['lastDate'] as String?,
    );
  }
}

// 2. StacAction Wrapper (for Dart usage)
class StacPersianDatePickerAction extends StacAction {
  const StacPersianDatePickerAction({
    required this.formFieldId,
    this.firstDate,
    this.lastDate,
  });
  
  final String formFieldId;
  final String? firstDate;
  final String? lastDate;
  
  @override
  String get actionType => 'persianDatePicker';
}

// 3. Action Parser
class PersianDatePickerActionParser extends StacActionParser<PersianDatePickerActionModel> {
  const PersianDatePickerActionParser();
  
  @override
  String get actionType => 'persianDatePicker';
  
  @override
  PersianDatePickerActionModel getModel(Map<String, dynamic> json) =>
      PersianDatePickerActionModel.fromJson(json);
  
  @override
  FutureOr onCall(BuildContext context, PersianDatePickerActionModel model) async {
    // Implementation: Show date picker, update form field, etc.
  }
}

// 4. Registration Function
void registerPersianDatePickerActionParser() {
  CustomComponentRegistry.instance.registerAction(const PersianDatePickerActionParser());
}
```

**Registration**: Add to `lib/core/stac/registry/register_custom_parsers.dart`:
```dart
void _registerExampleParsers() {
  registerPersianDatePickerActionParser();
  // ... other parsers
}
```

**Usage in JSON**:
```json
{
  "type": "gestureDetector",
  "onTap": {
    "actionType": "persianDatePicker",
    "formFieldId": "birthdate",
    "firstDate": "1350/01/01",
    "lastDate": "1450/12/29"
  },
  "child": {
    "type": "textFormField",
    "id": "birthdate"
  }
}
```

**Usage in Dart**:
```dart
StacGestureDetector(
  onTap: StacPersianDatePickerAction(
    formFieldId: 'birthdate',
    firstDate: '1350/01/01',
    lastDate: '1450/12/29',
  ),
  child: StacTextFormField(id: 'birthdate'),
)
```

### Creating Custom Widgets

Custom widgets extend STAC's widget system to add project-specific UI components.

#### Example: Custom TextFormField Parser

**File**: `lib/core/stac/parsers/widgets/custom_text_form_field_parser.dart`

**Why Custom?**: 
- Registers `TextEditingController` in registry
- Allows external actions (like date picker) to update field values
- Overrides default STAC `TextFormField` parser

**Structure**:
```dart
// 1. Parser Class
class CustomTextFormFieldParser extends StacParser<StacTextFormField> {
  const CustomTextFormFieldParser();
  
  @override
  String get type => WidgetType.textFormField.name;
  
  @override
  StacTextFormField getModel(Map<String, dynamic> json) =>
      StacTextFormField.fromJson(json);
  
  @override
  Widget parse(BuildContext context, StacTextFormField model) {
    return _CustomTextFormFieldWidget(model, StacFormScope.of(context));
  }
}

// 2. Widget Implementation
class _CustomTextFormFieldWidget extends StatefulWidget {
  // ... implementation
}

class _CustomTextFormFieldWidgetState extends State<_CustomTextFormFieldWidget> {
  late final TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.model.initialValue);
    
    // Register controller in registry
    if (widget.model.id != null) {
      TextFormFieldControllerRegistry.instance.register(
        widget.model.id!,
        _controller,
      );
    }
  }
  
  @override
  void dispose() {
    if (widget.model.id != null) {
      TextFormFieldControllerRegistry.instance.unregister(widget.model.id!);
    }
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      // ... all TextFormField properties
    );
  }
}
```

**Registration**: In `register_custom_parsers.dart`:
```dart
const customTextFormFieldParser = CustomTextFormFieldParser();
stacRegistry.register(customTextFormFieldParser, true); // override: true
```

### Custom Component Rules

1. **Extend Base Classes**:
   - Actions: `StacActionParser<YourModel>`
   - Widgets: `StacParser<YourModel>`

2. **Implement Required Methods**:
   - `get actionType` / `get type`
   - `getModel(Map<String, dynamic> json)`
   - `onCall(BuildContext, Model)` / `parse(BuildContext, Model)`

3. **Register in Registry**:
   - Add registration function
   - Call in `_registerExampleParsers()`
   - Use `CustomComponentRegistry.instance.registerAction()` or `register()`

4. **Override Built-ins**:
   - Pass `override: true` to `stacRegistry.register()`
   - This replaces default STAC parsers

---

## 🔌 Mock API System

### How Mock API Works

1. **Dio Interceptor**: Custom interceptor intercepts all HTTP requests
2. **URL Mapping**: Maps API URLs to local JSON files
3. **File Loading**: Loads JSON from assets using `rootBundle`
4. **Response Format**: Returns data in expected API format

### Mock File Locations

**Screen JSONs**:
- URL: `https://api.tobank.com/screens/tobank_login`
- File: `lib/stac/tobank/login/api/GET_tobank_login.json`
- Format: Direct JSON (not wrapped)

**Data APIs**:
- URL: `https://api.tobank.com/strings`
- File: `lib/stac/config/GET_strings.json`
- Format: Wrapped in `{"GET": {"statusCode": 200, "data": {...}}}`

**Config APIs**:
- URL: `https://api.tobank.com/colors`
- File: `lib/stac/config/GET_colors.json`
- Format: Wrapped in `{"GET": {"statusCode": 200, "data": {...}}}`

### URL to File Mapping Rules

1. **Screen URLs** (`/screens/*`):
   - Pattern: `screens/tobank_{feature}`
   - Maps to: `lib/stac/tobank/{feature}/api/GET_tobank_{feature}.json`
   - Example: `screens/tobank_login` → `login/api/GET_tobank_login.json`

2. **Config URLs**:
   - `/colors` → `lib/stac/design_system/GET_colors.json`
   - `/strings` → `lib/stac/localization/GET_strings.json`
   - `/styles` → `lib/stac/design_system/GET_styles.json`

3. **Data APIs**:
   - Searches in `lib/stac/tobank/{feature}/api/` folders
   - Pattern: `{METHOD}_{endpoint}.json`

### Mock File Format

**Screen JSON** (direct):
```json
{
  "type": "scaffold",
  "body": { ... }
}
```

**Data API** (wrapped):
```json
{
  "GET": {
    "statusCode": 200,
    "data": {
      "key": "value"
    }
  }
}
```

### Adding New Mock Files

1. **Create file** in appropriate `api/` folder
2. **Follow naming**: `{METHOD}_{endpoint}.json`
3. **Add to pubspec.yaml** (if new folder):
   ```yaml
   flutter:
     assets:
       - lib/stac/tobank/new_feature/api/
   ```
4. **Run**: `flutter pub get`

---

## 📐 Common Patterns & Rules

### Pattern 1: Style Aliases (JSON Size Reduction) ⭐ **NEW RULE**

**Always use style aliases instead of inline style objects to reduce JSON payload size.**

#### Rule
When defining text styles (or any reusable styles), define them once in `GET_styles.json` and reference them using style aliases throughout the app.

#### Implementation

**1. Define Style in `GET_styles.json`:**
```json
{
  "GET": {
    "statusCode": 200,
    "data": {
      "appbarStyle": {
        "color": "{{appColors.current.text.title}}",
        "fontSize": 20.0,
        "fontWeight": "w400"
      }
    }
  }
}
```

**2. Use in Dart:**
```dart
StacText(
  data: '{{appStrings.login.validationTitle}}',
  style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
)
```

**3. Use in JSON:**
```json
{
  "type": "text",
  "data": "{{appStrings.login.validationTitle}}",
  "style": "{{appStyles.appbarStyle}}"
}
```

#### Benefits
- **Reduced JSON Size**: Instead of repeating full style objects, use a single string reference
- **Consistency**: Styles defined once, used everywhere
- **Maintainability**: Update style in one place, affects all usages
- **Performance**: Smaller JSON payloads = faster network transfers

#### Before vs After

**❌ OLD WAY** (large JSON):
```json
{
  "appBar": {
    "title": {
      "style": {
        "type": "custom",
        "color": "{{appColors.current.text.title}}",
        "fontSize": 20.0,
        "fontWeight": "w400"
      }
    }
  }
}
```

**✅ NEW WAY** (smaller JSON):
```json
{
  "appBar": {
    "title": {
      "style": "{{appStyles.appbarStyle}}"
    }
  }
}
```

**Size Reduction**: ~80% smaller for style definitions!

#### Creating Style Aliases

1. **Add to `lib/stac/design_system/GET_styles.json`**:
   ```json
   {
     "GET": {
       "statusCode": 200,
       "data": {
         "yourStyleName": {
           "color": "{{appColors.current.text.title}}",
           "fontSize": 16.0,
           "fontWeight": "w600"
         }
       }
     }
   }
   ```

2. **Use `StacAliasTextStyle` in Dart**:
   ```dart
   style: StacAliasTextStyle('{{appStyles.yourStyleName}}')
   ```

3. **Use string reference in JSON**:
   ```json
   "style": "{{appStyles.yourStyleName}}"
   ```

**This pattern is now mandatory for all new style definitions!**

---

### Pattern 2: Form Fields with Validation

```dart
StacTextFormField(
  id: 'mobile_number',
  validatorRules: [
    StacFormFieldValidator(
      rule: '^09\\d{9}\$',
      message: '{{appStrings.login.mobileNumberError}}',
    ),
  ],
)
```

**JSON**:
```json
{
  "id": "mobile_number",
  "type": "textFormField",
  "validatorRules": [
    {
      "rule": "^09\\d{9}$",
      "message": "{{appStrings.login.mobileNumberError}}"
    }
  ]
}
```

### Pattern 2: Date Picker with GestureDetector

```dart
StacGestureDetector(
  onTap: StacPersianDatePickerAction(
    formFieldId: 'birthdate',
    firstDate: '1350/01/01',
    lastDate: '1450/12/29',
  ),
  child: StacTextFormField(
    id: 'birthdate',
    readOnly: true,
    enabled: false,
  ),
)
```

**JSON**:
```json
{
  "type": "gestureDetector",
  "behavior": "opaque",
  "onTap": {
    "actionType": "persianDatePicker",
    "formFieldId": "birthdate",
    "firstDate": "1350/01/01",
    "lastDate": "1450/12/29"
  },
  "child": {
    "id": "birthdate",
    "type": "textFormField",
    "readOnly": true,
    "enabled": false
  }
}
```

**Important**: `behavior: "opaque"` allows GestureDetector to receive taps even when child is disabled.

### Pattern 3: Closing Dialogs

```json
{
  "type": "textButton",
  "onPressed": {
    "actionType": "closeDialog"
  }
}
```

**Custom Action**: `closeDialog` - closes current dialog using `Navigator.pop()`

### Pattern 4: Navigation

**From Dart**:
```dart
StacNavigateAction(
  request: StacNetworkRequest(
    url: 'https://api.tobank.com/screens/tobank_home',
    method: Method.get,
  ),
  navigationStyle: NavigationStyle.push,
)
```

**From JSON**:
```json
{
  "actionType": "navigate",
  "request": {
    "url": "https://api.tobank.com/screens/tobank_home",
    "method": "get"
  },
  "navigationStyle": "push"
}
```

### Pattern 5: Network Request with Dialog

```dart
StacNetworkRequest(
  url: 'https://api.tobank.com/verify-identity',
  method: Method.post,
  body: {
    'mobile_number': '{{form.mobile_number}}',
    'national_code': '{{form.national_code}}',
    'birthdate': '{{form.birthdate}}',
  },
  onSuccess: StacDialogAction(
    widget: {
      // Dialog content
    },
  ),
)
```

### Rules for Type Usage

1. **Enums, Not Strings**:
   ```dart
   // ❌ WRONG
   fontWeight: 'bold'
   mainAxisAlignment: 'center'
   
   // ✅ CORRECT
   fontWeight: StacFontWeight.bold
   mainAxisAlignment: StacMainAxisAlignment.center
   ```

2. **Objects, Not Primitives**:
   ```dart
   // ❌ WRONG
   borderRadius: 12
   offset: StacOffset(x: 0, y: 2)
   
   // ✅ CORRECT
   borderRadius: StacBorderRadius.all(12)
   offset: StacOffset(dx: 0, dy: 2)
   ```

3. **Custom Styles**:
   ```dart
   // ❌ WRONG
   style: StacTextStyle(...)  // Abstract class
   
   // ✅ CORRECT
   style: StacCustomTextStyle(...)  // Concrete class
   ```

---

## 🐛 Troubleshooting

### Issue: Variable Not Resolving

**Symptom**: `{{appStrings.login.title}}` shows as literal text

**Solutions**:
1. Check if loader was called: `TobankStringsLoader.loadStrings(dio)`
2. Verify variable name (case-sensitive)
3. Check registry: `StacRegistry.instance.getValue('appStrings.login.title')`
4. Ensure `WidgetsFlutterBinding.ensureInitialized()` called before loaders

### Issue: Colors Not Theme-Aware

**Symptom**: Colors don't change when switching themes

**Solutions**:
1. Use `{{appColors.current.*}}` not `{{appColors.light.*}}`
2. Verify `TobankColorsLoader.loadColors()` was called
3. Check theme detection: `appTheme.current` in registry
4. Ensure aliases created: `appColors.current.*` keys exist

### Issue: Date Picker Not Updating Field

**Symptom**: Date selected but field doesn't show value

**Solutions**:
1. Verify `CustomTextFormFieldParser` is registered
2. Check controller registered: `TextFormFieldControllerRegistry.instance.get('birthdate')`
3. Ensure field has `id: "birthdate"`
4. Check logs for "Registered TextFormField controller for: birthdate"

### Issue: Tap Not Working on Disabled Field

**Symptom**: GestureDetector not receiving taps

**Solutions**:
1. Add `behavior: "opaque"` to GestureDetector in JSON
2. Ensure `enabled: false` on TextFormField
3. Verify GestureDetector wraps TextFormField (not vice versa)

### Issue: STAC Build Fails

**Symptom**: `stac build` command errors

**Solutions**:
1. Check `default_stac_options.dart` exists in `lib/`
2. Verify source directory: `lib/stac/tobank/`
3. Ensure Dart files have `@StacScreen` annotation
4. Check for Flutter import errors (STAC CLI can't compile Flutter code)

### Issue: Mock API Not Found

**Symptom**: Request goes to real API or returns 404

**Solutions**:
1. Verify file exists: `lib/stac/tobank/{feature}/api/{METHOD}_{name}.json`
2. Check file in `pubspec.yaml` assets
3. Run `flutter pub get`
4. Verify interceptor setup: `setupStacMockDio()` called before `Stac.initialize()`

---

## 📚 Issues Reference

**Before starting any new task or facing an issue, read:**

👉 **[`docs/AI/Issues/ISSUES_LOG.md`](AI/Issues/ISSUES_LOG.md)**

This log contains:
- All bugs encountered and their solutions
- Common patterns and gotchas
- Prevention strategies
- Lessons learned

**Always check this first** to avoid repeating past mistakes!

---

## 🔄 Integration Flow

### How Everything Works Together

```
┌─────────────────────────────────────────────────────────────┐
│ APP STARTUP (main.dart)                                     │
│                                                             │
│ 1. WidgetsFlutterBinding.ensureInitialized()              │
│ 2. setupStacMockDio() - Create Dio with mock interceptor  │
│ 3. Stac.initialize(options, dio)                          │
│ 4. registerCustomParsers() - Register custom components    │
│ 5. TobankColorsLoader.loadColors() - Load & cache colors   │
│ 6. TobankStringsLoader.loadStrings() - Load & cache strings│
│ 7. TobankStylesLoader.loadStyles() - Load & cache styles  │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ DATA LOADED IN REGISTRY                                     │
│                                                             │
│ StacRegistry contains:                                      │
│ - appColors.light.* (all light colors)                     │
│ - appColors.dark.* (all dark colors)                       │
│ - appColors.current.* (aliases to current theme)          │
│ - appStrings.* (all strings)                               │
│ - appStyles.* (all styles)                                 │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ SCREEN LOADING                                              │
│                                                             │
│ Navigation Action:                                          │
│ - URL: https://api.tobank.com/screens/tobank_login         │
│ - Mock Interceptor: Maps to lib/stac/tobank/login/api/...  │
│ - Load JSON: Reads from assets                             │
│ - Resolve Variables: {{appStrings.*}}, {{appColors.*}}     │
│ - Parse Widget: STAC framework parses JSON to Flutter      │
│ - Render: Widget tree built and displayed                  │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ USER INTERACTION                                            │
│                                                             │
│ User taps button:                                           │
│ - Action triggered: e.g., persianDatePicker                │
│ - Custom parser executes: Shows date picker                │
│ - User selects date: Date formatted                        │
│ - Form updated: formData[birthdate] = "1404/09/16"        │
│ - Registry updated: StacRegistry.setValue(...)             │
│ - Controller updated: TextFormFieldControllerRegistry      │
│ - UI refreshed: TextFormField shows selected date          │
└─────────────────────────────────────────────────────────────┘
```

---

## 📝 Quick Reference

### File Locations

| Type | Location | Example |
|------|----------|---------|
| Dart Source | `lib/stac/tobank/{feature}/dart/` | `tobank_login.dart` |
| Generated JSON | `lib/stac/.build/` | `tobank_login.json` |
| API JSON | `lib/stac/tobank/{feature}/api/` | `GET_tobank_login.json` |
| Config | `lib/stac/config/` | `GET_colors.json` |
| Custom Parsers | `lib/core/stac/parsers/` | `persian_date_picker_action_parser.dart` |

### Common Commands

```bash
# Build JSON from Dart
stac build

# Run app
flutter run

# Get dependencies
flutter pub get

# Format code
dart format .
```

### Variable Namespaces

- `{{appStrings.*}}` - Localization strings
- `{{appColors.current.*}}` - Theme-aware colors (use this!)
- `{{appStyles.*}}` - Component styles
- `{{form.*}}` - Form field values

### Action Types

- `persianDatePicker` - Show Persian date picker
- `closeDialog` - Close current dialog
- `navigate` - Navigate to screen
- `setValue` - Set registry value
- `networkRequest` - Make API call

---

## 🎓 Best Practices

1. **Always start with Dart** - Design and preview first
2. **Use theme-aware colors** - Always `appColors.current.*`
3. **Register custom components** - Add to `register_custom_parsers.dart`
4. **Check Issues Log** - Before starting tasks
5. **Follow file structure** - Don't create files outside defined structure
6. **Keep in sync** - When updating Dart, rebuild JSON and update API JSON
7. **Use variables** - Never hardcode strings or colors
8. **Test all three versions** - Dart, JSON, and API JSON

---

## 📖 Additional Resources

- **STAC Framework Docs**: `docs/App_Docs/stac_docs/`
- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`
- **Persian Date Picker**: `docs/persian_date_picker_implementation.md`

---

**Last Updated**: 2025-01-XX  
**Status**: ✅ Complete - Ready for Development
