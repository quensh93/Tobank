# Custom Components - Actions & Parsers

## 🎯 Overview

This document explains how to create custom actions and parsers in the Tobank STAC SDUI project. Custom components extend the STAC framework to add project-specific functionality.

## 📋 Types of Custom Components

### 1. Custom Actions
- **Purpose**: Add custom behaviors triggered by user interactions
- **Examples**: Persian date picker, close dialog, custom navigation
- **Location**: `lib/core/stac/parsers/actions/`

### 2. Custom Widget Parsers
- **Purpose**: Override or extend default widget behavior
- **Examples**: Custom TextFormField with controller registry
- **Location**: `lib/core/stac/parsers/widgets/`

## 🔧 Creating Custom Actions

### Step 1: Create Action Model

**File**: `lib/core/stac/parsers/actions/{action_name}_action_parser.dart`

```dart
/// Action Model
class {ActionName}ActionModel {
  final String requiredParam;
  final String? optionalParam;
  
  const {ActionName}ActionModel({
    required this.requiredParam,
    this.optionalParam,
  });
  
  factory {ActionName}ActionModel.fromJson(Map<String, dynamic> json) {
    return {ActionName}ActionModel(
      requiredParam: json['requiredParam'] as String,
      optionalParam: json['optionalParam'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'actionType': '{actionName}',
      'requiredParam': requiredParam,
      if (optionalParam != null) 'optionalParam': optionalParam,
    };
  }
}
```

### Step 2: Create StacAction Wrapper (for Dart usage)

```dart
/// StacAction wrapper for {ActionName}ActionModel
class Stac{ActionName}Action extends StacAction {
  const Stac{ActionName}Action({
    required this.requiredParam,
    this.optionalParam,
  });
  
  final String requiredParam;
  final String? optionalParam;
  
  @override
  String get actionType => '{actionName}';
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': '{actionName}',
      'requiredParam': requiredParam,
      if (optionalParam != null) 'optionalParam': optionalParam,
    };
  }
}
```

### Step 3: Create Action Parser

```dart
/// {Action Name} Action Parser
class {ActionName}ActionParser extends StacActionParser<{ActionName}ActionModel> {
  const {ActionName}ActionParser();
  
  @override
  String get actionType => '{actionName}';
  
  @override
  {ActionName}ActionModel getModel(Map<String, dynamic> json) =>
      {ActionName}ActionModel.fromJson(json);
  
  @override
  FutureOr onCall(BuildContext context, {ActionName}ActionModel model) async {
    // Implementation: Your custom logic here
    try {
      // Do something
      return result;
    } catch (e, stackTrace) {
      AppLogger.e('Error in {actionName} action: $e', e, stackTrace);
      return null;
    }
  }
}
```

### Step 4: Create Registration Function

```dart
/// Register the {action name} action parser
void register{ActionName}ActionParser() {
  CustomComponentRegistry.instance.registerAction(const {ActionName}ActionParser());
}
```

### Step 5: Register in Main Registry

**File**: `lib/core/stac/registry/register_custom_parsers.dart`

Add to `_registerExampleParsers()`:
```dart
void _registerExampleParsers() {
  // ... existing parsers
  register{ActionName}ActionParser();
}
```

### Example: Persian Date Picker Action

**Reference**: `lib/core/stac/parsers/actions/persian_date_picker_action_parser.dart`

**Key Features:**
- Shows Persian date picker dialog
- Updates form field value
- Updates registry with `form.{fieldId}` key
- Updates TextFormField controller via registry

**Usage in JSON:**
```json
{
  "type": "gestureDetector",
  "behavior": "opaque",
  "onTap": {
    "actionType": "persianDatePicker",
    "formFieldId": "birthdate",
    "firstDate": "1350/01/01",
    "lastDate": "1450/12/29"
  },
  "child": {
    "type": "textFormField",
    "id": "birthdate",
    "readOnly": true,
    "enabled": false
  }
}
```

**Usage in Dart:**
```dart
StacGestureDetector(
  onTap: StacPersianDatePickerAction(
    formFieldId: 'birthdate',
    firstDate: '1350/01/01',
    lastDate: '1450/12/29',
  ),
  child: StacTextFormField(id: 'birthdate', readOnly: true),
)
```

## 🎨 Creating Custom Widget Parsers

### Step 1: Create Parser Class

**File**: `lib/core/stac/parsers/widgets/{widget_name}_parser.dart`

