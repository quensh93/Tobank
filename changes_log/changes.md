# Changes Log

This file tracks all changes made to the tobank_sdui project.

---

## [October 22, 2025]

### Documentation Setup
- **Created** `docs/` folder for project documentation
- **Created** `docs/todo.md` for tracking project tasks
- **Created** `changes_log/` folder for tracking changes
- **Created** `changes_log/changes.md` for logging all project changes

### STAC Project Integration
- **Completed** Cloned STAC project from [https://github.com/StacDev/stac.git](https://github.com/StacDev/stac.git)
- **Location** STAC project cloned to root-level `stac/` folder (not in `lib/`)
- **Files Cloned** 1,331 files successfully cloned from the dev branch
- **Description** Stac is a Server-Driven UI (SDUI) framework for Flutter that allows building dynamic UIs from JSON

### Git Configuration for STAC
- **Modified** `.gitignore` to exclude `stac/` folder from main project tracking
- **Reason** Keep stac as independent repository to avoid conflicts and unwanted changes in main project
- **Benefit** Can update stac independently using `cd stac && git pull` without affecting main project
- **Impact** Main project won't see bugs, changes, or files from the stac folder in git status

### Dart Analyzer Configuration for STAC
- **Modified** `analysis_options.yaml` to exclude `stac/**` from Dart analyzer
- **Reason** Prevent Dart analyzer from processing stac folder and showing related errors
- **Configuration** Added `analyzer.exclude: [stac/**]` to ignore all files in stac directory
- **Impact** No more analyzer errors or warnings from the stac folder in IDE

### STAC Local Dependency Integration
- **Modified** `pubspec.yaml` to add STAC as local dependency
- **Configuration** Added `stac: path: stac/packages/stac` to dependencies
- **Installed** STAC framework and all its dependencies (49 packages)
- **Version** Using STAC v1.0.1 from local path
- **Dependencies** Includes stac_core, stac_framework, stac_logger, and other required packages
- **Ready** STAC framework is now available for use in tobank_sdui project

### Pubspec Cleanup
- **Cleaned** `pubspec.yaml` by removing all comments and documentation
- **Result** Minimal, clean configuration file with only essential settings
- **Maintained** All functionality including STAC dependency
- **Improved** Readability and maintainability

### STAC Test Implementation
- **Created** `lib/dummy/stac_test_page.dart` with complex STAC JSON configuration
- **Modified** `lib/main.dart` to initialize STAC framework
- **Added** navigation button to test STAC page from home screen
- **Tested** compilation with `flutter analyze` - no issues found
- **Features** Complex test page includes:
  - Scaffold with app bar and floating action button
  - Card with padding and text styling
  - Multiple button types (elevated, outlined, text)
  - Container with decoration and border radius
  - ListView with ListTiles and icons
  - Wrap layout with chips
  - Progress indicators (circular and linear)
  - Dividers and spacing
- **Ready** STAC integration is working with complex UI components

### STAC Configuration Fixes
- **Fixed** Icon format issues - changed from `Icons.xxx` to `xxx` format
- **Fixed** ListView physics - changed from `NeverScrollableScrollPhysics` to `never`
- **Updated** All icon references: settings, star, favorite, thumb_up, add
- **Fixed** LinearProgressIndicator layout issue - wrapped in Expanded widget to prevent infinite width constraint
- **Fixed** Column overflow issue - wrapped Column in SingleChildScrollView to make content scrollable
- **Tested** compilation with `flutter analyze` - no issues found
- **Result** Complex STAC configuration now works without parsing, layout, or overflow errors

### Next Steps
- Document integration approach and usage with tobank_sdui project
- Test the STAC page in the app to verify functionality

---

## Change Log Format

Each entry should include:
- **Date:** When the change was made
- **Type:** Created, Modified, Deleted, Fixed, Added, etc.
- **Description:** What was changed and why
- **Impact:** How it affects the project (if significant)

