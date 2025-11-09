# Debug Panel and ISpect Toggle Feature Investigation

## Overview

This document details the investigation and implementation of ON/OFF toggle features for both the custom Debug Panel and ISpect's draggable panel. The investigation covered configuration approaches, runtime toggle capabilities, and integration with persistent storage.

## Investigation Context

**Date**: November 2025  
**Objective**: Enable users to toggle Debug Panel and ISpect draggable panel ON/OFF through multiple methods:
1. Launch arguments (highest priority)
2. Persistent settings with UI toggles
3. Runtime toggle via buttons in ISpect's draggable panel

## Key Findings

### 1. Debug Panel Configuration

**File**: `lib/core/config/debug_panel_config.dart`

**Initial Implementation Issue**:
```dart
// ❌ INCORRECT: Always returned true in debug mode
static bool get shouldInitializeByFlag {
  if (kDebugMode) {
    return true; // Always enable in debug mode
  }
  return isEnabledByFlag && environment != 'production';
}
```

**Problem**: Using `bool.fromEnvironment('ENABLE_DEBUG_PANEL')` with `defaultValue: false` cannot distinguish between:
- Flag not set → defaults to `false`
- Flag explicitly set to `false`

This meant `--dart-define=ENABLE_DEBUG_PANEL=false` was ignored in debug mode.

**Solution**: Use `bool.hasEnvironment()` to check if the flag was explicitly set:

```dart
// ✅ CORRECT: Respects explicit false values
static bool get shouldInitializeByFlag {
  const bool wasFlagSet = bool.hasEnvironment('ENABLE_DEBUG_PANEL');
  
  if (kDebugMode) {
    // In debug mode: auto-enable for convenience
    if (!wasFlagSet) {
      // Flag not set: enable by default in debug mode
      return true;
    }
    // Flag was set: use its value
    return isEnabledByFlag;
  }
  
  // In release mode, only enable if explicitly set AND not production
  return isEnabledByFlag && environment != 'production';
}
```

### 2. ISpect Configuration

**File**: `lib/core/config/ispect_config.dart`

Same issue and solution applied to ISpect configuration. Both configs now properly respect `--dart-define` flags.

### 3. Debug Panel Toggle Implementation

#### State Management

**File**: `lib/debug_panel/state/debug_panel_settings_state.dart`

Added persistent setting:
```dart
final bool debugPanelEnabled; // Whether debug panel is visible
```

**Persistence**: Saved in JSON file at `Documents/debug_panel_settings.json`

#### UI Toggle

**File**: `lib/debug_panel/widgets/settings_tab.dart`

Added Switch control in Settings tab:
```dart
Switch(
  value: settings.debugPanelEnabled,
  onChanged: (enabled) {
    controller.setDebugPanelEnabled(enabled);
  },
)
```

#### Runtime Control

**File**: `lib/core/bootstrap/app_root.dart`

Debug Panel visibility controlled via `DebugPanel.enabled` property:
```dart
if (DebugPanelConfig.shouldInitializeByFlag) {
  return DebugPanel(
    enabled: settings.debugPanelEnabled, // Runtime control via settings
    child: materialApp,
  );
}
```

**Architecture**:
- `DebugPanelConfig.shouldInitializeByFlag` → controls whether to wrap app with DebugPanel
- `settings.debugPanelEnabled` → controls visibility of wrapped DebugPanel

### 4. ISpect Draggable Panel Toggle Implementation

#### State Management

Added persistent setting:
```dart
final bool ispectDraggablePanelEnabled; // Whether ISpect draggable panel is visible
```

#### UI Toggle

Added Switch control in Settings tab:
```dart
Switch(
  value: settings.ispectDraggablePanelEnabled,
  onChanged: (enabled) {
    controller.setIspectDraggablePanelEnabled(enabled);
  },
)
```

#### Runtime Control

**File**: `lib/core/bootstrap/app_root.dart`

ISpect panel visibility controlled via `ISpectBuilder.isISpectEnabled`:
```dart
final ispectBuilder = ISpectBuilder(
  isISpectEnabled: settings.ispectDraggablePanelEnabled, // Runtime control
  options: ISpectOptions(
    observer: observer,
    locale: const Locale('en'),
    panelButtons: panelButtons,
  ),
  child: child ?? const SizedBox.shrink(),
);
```

