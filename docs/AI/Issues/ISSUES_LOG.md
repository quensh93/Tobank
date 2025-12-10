# Issues Log - Tobank STAC SDUI

> **Critical**: Read this log **BEFORE** starting any new task or when facing issues.
> 
> This log tracks all bugs, errors, and solutions encountered during development to avoid repeating mistakes.

---

## 📋 How to Use This Log

1. **Before starting a task**: Search this log for similar issues
2. **When facing an error**: Check if it's documented here
3. **After solving an issue**: Add it to this log for future reference
4. **When stuck**: Review patterns and gotchas section

---

## 🔴 Build Errors & Type Issues

### Bug #1: Incorrect FontWeight Type (String vs Enum)
**Date**: 2025-11-29  
**Phase**: Creating Tobank Menu Screen

**Error**:
```
Error: The argument type 'String' can't be assigned to the parameter type 'StacFontWeight?'.
fontWeight: 'bold',
```

**Root Cause**: 
- Used string `'bold'` instead of enum `StacFontWeight.bold`
- STAC uses strongly-typed enums, not strings

**Solution**:
```dart
// ❌ WRONG
style: StacCustomTextStyle(
  fontWeight: 'bold',  // String - WRONG!
)

// ✅ CORRECT
style: StacCustomTextStyle(
  fontWeight: StacFontWeight.bold,  // Enum - CORRECT!
)
```

**Prevention**: 
- Always check property types (enum, class, or primitive)
- Use `StacFontWeight.bold`, `StacFontWeight.w400`, `StacFontWeight.w600`, etc.

---

### Bug #2: Incorrect TextStyle Class (StacTextStyle vs StacCustomTextStyle)
**Date**: 2025-11-29

**Error**:
```
Error: The argument type 'String' can't be assigned to the parameter type 'StacFontWeight?'.
```

**Root Cause**:
- Used `StacTextStyle()` which is an abstract class
- Should use `StacCustomTextStyle()` for custom styles

**Solution**:
```dart
// ❌ WRONG
style: StacTextStyle(
  fontSize: 20,
  fontWeight: StacFontWeight.bold,
)

// ✅ CORRECT
style: StacCustomTextStyle(
  fontSize: 20,
  fontWeight: StacFontWeight.bold,
)
```

**Prevention**:
- `StacTextStyle` is abstract - use `StacCustomTextStyle` for explicit styles
- Or use `StacThemeTextStyle` for theme-based styles

---

### Bug #3: Incorrect Alignment Types (String vs Enum)
**Date**: 2025-11-29

**Error**:
```
Error: The argument type 'String' can't be assigned to the parameter type 'StacMainAxisAlignment?'.
mainAxisAlignment: 'center',
```

**Root Cause**:
- Used string `'center'` instead of enum `StacMainAxisAlignment.center`

**Solution**:
```dart
// ❌ WRONG
StacColumn(
  mainAxisAlignment: 'center',  // String - WRONG!
  crossAxisAlignment: 'stretch',  // String - WRONG!
)

// ✅ CORRECT
StacColumn(
  mainAxisAlignment: StacMainAxisAlignment.center,  // Enum - CORRECT!
  crossAxisAlignment: StacCrossAxisAlignment.stretch,  // Enum - CORRECT!
)
```

**Prevention**:
- All alignment properties use enums, not strings
- Check `docs/stac/06-widgets.md` for widget property types

---

### Bug #4: Incorrect Offset Parameters (x/y vs dx/dy)
**Date**: 2025-11-29

**Error**:
```
Error: No named parameter with the name 'x'.
offset: StacOffset(x: 0, y: 2),
```

**Root Cause**:
- Used `x` and `y` parameters
- STAC uses `dx` (delta x) and `dy` (delta y) instead

**Solution**:
```dart
// ❌ WRONG
offset: StacOffset(x: 0, y: 2),

// ✅ CORRECT
offset: StacOffset(dx: 0, dy: 2),
```

