# SDUI Flow Patterns - Best Practices

## 🎯 Overview

This document defines the **standard patterns and best practices** for creating Server-Driven UI (SDUI) flows in the Tobank STAC project. These patterns ensure consistency, server-readiness, and maintainability.

**Reference Implementation**: `lib/stac/tobank/flows/login_flow_linear/`

---

## 📁 File Structure Pattern

### Directory Organization

Every SDUI flow should follow this structure:

```
lib/stac/tobank/flows/{flow_name}/
├── dart/
│   └── {flow_name}_{screen_name}.dart
├── json/
│   └── {flow_name}_{screen_name}.json
└── api/
    └── GET_{flow_name}_{screen_name}.json
```

**Example**:
```
lib/stac/tobank/flows/login_flow_linear/
├── dart/
│   ├── login_flow_linear_splash.dart
│   ├── login_flow_linear_onboarding.dart
│   ├── login_flow_linear_login.dart
│   └── login_flow_linear_verify_otp.dart
├── json/
│   ├── login_flow_linear_splash.json
│   ├── login_flow_linear_onboarding.json
│   ├── login_flow_linear_login.json
│   └── login_flow_linear_verify_otp.json
└── api/
    ├── GET_login_flow_linear_splash.json
    ├── GET_login_flow_linear_onboarding.json
    ├── GET_login_flow_linear_login.json
    └── GET_login_flow_linear_verify_otp.json
```

### Purpose of Each Directory

1. **`dart/`** - Source Dart files using STAC Dart syntax
   - Used for development and preview
   - Can be built to JSON using `stac build` (optional)

2. **`json/`** - Local JSON files for development/testing
   - Used when navigating with `assetPath`
   - References other JSON files using `assetPath`
   - Not deployed to server (development only)

3. **`api/`** - Server-ready JSON files (API responses)
   - Wrapped in API response format: `{ "GET": { "statusCode": 200, "data": {...} } }`
   - **Must use `request` URLs for navigation** (simulates server API calls)
   - **Ready for server deployment** - Can be served directly from backend

---

## 🔗 Navigation Patterns

### Pattern 1: API JSON Files → Use `request`

**When**: In API JSON files (`/api/` directory)

**Why**: Simulates real server behavior. When deployed to server, these URLs will fetch the next screen from the backend.

**Format**:
```json
{
  "actionType": "navigate",
  "request": {
    "url": "https://api.tobank.com/flows/{flow_name}/{screen_name}",
    "method": "get"
  },
  "navigationStyle": "pushReplacement"
}
```

**Example** (from `GET_login_flow_linear_splash.json`):
```json
{
  "type": "onMountAction",
  "delay": 2000,
  "action": {
    "actionType": "navigate",
    "request": {
      "url": "https://api.tobank.com/flows/login_flow_linear/login_flow_linear_onboarding",
      "method": "get"
    },
    "navigationStyle": "pushReplacement"
  },
  "child": { ... }
}
```

**How it works**:
- The mock interceptor intercepts these URLs during development
- Maps `flows/login_flow_linear/login_flow_linear_onboarding` → `GET_login_flow_linear_onboarding.json`
- In production, these URLs will fetch from the real server

### Pattern 2: JSON Files → Use `assetPath`

**When**: In local JSON files (`/json/` directory)

**Why**: For local development and testing. Points directly to other JSON files in the project.

**Format**:
```json
{
  "actionType": "navigate",
  "assetPath": "lib/stac/tobank/flows/{flow_name}/json/{screen_name}.json",
  "navigationStyle": "pushReplacement"
}
```

**Example** (from `login_flow_linear_onboarding.json`):
```json
{
  "type": "scaffold",
  "body": {
    "type": "tobank_onboarding_slider",
    "onFinish": {
      "actionType": "navigate",
      "assetPath": "lib/stac/tobank/flows/login_flow_linear/json/login_flow_linear_login.json",
      "navigationStyle": "pushReplacement"
    }
  }
}
```

### Pattern 3: Avoid `widgetType` (Deprecated)

