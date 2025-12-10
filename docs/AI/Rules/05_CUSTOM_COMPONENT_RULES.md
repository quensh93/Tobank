# Custom Component Rules - Actions & Parsers

## 🎯 Mandatory Rules for Custom Components

### Rule 1: Always Register Custom Components
**Priority**: CRITICAL

**Action Required:**
- Custom actions must be registered in `register_custom_parsers.dart`
- Custom widgets must be registered in `register_custom_parsers.dart`
- Registration happens in `_registerExampleParsers()` function

**Location**: `lib/core/stac/registry/register_custom_parsers.dart`

**Example:**
```dart
void _registerExampleParsers() {
  registerPersianDatePickerActionParser();
  registerCloseDialogActionParser();
  // ... other parsers
}
```

**Why**: Unregistered components won't work in the app.

---

### Rule 2: Follow Custom Action Structure
**Priority**: CRITICAL

**Action Required:**
1. Create Action Model class
2. Create StacAction wrapper class
3. Create Action Parser class
4. Create registration function
5. Register in `_registerExampleParsers()`

**Structure:**
```dart
// 1. Action Model
class CustomActionModel {
  final String requiredParam;
  const CustomActionModel({required this.requiredParam});
  factory CustomActionModel.fromJson(Map<String, dynamic> json) { ... }
}

// 2. StacAction Wrapper
class StacCustomAction extends StacAction {
  final String requiredParam;
  @override
  String get actionType => 'customAction';
}

// 3. Action Parser
class CustomActionParser extends StacActionParser<CustomActionModel> {
  @override
  String get actionType => 'customAction';
  @override
  FutureOr onCall(BuildContext context, CustomActionModel model) async { ... }
}

// 4. Registration
void registerCustomActionParser() {
  CustomComponentRegistry.instance.registerAction(const CustomActionParser());
}
```

**Why**: Ensures consistency and correct integration with STAC.

---

### Rule 3: Use CustomComponentRegistry First
**Priority**: HIGH

**Action Required:**
- Register with `CustomComponentRegistry` first
- Then register with STAC framework in `registerCustomParsers()`
- This allows conflict checking before STAC registration

**Example:**
```dart
// In registration function
void registerCustomActionParser() {
  CustomComponentRegistry.instance.registerAction(const CustomActionParser());
}

// In registerCustomParsers()
final customRegistry = CustomComponentRegistry.instance;
final parser = customRegistry.getActionParser('customAction');
stacRegistry.registerAction(parser);
```

**Why**: Provides two-stage registration for better control.

---

### Rule 4: Override Built-ins When Needed
**Priority**: HIGH

**Action Required:**
- Pass `override: true` when registering to replace built-in parsers
- Use this for custom TextFormField, custom navigation, etc.
- Document why override is needed

**Example:**
```dart
// Override default TextFormField parser
const customTextFormFieldParser = CustomTextFormFieldParser();
stacRegistry.register(customTextFormFieldParser, true); // override: true
```

**Why**: Allows replacing default behavior with custom implementation.

---

### Rule 5: Handle Errors in Custom Actions
**Priority**: HIGH

**Action Required:**
- Always wrap action logic in try-catch
- Log errors with `AppLogger.e()`
- Return null or appropriate value on error
- Don't crash the app

**Example:**
```dart
@override
FutureOr onCall(BuildContext context, CustomActionModel model) async {
  try {
    // Action logic
    return result;
  } catch (e, stackTrace) {
    AppLogger.e('Error in custom action: $e', e, stackTrace);
    return null;
  }
}
```

**Why**: Ensures app stability and helps debugging.

---

### Rule 6: Use TextFormFieldControllerRegistry for Field Updates
**Priority**: HIGH

**Action Required:**
- When custom action needs to update TextFormField value
- Use `TextFormFieldControllerRegistry` to access controller
- Update controller value, which triggers UI refresh

**Example:**
```dart
// In date picker action
final registry = TextFormFieldControllerRegistry.instance;
registry.updateValue('birthdate', selectedDate);
```

**Why**: Allows external actions to update form fields programmatically.

---

### Rule 7: Register Custom TextFormField Parser
**Priority**: HIGH

**Action Required:**
- If you need external field updates (e.g., date picker)
- Register `CustomTextFormFieldParser` to override default
- This registers controllers in `TextFormFieldControllerRegistry`