---

### Bug #5: Incorrect BorderRadius Type (int vs StacBorderRadius)
**Date**: 2025-11-29

**Error**:
```
Error: The argument type 'int' can't be assigned to the parameter type 'StacBorderRadius?'.
borderRadius: 12,
```

**Root Cause**:
- Used plain integer `12` instead of `StacBorderRadius` object

**Solution**:
```dart
// ❌ WRONG
decoration: StacBoxDecoration(
  borderRadius: 12,  // int - WRONG!
)

// ✅ CORRECT
decoration: StacBoxDecoration(
  borderRadius: StacBorderRadius.all(12),  // Object - CORRECT!
  // OR
  borderRadius: StacBorderRadius.circular(12),
)
```

---

### Bug #6: Missing default_stac_options.dart in lib/
**Date**: 2025-11-29

**Error**:
```
[ERROR] Build failed: StacException: Could not find default_stac_options.dart. Run "stac init" first.
```

**Root Cause**:
- File existed in `stac/default_stac_options.dart` but STAC CLI expects it in `lib/`

**Solution**:
- Created `lib/default_stac_options.dart` with same content
- STAC CLI looks for it in `lib/` directory

**Prevention**:
- `default_stac_options.dart` must be in `lib/` root, not in `stac/`

---

### Bug #7: JSON Build Output Location
**Date**: 2025-11-29

**Issue**:
- Expected JSON in `stac/.build/tobank/tobank_menu.json`
- Actual location: `stac/.build/tobank_menu.json` (no subdirectory)

**Root Cause**:
- STAC CLI builds JSON files directly in `.build/` with screen name as filename
- Doesn't preserve directory structure from source

**Solution**:
- Copy from `stac/.build/tobank_menu.json` (not `stac/.build/tobank/tobank_menu.json`)
- Manually organize into subdirectories when copying to final location

**Prevention**:
- Check actual build output location after `stac build`
- Don't assume directory structure is preserved

---

### Bug #8: StacOptions Import Issue (Linter False Positive)
**Date**: 2025-11-29

**Issue**:
- Linter shows error: "The function 'StacOptions' isn't defined"
- But `stac build` command works successfully

**Root Cause**:
- `stac_core` is a transitive dependency (comes with `stac` package)
- Linter/analyzer might not recognize transitive dependencies

**Solution**:
- File is correct as-is
- Use `import 'package:stac_core/core/stac_options.dart';`
- Ignore linter error if build works

**Prevention**:
- If build works, linter error is likely false positive
- Trust the build system over linter for dependency resolution

---

### Bug #9: StacOptions Not Set Error
**Date**: 2025-11-29

**Error**:
```
Exception: StacOptions is not set
#0   _StacView.build (package:stac/src/framework/stac.dart:131:7)
```

**Root Cause**: 
- `Stac.initialize()` was called without passing `StacOptions`

**Solution**:
```dart
// ❌ WRONG
void main() async {
  await Stac.initialize();  // Missing options!
  await bootstrap();
}

// ✅ CORRECT
void main() async {
  await Stac.initialize(
    options: defaultStacOptions,  // Pass options!
  );
  await bootstrap();
}
```

**Prevention**: 
- Always pass `defaultStacOptions` to `Stac.initialize()`

---

### Bug #10: Black Screen When Navigating (routeName vs assetPath)
**Date**: 2025-11-29

**Error**:
- Black screen appears when navigating to screens
- Loading indicator shows, then black screen

**Root Cause**:
- `StacNavigateAction` with `routeName` tries to fetch from STAC Cloud
- `Stac(routeName: 'tobank_login')` calls `StacCloud.fetchScreen()` which fails for local-only development

