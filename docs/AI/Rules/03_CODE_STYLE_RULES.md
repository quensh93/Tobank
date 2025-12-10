# Code Style and Syntax Rules

## 🎯 Mandatory Rules for Code Style

### Rule 1: Use Strongly-Typed Enums, Not Strings
**Priority**: CRITICAL

**Action Required:**
- **FontWeight**: Use `StacFontWeight.bold`, `StacFontWeight.w400`, etc.
- **Alignment**: Use `StacMainAxisAlignment.center`, `StacCrossAxisAlignment.stretch`
- **Text Direction**: Use `StacTextDirection.rtl`, `StacTextDirection.ltr`
- **Navigation**: Use `NavigationStyle.push`, `NavigationStyle.replace`
- **Method**: Use `Method.get`, `Method.post`

**Examples:**
```dart
// ❌ WRONG
fontWeight: 'bold'
mainAxisAlignment: 'center'
textDirection: 'rtl'

// ✅ CORRECT
fontWeight: StacFontWeight.bold
mainAxisAlignment: StacMainAxisAlignment.center
textDirection: StacTextDirection.rtl
```

**Why**: STAC uses strongly-typed enums for type safety.

---

### Rule 2: Use Objects for Geometry, Not Primitives
**Priority**: CRITICAL

**Action Required:**
- **BorderRadius**: Use `StacBorderRadius.all(12)` or `StacBorderRadius.circular(12)`
- **Offset**: Use `StacOffset(dx: 0, dy: 2)` not `StacOffset(x: 0, y: 2)`
- **EdgeInsets**: Use `StacEdgeInsets.all(16)`, `StacEdgeInsets.symmetric(...)`
- **Size**: Use `StacSize(width: 100, height: 50)`

**Examples:**
```dart
// ❌ WRONG
borderRadius: 12
offset: StacOffset(x: 0, y: 2)

// ✅ CORRECT
borderRadius: StacBorderRadius.all(12)
offset: StacOffset(dx: 0, dy: 2)
```

**Why**: STAC uses objects for geometry properties.

---

### Rule 3: Use Correct TextStyle Classes
**Priority**: CRITICAL

