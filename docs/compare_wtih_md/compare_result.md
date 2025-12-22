# 📊 Feature Comparison Report: Proposal vs Current Implementation

> **Purpose**: Comprehensive comparison between features mentioned in `flutter_project_proposal.md` and the current Tobank STAC SDUI project implementation.

**Date**: 2025-01-27  
**Project**: Tobank STAC SDUI  
**Comparison Source**: `flutter_project_proposal.md`

---

## 📋 Executive Summary

| Category | Proposal Features | Supported | Partially Supported | Not Supported |
|----------|------------------|-----------|---------------------|---------------|
| State Management | 2 | 0 | 1 | 1 |
| Data Management | 1 | 0 | 1 | 0 |
| Expression Engine | 1 | 1 | 0 | 0 |
| UI Components | 5 | 1 | 2 | 2 |
| Lifecycle | 1 | 0 | 1 | 0 |
| Field Observer | 1 | 0 | 0 | 1 |
| JSON Patch | 1 | 0 | 0 | 1 |
| Actions System | 12 | 0 | 8 | 4 |

**Overall**: The current project uses a different architecture (STAC framework + Riverpod) compared to the proposal's BlocConnector/FormCubit approach. Many features have **equivalent functionality** but implemented differently.

---

## 🔍 Detailed Feature Comparison

### 1. State Management

#### 1.1 BlocConnector ❌ **NOT SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "blocConnector",
  "scope": "user.profile",
  "persist": true,
  "autoPersist": true,
  "autoPersistDebounceMs": 500,
  "mirrorToRegistry": true,
  "historyLimit": 10,
  "initialValues": [
    {"key": "name", "value": ""},
    {"key": "email", "value": ""}
  ],
  "imports": [
    {"scope": "user.settings", "from": "theme", "to": "userTheme"}
  ]
}
```

**Current Implementation:**
- ❌ **BlocConnector does not exist** in the codebase
- ✅ **Alternative**: `StacRegistry` + `StacSetValue` widget for scoped state
- ✅ **Alternative**: Riverpod providers for reactive state management

**Current Approach:**
```json
{
  "type": "setValue",
  "values": [
    {"key": "user.name", "value": ""},
    {"key": "user.email", "value": ""}
  ],
  "child": {
    "type": "form"
  }
}
```

**Differences:**
- No automatic persistence (manual via SharedPreferences if needed)
- No history/undo-redo functionality
- No cross-scope imports
- No debounced auto-persistence
- Simpler key-value storage in `StacRegistry`

**Location in Codebase:**
- `docs/Archived/stac_core/02-state-management.md` - STAC state management docs
- `StacRegistry` - Core STAC framework singleton

---

#### 1.2 FormCubit ❌ **NOT SUPPORTED**

**Proposal Feature:**
```dart
formCubit.setPath("user.name", "احمد");
String name = formCubit.getPath("user.name");
formCubit.update({
  "user.name": "علی",
  "user.email": "ali@example.com"
});
formCubit.copyFrom("user.name", "display.name");
```

**Current Implementation:**
- ❌ **FormCubit does not exist** in the codebase
- ✅ **Alternative**: `StacFormScope` + `StacForm` widget for form state
- ✅ **Alternative**: `TextFormFieldControllerRegistry` for programmatic field access

**Current Approach:**
```dart
// Form state managed via StacFormScope
final formScope = StacFormScope.of(context);
final formData = formScope?.formData;

// Access form values
final name = formData?['fieldId']?.toString();

// Update via registry
StacRegistry.instance.setValue('form.fieldId', 'newValue');
TextFormFieldControllerRegistry.instance.updateValue('fieldId', 'newValue');
```

**Differences:**
- No dedicated FormCubit class
- Form state managed via Flutter's Form widget + StacFormScope
- Path-based access not available (uses field IDs instead)
- No built-in copyFrom functionality

**Location in Codebase:**
- `lib/core/stac/utils/text_form_field_controller_registry.dart`
- `StacFormScope` - STAC framework form scope

---

### 2. Data Management

#### 2.1 Repository Pattern ⚠️ **PARTIALLY SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "cubitAction",
  "action": "repoRead",
  "config": {
    "repository": "api",
    "key": "users/123",
    "targetPath": "user.data"
  }
}
```

**Data Sources in Proposal:**
- API (HTTP requests)
- Hive (NoSQL local database)
- SharedPrefs (simple settings)
- SQLite (relational database)
- Memory (fast in-memory cache)

