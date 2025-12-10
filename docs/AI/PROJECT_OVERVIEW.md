# Project Overview - Tobank STAC SDUI

## 🎯 What is This Project?

**Tobank STAC SDUI** is a Flutter banking application built using the **STAC (Server-Driven UI)** framework. The UI is defined in JSON and can be updated server-side without app releases.

### Key Characteristics

- **Server-Driven**: UI comes from JSON (local files or remote APIs)
- **Three-Source Workflow**: Dart → JSON → API JSON
- **Mock-First Development**: All APIs are mocked using local JSON files
- **Theme-Aware**: Automatic light/dark mode support
- **Persian Localization**: Full RTL and Persian language support
- **UI Matching**: Pages must match old tobank app exactly

## 🏗️ Project Structure

```
tobank_sdui/
├── lib/
│   ├── core/
│   │   └── stac/              # STAC framework extensions
│   │       ├── loaders/       # Colors, strings, styles loaders
│   │       ├── parsers/       # Custom parsers (actions & widgets)
│   │       ├── registry/      # Component registration
│   │       ├── services/     # STAC services (navigation, theme, widget)
│   │       └── utils/        # Utilities
│   ├── stac/
│   │   ├── .build/            # Generated JSON (from stac build)
│   │   ├── config/            # Global configs (colors, strings, styles)
│   │   ├── design_system/     # Theme files
│   │   └── tobank/            # Feature-based screens
│   │       ├── login/
│   │       │   ├── dart/      # STAC Dart widget definitions
│   │       │   ├── json/      # Manual JSON files
│   │       │   └── api/       # API JSON files (mock responses)
│   │       └── ... (other features)
│   └── main.dart
├── assets/                    # Assets (copied from old tobank)
├── docs/
│   ├── AI/                    # This folder - AI agent docs
│   ├── App_Docs/
│   │   └── stac_docs/         # STAC widget documentation
│   ├── Archived/
│   │   ├── .tobank_old/       # Old tobank app reference
│   │   └── .stac/             # STAC repository clone
│   └── TOBANK_STAC_SDUI_COMPLETE_GUIDE.md
└── pubspec.yaml
```

## 🔑 Key Directories Explained

### `lib/stac/tobank/{feature}/dart/`
- **Purpose**: STAC Dart widget definitions (source of truth)
- **Usage**: Write screens using `StacWidget`, `StacContainer`, etc.
- **Workflow**: Design here first, preview in app

### `lib/stac/tobank/{feature}/json/`
- **Purpose**: Manual JSON files (alternative to Dart)
- **Usage**: Direct JSON definitions (less common)
- **Note**: Can be manually edited or generated

### `lib/stac/tobank/{feature}/api/`
- **Purpose**: API mock response files
- **Naming**: `{METHOD}_{endpoint}.json` (e.g., `GET_tobank_login.json`)
- **Format**: Wrapped in `{"GET": {"statusCode": 200, "data": {...}}}`

### `lib/stac/.build/`
- **Purpose**: Generated JSON from `stac build` command
- **Source**: Generated from `dart/` files
- **Rule**: **DO NOT manually edit** - regenerated on each build

### `lib/stac/config/`
- **Purpose**: Global configuration files
- **Files**:
  - `GET_colors.json` - Color definitions for both themes
  - `GET_strings.json` - All localization strings
  - `GET_styles.json` - Component style definitions

### `lib/core/stac/`
- **Purpose**: STAC framework extensions and custom components
- **Structure**:
  - `loaders/` - Load colors, strings, styles into registry
  - `parsers/` - Custom action and widget parsers
  - `registry/` - Component registration system
  - `services/` - Navigation, theme, widget loading services
  - `utils/` - Utilities (e.g., controller registry)

### `assets/`
- **Purpose**: All app assets (images, icons, fonts)
- **Source**: Copied from `docs/Archived/.tobank_old/assets/`
- **Usage**: Reference in JSON/Dart using asset paths

## 🎨 Technology Stack

- **Framework**: Flutter 3.9+
- **SDUI Framework**: STAC (local package)
- **State Management**: Riverpod
- **Network**: Dio with custom mock interceptor
- **Date Picker**: `persian_datetime_picker` for Persian calendar
- **Storage**: Flutter Secure Storage

## 📋 Key Principles

### 1. UI Must Match Old Tobank
- Pages created for tobank SDUI should match old tobank UI exactly
- Assets were copied from `docs/Archived/.tobank_old/assets/` to `assets/`
- Reference old tobank screens in `docs/Archived/.tobank_old/lib/ui/`

### 2. Three-Source Workflow
- **Dart**: Source of truth (`dart/` folder)
- **JSON**: Generated from Dart (`stac build`)
- **API JSON**: Mock response (`api/` folder)

### 3. Data Binding System
- Colors, styles, strings loaded once at startup
- Stored in `StacRegistry` with dot-notation keys
- Accessed via `{{appColors.*}}`, `{{appStyles.*}}`, `{{appStrings.*}}`
- **Critical**: Use style aliases to reduce JSON size

### 4. Theme System
- Colors loaded for both light and dark themes
- `appColors.current.*` aliases point to current theme
- Always use `{{appColors.current.*}}` for theme-aware colors
- Automatically updates when theme changes

### 5. Custom Components
- Custom actions: `lib/core/stac/parsers/actions/`
- Custom widgets: `lib/core/stac/parsers/widgets/`
- Registered in: `lib/core/stac/registry/register_custom_parsers.dart`

## 🔄 Development Flow

```
1. DESIGN (Dart)
   lib/stac/tobank/{feature}/dart/{feature}.dart
   ↓
   Write STAC widgets, preview in app
   
2. BUILD (JSON Generation)
   stac build
   ↓
   lib/stac/.build/{feature}.json
   (Auto-generated, DO NOT edit manually)
   
3. MOCK API (API JSON)
   lib/stac/tobank/{feature}/api/GET_{feature}.json
   ↓
   Wrapped in {"GET": {"data": {...}}}
   (Manual copy from .build/ or reference)
   
4. USE IN APP
   Navigation loads from API URL or asset path
   Mock interceptor maps URL → API JSON file
```

## 📚 Reference Locations

### STAC Widget Documentation
- **Location**: `docs/App_Docs/stac_docs/`
- **Purpose**: Reference for creating STAC widgets
- **Usage**: Read before creating STAC Dart pages

### Old Tobank Reference
- **Location**: `docs/Archived/.tobank_old/`
- **Purpose**: UI reference to match exactly
- **Usage**: Check old screens to ensure UI matches

### STAC Repository (Inner Layer)
- **Location**: `docs/Archived/.stac/`
- **Purpose**: STAC framework source code
- **Usage**: When facing framework-level issues

### Issues Log
- **Location**: `docs/AI/Issues/ISSUES_LOG.md`
- **Purpose**: Documented bugs and solutions
- **Usage**: Check before starting tasks or when facing issues

## 🚨 Critical Rules

1. **Always start with Dart** - Design and preview in Dart first
2. **Build before using** - Run `stac build` after Dart changes
3. **Use style aliases** - Reduce JSON size with style aliases
4. **Theme-aware colors** - Always `{{appColors.current.*}}`
5. **Check Issues log** - Before starting tasks
6. **Match old UI** - Pages must match old tobank exactly
7. **Assets location** - Use assets from `assets/` folder

---

**Next Steps**: Read [DEVELOPMENT_WORKFLOW.md](./DEVELOPMENT_WORKFLOW.md) to understand how to create STAC pages.