**Solution**:
```dart
// ❌ WRONG (tries to load from STAC Cloud)
StacNavigateAction(
  routeName: 'tobank_login',
  navigationStyle: NavigationStyle.push,
)

// ✅ CORRECT (loads from local assets)
StacNavigateAction(
  assetPath: 'lib/stac/.build/tobank_login.json',
  navigationStyle: NavigationStyle.push,
)

// OR use request (recommended for mock API)
StacNavigateAction(
  request: StacNetworkRequest(
    url: 'https://api.tobank.com/screens/tobank_login',
    method: Method.get,
  ),
  navigationStyle: NavigationStyle.push,
)
```

**Prevention**: 
- For local-only development, use `assetPath` or `request` instead of `routeName`
- `routeName` is for STAC Cloud deployment

---

### Bug #11: Flutter Asset Subfolders Not Registered
**Date**: 2025-11-29

**Error**:
```
Mock files not found - variables like {{appStrings.login.validationTitle}} showing as literal text
```

**Root Cause**: 
- In `pubspec.yaml`, only the parent folder `stac/api_mock/` was registered
- Flutter's asset bundler does NOT recursively include subfolders
- Files in `stac/api_mock/localization/`, `stac/api_mock/login/`, etc. were not bundled

**Solution**:
```yaml
# ❌ WRONG - only includes files directly in api_mock/, not subfolders
assets:
  - stac/api_mock/

# ✅ CORRECT - explicitly list each subfolder
assets:
  - stac/api_mock/config/
  - stac/api_mock/localization/
  - stac/api_mock/login/
  - stac/api_mock/menu/
  # ... etc
```

**Prevention**: 
- When adding new asset folders, always list each subfolder explicitly
- Run `flutter pub get` after modifying pubspec.yaml

---

### Bug #12: WidgetsFlutterBinding Not Initialized Before rootBundle
**Date**: 2025-11-29

**Error**:
```
Strings not loading - no logs from TobankStringsLoader at startup
Mock interceptor fails silently when rootBundle.loadString() called before bindings initialized
```

**Root Cause**: 
- `main()` was calling `TobankStringsLoader.loadStrings()` before `bootstrap()`
- `bootstrap()` contained `WidgetsFlutterBinding.ensureInitialized()`
- The mock Dio interceptor uses `rootBundle.loadString()` which requires Flutter bindings
- Without bindings, `rootBundle.loadString()` fails silently

**Solution**:
```dart
// main.dart
void main() async {
  // CRITICAL: Initialize Flutter bindings FIRST
  // Required for rootBundle.loadString() in mock interceptor
  WidgetsFlutterBinding.ensureInitialized();
  
  final stacDio = setupStacMockDio();
  await Stac.initialize(options: defaultStacOptions, dio: stacDio);
  await registerCustomParsers();
  await TobankStringsLoader.loadStrings(stacDio);  // Now works!
  await bootstrap();
}
```

**Prevention**: 
- ALWAYS call `WidgetsFlutterBinding.ensureInitialized()` at the very start of `main()`
- Any code using Flutter APIs (rootBundle, SharedPreferences, etc.) needs bindings

---

### Bug #13: TextFormField Not Updating After External Action
**Date**: 2025-01-XX

**Error**:
```
Date picker selects date but TextFormField doesn't show the value
```

**Root Cause**:
- `TextFormField`'s `TextEditingController` not accessible from external actions
- STAC's internal `_TextFormFieldWidgetState` doesn't expose controller
- No mechanism to update controller after date selection

**Solution**:
1. Created `TextFormFieldControllerRegistry` singleton
2. Created `CustomTextFormFieldParser` that registers controllers
3. Date picker action updates controller via registry

**Prevention**:
- Always register custom TextFormField parser if you need external updates
- Use `TextFormFieldControllerRegistry` for controller management

---

### Bug #14: GestureDetector Not Receiving Taps on Disabled Field
**Date**: 2025-01-XX

**Error**:
```
Tap on date input field doesn't trigger date picker
```

**Root Cause**:
- `TextFormField` with `enabled: false` blocks pointer events
- GestureDetector uses default `HitTestBehavior.deferToChild`
- When child doesn't participate in hit testing, GestureDetector doesn't receive events