#### Critical Fix: Runtime Updates

**File**: `ispect/packages/ispect/lib/src/features/inspector/src/inspector_builder.dart`

**Issue**: `ISpectBuilder` didn't update when `isISpectEnabled` changed at runtime.

**Solution**: Added `didUpdateWidget` lifecycle method:
```dart
@override
void didUpdateWidget(ISpectBuilder oldWidget) {
  super.didUpdateWidget(oldWidget);
  
  // Update model when widget properties change
  if (oldWidget.isISpectEnabled != widget.isISpectEnabled) {
    model.isISpectEnabled = widget.isISpectEnabled;
  }
  
  if (oldWidget.options != widget.options) {
    model.options = (widget.options ?? model.options).copyWith(
      onShare: widget.options?.onShare,
      onOpenFile: widget.options?.onOpenFile,
    );
  }
  
  if (oldWidget.theme != widget.theme) {
    model.theme = widget.theme ?? model.theme;
  }
}
```

This makes the ISpect panel respond to runtime toggle changes without app restart.

### 5. ISpect Draggable Panel Button Toggle

**File**: `lib/core/config/ispect_config.dart`

Added provider for custom ISpect panel buttons:
```dart
final ispectPanelButtonsProvider = Provider<List<DraggablePanelButtonItem>>((ref) {
  final settings = ref.watch(debugPanelSettingsProvider);
  final controller = ref.read(debugPanelSettingsProvider.notifier);
  
  return [
    DraggablePanelButtonItem(
      icon: settings.debugPanelEnabled ? Icons.bug_report : Icons.bug_report_outlined,
      label: settings.debugPanelEnabled ? 'ON' : 'OFF',
      description: settings.debugPanelEnabled 
          ? 'Debug Panel: ON - Tap to hide' 
          : 'Debug Panel: OFF - Tap to show',
      onTap: (_) {
        controller.setDebugPanelEnabled(!settings.debugPanelEnabled);
      },
    ),
  ];
});
```

**Usage**: Passed to `ISpectOptions.panelButtons` in `app_root.dart`

**Result**: A button appears in ISpect's floating draggable panel that toggles the Debug Panel ON/OFF with clear visual indication.

### 6. Launch Configurations

**File**: `.vscode/launch.json`

Created comprehensive VS Code launch configurations for testing all combinations:

```json
{
  "configurations": [
    {
      "name": "tobank_sdui",
      "args": ["--web-port=9100"]
    },
    {
      "name": "tobank_sdui (Debug Panel OFF)",
      "args": ["--web-port=9100", "--dart-define=ENABLE_DEBUG_PANEL=false"]
    },
    {
      "name": "tobank_sdui (Debug Panel ON)",
      "args": ["--web-port=9100", "--dart-define=ENABLE_DEBUG_PANEL=true"]
    },
    {
      "name": "tobank_sdui (ISpect OFF)",
      "args": ["--web-port=9100", "--dart-define=ENABLE_ISPECT=false"]
    },
    {
      "name": "tobank_sdui (ISpect ON)",
      "args": ["--web-port=9100", "--dart-define=ENABLE_ISPECT=true"]
    },
    {
      "name": "tobank_sdui (Both ON)",
      "args": [
        "--web-port=9100",
        "--dart-define=ENABLE_DEBUG_PANEL=true",
        "--dart-define=ENABLE_ISPECT=true"
      ]
    },
    {
      "name": "tobank_sdui (Both OFF)",
      "args": [
        "--web-port=9100",
        "--dart-define=ENABLE_DEBUG_PANEL=false",
        "--dart-define=ENABLE_ISPECT=false"
      ]
    }
  ]
}
```

**Git Tracking**: Confirmed `.vscode/launch.json` is tracked in Git (not in `.gitignore`)

## Architecture Summary

### Widget Hierarchy

```
App
└── DebugPanel (wraps app if shouldInitializeByFlag)
    └── MaterialApp
        └── ISpectBuilder (wraps content if shouldInitialize)
            └── App Content (HomeScreen, etc.)
```

### Control Flow

**Debug Panel**:
- Launch Args (`ENABLE_DEBUG_PANEL`) → `DebugPanelConfig.shouldInitializeByFlag`
- Persistent Setting → `DebugPanel.enabled`
- Result: Controls whether to wrap app and visibility

