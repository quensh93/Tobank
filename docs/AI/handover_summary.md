# 🐛 Bug Report: Premature Template Resolution in ReactiveElevatedButton

## 📋 Issue Summary
The `promissory_real_payment_deposits_screen.dart` uses a `ReactiveElevatedButton` to trigger a draft creation API call. The request body uses `{{selectedDeposit.depositNumber}}` to reference the currently selected deposit.

**The Problem:** The `{{...}}` templates are being resolved too early (at widget build time or initial parsing) by `StacService.resolveVariablesInJson`. This "bakes in" the deposit ID available at that moment. When the user changes selection, the registry updates, but the button's `onPressed` action still holds the old resolved string.

**Result:** The API call sends stale data (e.g., the initial deposit ID) instead of the user's new selection.

## 🛠️ Attempted Fix (Tunneling Strategy)
We attempted to bypass `StacService` by "tunneling" the `onPressed` action as an escaped string.

### 1. `StatefulWidgetParser` Modification
**File:** `lib/core/stac/parsers/widgets/stateful_widget_parser.dart`
**Change:** In `_resolveExpressionsInJson`, we check for `onPressed` key in `ReactiveElevatedButton` and convert it to a JSON string with escaped templates (`__STAC_OPEN__` instead of `{{`).

```dart
if (isReactiveElevatedButton && _reactiveElevatedButtonProtectedKeys.contains(key)) {
  if (key == 'onPressed') {
    final jsonStr = jsonEncode(value);
    final escaped = jsonStr.replaceAll('{{', '__STAC_OPEN__');
    return MapEntry('rawOnPressed', escaped);
  }
  return MapEntry(key, value);
}
```

### 2. `ReactiveElevatedButtonParser` Modification
**File:** `lib/core/stac/parsers/widgets/reactive_elevated_button_parser.dart`
**Change:** In `fromJson`, detected `rawOnPressed`, decoded it, replaced `__STAC_OPEN__` back to `{{`, and assigned to `onPressed`.

## ❌ Current Status & Failure Analysis
The fix failed. Logs show `hasTemplates=false` in the draft request pre-check, meaning the JSON reaching `CustomNetworkRequestActionParser` still has resolved values (e.g., `110.7007...`) instead of templates.

**Logs Evidence:**
```
I/flutter ( 8564): 🌐 🔍 DRAFT PRE-RESOLVE: sourceAccount=110.7007.1824413.1 ... (hasTemplates=false)
```

**Likely Root Cause:**
The protection logic in `StatefulWidgetParser` relies on `_reactiveElevatedButtonProtectedKeys.contains(key)`. It is highly probable that `'onPressed'` is missing from this list, causing the tunneling block to be skipped entirely, allowing standard recursion to resolve the templates.

## 📍 Next Steps for Agent
1.  **Verify `_reactiveElevatedButtonProtectedKeys`**: Locate this list in `stateful_widget_parser.dart` and ensure `'onPressed'` is included.
2.  **Verify `isReactiveElevatedButton`**: Confirm the type check logic `widgetType == 'reactiveElevatedButton'` works for the deeply nested button.
3.  **Alternative Strategy**: If tunneling proves fragile, consider implementing `StacRawJsonAction` support directly in `CustomNetworkRequestActionParser` or deferring resolution via a `SequencedAction` wrapper that forces a fresh registry lookup.

## 📂 File Locations
-   **StatefulWidgetParser**: `lib/core/stac/parsers/widgets/stateful_widget_parser.dart`
-   **ReactiveElevatedButtonParser**: `lib/core/stac/parsers/widgets/reactive_elevated_button_parser.dart`
-   **Network Parser (Debug Logs)**: `lib/core/stac/parsers/actions/custom_network_request_action_parser.dart`