**❌ Don't use** `widgetType` in API JSON files:
```json
{
  "actionType": "navigate",
  "widgetType": "tobank_login_flow_linear_login",  // ❌ BAD
  "navigationStyle": "pushReplacement"
}
```

**Why**: `widgetType` requires client-side widget loading logic. For SDUI, everything should be server-driven via API URLs.

---

## 📐 JSON Formatting Standards

### Rule: `"type"` Property Always First

**MANDATORY**: The `"type"` property must be the first property in every widget object.

**✅ Correct**:
```json
{
  "type": "scaffold",
  "backgroundColor": "{{appColors.current.background.surface}}",
  "body": {
    "type": "stack",
    "children": [...]
  }
}
```

**❌ Incorrect**:
```json
{
  "backgroundColor": "{{appColors.current.background.surface}}",
  "body": {...},
  "type": "scaffold"  // ❌ type must be first
}
```

**Why**: 
- Makes widget type immediately visible when reading JSON
- Consistent formatting across all files
- Easier for servers and tools to parse

### Apply to All Nested Objects

This rule applies to **all widget objects**, including nested ones:

```json
{
  "type": "scaffold",
  "body": {
    "type": "column",
    "children": [
      {
        "type": "text",  // ✅ type first here too
        "data": "...",
        "style": {
          "type": "custom",  // ✅ type first in style too
          "color": "..."
        }
      }
    ]
  }
}
```

---

## 🎬 Lifecycle Actions with `onMountAction`

### Overview