**Action Required:**
- **Custom Style**: Use `StacCustomTextStyle(...)` for explicit styles
- **Alias Style**: Use `StacAliasTextStyle('{{appStyles.*}}')` for style aliases
- **Theme Style**: Use `StacThemeTextStyle(...)` for theme-based styles
- **NEVER**: Use `StacTextStyle(...)` directly (it's abstract)

**Examples:**
```dart
// ❌ WRONG
style: StacTextStyle(
  fontSize: 20,
  fontWeight: StacFontWeight.bold,
)

// ✅ CORRECT - Custom style
style: StacCustomTextStyle(
  fontSize: 20,
  fontWeight: StacFontWeight.bold,
)

// ✅ CORRECT - Alias style (preferred)
style: StacAliasTextStyle('{{appStyles.appbarStyle}}')
```

**Why**: `StacTextStyle` is abstract and cannot be instantiated.

---

### Rule 4: Use Correct Action Classes
**Priority**: CRITICAL

**Action Required:**
- **Navigate**: Use `StacNavigateAction(...)`
- **Network Request**: Use `StacNetworkRequest(...)`
- **Set Value**: Use `StacSetValueAction(...)`
- **Custom Actions**: Use custom action classes (e.g., `StacPersianDatePickerAction`)

**Examples:**
```dart
// ✅ CORRECT
StacNavigateAction(
  request: StacNetworkRequest(
    url: 'https://api.tobank.com/screens/tobank_home',
    method: Method.get,
  ),
  navigationStyle: NavigationStyle.push,
)
```

**Why**: Ensures type safety and correct action execution.

---

### Rule 5: Use Correct Widget Classes
**Priority**: CRITICAL

**Action Required:**
- **Scaffold**: Use `StacScaffold(...)`
- **Container**: Use `StacContainer(...)`
- **Column/Row**: Use `StacColumn(...)`, `StacRow(...)`
- **Text**: Use `StacText(...)`
- **TextFormField**: Use `StacTextFormField(...)`
- **Button**: Use `StacElevatedButton(...)`, `StacTextButton(...)`, etc.

**Examples:**
```dart
// ✅ CORRECT
StacScaffold(
  appBar: StacAppBar(
    title: StacText(data: '{{appStrings.login.title}}'),
  ),
  body: StacColumn(
    children: [
      StacTextFormField(id: 'mobile_number'),
    ],
  ),
)
```

**Why**: STAC widgets have specific classes and properties.

---

### Rule 6: Always Use Variables for Colors
**Priority**: CRITICAL

**Action Required:**
- **NEVER** hardcode hex colors: `'#101828'`
- **ALWAYS** use color variables: `'{{appColors.current.text.title}}'`
- Use `appColors.current.*` for theme-aware colors

**Examples:**
```dart
// ❌ WRONG
color: '#101828'
backgroundColor: '#d61f2c'

// ✅ CORRECT
color: '{{appColors.current.text.title}}'
backgroundColor: '{{appColors.current.button.primary.backgroundColor}}'
```

**Why**: Enables theming and ensures consistency.

---

### Rule 7: Always Use Variables for Strings
**Priority**: CRITICAL

**Action Required:**
- **NEVER** hardcode text: `'اعتبار سنجی'`
- **ALWAYS** use string variables: `'{{appStrings.login.validationTitle}}'`
- Add new strings to `GET_strings.json` if needed

**Examples:**
```dart
// ❌ WRONG
StacText(data: 'اعتبار سنجی')
StacText(data: 'Loading...')

// ✅ CORRECT
StacText(data: '{{appStrings.login.validationTitle}}')
StacText(data: '{{appStrings.common.loading}}')
```

**Why**: Enables localization and consistency.

---

### Rule 8: Use Style Aliases, Not Inline Styles
**Priority**: CRITICAL

**Action Required:**
- **NEVER** define inline style objects in JSON
- **ALWAYS** use style aliases: `'{{appStyles.styleName}}'`
- Define styles once in `GET_styles.json`
- Reference by alias name

**Examples:**
```dart
// ❌ WRONG
StacText(
  style: StacCustomTextStyle(
    color: '{{appColors.current.text.title}}',
    fontSize: 20.0,
    fontWeight: StacFontWeight.w400,
  ),
)

// ✅ CORRECT
StacText(
  style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
)
```

**Why**: Reduces JSON size by ~80% and ensures consistency.

---

### Rule 9: Use Correct Form Field Properties
**Priority**: HIGH

**Action Required:**
- **ID**: Always provide `id` for form fields
- **Validator Rules**: Use `validatorRules` for validation
- **Initial Value**: Use `initialValue` only when needed
- **ReadOnly/Enabled**: Use for date picker fields

**Examples:**
```dart
// ✅ CORRECT
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

**Why**: Ensures form fields work correctly with validation and actions.

---

### Rule 10: Use Correct GestureDetector Properties
**Priority**: HIGH

**Action Required:**
- **Behavior**: Use `behavior: "opaque"` when wrapping disabled widgets
- **OnTap**: Use action objects, not raw JSON
- **Child**: Wrap the widget that should receive taps

**Examples:**
```dart
// ✅ CORRECT - For date picker
StacGestureDetector(
  behavior: StacHitTestBehavior.opaque,
  onTap: StacPersianDatePickerAction(
    formFieldId: 'birthdate',
  ),
  child: StacTextFormField(
    id: 'birthdate',
    readOnly: true,
    enabled: false,
  ),
)
```

**Why**: Ensures gesture detection works correctly.

---

### Rule 11: Use Correct Import Statements
**Priority**: HIGH

**Action Required:**
- **STAC**: `import 'package:stac/stac.dart';`
- **STAC Core**: `import 'package:stac_core/stac_core.dart';`
- **Annotations**: Include `@StacScreen` from stac_core

**Examples:**
```dart
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'tobank_login')
StacWidget tobankLoginDart() {
  // ...
}
```

**Why**: Ensures correct imports for STAC functionality.

---

### Rule 12: Follow Naming Conventions
**Priority**: HIGH

**Action Required:**
- **Dart Functions**: `tobank{FeatureName}Dart()` (e.g., `tobankLoginDart()`)
- **Screen Names**: `tobank_{feature_name}` (e.g., `tobank_login`)
- **File Names**: `{feature_name}.dart` (e.g., `tobank_login.dart`)
- **API Files**: `GET_tobank_{feature_name}.json`

**Why**: Maintains consistency across the project.

---

### Rule 13: Use Correct Padding and Spacing
**Priority**: MEDIUM

**Action Required:**
- Use `StacEdgeInsets` for padding
- Use `StacSizedBox` for spacing
- Match spacing from old tobank reference

**Examples:**
```dart
// ✅ CORRECT
StacPadding(
  padding: StacEdgeInsets.all(16.0),
  child: StacColumn(
    children: [
      StacText(data: 'Title'),
      StacSizedBox(height: 16.0),
      StacText(data: 'Subtitle'),
    ],
  ),
)
```

**Why**: Ensures consistent spacing and layout.

---

### Rule 14: Use Correct Image Properties
**Priority**: MEDIUM

**Action Required:**
- Use `src` for image path
- Reference assets from `assets/` folder
- Use correct path format

**Examples:**
```dart
// ✅ CORRECT
StacImage(
  src: 'assets/icons/back_arrow.svg',
)
```

**Why**: Ensures images load correctly.

---

## 🚨 Common Type Errors to Avoid

1. **String instead of Enum**: `'bold'` → `StacFontWeight.bold`
2. **Primitive instead of Object**: `12` → `StacBorderRadius.all(12)`
3. **Abstract class**: `StacTextStyle` → `StacCustomTextStyle`
4. **Wrong offset params**: `x, y` → `dx, dy`
5. **Hardcoded colors**: `'#101828'` → `'{{appColors.current.*}}'`
6. **Hardcoded strings**: `'Text'` → `'{{appStrings.*}}'`
7. **Inline styles**: Full style object → Style alias

---

## ✅ Code Style Checklist

Before submitting code:

- [ ] All enums used (not strings)
- [ ] All geometry objects used (not primitives)
- [ ] Correct TextStyle classes used
- [ ] Variables used for colors (no hardcoding)
- [ ] Variables used for strings (no hardcoding)
- [ ] Style aliases used (not inline styles)
- [ ] Correct import statements
- [ ] Naming conventions followed
- [ ] RTL text direction set
- [ ] Form fields have IDs

---

**Next**: Read [04_DATA_BINDING_RULES.md](./04_DATA_BINDING_RULES.md) for data binding rules.