**Location**: `lib/core/stac/parsers/widgets/custom_text_form_field_parser.dart`

**Why**: Default STAC TextFormField doesn't expose controllers.

---

### Rule 8: Use StacFormScope for Form Data
**Priority**: HIGH

**Action Required:**
- Access form data via `StacFormScope.of(context)`
- Update form data directly: `formScope.formData[fieldId] = value`
- Also update registry: `StacRegistry.instance.setValue('form.{fieldId}', value)`

**Example:**
```dart
final formScope = StacFormScope.of(context);
if (formScope != null) {
  formScope.formData[model.formFieldId] = selectedDate;
  StacRegistry.instance.setValue('form.${model.formFieldId}', selectedDate);
}
```

**Why**: Ensures form data is accessible throughout the form.

---

### Rule 9: Document Custom Components
**Priority**: MEDIUM

**Action Required:**
- Add documentation comments to custom components
- Include usage examples in comments
- Document parameters and behavior
- Add to `docs/AI/CUSTOM_COMPONENTS.md` if significant

**Example:**
```dart
/// Persian Date Picker Action
///
/// Shows a Persian (Jalali) date picker dialog and updates the form field.
///
/// Usage in JSON:
/// ```json
/// {
///   "actionType": "persianDatePicker",
///   "formFieldId": "birthdate",
///   "firstDate": "1350/01/01",
///   "lastDate": "1450/12/29"
/// }
/// ```
```

**Why**: Helps other developers understand and use custom components.

---

### Rule 10: Follow Existing Custom Component Patterns
**Priority**: HIGH

**Action Required:**
- Study existing custom components before creating new ones
- Follow the same structure and patterns
- Use existing examples as templates

**Reference Files:**
- `lib/core/stac/parsers/actions/persian_date_picker_action_parser.dart`
- `lib/core/stac/parsers/widgets/custom_text_form_field_parser.dart`

**Why**: Ensures consistency across custom components.

---

### Rule 11: Check for Conflicts with Built-ins
**Priority**: HIGH

**Action Required:**
- Before registering, check if built-in parser exists
- If conflict, decide whether to override or use different name
- Document decision in code

**Example:**
```dart
// Check for conflict
final existingParser = stacRegistry.getActionParser('customAction');
if (existingParser != null) {
  // Decide: override or skip
  stacRegistry.registerAction(parser, true); // override
}
```

**Why**: Prevents unexpected behavior from conflicts.

---

### Rule 12: Use Correct Action Type Names
**Priority**: MEDIUM

**Action Required:**
- Use camelCase for action types: `persianDatePicker`, `closeDialog`
- Be descriptive and clear
- Avoid conflicts with built-in action types

**Examples:**
```dart
@override
String get actionType => 'persianDatePicker';  // ✅ CORRECT
@override
String get actionType => 'PersianDatePicker';   // ❌ WRONG (capital)
@override
String get actionType => 'persian_date_picker'; // ❌ WRONG (snake_case)
```

**Why**: Maintains consistency with STAC naming conventions.

---

## 🚨 Critical Don'ts for Custom Components

1. **DON'T** forget to register custom components
2. **DON'T** skip error handling
3. **DON'T** forget to use TextFormFieldControllerRegistry for field updates
4. **DON'T** create components without checking existing patterns
5. **DON'T** override built-ins without documenting why
6. **DON'T** skip documentation

---

## ✅ Custom Component Checklist

Before using custom component:

- [ ] Component registered in `register_custom_parsers.dart`
- [ ] Follows correct structure (Model, StacAction, Parser)
- [ ] Error handling implemented
- [ ] Documentation added
- [ ] Tested in app
- [ ] No conflicts with built-ins
- [ ] Uses correct naming conventions

---

## 📋 Custom Component Locations

| Type | Location | Registration |
|------|----------|--------------|
| Custom Actions | `lib/core/stac/parsers/actions/` | `register_custom_parsers.dart` |
| Custom Widgets | `lib/core/stac/parsers/widgets/` | `register_custom_parsers.dart` |
| Registry | `lib/core/stac/registry/` | N/A |
| Utils | `lib/core/stac/utils/` | N/A |

---

**Next**: Read [06_FILE_ORGANIZATION_RULES.md](./06_FILE_ORGANIZATION_RULES.md) for file organization rules.

