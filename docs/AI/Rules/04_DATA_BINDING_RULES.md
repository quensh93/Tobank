# Data Binding Rules - Colors, Styles, Strings

## 🎯 Mandatory Rules for Data Binding

### Rule 1: Always Use Theme-Aware Colors
**Priority**: CRITICAL

**Action Required:**
- **ALWAYS** use `{{appColors.current.*}}` for colors
- **NEVER** use `{{appColors.light.*}}` or `{{appColors.dark.*}}` directly
- Current theme aliases automatically point to correct theme
- Colors update automatically when theme changes

**Examples:**
```dart
// ❌ WRONG
color: '{{appColors.light.text.title}}'
backgroundColor: '{{appColors.dark.button.primary.backgroundColor}}'

// ✅ CORRECT
color: '{{appColors.current.text.title}}'
backgroundColor: '{{appColors.current.button.primary.backgroundColor}}'
```

**Why**: Ensures colors adapt to theme changes without reloading JSON.

---

### Rule 2: Never Hardcode Colors
**Priority**: CRITICAL

**Action Required:**
- **NEVER** use hex color codes directly: `'#101828'`
- **ALWAYS** use color variables: `'{{appColors.current.*}}'`
- Add new colors to `GET_colors.json` if needed

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

### Rule 3: Use Style Aliases, Not Inline Styles
**Priority**: CRITICAL

**Action Required:**
- **NEVER** define inline style objects in JSON
- **ALWAYS** use style aliases: `'{{appStyles.styleName}}'`
- Define styles once in `GET_styles.json`
- Reference by alias name throughout app

**Examples:**
```dart
// ❌ WRONG - Inline style
StacText(
  style: StacCustomTextStyle(
    color: '{{appColors.current.text.title}}',
    fontSize: 20.0,
    fontWeight: StacFontWeight.w400,
  ),
)

// ✅ CORRECT - Style alias
StacText(
  style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
)
```

**In JSON:**
```json
// ❌ WRONG
{
  "style": {
    "type": "custom",
    "color": "{{appColors.current.text.title}}",
    "fontSize": 20.0,
    "fontWeight": "w400"
  }
}

// ✅ CORRECT
{
  "style": "{{appStyles.appbarStyle}}"
}
```

**Why**: Reduces JSON size by ~80% and ensures consistency.

---

### Rule 4: Create Style Aliases in GET_styles.json
**Priority**: CRITICAL

**Action Required:**
1. Define style in `lib/stac/config/GET_styles.json`:
   ```json
   {
     "GET": {
       "statusCode": 200,
       "data": {
         "yourStyleName": {
           "color": "{{appColors.current.text.title}}",
           "fontSize": 16.0,
           "fontWeight": "w600"
         }
       }
     }
   }
   ```
2. Use alias in Dart/JSON: `'{{appStyles.yourStyleName}}'`

**Why**: Centralizes style definitions and reduces JSON size.

---

### Rule 5: Never Hardcode Strings
**Priority**: CRITICAL

**Action Required:**
- **NEVER** hardcode text strings: `'اعتبار سنجی'`
- **ALWAYS** use string variables: `'{{appStrings.*}}'`
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

### Rule 6: Use Correct String Variable Format
**Priority**: HIGH

**Action Required:**
- Use dot notation: `appStrings.{section}.{key}`
- Follow existing organization: `common`, `login`, `menu`, etc.
- Add to appropriate section in `GET_strings.json`

**Examples:**
```dart
// ✅ CORRECT
'{{appStrings.login.validationTitle}}'
'{{appStrings.common.loading}}'
'{{appStrings.menu.appBarTitle}}'
```

**Why**: Maintains organization and makes strings easy to find.

---

### Rule 7: Colors Must Be Loaded Before Styles
**Priority**: CRITICAL

**Action Required:**
- Load colors first: `await TobankColorsLoader.loadColors(dio)`
- Then load styles: `await TobankStylesLoader.loadStyles(dio)`
- Styles resolve color variables during loading