**ISpect Draggable Panel**:
- Launch Args (`ENABLE_ISPECT`) → `ISpectConfig.shouldInitialize`
- Persistent Setting → `ISpectBuilder.isISpectEnabled`
- Result: Controls whether to wrap content and panel visibility

### Data Persistence

Settings stored in:
```
Documents/debug_panel_settings.json
```

Contains:
```json
{
  "debugPanelEnabled": true,
  "ispectDraggablePanelEnabled": true,
  // ... other settings
}
```

## Key Learnings

### 1. `bool.hasEnvironment()` vs `bool.fromEnvironment()`

**Problem**: Cannot distinguish between "flag not set" and "flag set to false" with `bool.fromEnvironment()`

**Solution**: Use `bool.hasEnvironment()` to check if flag was explicitly passed:
- Not set → auto-enable in debug mode
- Set to false → disable
- Set to true → enable

### 2. StatefulWidget Lifecycle for Runtime Updates

**Problem**: Passing boolean props to widgets doesn't update when provider state changes

**Solution**: Implement `didUpdateWidget()` in `ISpectBuilder` to react to prop changes

### 3. Two-Layer Control Architecture

- **Layer 1**: Flag-based initialization (controls wrapping)
- **Layer 2**: Settings-based visibility (controls display)

Both layers must be respected for proper functionality.

## Files Modified

### Core Configuration
- `lib/core/config/debug_panel_config.dart` - Fixed flag detection logic
- `lib/core/config/ispect_config.dart` - Fixed flag detection logic, added panel buttons provider
- `lib/core/bootstrap/app_root.dart` - Integrated persistent settings
- `lib/core/bootstrap/bootstrap.dart` - ISpect initialization flow

### State Management
- `lib/debug_panel/state/debug_panel_settings_state.dart` - Added toggle settings
- `lib/debug_panel/widgets/settings_tab.dart` - Added UI toggles

### ISpect Modifications
- `ispect/packages/ispect/lib/src/features/inspector/src/inspector_builder.dart` - Added didUpdateWidget

### Configuration
- `.vscode/launch.json` - Added comprehensive launch configurations

## Testing Results

### ✅ Successfully Tested

1. Launch with "Both OFF" configuration → both panels disabled
2. Launch with default → both panels enabled in debug mode
3. Runtime toggle via Settings tab → panels toggle live
4. Runtime toggle via ISpect button → debug panel toggles live
5. Settings persist across app restarts
6. Launch args override persistent settings
7. `bool.hasEnvironment()` correctly detects flag presence

### ⚠️ Known Issues

None - all functionality working as expected.

## Future Considerations

### Potential Improvements

1. **Separate State Management**: Consider extracting ISpect settings from debug panel settings
2. **UI Feedback**: Add toast notifications when toggling panels
3. **Shortcuts**: Add keyboard shortcuts for quick toggles
4. **Animation**: Add smooth fade in/out animations

### Removal Consideration

**Current Status**: ISpect deeply integrated
- ISpect folder in `.gitignore` (won't be committed)
- ISpect dependencies in `pubspec.yaml`
- ISpect used in Logs, Performance tabs
- ISpect draggable panel as separate feature

**If Removing ISpect**:
- Replace Logs tab with custom implementation
- Replace Performance tab with custom implementation
- Remove ISpect draggable panel toggle setting
- Remove all ISpect imports
- Remove from `pubspec.yaml`
- Provide alternative network logging solution

**Recommendation**: Keep ISpect as optional feature since:
- Tree-shaken in production
- Powerful debugging capabilities
- Already fully integrated
- Folder ignored in Git

## Conclusion

Successfully implemented comprehensive ON/OFF toggle system for both Debug Panel and ISpect draggable panel with:
- ✅ Launch argument control (highest priority)
- ✅ Persistent settings storage
- ✅ UI toggle switches in Settings tab
- ✅ Runtime toggle button in ISpect panel
- ✅ Live updates without app restart
- ✅ Proper flag detection logic
- ✅ Comprehensive launch configurations

All features working correctly and tested thoroughly.

---

**Investigation Date**: November 2025  
**Status**: ✅ COMPLETED  
**All Features Working**: Yes