**Current Implementation:**
- ✅ **Repository Pattern EXISTS** but different implementation
- ✅ Uses **Riverpod + Retrofit** for API layer
- ✅ Uses **fpdart TaskEither** for functional error handling
- ⚠️ **No generic repository registry** like proposal
- ⚠️ **No unified repoRead/repoSave actions** in STAC JSON

**Current Approach:**
```dart
// Repository pattern exists in lib/data/repositories/
class UserRepository {
  final ApiService _apiService;
  
  TaskEither<ApiError, UserModel> getUser(int id) {
    return safeApiCall(() => _apiService.getUser(id));
  }
}

// Used via Riverpod providers
final userRepositoryProvider = Provider((ref) => 
  UserRepository(ref.read(apiServiceProvider))
);
```

**Differences:**
- No `RepoRegistry` with multiple data sources
- No `repoRead`, `repoSave`, `repoQuery` actions in STAC JSON
- Uses Riverpod providers instead of action-based approach
- No Hive, SQLite, or Memory data sources implemented
- API-only implementation currently

**Location in Codebase:**
- `lib/data/repositories/user_repository.dart`
- `lib/data/datasources/api_service.dart`
- `lib/data/providers/api_providers.dart`

**Note**: The proposal's repository actions (`repoRead`, `repoSave`, etc.) would need to be implemented as custom STAC actions to match the proposal's approach.

---

### 3. Expression Engine ✅ **SUPPORTED**

#### 3.1 Basic Expression Evaluation

**Proposal Feature:**
```json
{
  "type": "exprValue",
  "expr": "user.firstName + ' ' + user.lastName",
  "propPath": "text",
  "child": {
    "type": "text"
  }
}
```

**Current Implementation:**
- ✅ **Expression Engine EXISTS** in STAC core
- ✅ `ExpressionResolver` class handles expression evaluation
- ✅ Supports arithmetic, boolean, and string operations
- ✅ Variable resolution via `{{variable}}` syntax

**Current Approach:**
```dart
// ExpressionResolver in STAC core
ExpressionResolver.evaluate('1+1'); // Returns 2
ExpressionResolver.evaluate('5 > 3'); // Returns true
ExpressionResolver.evaluate('"hello" + " world"'); // Returns 'hello world'
```

**Supported Operations:**
- ✅ Arithmetic: `+`, `-`, `*`, `/`, `%`
- ✅ Comparisons: `==`, `!=`, `>`, `<`, `>=`, `<=`
- ✅ Logical: `&&`, `||`
- ✅ String concatenation: `"hello" + "world"`

**Location in Codebase:**
- `docs/Archived/.stac/packages/stac/lib/src/utils/expression_resolver.dart`

**Note**: The proposal mentions more advanced functions (`upper`, `contains`, `startsWith`, `iif`, `toNum`, `toStr`) which may not all be implemented. Basic expression evaluation is supported.

---

### 4. UI Components

#### 4.1 Bind - Data Binding to UI ✅ **SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "textFormField",
  "bind": {
    "path": "user.email",
    "propPath": "controller.text"
  }
}
```

**Current Implementation:**
- ✅ **Bind functionality EXISTS** in STAC framework
- ✅ `bind` property supported on form fields
- ✅ Variable resolution via `{{path}}` syntax
- ✅ Form field binding via `StacFormScope`

**Current Approach:**
```json
{
  "type": "textFormField",
  "id": "email",
  "bind": {
    "path": "user.email",
    "propPath": "controller.text"
  }
}
```

**Location in Codebase:**
- STAC framework core - bind property parsing
- `lib/core/stac/parsers/widgets/custom_text_form_field_parser.dart` - Custom implementation

---

#### 4.2 EventWrapper ⚠️ **PARTIALLY SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "eventWrapper",
  "onTap": {
    "type": "cubitAction",
    "action": "setField",
    "config": {
      "path": "ui.buttonClicked",
      "value": true
    }
  },
  "child": {
    "type": "elevatedButton"
  }
}
```

**Current Implementation:**
- ⚠️ **No dedicated EventWrapper widget**
- ✅ **Alternative**: Actions can be attached directly to widgets
- ✅ `onPressed`, `onTap` properties support actions

**Current Approach:**
```json
{
  "type": "elevatedButton",
  "onPressed": {
    "actionType": "setValue",
    "values": [
      {"key": "ui.buttonClicked", "value": true}
    ]
  },
  "child": {
    "type": "text",
    "data": "کلیک کنید"
  }
}
```

**Differences:**
- No wrapper widget needed - actions attached directly
- Uses `setValue` action instead of `cubitAction.setField`
- Same functionality, different syntax

---

