# Reference Locations - Where to Find Things

## 🎯 Overview

This document provides a quick reference guide to all important locations in the Tobank STAC SDUI project. Use this when you need to find documentation, old code, assets, or resources.

## 📚 Documentation Locations

### AI Agent Documentation
- **Location**: `docs/AI/`
- **Purpose**: Documentation for AI agents
- **Files**:
  - `README.md` - Main index
  - `PROJECT_OVERVIEW.md` - Project structure and overview
  - `DEVELOPMENT_WORKFLOW.md` - How to create STAC pages
  - `CUSTOM_COMPONENTS.md` - Creating custom actions and parsers
  - `DATA_BINDING_SYSTEM.md` - Colors, styles, strings system
  - `CORE_STAC_STRUCTURE.md` - lib/core/stac structure
  - `REFERENCE_LOCATIONS.md` - This file
  - `ISSUES_HANDLING.md` - How to handle issues

### Issues Log
- **Location**: `docs/AI/Issues/ISSUES_LOG.md`
- **Purpose**: Documented bugs, errors, and solutions
- **Usage**: Check before starting tasks or when facing issues
- **Content**: All bugs encountered, common patterns, prevention strategies

### Complete Guide
- **Location**: `docs/TOBANK_STAC_SDUI_COMPLETE_GUIDE.md`
- **Purpose**: Comprehensive project guide
- **Content**: Complete workflow, patterns, troubleshooting

### Project Overview
- **Location**: `docs/overview.md`
- **Purpose**: High-level project overview
- **Content**: Architecture, features, technical stack

### STAC Widget Documentation
- **Location**: `docs/App_Docs/stac_docs/`
- **Purpose**: Reference for creating STAC widgets
- **Content**: Widget documentation, action documentation, examples
- **Usage**: **Read before creating STAC Dart pages**
- **Key Files**:
  - `widgets_*.md` - Individual widget documentation
  - `actions_*.md` - Action documentation
  - `06-widgets.md` - Widget overview
  - `07-actions.md` - Actions overview

### Persian Date Picker Implementation
- **Location**: `docs/persian_date_picker_implementation.md`
- **Purpose**: How Persian date picker was implemented
- **Content**: Implementation details, usage examples

## 🏗️ Code Locations

### Old Tobank Reference (UI Matching)
- **Location**: `docs/Archived/.tobank_old/`
- **Purpose**: Reference for matching UI exactly
- **Content**: Old tobank app source code
- **Key Directories**:
  - `lib/ui/` - UI screens (reference for matching)
  - `assets/` - Assets (already copied to `assets/`)
- **Usage**: **Check before creating new pages to match UI**

### STAC Repository (Inner Layer)
- **Location**: `docs/Archived/.stac/`
- **Purpose**: STAC framework source code
- **Content**: STAC framework repository clone
- **Usage**: **When facing framework-level issues or need to understand inner workings**
- **Key Directories**:
  - `packages/stac/` - Main STAC package
  - `packages/stac_core/` - Core models and types
  - `packages/stac_framework/` - Framework interfaces
  - `website/docs/` - STAC documentation

### STAC Source Files
- **Location**: `lib/stac/`
- **Purpose**: STAC source files (Dart widgets, JSON, API mocks)
- **Structure**:
  - `tobank/{feature}/dart/` - STAC Dart widgets
  - `tobank/{feature}/json/` - Manual JSON files
  - `tobank/{feature}/api/` - API mock responses
  - `.build/` - Generated JSON (from `stac build`)
  - `config/` - Global configs (colors, strings, styles)

### Core STAC Extensions
- **Location**: `lib/core/stac/`
- **Purpose**: STAC framework extensions
- **Structure**:
  - `loaders/` - Colors, strings, styles loaders
  - `parsers/` - Custom parsers (actions & widgets)
  - `registry/` - Component registration
  - `services/` - STAC services
  - `utils/` - Utilities

## 🎨 Assets

### App Assets
- **Location**: `assets/`
- **Purpose**: All app assets (images, icons, fonts)
- **Source**: Copied from `docs/Archived/.tobank_old/assets/`
- **Usage**: Reference in JSON/Dart using asset paths
- **Content**:
  - `icons/` - SVG icons
  - `images/` - PNG images
  - `fonts/` - Font files