**Solution**:
```json
{
  "type": "gestureDetector",
  "behavior": "opaque",  // ← Add this!
  "onTap": {
    "actionType": "persianDatePicker",
    "formFieldId": "birthdate"
  },
  "child": {
    "type": "textFormField",
    "enabled": false
  }
}
```

**Prevention**:
- Always use `behavior: "opaque"` when GestureDetector wraps disabled widgets
- This allows GestureDetector to receive taps even when child is disabled

---

### Bug #15: navigateBack Action Not Supported
**Date**: 2025-01-XX

**Error**:
```
! Action type [navigateBack] not supported
```

**Root Cause**:
- `navigateBack` action type not registered in STAC framework
- Need custom action parser to close dialogs

**Solution**:
- Created `CloseDialogActionParser` custom action
- Registered in `register_custom_parsers.dart`
- Use `actionType: "closeDialog"` instead of `"navigateBack"`

**Prevention**:
- Check available action types before using
- Create custom action parser if needed
- Register in `_registerExampleParsers()`

---

### Bug #16: Text Color Not Readable in Input Fields
**Date**: 2025-01-XX

**Error**:
```
Text in input fields is very light gray, hard to read
```

**Root Cause**:
- `textStyleColor` was set to `{{appColors.current.background.onSurface}}`
- This color (`#efefef`) is very light and not readable on light backgrounds

**Solution**:
- Changed to `{{appColors.current.text.title}}` in `GET_styles.json`
- Light theme: `#101828` (dark, readable)
- Dark theme: `#f9fafb` (light, readable)

**Prevention**:
- Always use readable text colors
- Test in both light and dark themes
- Use `appColors.current.text.title` for primary text

---

## 🟡 Common Patterns & Gotchas

### Pattern #1: Color Usage
**Issue**: How to specify colors in STAC

**Solution**:
```dart
// StacColor is a typedef for String
// Use hex strings directly:
color: '#1976D2'  // ✅ CORRECT

// OR use data binding:
color: '{{appColors.current.text.title}}'  // ✅ CORRECT (theme-aware)
```

---

### Pattern #2: Navigation Actions
**Issue**: How to navigate between screens

**Solution**:
```dart
// Use request (recommended for mock API)
StacNavigateAction(
  request: StacNetworkRequest(
    url: 'https://api.tobank.com/screens/tobank_login',
    method: Method.get,
  ),
  navigationStyle: NavigationStyle.push,
)

// OR use assetPath (for local development)
StacNavigateAction(
  assetPath: 'lib/stac/.build/tobank_login.json',
  navigationStyle: NavigationStyle.push,
)
```

---

### Pattern #3: Form Validation
**Issue**: Making form fields required

**Solution**:
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

---

### Pattern #4: Date Picker Integration
**Issue**: Integrating Persian date picker with TextFormField

**Solution**:
1. Wrap TextFormField in GestureDetector with `behavior: "opaque"`
2. Set TextFormField `enabled: false` and `readOnly: true`
3. Use `persianDatePicker` action in GestureDetector's `onTap`
4. Register `CustomTextFormFieldParser` to enable controller updates

---

## 📚 Key Lessons Learned

1. **STAC uses strongly-typed enums, not strings**
   - FontWeight: `StacFontWeight.bold` not `'bold'`
   - Alignment: `StacMainAxisAlignment.center` not `'center'`
   - Navigation: `NavigationStyle.push` not `'push'`

2. **Always use StacCustomTextStyle for explicit styles**
   - `StacTextStyle` is abstract
   - Use `StacCustomTextStyle` for custom properties

3. **Geometry objects are classes, not primitives**
   - `StacBorderRadius.all(12)` not `12`
   - `StacOffset(dx: 0, dy: 2)` not `StacOffset(x: 0, y: 2)`

4. **Read docs BEFORE implementing**
   - Saves time debugging
   - Prevents type errors
   - Ensures correct API usage