#### 4.3 EnableIfAll ❌ **NOT SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "enableIfAll",
  "conditions": [
    {"path": "user.isLoggedIn", "value": true},
    {"path": "user.role", "value": "admin"}
  ],
  "child": {
    "type": "text",
    "data": "پنل مدیریت"
  }
}
```

**Current Implementation:**
- ❌ **EnableIfAll widget does not exist**
- ✅ **Alternative**: `StacConditional` widget for conditional rendering
- ✅ **Alternative**: Expression-based conditions in templates

**Current Approach:**
```json
{
  "type": "conditional",
  "condition": "{{user.isLoggedIn}} && {{user.role}} == 'admin'",
  "trueChild": {
    "type": "text",
    "data": "پنل مدیریت"
  },
  "falseChild": null
}
```

**Differences:**
- No `enableIfAll` widget with array of conditions
- Uses single expression condition instead
- Multiple conditions must be combined in expression

**Location in Codebase:**
- `StacConditional` - STAC framework conditional widget

---

#### 4.4 ListBuilder ⚠️ **PARTIALLY SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "listBuilder",
  "bind": {
    "path": "products.list"
  },
  "itemBuilder": {
    "type": "card",
    "child": {
      "type": "column",
      "children": [
        {
          "type": "text",
          "bind": {"path": "item.name"}
        }
      ]
    }
  }
}
```

**Current Implementation:**
- ⚠️ **No dedicated ListBuilder widget**
- ✅ **Alternative**: `StacDynamicView` with `itemTemplate` for dynamic lists
- ✅ **Alternative**: `StacListView` with `itemTemplate` for static lists

**Current Approach:**
```json
{
  "type": "dynamicView",
  "request": {
    "url": "https://api.example.com/products",
    "method": "GET"
  },
  "resultTarget": "products",
  "itemTemplate": {
    "type": "card",
    "child": {
      "type": "column",
      "children": [
        {
          "type": "text",
          "data": "{{item.name}}"
        }
      ]
    }
  }
}
```

**Differences:**
- No `listBuilder` widget type
- Uses `dynamicView` with `itemTemplate` instead
- Binds to data from API request, not registry path directly
- Can bind to registry via `setValue` + `dynamicView` combination

**Location in Codebase:**
- `docs/Archived/.stac/packages/stac/lib/src/parsers/widgets/stac_dynamic_view/stac_dynamic_view_parser.dart`

---

#### 4.5 ForEachChildren ❌ **NOT SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "forEachChildren",
  "bind": {
    "path": "navigation.tabs"
  },
  "childTemplate": {
    "type": "tab",
    "text": "{{item.title}}",
    "child": {
      "type": "text",
      "data": "{{item.content}}"
    }
  }
}
```

**Current Implementation:**
- ❌ **ForEachChildren widget does not exist**
- ✅ **Alternative**: `itemTemplate` in `dynamicView` or `listView`
- ✅ **Alternative**: Manual children array generation via expressions

**Current Approach:**
```json
{
  "type": "dynamicView",
  "targetPath": "navigation.tabs",
  "itemTemplate": {
    "type": "tab",
    "text": "{{item.title}}",
    "child": {
      "type": "text",
      "data": "{{item.content}}"
    }
  }
}
```

**Differences:**
- No dedicated `forEachChildren` widget
- Uses `dynamicView` with `itemTemplate` pattern
- Similar functionality but different widget type

---

### 5. Lifecycle Management ⚠️ **PARTIALLY SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "lifecycle",
  "onInit": [
    {
      "type": "cubitAction",
      "action": "repoRead",
      "config": {
        "repository": "api",
        "key": "user/profile",
        "targetPath": "user.data"
      }
    }
  ],
  "onDispose": [
    {
      "type": "cubitAction",
      "action": "clearScope",
      "config": {"scope": "temp"}
    }
  ],
  "child": {
    "type": "userProfileForm"
  }
}
```

**Current Implementation:**
- ❌ **No Lifecycle widget in STAC**
- ✅ **Alternative**: Riverpod `ref.onDispose` for cleanup
- ✅ **Alternative**: Flutter widget lifecycle (`initState`, `dispose`)
- ✅ **Alternative**: `StacSetValue` widget with automatic cleanup

**Current Approach:**
```dart
// In Riverpod providers
@riverpod
Future<UserData> userProfile(Ref ref) async {
  ref.onDispose(() {
    // Cleanup logic
  });
  
  // Load data
  return await loadUserProfile();
}

// In custom widgets
class CustomWidget extends StatefulWidget {
  @override
  void initState() {
    super.initState();
    // Init logic
  }
  
  @override
  void dispose() {
    // Cleanup logic
    super.dispose();
  }
}
```

