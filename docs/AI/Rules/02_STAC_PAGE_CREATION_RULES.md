# STAC Page Creation Rules

## 🎯 Mandatory Rules for Creating STAC Pages

### Rule 1: Always Start with Old Tobank Reference
**Priority**: CRITICAL

**Action Required:**
1. Locate corresponding screen in `docs/Archived/.tobank_old/lib/ui/`
2. Study the UI: layout, spacing, colors, text, interactions
3. Note all visual elements and their properties
4. Match exactly when creating STAC page

**Example:**
```
Old: docs/Archived/.tobank_old/lib/ui/signup/view/verify_code_page.dart
New: lib/stac/tobank/login/dart/verify_otp.dart
```

**Why**: Ensures UI consistency with existing app.

---

### Rule 2: Read STAC Widget Documentation
**Priority**: CRITICAL  
**Location**: `docs/App_Docs/stac_docs/`

**Action Required:**
1. Before writing any widget, read its documentation
2. Understand all properties and their types
3. Check examples in documentation
4. Verify correct syntax

**Key Files:**
- `widgets_scaffold.md` - For page structure
- `widgets_textformfield.md` - For form fields
- `widgets_text.md` - For text elements
- `widgets_column.md`, `widgets_row.md` - For layouts

**Why**: Prevents type errors and ensures correct usage.

---

### Rule 3: Use @StacScreen Annotation
**Priority**: CRITICAL

**Action Required:**
- Always use `@StacScreen(screenName: 'tobank_{feature_name}')` annotation
- Screen name must match file name pattern
- Required for `stac build` command

**Example:**
```dart
@StacScreen(screenName: 'tobank_login')
StacWidget tobankLoginDart() {
  // ...
}
```

**Why**: Required for JSON generation.

---

### Rule 4: Always Use RTL Text Direction
**Priority**: CRITICAL

**Action Required:**
- Set `textDirection: StacTextDirection.rtl` on all containers
- Set on `StacColumn`, `StacRow`, `StacText`, etc.
- Required for Persian/RTL layout

**Example:**
```dart
StacColumn(
  textDirection: StacTextDirection.rtl,
  children: [
    StacText(
      data: '{{appStrings.login.title}}',
      textDirection: StacTextDirection.rtl,
    ),
  ],
)
```

**Why**: App is in Persian and requires RTL layout.

---

### Rule 5: Use Style Aliases, Not Inline Styles
**Priority**: CRITICAL

**Action Required:**
- **NEVER** define inline style objects
- **ALWAYS** use style aliases from `GET_styles.json`
- Use `StacAliasTextStyle('{{appStyles.styleName}}')` in Dart
- Use `"style": "{{appStyles.styleName}}"` in JSON

**Example:**
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

### Rule 6: Use Theme-Aware Colors
**Priority**: CRITICAL

**Action Required:**
- **ALWAYS** use `{{appColors.current.*}}` for colors
- **NEVER** use `{{appColors.light.*}}` or `{{appColors.dark.*}}` directly
- Current theme aliases auto-update when theme changes

**Example:**
```dart
// ❌ WRONG
color: '{{appColors.light.text.title}}'

// ✅ CORRECT
color: '{{appColors.current.text.title}}'
```

**Why**: Ensures colors adapt to theme changes automatically.

---

### Rule 7: Use String Variables, Never Hardcode
**Priority**: CRITICAL

**Action Required:**
- **NEVER** hardcode text strings
- **ALWAYS** use `{{appStrings.*}}` variables
- Add new strings to `GET_strings.json` if needed

**Example:**
```dart
// ❌ WRONG
StacText(data: 'اعتبار سنجی')

// ✅ CORRECT
StacText(data: '{{appStrings.login.validationTitle}}')
```

**Why**: Enables localization and consistency.

---

### Rule 8: Follow Exact Folder Structure
**Priority**: CRITICAL

**Action Required:**
```
lib/stac/tobank/{feature_name}/
├── dart/
│   └── {feature_name}.dart
├── json/
│   └── {feature_name}.json (optional)
└── api/
    └── GET_tobank_{feature_name}.json
```

**Naming Rules:**
- Dart file: `{feature_name}.dart` (e.g., `tobank_login.dart`)
- API file: `GET_tobank_{feature_name}.json` (e.g., `GET_tobank_login.json`)
- Screen name: `tobank_{feature_name}` (e.g., `tobank_login`)