5. **STAC project structure matters**
   - `default_stac_options.dart` in `lib/`, not `stac/`
   - Follow structure from documentation

6. **Always initialize Flutter bindings first**
   - `WidgetsFlutterBinding.ensureInitialized()` must be first in `main()`
   - Required for any Flutter API usage (rootBundle, etc.)

7. **Use theme-aware colors**
   - Always `{{appColors.current.*}}` not `{{appColors.light.*}}`
   - Automatically adapts to theme changes

8. **Mock API file structure**
   - List each subfolder explicitly in `pubspec.yaml`
   - Flutter doesn't recursively include subfolders

9. **Navigation for local development**
   - Use `request` or `assetPath`, not `routeName`
   - `routeName` is for STAC Cloud deployment

10. **Custom components need registration**
    - Always register in `register_custom_parsers.dart`
    - Call registration function in `_registerExampleParsers()`

---

## 🔍 How to Avoid These Bugs

1. **Before writing any STAC code**:
   - Read the widget/action documentation
   - Check examples in existing code
   - Understand property types (enum, class, or primitive)

2. **When you get a build error**:
   - Read the error message carefully
   - Check the STAC docs for that specific widget/action
   - Verify the type (enum, class, or primitive)
   - Search this issues log for similar errors

3. **Before using a new widget**:
   - Search documentation for that widget
   - Read the properties table
   - Check the example JSON
   - Understand the Dart API

4. **When facing runtime issues**:
   - Check if initialization order is correct
   - Verify all loaders are called
   - Check if custom parsers are registered
   - Review this issues log for similar problems

---

## 📝 Template for New Bugs

When documenting a new bug, use this format:

### Bug #X: [Brief Description]
**Date**: YYYY-MM-DD  
**Phase**: [Which phase/task]

**Error**:
```
[Paste the exact error message]
```

**Root Cause**: 
- [Why did this happen?]
- [What was misunderstood?]

**Solution**:
```dart
// ❌ WRONG
[Wrong code]

// ✅ CORRECT
[Correct code]
```

**Prevention**: 
- [How to avoid this in the future]
- [Which docs to read]

**Related Files**:
- [List files affected]

---

### Bug #17: Date Picker TextFormField Value Not Displaying
**Date**: 2025-01-XX

**Error**:
```
Date picker selects date but TextFormField shows raw binding {{form.birthdate}}
```

**Root Cause**:
- TextFormField initialized with `initialValue: '{{form.birthdate}}'`
- When formData updates, TextFormField doesn't rebuild
- Controller not accessible to update programmatically

**Solution**:
1. Remove `initialValue` from TextFormField (don't use binding)
2. Register TextFormField controller in `TextFormFieldControllerRegistry`
3. Date picker action updates controller via registry
4. Controller updates trigger UI refresh automatically

**Prevention**:
- Don't use `initialValue` with bindings for fields that get updated externally
- Always register controllers if external actions need to update them
- Use `TextFormFieldControllerRegistry` for controller management

---

### Bug #18: Persian Date Picker Not Fully Localized
**Date**: 2025-01-XX

**Error**:
```
Date picker shows "Select date", "Sun, Dec Y", "November 2025" in English
```

**Root Cause**:
- `showPersianDatePicker` needs Persian localization context
- App-level locale not sufficient for dialog
- Dialog builder needs explicit Localizations wrapper

**Solution**:
```dart
showPersianDatePicker(
  context: context,
  // ... other params
  builder: (BuildContext context, Widget? child) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Localizations(
        locale: const Locale('fa', 'IR'),
        delegates: const [
          PersianMaterialLocalizations.delegate,
          PersianCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: child ?? const SizedBox.shrink(),
      ),
    );
  },
)
```

**Prevention**:
- Always wrap date picker in Localizations with Persian delegates
- Use Directionality with RTL for proper layout
- Prioritize Persian delegates before global delegates

---

**Last Updated**: 2025-01-XX  
**Total Bugs Documented**: 18