**Differences:**
- No JSON-based lifecycle widget
- Lifecycle handled at Dart code level
- No `onInit`/`onDispose` actions in STAC JSON
- Riverpod provides lifecycle hooks for providers

**Location in Codebase:**
- `docs/App_Docs/riverpod_docs/docs_concepts2_refs.md` - Riverpod lifecycle
- Flutter widget lifecycle - standard Flutter approach

---

### 6. Field Observer ❌ **NOT SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "fieldObserver",
  "bind": {"path": "user.email"},
  "onUnfocus": [
    {
      "type": "cubitAction",
      "action": "setComputed",
      "config": {
        "path": "validation.emailValid",
        "expr": "contains(user.email, '@')"
      }
    }
  ],
  "onDebounceChange": [
    {
      "type": "cubitAction",
      "action": "repoRead",
      "config": {
        "repository": "api",
        "key": "validate/email/{{user.email}}",
        "targetPath": "validation.emailAvailable"
      }
    }
  ],
  "debounceMs": 500
}
```

**Current Implementation:**
- ❌ **FieldObserver widget does not exist**
- ✅ **Alternative**: Custom `TextFormField` parser with controller registry
- ⚠️ **No built-in debounce or field observation**

**Current Approach:**
```dart
// Custom TextFormField parser can access controller
// But no automatic field observation or debouncing
class CustomTextFormFieldParser extends StacParser<StacTextFormField> {
  // Controller registered in TextFormFieldControllerRegistry
  // Manual observation would need to be implemented
}
```

**Differences:**
- No field observer widget
- No automatic debouncing
- No onUnfocus/onDebounceChange callbacks
- Would need custom implementation

**Location in Codebase:**
- `lib/core/stac/parsers/widgets/custom_text_form_field_parser.dart`
- `lib/core/stac/utils/text_form_field_controller_registry.dart`

---

### 7. JSON Patch ❌ **NOT SUPPORTED**

**Proposal Feature:**
```json
{
  "type": "jsonPatch",
  "patches": [
    {
      "condition": "user.role == 'admin'",
      "patch": {
        "child.decoration.color": "red",
        "child.enabled": true
      }
    }
  ],
  "child": {
    "type": "elevatedButton",
    "child": {"type": "text", "data": "دکمه"}
  }
}
```

**Current Implementation:**
- ❌ **JSON Patch widget does not exist**
- ✅ **Alternative**: Conditional rendering with `StacConditional`
- ✅ **Alternative**: Expression-based property values

**Current Approach:**
```json
{
  "type": "conditional",
  "condition": "{{user.role}} == 'admin'",
  "trueChild": {
    "type": "elevatedButton",
    "style": {
      "backgroundColor": "red"
    },
    "enabled": true,
    "child": {"type": "text", "data": "دکمه"}
  },
  "falseChild": {
    "type": "elevatedButton",
    "child": {"type": "text", "data": "دکمه"}
  }
}
```

**Differences:**
- No JSON patch system
- Must duplicate widgets for different conditions
- No dynamic property patching

---

### 8. Actions System

#### 8.1 Cubit Actions ⚠️ **PARTIALLY SUPPORTED**

**Proposal Actions:**
- `setField` - Set a field value
- `setComputed` - Compute and set a value
- `syncForm` - Sync form between scopes
- `copy` - Copy data between paths
- `clear` - Clear paths
- `undo` - Undo last change
- `redo` - Redo last change

**Current Implementation:**
- ✅ **setValue action EXISTS** (equivalent to `setField`)
- ❌ **setComputed** - Not available (would need custom action)
- ❌ **syncForm** - Not available
- ❌ **copy** - Not available (would need custom action)
- ❌ **clear** - Not available (can use `removeValue` manually)
- ❌ **undo/redo** - Not available (no history system)

**Current Approach:**
```json
{
  "actionType": "setValue",
  "values": [
    {"key": "user.name", "value": "علی"}
  ]
}
```

**Location in Codebase:**
- `lib/core/stac/parsers/actions/custom_set_value_action_parser.dart`

---

#### 8.2 Repository Actions ❌ **NOT SUPPORTED**

**Proposal Actions:**
- `repoRead` - Read from repository
- `repoQuery` - Query repository
- `repoSave` - Save to repository
- `repoDelete` - Delete from repository
- `repoWatch` - Watch repository changes
- `repoUnwatch` - Stop watching

**Current Implementation:**
- ❌ **No repository actions in STAC**
- ✅ **Alternative**: Riverpod providers for data fetching
- ✅ **Alternative**: Custom actions can be created

**Current Approach:**
```dart
// Data fetching via Riverpod
final userData = ref.watch(userProfileProvider);

