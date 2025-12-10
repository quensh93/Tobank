# Data Binding System - Colors, Styles, Strings

## 🎯 Overview

This document explains how colors, styles, and strings are handled in the Tobank STAC SDUI project. **This is critical for reducing JSON size and maintaining consistency.**

## 🔑 Key Principle

**Single JSON File Binding** - Colors, styles, and strings are loaded once at startup from single JSON files and stored in `StacRegistry`. This avoids repeating data in every screen JSON, significantly reducing file sizes.

## 🎨 Colors System

### How It Works

1. **Load at Startup**: `TobankColorsLoader.loadColors(dio)` loads colors once
2. **Store in Registry**: Colors stored with dot-notation keys in `StacRegistry`
3. **Theme Aliases**: `appColors.current.*` aliases point to current theme
4. **Use in JSON**: Access via `{{appColors.current.*}}` syntax

### Color File Structure

**Location**: `lib/stac/config/GET_colors.json`

**Format**:
```json
{
  "GET": {
    "statusCode": 200,
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
}
```

### Color Access

**In JSON:**
```json
{
  "type": "text",
  "style": {
    "color": "{{appColors.current.text.title}}"
  }
}
```

**In Dart:**
```dart
StacText(
  data: 'Title',
  style: StacCustomTextStyle(
    color: '{{appColors.current.text.title}}',
  ),
)
```

### Theme-Aware Colors

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

**Why?**
- `appColors.current.*` automatically points to current theme
- When theme changes, all colors update automatically
- No need to reload JSON or change files

### Color Loader

**Location**: `lib/core/stac/loaders/tobank/tobank_colors_loader.dart`

**Key Methods:**
- `loadColors(dio)` - Load colors from API and store in registry
- `updateCurrentTheme(newTheme, dio)` - Update theme aliases
- `setCurrentTheme(newTheme)` - Update theme without refetching

**Storage:**
- `appColors.light.*` - All light theme colors
- `appColors.dark.*` - All dark theme colors
- `appColors.current.*` - Aliases to current theme (auto-updates)

## 📝 Strings System

### How It Works

1. **Load at Startup**: `TobankStringsLoader.loadStrings(dio)` loads strings once
2. **Store in Registry**: Strings stored with dot-notation keys in `StacRegistry`
3. **Use in JSON**: Access via `{{appStrings.*}}` syntax

### String File Structure

**Location**: `lib/stac/config/GET_strings.json`

**Format**:
```json
{
  "GET": {
    "statusCode": 200,
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
}
```

### String Access

**In JSON:**
```json
{
  "type": "text",
  "data": "{{appStrings.login.validationTitle}}"
}
```