The `onMountAction` widget executes an action when the widget is mounted (initialized), then renders its child widget. This solves the problem of lifecycle actions in STAC (which doesn't have built-in lifecycle hooks).

### Use Cases

- **Auto-navigation after delay** (e.g., splash screens)
- **Auto-fetch data on screen load**
- **Auto-trigger analytics events**
- **Auto-show dialogs/toasts**

### JSON Syntax

```json
{
  "type": "onMountAction",
  "delay": 2000,
  "action": {
    "actionType": "navigate",
    "request": {
      "url": "https://api.tobank.com/flows/login_flow_linear/login_flow_linear_onboarding",
      "method": "get"
    },
    "navigationStyle": "pushReplacement"
  },
  "child": {
    "type": "scaffold",
    "body": { ... }
  }
}
```

### Properties

- **`type`** (required): `"onMountAction"`
- **`delay`** (optional): Delay in milliseconds before executing action. Default: `0`
- **`action`** (required): The STAC action to execute (any action type: navigate, delay, setValue, etc.)
- **`child`** (optional): The widget to render while/after action executes
- **`executeOnce`** (optional): If `true`, action only executes once even if widget rebuilds. Default: `true`

### Complete Example: Splash Screen

```json
{
  "GET": {
    "statusCode": 200,
    "data": {
      "type": "onMountAction",
      "delay": 2000,
      "action": {
        "actionType": "navigate",
        "request": {
          "url": "https://api.tobank.com/flows/login_flow_linear/login_flow_linear_onboarding",
          "method": "get"
        },
        "navigationStyle": "pushReplacement"
      },
      "child": {
        "type": "scaffold",
        "backgroundColor": "{{appColors.current.background.surface}}",
        "body": {
          "type": "stack",
          "children": [
            {
              "type": "align",
              "alignment": "center",
              "child": {
                "type": "column",
                "mainAxisSize": "min",
                "crossAxisAlignment": "center",
                "children": [
                  {
                    "type": "image",
                    "src": "{{appAssets.icons.logoRed}}",
                    "imageType": "asset",
                    "width": 229.0,
                    "height": 36.0,
                    "fit": "contain"
                  }
                ]
              }
            }
          ]
        }
      }
    }
  }
}
```

### Implementation Details

- Uses Flutter's `initState()` internally for lifecycle management
- Executes action after first frame (using `addPostFrameCallback`)
- Includes mounted checks to prevent errors
- Handles delays safely
- Can load child from widget loader if `child` is not provided

---

## 🔄 Complete Flow Example

### Flow Structure: Login Flow Linear

```
Splash → Onboarding → Login → Verify OTP → Menu
```

### Screen 1: Splash (`GET_login_flow_linear_splash.json`)

```json
{
  "GET": {
    "statusCode": 200,
    "data": {
      "type": "onMountAction",
      "delay": 2000,
      "action": {
        "actionType": "navigate",
        "request": {
          "url": "https://api.tobank.com/flows/login_flow_linear/login_flow_linear_onboarding",
          "method": "get"
        },
        "navigationStyle": "pushReplacement"
      },
      "child": { ... splash UI ... }
    }
  }
}
```

### Screen 2: Onboarding (`GET_login_flow_linear_onboarding.json`)

```json
{
  "GET": {
    "statusCode": 200,
    "data": {
      "type": "scaffold",
      "body": {
        "type": "tobank_onboarding_slider",
        "pages": [...],
        "onFinish": {
          "actionType": "navigate",
          "request": {
            "url": "https://api.tobank.com/flows/login_flow_linear/login_flow_linear_login",
            "method": "get"
          },
          "navigationStyle": "pushReplacement"
        }
      }
    }
  }
}
```

### Screen 3: Login (`GET_login_flow_linear_login.json`)

```json
{
  "GET": {
    "statusCode": 200,
    "data": {
      "type": "scaffold",
      "appBar": {...},
      "body": {
        "type": "form",
        "onSubmit": {
          "actionType": "multiAction",
          "actions": [
            { "actionType": "closeDialog" },
            {
              "actionType": "navigate",
              "request": {
                "url": "https://api.tobank.com/flows/login_flow_linear/login_flow_linear_verify_otp",
                "method": "get"
              },
              "navigationStyle": "pushReplacement"
            }
          ]
        }
      }
    }
  }
}
```

---

## ✅ Best Practices Checklist

When creating a new SDUI flow, ensure:

- [ ] **File structure follows pattern**: `dart/`, `json/`, `api/` directories
- [ ] **API JSON files use `request` URLs** for navigation (not `widgetType` or `assetPath`)
- [ ] **JSON files use `assetPath`** for local development navigation
- [ ] **All widgets have `"type"` as first property** (including nested widgets)
- [ ] **API JSON files are wrapped** in API response format: `{ "GET": { "statusCode": 200, "data": {...} } }`
- [ ] **API JSON files are complete and standalone** - Ready to be served from backend
- [ ] **Use `onMountAction`** for lifecycle actions (auto-navigation, auto-fetch, etc.)
- [ ] **URLs follow pattern**: `https://api.tobank.com/flows/{flow_name}/{screen_name}`
- [ ] **Mock interceptor can map URLs** to corresponding API JSON files

---

## 🔍 Verification

### Check API JSON File Structure

1. ✅ File is wrapped: `{ "GET": { "statusCode": 200, "data": {...} } }`
2. ✅ Navigation uses `request` with URL (not `widgetType` or `assetPath`)
3. ✅ All widgets have `"type"` as first property
4. ✅ JSON is complete and standalone (no missing references)

### Check JSON File Structure

1. ✅ Navigation uses `assetPath` pointing to JSON files
2. ✅ All widgets have `"type"` as first property
3. ✅ References use relative paths to other JSON files

### Test Flow

1. ✅ Navigate to flow start screen
2. ✅ Verify navigation works through all screens
3. ✅ Check that mock interceptor finds API files correctly
4. ✅ Verify `onMountAction` delays and actions work correctly

---

## 📚 Related Documentation

- **[DEVELOPMENT_WORKFLOW.md](./DEVELOPMENT_WORKFLOW.md)** - General workflow for creating STAC pages
- **[CUSTOM_COMPONENTS.md](./CUSTOM_COMPONENTS.md)** - Creating custom widgets (like `onMountAction`)
- **[DATA_BINDING_SYSTEM.md](./DATA_BINDING_SYSTEM.md)** - Using variables (`{{appColors.*}}`, `{{appStrings.*}}`)
- **Reference Implementation**: `lib/stac/tobank/flows/login_flow_linear/`

---

**Last Updated**: 2025-12-16  
**Status**: ✅ Complete - Standard Pattern for All SDUI Flows