**Initialization Order:**
```dart
await TobankColorsLoader.loadColors(dio);  // First
await TobankStringsLoader.loadStrings(dio);
await TobankStylesLoader.loadStyles(dio);  // After colors
```

**Why**: Styles need colors to resolve `{{appColors.*}}` variables.

---

### Rule 8: Use Form Data Variables Correctly
**Priority**: HIGH

**Action Required:**
- Use `{{form.{fieldId}}}` for form field values
- Field ID must match the `id` property of TextFormField
- Values update automatically when user types

**Examples:**
```dart
// In TextFormField
StacTextFormField(id: 'mobile_number')

// In action or display
'{{form.mobile_number}}'
```

**Why**: Enables dynamic form data access.

---

### Rule 9: Verify Variables Are Loaded
**Priority**: HIGH

**Action Required:**
- Check that loaders are called at startup
- Verify variables resolve correctly
- Test in app to ensure variables work

**Debug:**
```dart
// Check if variable exists
final value = StacRegistry.instance.getValue('appStrings.login.title');
print('Value: $value');
```

**Why**: Ensures data binding works correctly.

---

### Rule 10: Use Individual Style Properties When Needed
**Priority**: MEDIUM

**Action Required:**
- For individual properties, use: `{{appStyles.component.property}}`
- For complete styles, use: `{{appStyles.styleAlias}}`
- Choose based on what you need

**Examples:**
```dart
// Individual property
backgroundColor: '{{appStyles.button.primary.backgroundColor}}'

// Complete style object
style: StacAliasTextStyle('{{appStyles.appbarStyle}}')
```

**Why**: Provides flexibility when only one property is needed.

---

### Rule 11: Don't Resolve Variables Manually
**Priority**: HIGH

**Action Required:**
- **NEVER** manually resolve variables in code
- **ALWAYS** use `{{variable}}` syntax
- Let STAC framework handle resolution

**Examples:**
```dart
// ❌ WRONG
final color = StacRegistry.instance.getValue('appColors.current.text.title');
StacText(style: StacCustomTextStyle(color: color))

// ✅ CORRECT
StacText(style: StacCustomTextStyle(color: '{{appColors.current.text.title}}'))
```

**Why**: STAC framework handles variable resolution automatically.

---

### Rule 12: Add New Variables to Config Files
**Priority**: HIGH

**Action Required:**
- **Colors**: Add to `lib/stac/config/GET_colors.json`
- **Strings**: Add to `lib/stac/config/GET_strings.json`
- **Styles**: Add to `lib/stac/config/GET_styles.json`
- Follow existing structure and naming

**Why**: Maintains organization and ensures variables are available.

---

## 🚨 Critical Don'ts for Data Binding

1. **DON'T** use `{{appColors.light.*}}` or `{{appColors.dark.*}}` directly
2. **DON'T** hardcode colors with hex codes
3. **DON'T** define inline style objects
4. **DON'T** hardcode text strings
5. **DON'T** load styles before colors
6. **DON'T** manually resolve variables
7. **DON'T** forget to add new variables to config files

---

## ✅ Data Binding Checklist

Before using variables:

- [ ] Theme-aware colors used (`appColors.current.*`)
- [ ] No hardcoded colors
- [ ] Style aliases used (not inline styles)
- [ ] No hardcoded strings
- [ ] Correct variable format used
- [ ] Colors loaded before styles
- [ ] Variables verified in app
- [ ] New variables added to config files

---

## 📋 Variable Namespaces Summary

| Namespace | Format | Example | Source |
|-----------|--------|---------|--------|
| Colors | `{{appColors.current.*}}` | `{{appColors.current.text.title}}` | `GET_colors.json` |
| Strings | `{{appStrings.*}}` | `{{appStrings.login.title}}` | `GET_strings.json` |
| Styles | `{{appStyles.*}}` | `{{appStyles.appbarStyle}}` | `GET_styles.json` |
| Form Data | `{{form.*}}` | `{{form.mobile_number}}` | Form fields |

---

**Next**: Read [05_CUSTOM_COMPONENT_RULES.md](./05_CUSTOM_COMPONENT_RULES.md) for custom component rules.

