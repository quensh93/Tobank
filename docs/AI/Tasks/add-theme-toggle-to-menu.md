# Task: Add Theme Toggle to Menu

## Status
✅ **COMPLETED**

## Objective
Implement a server-driven theme toggle button in the menu AppBar that allows switching between light and dark modes. The theme colors, including input borders (which were a limitation), must be controlled by the server via `StacRegistry`.

## Completed Work

### 1. Analysis & Documentation
- [x] Identified STAC `InputDecorationTheme` border parsing limitation.
- [x] Created `docs/AI/STAC_LIMITATIONS.md`.
- [x] Designed proper architecture using `StacThemeWrapper` + `StacRegistry`.

### 2. Core Implementation
- [x] **Updated `StacThemeWrapper`**:
    - Now reads `appColors.current.input.borderEnabled` etc. from `StacRegistry`.
    - Added comprehensive logging.
    - Added hex color parsing helper.
- [x] **Created Theme Toggle Action**:
    - `ThemeToggleActionModel` (lib/core/stac/parsers/actions/theme_toggle_action_model.dart)
    - `ThemeToggleActionParser` (lib/core/stac/parsers/actions/theme_toggle_action_parser.dart)
    - Registered in `register_custom_parsers.dart`.

### 3. UI Implementation
- [x] **Updated Menu Screen (`tobank_menu.dart`)**:
    - Added `StacIconButton` to AppBar actions.
    - Used `assets/icons/ic_theme.svg`.
    - Bound `onPressed` to `toggleTheme` action.
    - Tooltip uses localized string.
- [x] **Localization**:
    - Added `menu.themeToggle.tooltip` to `GET_strings.json`.

### 4. Logic & Persistence
- [x] **Updated `AppRoot`**:
    - Fixed logic to handle `ThemeMode.system` correctly by checking platform brightness.
    - Ensures `appColors.current.*` aliases are synced with the active theme on startup and changes.
- [x] **Verification**:
    - `GET_colors.json` contains all necessary keys for light and dark modes.

## Next Steps for User
1.  **Run Build**: `dart run build_runner build --delete-conflicting-outputs` (Already triggered).
2.  **Verify**:
    - Launch app.
    - Go to Menu.
    - Click Theme Toggle icon.
    - Observe theme change AND console logs (`AppLogger`).
    - Verify Input borders change color correctly in screens like Login/OTP.