### Old Tobank Assets (Reference)
- **Location**: `docs/Archived/.tobank_old/assets/`
- **Purpose**: Original assets from old tobank
- **Note**: Assets were copied to `assets/` - use those instead

## 📋 Configuration Files

### STAC Configuration
- **Location**: `lib/default_stac_options.dart`
- **Purpose**: STAC CLI configuration
- **Content**: Source and output directories for `stac build`

### Global Configs
- **Location**: `lib/stac/config/`
- **Files**:
  - `GET_colors.json` - Color definitions
  - `GET_strings.json` - Localization strings
  - `GET_styles.json` - Component styles

### Design System
- **Location**: `lib/stac/design_system/`
- **Files**:
  - `tobank_theme_light.json` - Light theme
  - `tobank_theme_dark.json` - Dark theme

## 🔧 Tools & Utilities

### Debug Panel
- **Location**: `lib/debug_panel/`
- **Purpose**: Development tools
- **Content**: Debug panel widgets, screens, state management

### Supabase Tools
- **Location**: `lib/tools/supabase_cli/`
- **Purpose**: Firebase/Supabase CLI tools
- **Content**: Upload, download, list, delete commands

## 📖 Quick Reference Guide

### When Creating a New STAC Page

1. **Check old tobank reference**: `docs/Archived/.tobank_old/lib/ui/`
2. **Read STAC widget docs**: `docs/App_Docs/stac_docs/`
3. **Check existing examples**: `lib/stac/tobank/login/dart/`
4. **Check Issues log**: `docs/AI/Issues/ISSUES_LOG.md`
5. **Use assets**: `assets/` (copied from old tobank)

### When Facing an Issue

1. **Check Issues log**: `docs/AI/Issues/ISSUES_LOG.md`
2. **Check STAC repository**: `docs/Archived/.stac/` (for framework issues)
3. **Check core/stac**: `lib/core/stac/` (for custom component issues)
4. **Check complete guide**: `docs/TOBANK_STAC_SDUI_COMPLETE_GUIDE.md`

### When Creating Custom Components

1. **Check existing examples**: `lib/core/stac/parsers/`
2. **Read custom components doc**: `docs/AI/CUSTOM_COMPONENTS.md`
3. **Check registration**: `lib/core/stac/registry/register_custom_parsers.dart`

### When Understanding Data Binding

1. **Read data binding doc**: `docs/AI/DATA_BINDING_SYSTEM.md`
2. **Check loaders**: `lib/core/stac/loaders/tobank/`
3. **Check config files**: `lib/stac/config/`

## 🗺️ File Path Mapping

### STAC Page Creation Flow

```
1. Reference: docs/Archived/.tobank_old/lib/ui/{screen}.dart
   ↓
2. Create: lib/stac/tobank/{feature}/dart/{feature}.dart
   ↓
3. Build: stac build → lib/stac/.build/tobank_{feature}.json
   ↓
4. Create: lib/stac/tobank/{feature}/api/GET_tobank_{feature}.json
```

### Asset Usage

```
Old: docs/Archived/.tobank_old/assets/icons/icon.svg
New: assets/icons/icon.svg
Reference: assets/icons/icon.svg (in JSON/Dart)
```

### Documentation Flow

```
AI Docs: docs/AI/*.md
  ↓
STAC Widget Docs: docs/App_Docs/stac_docs/*.md
  ↓
Complete Guide: docs/TOBANK_STAC_SDUI_COMPLETE_GUIDE.md
  ↓
STAC Framework: docs/Archived/.stac/
```

## 📝 Summary Table

| What | Where | Purpose |
|------|-------|---------|
| AI Documentation | `docs/AI/` | AI agent guides |
| Issues Log | `docs/AI/Issues/ISSUES_LOG.md` | Bugs and solutions |
| STAC Widget Docs | `docs/App_Docs/stac_docs/` | Widget reference |
| Old Tobank Reference | `docs/Archived/.tobank_old/` | UI matching |
| STAC Repository | `docs/Archived/.stac/` | Framework source |
| STAC Source Files | `lib/stac/tobank/` | Project STAC files |
| Core STAC | `lib/core/stac/` | Framework extensions |
| Assets | `assets/` | App assets |
| Config Files | `lib/stac/config/` | Global configs |

---

**Next Steps**: Read [ISSUES_HANDLING.md](./ISSUES_HANDLING.md) to understand how to handle issues.