// Or custom action would need to be implemented
```

**Note**: These actions would need to be implemented as custom STAC actions to match the proposal.

---

## 📊 Summary Table

| Feature | Proposal | Current Status | Notes |
|---------|----------|----------------|-------|
| **BlocConnector** | ✅ | ❌ Not Supported | Use `StacSetValue` + `StacRegistry` instead |
| **FormCubit** | ✅ | ❌ Not Supported | Use `StacFormScope` + `TextFormFieldControllerRegistry` |
| **Repository Pattern** | ✅ Generic Registry | ⚠️ Partial | Riverpod + Retrofit, no generic registry |
| **Expression Engine** | ✅ | ✅ Supported | `ExpressionResolver` in STAC core |
| **Bind** | ✅ | ✅ Supported | `bind` property on form fields |
| **EventWrapper** | ✅ | ⚠️ Partial | Actions attached directly to widgets |
| **EnableIfAll** | ✅ | ❌ Not Supported | Use `StacConditional` with expressions |
| **ListBuilder** | ✅ | ⚠️ Partial | Use `dynamicView` with `itemTemplate` |
| **ForEachChildren** | ✅ | ❌ Not Supported | Use `dynamicView` with `itemTemplate` |
| **Lifecycle** | ✅ | ⚠️ Partial | Riverpod `ref.onDispose`, no JSON lifecycle widget |
| **FieldObserver** | ✅ | ❌ Not Supported | Would need custom implementation |
| **JSON Patch** | ✅ | ❌ Not Supported | Use conditional rendering |
| **Cubit Actions** | ✅ 7 actions | ⚠️ Partial | Only `setValue` exists |
| **Repository Actions** | ✅ 6 actions | ❌ Not Supported | Would need custom implementation |

---

## 🎯 Key Architectural Differences

### 1. State Management Approach

**Proposal:**
- BlocConnector with scoped state, persistence, history
- FormCubit for form-specific state management

**Current:**
- `StacRegistry` singleton for global state
- `StacSetValue` widget for scoped state
- Riverpod providers for reactive state
- `StacFormScope` for form state

### 2. Data Management Approach

**Proposal:**
- Generic `RepoRegistry` with multiple data sources
- Repository actions (`repoRead`, `repoSave`, etc.) in JSON

**Current:**
- Riverpod + Retrofit for API layer
- fpdart TaskEither for error handling
- No generic repository registry
- No repository actions in STAC JSON

### 3. Action System

**Proposal:**
- `cubitAction` with various action types
- Repository actions integrated into JSON

**Current:**
- Custom action parsers (`setValue`, `persianDatePicker`, etc.)
- Actions defined via `actionType` property
- No unified `cubitAction` wrapper

---

## 💡 Recommendations

### High Priority (Core Functionality Gaps)

1. **Implement Repository Actions** - Create custom STAC actions for `repoRead`, `repoSave`, `repoQuery`, etc.
2. **Add Field Observer** - Implement field observation with debouncing for form validation
3. **Add Lifecycle Widget** - Create a STAC widget that supports `onInit` and `onDispose` actions

### Medium Priority (UX Improvements)

4. **Add EnableIfAll Widget** - Simplify conditional rendering with multiple conditions
5. **Add ListBuilder Widget** - Dedicated widget for binding lists from registry
6. **Add JSON Patch** - Dynamic property patching based on conditions

### Low Priority (Nice to Have)

7. **Add History/Undo-Redo** - Implement history system for state management
8. **Add FormCubit-like API** - Create a more convenient form state management API
9. **Add Cross-Scope Imports** - Implement scope import functionality

---

## 📝 Conclusion

The current Tobank STAC SDUI project uses a **different architecture** than the proposal:

- **Proposal**: BlocConnector/FormCubit + Generic Repository Pattern + Action-based JSON
- **Current**: STAC Framework + Riverpod + Custom Actions + Registry-based State

**Key Findings:**
- ✅ Core STAC framework features (expressions, bind, dynamicView) are supported
- ⚠️ Many proposal features have **equivalent functionality** but implemented differently
- ❌ Some advanced features (FieldObserver, JSON Patch, Repository Actions) are missing
- 🔄 The project could be extended to match the proposal's features through custom parsers and actions

**Overall Assessment**: The current implementation provides a solid foundation for server-driven UI, but would benefit from implementing the missing features to match the proposal's comprehensive feature set.

---

**Last Updated**: 2025-01-27  
**Next Steps**: Consider implementing high-priority features to bridge the gap with the proposal.