**Why**: Maintains project organization and consistency.

---

### Rule 9: Preview Dart Before Building
**Priority**: HIGH

**Action Required:**
1. Create Dart widget
2. Create screen wrapper to preview
3. Navigate to screen in app
4. Verify UI matches old tobank
5. Test interactions
6. Fix any issues in Dart
7. Only then run `stac build`

**Why**: Catches issues early and saves time.

---

### Rule 10: Build JSON After Dart Changes
**Priority**: CRITICAL

**Action Required:**
- After any Dart changes, run `stac build`
- Verify generated JSON in `.build/` folder
- Check that variables are preserved
- Never manually edit generated JSON

**Command:**
```bash
stac build
```

**Why**: Ensures JSON is up-to-date with Dart source.

---

### Rule 11: Create API JSON with Correct Format
**Priority**: CRITICAL

**Action Required:**
1. Copy JSON from `.build/tobank_{feature}.json`
2. Create file: `api/GET_tobank_{feature}.json`
3. Wrap in API response format:
   ```json
   {
     "GET": {
       "statusCode": 200,
       "data": {
         // Paste JSON here
       }
     }
   }
   ```

**Why**: Mock API interceptor expects this format.

---

### Rule 12: Update pubspec.yaml for New Folders
**Priority**: HIGH

**Action Required:**
- When creating new feature folder, add to `pubspec.yaml`:
  ```yaml
  flutter:
    assets:
      - lib/stac/tobank/{feature}/api/
  ```
- Run `flutter pub get` after updating

**Why**: Flutter requires explicit asset folder listing.

---

### Rule 13: Use Correct Property Types
**Priority**: CRITICAL

**Action Required:**
- **Enums, not strings**: Use `StacFontWeight.bold` not `'bold'`
- **Objects, not primitives**: Use `StacBorderRadius.all(12)` not `12`
- **Custom styles**: Use `StacCustomTextStyle` not `StacTextStyle`

**Common Mistakes:**
```dart
// ❌ WRONG
fontWeight: 'bold'
mainAxisAlignment: 'center'
borderRadius: 12

// ✅ CORRECT
fontWeight: StacFontWeight.bold
mainAxisAlignment: StacMainAxisAlignment.center
borderRadius: StacBorderRadius.all(12)
```

**Why**: STAC uses strongly-typed enums and objects.

---

### Rule 14: Use Assets from assets/ Folder
**Priority**: HIGH

**Action Required:**
- Use assets from `assets/` folder (copied from old tobank)
- Reference using asset paths: `assets/icons/icon.svg`
- Don't use paths from old tobank folder

**Example:**
```dart
StacImage(
  src: 'assets/icons/back_arrow.svg',
)
```

**Why**: Assets are bundled from `assets/` folder.

---

### Rule 15: Test in Both Themes
**Priority**: HIGH

**Action Required:**
- Test page in light theme
- Test page in dark theme
- Verify colors adapt correctly
- Verify text is readable in both themes

**Why**: Ensures theme support works correctly.

---

## 🚨 Critical Don'ts for STAC Pages

1. **DON'T** create pages without checking old tobank reference
2. **DON'T** skip reading STAC widget documentation
3. **DON'T** forget `@StacScreen` annotation
4. **DON'T** use LTR text direction
5. **DON'T** define inline style objects
6. **DON'T** use hardcoded colors or strings
7. **DON'T** use `{{appColors.light.*}}` directly
8. **DON'T** edit `.build/` files manually
9. **DON'T** skip preview/testing
10. **DON'T** use wrong property types (strings instead of enums)

---

## ✅ STAC Page Creation Checklist

Before considering a page complete:

- [ ] Old tobank reference checked
- [ ] STAC widget docs read
- [ ] `@StacScreen` annotation added
- [ ] RTL text direction set
- [ ] Style aliases used (not inline styles)
- [ ] Theme-aware colors used
- [ ] String variables used (no hardcoding)
- [ ] Folder structure correct
- [ ] Dart widget previewed
- [ ] `stac build` run successfully
- [ ] API JSON created with correct format
- [ ] `pubspec.yaml` updated (if new folder)
- [ ] Tested in both themes
- [ ] UI matches old tobank exactly

---

**Next**: Read [03_CODE_STYLE_RULES.md](./03_CODE_STYLE_RULES.md) for code style and syntax rules.