```dart
/// Custom {Widget Name} Parser
class Custom{WidgetName}Parser extends StacParser<Stac{WidgetName}> {
  const Custom{WidgetName}Parser();
  
  @override
  String get type => WidgetType.{widgetName}.name;
  
  @override
  Stac{WidgetName} getModel(Map<String, dynamic> json) =>
      Stac{WidgetName}.fromJson(json);
  
  @override
  Widget parse(BuildContext context, Stac{WidgetName} model) {
    return _Custom{WidgetName}Widget(model, StacFormScope.of(context));
  }
}
```

### Step 2: Create Widget Implementation

```dart
class _Custom{WidgetName}Widget extends StatefulWidget {
  final Stac{WidgetName} model;
  final StacFormScope? formScope;
  
  const _Custom{WidgetName}Widget(this.model, this.formScope);
  
  @override
  State<_Custom{WidgetName}Widget> createState() => _Custom{WidgetName}WidgetState();
}

class _Custom{WidgetName}WidgetState extends State<_Custom{WidgetName}Widget> {
  @override
  void initState() {
    super.initState();
    // Custom initialization
  }
  
  @override
  void dispose() {
    // Cleanup
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Build and return widget
    return YourWidget(
      // ... properties
    );
  }
}
```

### Step 3: Register Parser

**File**: `lib/core/stac/registry/register_custom_parsers.dart`

```dart
// Register custom {WidgetName} parser to override the default one
try {
  const custom{WidgetName}Parser = Custom{WidgetName}Parser();
  final success = stacRegistry.register(custom{WidgetName}Parser, true); // override: true
  if (success) {
    AppLogger.i('✅ Registered custom {WidgetName} parser (overriding default)');
  }
} catch (e, stackTrace) {
  AppLogger.e('❌ Failed to register custom {WidgetName} parser: $e\n$stackTrace');
}
```

### Example: Custom TextFormField Parser

**Reference**: `lib/core/stac/parsers/widgets/custom_text_form_field_parser.dart`

**Key Features:**
- Registers `TextEditingController` in registry
- Allows external actions (like date picker) to update field values
- Overrides default STAC `TextFormField` parser

**Why Custom?**
- Default STAC TextFormField doesn't expose controller
- Date picker needs to update field value programmatically
- Registry allows external access to controller

## 📝 Registration System

### CustomComponentRegistry

**Location**: `lib/core/stac/registry/custom_component_registry.dart`

**Purpose**: Central registry for custom components before registering with STAC

**Methods:**
- `registerAction(parser)` - Register custom action parser
- `registerWidget(parser)` - Register custom widget parser
- `getActionParser(type)` - Get action parser by type
- `getWidgetParser(type)` - Get widget parser by type

### Registration Flow

```
1. Create custom parser
   ↓
2. Register with CustomComponentRegistry
   (via register{Name}ActionParser() or register{Name}WidgetParser())
   ↓
3. Register with STAC framework
   (via registerCustomParsers() in register_custom_parsers.dart)
   ↓
4. Available in app
```

## 🔍 Finding Existing Custom Components

### Custom Actions
- **Location**: `lib/core/stac/parsers/actions/`
- **Files**:
  - `persian_date_picker_action_parser.dart`
  - `close_dialog_action_parser.dart`
  - `custom_navigate_action_parser.dart`
  - `custom_set_value_action_parser.dart`

### Custom Widget Parsers
- **Location**: `lib/core/stac/parsers/widgets/`
- **Files**:
  - `custom_text_form_field_parser.dart`
  - `example_card_parser.dart`

### Registration
- **Location**: `lib/core/stac/registry/register_custom_parsers.dart`
- **Function**: `_registerExampleParsers()`

## 🚨 Important Rules

1. **Always register** - Custom components must be registered to work
2. **Override built-ins** - Pass `override: true` to replace default parsers
3. **Use registry** - Use `CustomComponentRegistry` for custom components
4. **Error handling** - Always wrap in try-catch and log errors
5. **Documentation** - Document custom components with examples

## 📚 Related Documentation

- **Persian Date Picker**: `docs/persian_date_picker_implementation.md`
- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`
- **STAC Framework Docs**: `docs/App_Docs/stac_docs/`

---

**Next Steps**: Read [DATA_BINDING_SYSTEM.md](./DATA_BINDING_SYSTEM.md) to understand colors, styles, and strings system.

