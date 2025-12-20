# 🚀 Create New Page Rule Template - Tobank STAC SDUI

> **Purpose**: This template provides comprehensive rules and workflow for AI agents to create new SDUI pages in the Tobank project. Add this prompt to your AI agent to enable consistent, efficient page creation.

---

## 📋 Table of Contents

1. [Quick Start Checklist](#-quick-start-checklist)
2. [Project Understanding](#-project-understanding)
3. [Page Creation Workflow](#-page-creation-workflow)
4. [Creation Scenarios](#-creation-scenarios)
5. [Code Style Rules](#-code-style-rules)
6. [Data Binding System](#-data-binding-system)
7. [File Templates](#-file-templates)
8. [Testing & Validation](#-testing--validation)
9. [Troubleshooting](#-troubleshooting)
10. [Reference Locations](#-reference-locations)

---

## ✅ Quick Start Checklist

Before creating any page, complete these steps:

```
[ ] 1. Check Issues log: docs/AI/Issues/ISSUES_LOG.md
[ ] 2. Read relevant STAC widget docs: docs/App_Docs/stac_docs/
[ ] 3. Check old tobank reference (for UI matching): docs/Archived/.tobank_old/lib/ui/
[ ] 4. Understand the complete workflow below
```

---

## ⭐ BEST REFERENCE: Already Implemented Pages

> **🎯 The BEST way to learn how to create new pages is by studying the already implemented pages in Tobank SDUI!**

### Study These Implemented Examples:

| Page | Dart File | What to Learn |
|------|-----------|---------------|
| **Login** ⭐ | `lib/stac/tobank/login/dart/tobank_login.dart` | Forms, validation, text fields, buttons, date picker, network requests, dialogs |
| **Verify OTP** | `lib/stac/tobank/login/dart/verify_otp.dart` | OTP input, countdown timer, form submission |
| **Splash** | `lib/stac/tobank/splash/dart/tobank_splash.dart` | Simple layout, images, text positioning |
| **Onboarding** | `lib/stac/tobank/onboarding/dart/tobank_onboarding.dart` | Slider/carousel, dynamic content |
| **Menu** | `lib/stac/tobank/menu/dart/tobank_menu.dart` | List views, navigation, dynamic data binding |

### What to Look For:

1. **File Structure**: How `dart/`, `json/`, `api/` folders are organized
2. **@StacScreen Annotation**: How screen names are defined
3. **Style Usage**: How `StacAliasTextStyle` and style variables are used
4. **String Variables**: How `{{appStrings.*}}` are referenced
5. **Color Variables**: How `{{appColors.current.*}}` are used
6. **Form Patterns**: How forms, validation, and submission work
7. **Navigation**: How `StacNavigateAction` is used
8. **Custom Actions**: How custom actions like `StacPersianDatePickerAction` are integrated

### Quick Study Command:

Before creating a new page, open and study the login page:
```
lib/stac/tobank/login/dart/tobank_login.dart  # Main Dart STAC file
lib/stac/tobank/login/api/GET_tobank_login.json  # API JSON wrapper
lib/stac/.build/tobank_login_dart.json  # Generated JSON (for reference only)
```

**💡 Pro Tip**: The login page is the most comprehensive example - it has forms, validation, date picker, network requests, dialogs, and proper styling. Use it as your primary reference!

---

## 🔧 MUST UNDERSTAND: Core STAC Structure & Flow

> **🎯 Before creating pages, you MUST understand how STAC works internally by studying `lib/core/stac/`!**

### Core STAC Directory Structure

```
lib/core/stac/
├── loaders/tobank/              # 📥 Data loaders (colors, strings, styles)
│   ├── tobank_colors_loader.dart    # Loads colors from GET_colors.json
│   ├── tobank_strings_loader.dart   # Loads strings from GET_strings.json
│   └── tobank_styles_loader.dart    # Loads styles from GET_styles.json
│
├── mock/                        # 🔌 API mocking
│   └── stac_mock_dio_setup.dart     # Maps API URLs to local JSON files
│
├── parsers/                     # 🧩 Custom parsers (extend STAC framework)
│   ├── actions/                     # Custom action parsers
│   │   ├── persian_date_picker_action_parser.dart  # Date picker action
│   │   ├── close_dialog_action_parser.dart         # Close dialog action
│   │   ├── custom_navigate_action_parser.dart      # Custom navigation
│   │   └── custom_set_value_action_parser.dart     # Custom value setter
│   └── widgets/                     # Custom widget parsers
│       └── custom_text_form_field_parser.dart      # TextFormField with registry
│
├── registry/                    # 📋 Component registration
│   ├── custom_component_registry.dart   # Central registry for custom components
│   └── register_custom_parsers.dart     # Main registration function
│
├── services/                    # 🔧 STAC services
│   ├── navigation/                  # Navigation handling
│   ├── path/                        # Path normalization
│   ├── theme/                       # Theme wrapper (workaround for STAC limitations)
│   └── widget/                      # Widget loading & resolution
│       ├── stac_widget_loader.dart      # Loads widget JSON from Dart
│       └── stac_widget_resolver.dart    # Resolves widget types
│
└── utils/                       # 🛠️ Utilities
    ├── text_form_field_controller_registry.dart  # Controller access for date picker
    └── variable_resolver_debug.dart              # Debug variable resolution
```

### STAC Initialization Flow (CRITICAL!)

Understanding this flow is essential for debugging:

```
1. WidgetsFlutterBinding.ensureInitialized()
   ↓
2. setupStacMockDio() 
   → Creates Dio with mock interceptor
   → Maps API URLs to local JSON files
   ↓
3. Stac.initialize(options, dio)
   → Initializes STAC framework
   ↓
4. registerCustomParsers() 
   → Registers all custom actions & widgets
   → Persian date picker, close dialog, etc.
   ↓
5. TobankColorsLoader.loadColors(dio) 
   → Loads colors from GET_colors.json
   → Creates appColors.light.*, appColors.dark.*
   → Creates appColors.current.* aliases (theme-aware)
   ↓
6. TobankStringsLoader.loadStrings(dio)
   → Loads strings from GET_strings.json
   → Creates appStrings.* keys
   ↓
7. TobankStylesLoader.loadStyles(dio)
   → Loads styles from GET_styles.json  
   → Resolves color variables inside styles
   → Creates appStyles.* keys
   ↓
8. App ready to render STAC widgets!
```

### Why Understanding This Matters

| Component | Why You Need to Know It |
|-----------|------------------------|
| **Loaders** | Variables like `{{appStrings.*}}` won't work if loaders didn't run |
| **Custom Actions** | Custom behaviors (date picker, dialogs) are defined here |
| **Custom Widgets** | Override default STAC parsers for special functionality |
| **Registry** | Custom components must be registered to work |
| **Mock Setup** | Understand how API URLs map to local JSON files |
| **Theme Wrapper** | Know the workarounds for STAC limitations |

### Key Files to Study

```
1. lib/core/stac/registry/register_custom_parsers.dart
   → See how custom components are registered
   
2. lib/core/stac/loaders/tobank/tobank_colors_loader.dart
   → Understand how appColors.current.* works
   
3. lib/core/stac/parsers/actions/persian_date_picker_action_parser.dart
   → Example of custom action implementation
   
4. lib/core/stac/mock/stac_mock_dio_setup.dart
   → How API URLs are mapped to local JSON files
```

### When to Reference lib/core/stac

- **Variable not resolving?** → Check loaders
- **Custom action not working?** → Check parsers/actions/ and registration
- **Need new custom behavior?** → Study existing parsers as examples
- **API not loading?** → Check mock setup
- **Theme not applying?** → Check theme wrapper

---

## 🏗️ Project Understanding

### What is Tobank STAC SDUI?

- **Server-Driven UI (SDUI)** application built with Flutter
- UI is defined in **JSON** (can be updated server-side without app releases)
- Uses **STAC framework** to parse JSON into Flutter widgets
- **Three-Source Workflow**: Dart → JSON → API JSON

### Key Architecture Principles

1. **Dart is the source of truth** - Write screens in Dart STAC syntax
2. **JSON is generated** - Use `stac build` to generate JSON from Dart
3. **API JSON wraps the content** - Mock responses use `{"GET": {"data": {...}}}`
4. **Theme-aware** - Automatic light/dark mode support
5. **Persian RTL** - Full RTL and Persian language support
6. **UI matching** - Pages must match old tobank app exactly

### Project Structure

```
lib/stac/tobank/{feature}/
├── dart/                      # STAC Dart widget definitions (SOURCE OF TRUTH)
│   └── {feature_name}.dart    # Main screen definition
├── json/                      # Alternative manual JSON (rarely used)
│   └── {feature_name}.json    
└── api/                       # API mock response files
    └── GET_tobank_{feature}.json

lib/stac/.build/               # AUTO-GENERATED (DO NOT EDIT MANUALLY)
    └── tobank_{feature}.json  # Generated by `stac build`

lib/stac/config/               # Global configuration files
├── GET_colors.json            # Color definitions (light/dark)
├── GET_strings.json           # All localization strings (Persian)
└── GET_styles.json            # Component style definitions

assets/                        # All app assets (images, icons, fonts)
```

---

## 🔄 Page Creation Workflow

### The Complete 7-Step Flow

```
┌─────────────────────────────────────────────────────────────┐
│ STEP 1: PREPARE REFERENCE MATERIAL                          │
│  • Check old tobank: docs/Archived/.tobank_old/lib/ui/      │
│  • Read STAC docs: docs/App_Docs/stac_docs/                 │
│  • Check Issues log: docs/AI/Issues/ISSUES_LOG.md           │
│  • Check existing examples: lib/stac/tobank/login/dart/     │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 2: CREATE FOLDER STRUCTURE                              │
│  lib/stac/tobank/{feature}/                                  │
│  ├── dart/{feature}.dart                                     │
│  ├── json/ (optional)                                        │
│  └── api/                                                    │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 3: ADD STRINGS TO GET_strings.json                      │
│  • Add all Persian text strings                              │
│  • Add validation messages                                   │
│  • Use consistent naming: {feature}.{key}                    │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 4: WRITE DART STAC WIDGET                               │
│  lib/stac/tobank/{feature}/dart/{feature}.dart              │
│  • Use @StacScreen annotation                                │
│  • Use RTL text direction                                    │
│  • Use style aliases                                         │
│  • Use theme-aware colors                                    │
│  • Use string variables                                      │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 5: PREVIEW & TEST IN APP                                │
│  • Create screen wrapper if needed                           │
│  • Navigate to the screen                                    │
│  • Verify UI matches old tobank                              │
│  • Test interactions                                         │
│  • Fix any issues in Dart                                    │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 6: BUILD JSON                                           │
│  🚨🚨🚨 CRITICAL - THIS MUST WORK! 🚨🚨🚨                    │
│  Run: stac build                                             │
│  Output: lib/stac/.build/tobank_{feature}.json              │
│  ⚠️ If build fails, STOP EVERYTHING and fix it first!       │
│  ⚠️ NEVER manually edit generated JSON!                      │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│ STEP 7: CREATE API JSON & REGISTER                           │
│  • Create: api/GET_tobank_{feature}.json                     │
│  • Wrap content in {"GET": {"statusCode": 200, "data": {...}}}│
│  • Update pubspec.yaml with new asset folder                 │
│  • Run: flutter pub get                                      │
│  • Add to menu: lib/stac/tobank/menu/api/GET_menu-items.json │
└─────────────────────────────────────────────────────────────┘
```

---

## 🎯 Creation Scenarios

### Scenario A: Creating New Page from Figma Design

When you have a Figma link/design to implement:

```
1. ANALYZE FIGMA DESIGN
   • Identify all components (text, buttons, inputs, images)
   • Note exact colors, spacing, font sizes
   • Identify interactive elements (buttons, forms)
   • Export any required assets (icons, images) as SVG/PNG

2. CHECK FOR EXISTING ASSETS
   • Check assets/icons/ for existing icons
   • Check assets/images/ for existing images
   • If not found, export from Figma and add to assets folder

3. ADD/UPDATE COLORS (if new colors)
   • Open: lib/stac/config/GET_colors.json
   • Add new colors under both "light" and "dark" sections
   • Use semantic naming: button.primary, text.title, etc.

4. ADD STRINGS
   • Open: lib/stac/config/GET_strings.json
   • Add all Persian strings under feature section
   • Example structure:
     {
       "myFeature": {
         "title": "عنوان صفحه",
         "description": "توضیحات",
         "buttonText": "تایید"
       }
     }

5. CREATE/UPDATE STYLES (if needed)
   • Open: lib/stac/config/GET_styles.json
   • Add style aliases for reusable styles
   • Example:
     {
       "text": {
         "myFeatureTitle": {
           "color": "{{appColors.current.text.title}}",
           "fontSize": 20.0,
           "fontWeight": "w600"
         }
       }
     }

6. FOLLOW THE 7-STEP WORKFLOW ABOVE
```

### Scenario B: Creating Page from Old Tobank Files

When converting an existing Flutter screen to STAC:

```
1. LOCATE OLD TOBANK SCREEN
   • Path: docs/Archived/.tobank_old/lib/ui/{feature}/
   • Find the main screen file
   • Identify all widgets used

2. ANALYZE THE OLD CODE
   • List all text strings (convert to appStrings variables)
   • List all colors (convert to appColors variables)
   • List all spacing/sizing values
   • Identify custom logic (may need custom actions)
   • Note all assets used (icons, images)

3. MAP FLUTTER WIDGETS TO STAC WIDGETS
   Common mappings:
   
   Flutter              → STAC
   ────────────────────────────────────────
   Scaffold            → StacScaffold
   AppBar              → StacAppBar
   Column              → StacColumn
   Row                 → StacRow
   Container           → StacContainer
   Text                → StacText
   TextFormField       → StacTextFormField
   ElevatedButton      → StacElevatedButton
   TextButton          → StacTextButton
   Image.asset         → StacImage (imageType: asset)
   SizedBox            → StacSizedBox
   Padding             → StacPadding
   SingleChildScrollView → StacSingleChildScrollView
   Form                → StacForm
   GestureDetector     → StacGestureDetector

4. HANDLE CUSTOM LOGIC
   If old code has custom logic (API calls, date pickers, etc.):
   • Check if custom action already exists: lib/core/stac/parsers/actions/
   • If not, create new custom action (see CUSTOM_COMPONENTS.md)

5. MIGRATE STEP BY STEP
   • Start with layout structure
   • Add static content
   • Add form fields
   • Add actions/navigation
   • Test each step

6. FOLLOW THE 7-STEP WORKFLOW ABOVE
```

---

## 🎨 Code Style Rules

### STAC Dart Widget Syntax

```dart
// ✅ CORRECT - Complete example
import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'tobank_my_feature')
StacWidget tobankMyFeatureDart() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.myFeature.title}}',   // ✅ Use string variable
        textDirection: StacTextDirection.rtl,     // ✅ Always RTL for Persian
        style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),  // ✅ Use style alias
      ),
      centerTitle: true,
    ),
    body: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      textDirection: StacTextDirection.rtl,
      children: [
        // Your widgets here
      ],
    ),
  );
}
```

### Property Type Rules

```dart
// ❌ WRONG - Using strings for enums
fontWeight: 'bold'

// ✅ CORRECT - Using enum types
fontWeight: StacFontWeight.bold

// ❌ WRONG - Using primitives for objects
borderRadius: 12

// ✅ CORRECT - Using object types
borderRadius: StacBorderRadius.all(12)

// ❌ WRONG - Using generic StacTextStyle
style: StacTextStyle(...)

// ✅ CORRECT - Using specific style types
style: StacCustomTextStyle(...)
// OR
style: StacAliasTextStyle('{{appStyles.styleName}}')  // PREFERRED
```

### Hardcoding Prevention

```dart
// ❌ WRONG - Hardcoded color
color: '#101828'

// ✅ CORRECT - Theme-aware color variable
color: '{{appColors.current.text.title}}'

// ❌ WRONG - Hardcoded Persian text
data: 'عنوان صفحه'

// ✅ CORRECT - String variable
data: '{{appStrings.feature.title}}'

// ❌ WRONG - Using light theme directly
color: '{{appColors.light.text.title}}'

// ✅ CORRECT - Using current theme (auto-switches)
color: '{{appColors.current.text.title}}'
```

---

## 🔗 Data Binding System

### Variable Namespaces

| Prefix | Source File | Format | Example |
|--------|-------------|--------|---------|
| `appStrings.*` | GET_strings.json | `appStrings.{section}.{key}` | `{{appStrings.login.title}}` |
| `appColors.current.*` | GET_colors.json | `appColors.current.{category}.{property}` | `{{appColors.current.text.title}}` |
| `appStyles.*` | GET_styles.json | `appStyles.{component}.{property}` | `{{appStyles.button.primary.backgroundColor}}` |
| `form.*` | Form fields | `form.{fieldId}` | `{{form.mobile_number}}` |

### Style Aliases (Mandatory Pattern)

```dart
// ✅ PREFERRED - Style alias (reduces JSON size by ~80%)
style: StacAliasTextStyle('{{appStyles.appbarStyle}}')

// This references GET_styles.json:
// {
//   "appbarStyle": {
//     "color": "{{appColors.current.text.title}}",
//     "fontSize": 20.0,
//     "fontWeight": "w400"
//   }
// }
```

### Adding New Strings

```json
// In lib/stac/config/GET_strings.json
{
  "GET": {
    "statusCode": 200,
    "data": {
      "myNewFeature": {
        "title": "عنوان صفحه جدید",
        "subtitle": "توضیحات",
        "submitButton": "ارسال",
        "cancelButton": "انصراف",
        "errors": {
          "required": "این فیلد الزامی است",
          "invalidFormat": "فرمت نامعتبر است"
        }
      }
    }
  }
}
```

### Adding New Colors

```json
// In lib/stac/config/GET_colors.json
{
  "GET": {
    "statusCode": 200,
    "data": {
      "light": {
        "myFeature": {
          "background": "#ffffff",
          "cardBorder": "#e0e0e0"
        }
      },
      "dark": {
        "myFeature": {
          "background": "#121212",
          "cardBorder": "#424242"
        }
      }
    }
  }
}
```

---

## 📄 File Templates

### Dart STAC Widget Template

```dart
import 'package:stac_core/stac_core.dart';

/// Tobank {FeatureName} Screen
///
/// STAC Dart implementation matching old tobank UI.
/// Reference: docs/Archived/.tobank_old/lib/ui/{feature}/
@StacScreen(screenName: 'tobank_{feature_name}')
StacWidget tobank{FeatureName}Dart() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.{feature}.title}}',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
      ),
      centerTitle: true,
    ),
    body: StacForm(
      autovalidateMode: StacAutovalidateMode.onUserInteraction,
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                textDirection: StacTextDirection.rtl,
                children: [
                  // Main content here
                ],
              ),
            ),
          ),
          // Bottom fixed content (e.g., submit button)
          StacPadding(
            padding: StacEdgeInsets.all(16.0),
            child: StacElevatedButton(
              onPressed: StacFormValidate(
                isValid: StacNavigateAction(
                  request: StacNetworkRequest(
                    url: 'https://api.tobank.com/screens/{next_screen}',
                    method: Method.get,
                  ),
                  navigationStyle: NavigationStyle.push,
                ),
              ),
              style: StacButtonStyle(
                backgroundColor: '{{appStyles.button.primary.backgroundColor}}',
                fixedSize: StacSize(999999.0, 56.0),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(10.0),
                ),
              ),
              child: StacText(
                data: '{{appStrings.{feature}.submitButton}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  color: '{{appStyles.button.primary.textStyleColor}}',
                  fontSize: 16.0,
                  fontWeight: StacFontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Style alias helper class
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}
```

### API JSON Template

```json
{
  "GET": {
    "statusCode": 200,
    "data": {
      // Copy content from lib/stac/.build/tobank_{feature}.json here
      // OR reference the generated JSON
    }
  }
}
```

### Menu Item Entry Template

```json
// Add to lib/stac/tobank/menu/api/GET_menu-items.json
{
  "title": "{{appStrings.menu.items.{feature}}}",
  "dartPath": "lib/stac/tobank/{feature}/dart/{feature}.dart",
  "jsonPath": "lib/stac/tobank/{feature}/json/tobank_{feature}.json",
  "apiPath": "lib/stac/tobank/{feature}/api/GET_tobank_{feature}.json",
  "widgetType": "tobank_{feature}"
}
```

### pubspec.yaml Asset Entry

```yaml
flutter:
  assets:
    - lib/stac/tobank/{feature}/api/
```

---

## 🧪 Testing & Validation

### Pre-Completion Checklist

```
[ ] Issues log checked before starting
[ ] Old tobank reference checked for UI matching
[ ] All strings use {{appStrings.*}} variables
[ ] All colors use {{appColors.current.*}} variables
[ ] Style aliases used (StacAliasTextStyle)
[ ] RTL text direction set correctly
[ ] @StacScreen annotation present with correct screenName
[ ] Previewed in app and tested interactions
[ ] `stac build` ran successfully
[ ] Generated JSON verified in .build/ folder
[ ] API JSON created with correct wrapper structure
[ ] pubspec.yaml updated with new asset folder
[ ] `flutter pub get` ran successfully
[ ] Added to menu for testing
[ ] Navigation tested in app
[ ] Assets referenced correctly (assets/icons/, assets/images/)
```

### Common Build Commands

```bash
# Build JSON from Dart
stac build

# Get dependencies after pubspec changes
flutter pub get

# Run the app
flutter run

# Clean rebuild if needed
flutter clean
flutter pub get
flutter run
```

---

## 🔧 Troubleshooting

### Build Fails - CRITICAL!

**🚨🚨🚨 IF `stac build` FAILS, STOP EVERYTHING! 🚨🚨🚨**

This is the most critical issue. The entire workflow depends on Dart → JSON generation.

**Common causes and fixes:**

1. **Missing @StacScreen annotation**
   ```dart
   // ❌ WRONG
   StacWidget myScreen() { ... }
   
   // ✅ CORRECT
   @StacScreen(screenName: 'tobank_my_screen')
   StacWidget myScreen() { ... }
   ```

2. **Missing default_stac_options.dart**
   - Check `lib/default_stac_options.dart` exists
   - Contains source and output directory configuration

3. **Dart compilation errors**
   - Run `flutter analyze` to find errors
   - Fix all errors before running `stac build`

4. **Wrong property types**
   - Check you're using enum types, not strings
   - Check object types, not primitives

### Variable Not Resolving

**Symptoms**: `{{appStrings.x.y}}` shows as literal text

**Fixes**:
1. Check the key exists in GET_strings.json
2. Verify TobankStringsLoader is called before widget renders
3. Check for typos in variable path
4. Ensure JSON is valid (run through JSON validator)

### UI Doesn't Match Old Tobank

**Fixes**:
1. Compare with old tobank: `docs/Archived/.tobank_old/lib/ui/`
2. Check spacing values match
3. Verify colors match (use color picker)
4. Check font sizes and weights
5. Verify RTL direction is set

### Colors Not Theme-Aware

**Symptoms**: Colors don't change with theme

**Fixes**:
- Use `{{appColors.current.*}}` NOT `{{appColors.light.*}}`

### Asset Not Found

**Fixes**:
1. Verify file exists in `assets/` folder
2. Check `pubspec.yaml` has the asset folder listed
3. Run `flutter pub get`
4. Restart the app

---

## � Common Bugs & Solutions (From Issues Log)

> **⚠️ CRITICAL**: Always check `docs/AI/Issues/ISSUES_LOG.md` for the full list of documented bugs!

### Type Errors (Most Common!)

| Bug | Wrong | Correct |
|-----|-------|---------|
| FontWeight | `fontWeight: 'bold'` | `fontWeight: StacFontWeight.bold` |
| Alignment | `mainAxisAlignment: 'center'` | `mainAxisAlignment: StacMainAxisAlignment.center` |
| TextStyle | `StacTextStyle(...)` | `StacCustomTextStyle(...)` |
| BorderRadius | `borderRadius: 12` | `borderRadius: StacBorderRadius.all(12)` |
| Offset | `StacOffset(x: 0, y: 2)` | `StacOffset(dx: 0, dy: 2)` |

### Navigation Issues

**Black Screen When Navigating?**
```dart
// ❌ WRONG - tries to load from STAC Cloud (doesn't work locally)
StacNavigateAction(
  routeName: 'tobank_login',  // STAC Cloud only!
  navigationStyle: NavigationStyle.push,
)

// ✅ CORRECT - loads from local assets
StacNavigateAction(
  assetPath: 'lib/stac/.build/tobank_login.json',
  navigationStyle: NavigationStyle.push,
)

// ✅ CORRECT - uses mock API (recommended)
StacNavigateAction(
  request: StacNetworkRequest(
    url: 'https://api.tobank.com/screens/tobank_login',
    method: Method.get,
  ),
  navigationStyle: NavigationStyle.push,
)
```

### Form & Date Picker Issues

**Date Picker Not Working?**
```json
// ❌ WRONG - disabled field blocks taps
{
  "type": "gestureDetector",
  "onTap": { "actionType": "persianDatePicker", "formFieldId": "birthdate" },
  "child": { "type": "textFormField", "enabled": false }
}

// ✅ CORRECT - add behavior: "opaque" to receive taps
{
  "type": "gestureDetector",
  "behavior": "opaque",  // ← Add this!
  "onTap": { "actionType": "persianDatePicker", "formFieldId": "birthdate" },
  "child": { "type": "textFormField", "enabled": false, "readOnly": true }
}
```

**TextFormField Not Updating from External Action?**
- Use `CustomTextFormFieldParser` (registers controller in registry)
- Date picker updates controller via `TextFormFieldControllerRegistry`
- Don't use `initialValue` with bindings for externally-updated fields

### Asset Loading Issues

**Flutter Asset Subfolders Not Found?**
```yaml
# ❌ WRONG - Flutter doesn't recursively include subfolders
assets:
  - stac/api_mock/

# ✅ CORRECT - explicitly list each subfolder
assets:
  - lib/stac/tobank/login/api/
  - lib/stac/tobank/menu/api/
  - lib/stac/tobank/splash/api/
  - lib/stac/config/
```

### Initialization Order Issues

**Variables Not Resolving / Mock Files Not Loading?**
```dart
// ✅ CORRECT order in main.dart
void main() async {
  // 1. FIRST - Initialize Flutter bindings (required for rootBundle)
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Setup Dio with mock interceptor
  final stacDio = setupStacMockDio();
  
  // 3. Initialize STAC with options
  await Stac.initialize(options: defaultStacOptions, dio: stacDio);
  
  // 4. Register custom parsers
  await registerCustomParsers();
  
  // 5. Load colors FIRST (required for styles)
  await TobankColorsLoader.loadColors(stacDio);
  
  // 6. Load strings
  await TobankStringsLoader.loadStrings(stacDio);
  
  // 7. Load styles AFTER colors
  await TobankStylesLoader.loadStyles(stacDio);
  
  // 8. Bootstrap app
  await bootstrap();
}
```

### Key Lessons Learned

1. **STAC uses strongly-typed enums, not strings**
2. **Always use `StacCustomTextStyle` for explicit styles** (`StacTextStyle` is abstract)
3. **Geometry objects are classes, not primitives** (`StacBorderRadius.all(12)` not `12`)
4. **`default_stac_options.dart` must be in `lib/`** (not in `stac/`)
5. **Call `WidgetsFlutterBinding.ensureInitialized()` first** in `main()`
6. **Use `request` or `assetPath` for navigation**, not `routeName` (STAC Cloud only)
7. **List each asset subfolder explicitly** in `pubspec.yaml`
8. **Custom components need registration** in `register_custom_parsers.dart`
9. **Use `behavior: "opaque"` on GestureDetector** when wrapping disabled widgets
10. **Colors must be loaded before styles** (styles resolve color variables)

---

## �📍 Reference Locations

### Essential Documentation

| Purpose | Location |
|---------|----------|
| AI Documentation Index | `docs/AI/README.md` |
| Quick Rules (READ FIRST!) | `docs/AI/Rules/QUICK_RULES.md` |
| Issues Log | `docs/AI/Issues/ISSUES_LOG.md` |
| Development Workflow | `docs/AI/DEVELOPMENT_WORKFLOW.md` |
| Data Binding System | `docs/AI/DATA_BINDING_SYSTEM.md` |
| Custom Components | `docs/AI/CUSTOM_COMPONENTS.md` |
| STAC Limitations & Workarounds | `docs/AI/STAC_LIMITATIONS.md` |

### Reference Code

| Purpose | Location |
|---------|----------|
| Old Tobank UI Reference | `docs/Archived/.tobank_old/lib/ui/` |
| STAC Widget Documentation | `docs/App_Docs/stac_docs/` |
| STAC Framework Source | `docs/Archived/.stac/` |
| Example Dart Page (Login) | `lib/stac/tobank/login/dart/tobank_login.dart` |
| Example API JSON | `lib/stac/tobank/login/api/GET_tobank_login.json` |

### Configuration Files

| Purpose | Location |
|---------|----------|
| Colors (Light/Dark) | `lib/stac/config/GET_colors.json` |
| Strings (Persian) | `lib/stac/config/GET_strings.json` |
| Styles | `lib/stac/config/GET_styles.json` |
| Menu Items | `lib/stac/tobank/menu/api/GET_menu-items.json` |
| STAC CLI Config | `lib/default_stac_options.dart` |

### Custom Components

| Purpose | Location |
|---------|----------|
| Custom Action Parsers | `lib/core/stac/parsers/actions/` |
| Custom Widget Parsers | `lib/core/stac/parsers/widgets/` |
| Parser Registration | `lib/core/stac/registry/register_custom_parsers.dart` |
| Data Loaders | `lib/core/stac/loaders/tobank/` |

### Assets

| Purpose | Location |
|---------|----------|
| App Icons | `assets/icons/` |
| App Images | `assets/images/` |
| Fonts | `assets/fonts/` |

### Task Examples (How Pages Were Created)

Study these documented tasks to understand real implementation workflows:

| Task | Location | What to Learn |
|------|----------|---------------|
| **Splash Screen** | `docs/AI/Tasks/create-splash-screen.md` | Simple screen, version loading, loader creation |
| **Form Validation** | `docs/AI/Tasks/form-validation-identity-verification.md` | Form fields, validation rules, submit actions, dialogs |
| **Theme System** | `docs/AI/Tasks/theme-system-refactoring.md` | Colors, theme switching, workarounds |
| **Menu Structure** | `docs/AI/Tasks/improve-menu-structure.md` | Dynamic lists, data binding |

---

## 🎯 Summary: The Golden Rules

1. **📋 Check Issues log FIRST** - Don't repeat past mistakes
2. **� Study implemented pages** - Login, Splash, Menu are your best teachers
3. **🔧 Understand lib/core/stac** - Know the flow and structure
4. **�📝 Dart is the source of truth** - Never manually edit generated JSON
5. **🚨 `stac build` MUST work** - If it fails, fix it immediately
6. **🎨 Use style aliases** - Reduces JSON size by ~80%
7. **🌙 Theme-aware colors** - Always use `{{appColors.current.*}}`
8. **🔤 String variables** - Never hardcode Persian text
9. **↔️ RTL everywhere** - Always set `textDirection: StacTextDirection.rtl`
10. **📱 Match old UI** - Pages must look exactly like old tobank
11. **✅ Test before committing** - Preview and test all interactions
12. **📚 Document new issues** - Help future development

---

**Last Updated**: 2025-12-16
**Template Version**: 1.1
**Status**: ✅ Complete - Ready for AI Agents