**In Dart:**
```dart
StacText(
  data: '{{appStrings.login.validationTitle}}',
)
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

### String Loader

**Location**: `lib/core/stac/loaders/tobank/tobank_strings_loader.dart`

**Key Methods:**
- `loadStrings(dio)` - Load strings from API and store in registry
- `clearCache()` - Clear cached strings

**Storage:**
- `appStrings.*` - All strings with dot-notation keys

## 🎨 Styles System

### How It Works

1. **Load at Startup**: `TobankStylesLoader.loadStyles(dio)` loads styles once
2. **Resolve Colors**: Color variables resolved to actual values
3. **Store in Registry**: Styles stored with dot-notation keys in `StacRegistry`
4. **Use in JSON**: Access via `{{appStyles.*}}` syntax

### Style File Structure

**Location**: `lib/stac/config/GET_styles.json`

**Format**:
```json
{
  "GET": {
    "statusCode": 200,
    "data": {
      "button": {
        "primary": {
          "backgroundColor": "{{appColors.current.button.primary.backgroundColor}}",
          "height": 56.0
        }
      },
      "text": {
        "pageTitle": {
          "color": "{{appColors.current.text.title}}",
          "fontSize": 20.0,
          "fontWeight": "w400"
        }
      },
      "appbarStyle": {
        "color": "{{appColors.current.text.title}}",
        "fontSize": 20.0,
        "fontWeight": "w400"
      }
    }
  }
}
```

### Style Access

**Individual Properties:**
```json
{
  "type": "elevatedButton",
  "style": {
    "backgroundColor": "{{appStyles.button.primary.backgroundColor}}"
  }
}
```

**Style Aliases (Recommended):**
```json
{
  "type": "text",
  "style": "{{appStyles.appbarStyle}}"
}
```

**In Dart:**
```dart
StacText(
  data: 'Title',
  style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
)
```

### Style Aliases Pattern ⭐ **CRITICAL**

**Why Use Style Aliases?**
- **Reduces JSON Size**: Instead of repeating full style objects, use a single string reference
- **Consistency**: Styles defined once, used everywhere
- **Maintainability**: Update style in one place, affects all usages
- **Performance**: Smaller JSON payloads = faster network transfers

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

### Creating Style Aliases

1. **Add to `lib/stac/config/GET_styles.json`**:
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

**This pattern is mandatory for all new style definitions!**

### Style Loader

**Location**: `lib/core/stac/loaders/tobank/tobank_styles_loader.dart`

**Key Methods:**
- `loadStyles(dio)` - Load styles from API, resolve colors, store in registry
- `clearCache()` - Clear cached styles
- `buildStyleObject(key)` - Build style object from registry keys

**Important:**
- Colors are resolved **before** storing in registry
- This ensures styles contain actual color values, not variable references
- Color resolution happens after colors are loaded

## 🔄 Variable Resolution Flow

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

## 📋 Variable Namespaces

### 1. Strings: `{{appStrings.*}}`
- **Source**: `lib/stac/config/GET_strings.json`
- **Loaded**: At app startup via `TobankStringsLoader`
- **Format**: `appStrings.{section}.{key}`
- **Examples**:
  - `{{appStrings.login.validationTitle}}`
  - `{{appStrings.common.loading}}`

### 2. Colors: `{{appColors.current.*}}`
- **Source**: `lib/stac/config/GET_colors.json`
- **Loaded**: At app startup via `TobankColorsLoader`
- **Format**: `appColors.current.{category}.{property}`
- **Examples**:
  - `{{appColors.current.text.title}}`
  - `{{appColors.current.button.primary.backgroundColor}}`

### 3. Styles: `{{appStyles.*}}`
- **Source**: `lib/stac/config/GET_styles.json`
- **Loaded**: At app startup via `TobankStylesLoader`
- **Format**: `appStyles.{component}.{property}` OR `appStyles.{styleAlias}`
- **Examples**:
  - `{{appStyles.button.primary.backgroundColor}}` - Individual property
  - `{{appStyles.appbarStyle}}` - Style alias (complete style object) ⭐

### 4. Form Data: `{{form.*}}`
- **Source**: Form field values
- **Updated**: When user types or actions update fields
- **Format**: `form.{fieldId}`
- **Examples**:
  - `{{form.mobile_number}}`
  - `{{form.birthdate}}`

## 🚨 Critical Rules

1. **Always use style aliases** - Don't define inline style objects
2. **Always use theme-aware colors** - `{{appColors.current.*}}` not `{{appColors.light.*}}`
3. **Never hardcode strings** - Use `{{appStrings.*}}`
4. **Never hardcode colors** - Use `{{appColors.current.*}}`
5. **Loaders must be called** - Colors, strings, styles loaded at startup
6. **Colors loaded first** - Styles need colors to resolve variables

## 📚 Related Documentation

- **Complete Guide**: `docs/TOBANK_STAC_SDUI_COMPLETE_GUIDE.md`
- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`
- **Development Workflow**: `docs/AI/DEVELOPMENT_WORKFLOW.md`

---

**Next Steps**: Read [CORE_STAC_STRUCTURE.md](./CORE_STAC_STRUCTURE.md) to understand the core/stac structure.

