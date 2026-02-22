# STAC DSL Rules & Best Practices for AI Agents

This document is the **source of truth** for writing Dart DSL files that the `stac build` CLI can successfully compile into JSON. AI agents must follow these rules strictly when generating or converting SDUI screens for the Tobank project.

---

## The Golden Rule: Stac CLI is an Isolated Dart Environment

The `stac build` command parses your `.dart` files and executes them to generate JSON. 
**Crucially, it executes in an isolated environment that DOES NOT have access to Flutter (`dart:ui`, `BuildContext`, `MaterialApp`).**

If a DSL file imports *anything* that transitively relies on Flutter, the `stac build` CLI will instantly crash with errors like `Method not found` or `Failed to process`.

Additionally, **unused imports** or excessive imports can cause compilation errors if they reference missing files or invalid paths in the isolated environment. Only import exactly what is needed for the screen.

---

## 1. The "Wall of Separation" Architecture

To maintain a clean, scaling architecture while allowing DSL files to use custom components and actions without crashing the compiler, we strictly separate **Builders** from **Parsers**.

### A. The Builders (Pure Dart) - Safe for DSL
**Location:** `lib/core/stac/builders/`

These files contain the data models (`StacWidget`, `StacAction`, `StacTextStyle`). 
- They must **ONLY** import `package:stac_core/stac_core.dart`. 
- They must **NEVER** import `package:flutter/...` or any parser files.

*Example Builder (`sequence_action.dart`):*
```dart
import 'package:stac_core/stac_core.dart';

class StacSequenceAction extends StacAction {
  // Pure Dart properties and logic only
  final List<dynamic> actions;
  
  const StacSequenceAction({required this.actions});

  @override
  String get actionType => 'sequence';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': 'sequence',
    'actions': actions,
  };
}
```

### B. The Parsers (Flutter UI) - Real App Only
**Location:** `lib/core/stac/parsers/`

These files contain the actual Flutter rendering logic (`StacActionParser` or `StacWidgetParser`).
- They **will** import `package:flutter/material.dart`.
- They **will** import the corresponding pure Dart builder from `../builders/`.
- They must **NEVER** be imported into DSL files (`lib/stac/ready_for_build/...`).

*Example Parser (`sequence_action_parser.dart`):*
```dart
import 'package:flutter/material.dart';
import '../../builders/sequence_action.dart'; // Import the pure Dart builder

class SequenceActionParser extends StacActionParser<StacSequenceAction> {
  // Flutter logic with BuildContext
}
```

---

## 2. Using Custom Actions & Widgets in DSL Files

To use custom elements in your DSL files (e.g., `lib/stac/ready_for_build/my_screen.dart`), you must **only import the builders**. 

**DO NOT** use inline mocks unless absolutely necessary for a one-off rapid prototype. The shared `builders` directory is the standard.

**Example (Valid DSL File):**
```dart
import 'package:stac_core/stac_core.dart';
// EXACTLY correct: Importing pure Dart builders using robust package paths
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

@StacScreen(screenName: 'my_screen')
StacWidget myScreen() {
  return StacStatefulWidget( // Brought in from builders
    onInit: StacSequenceAction( // Brought in from builders
      actions: [],
    ),
    child: StacScaffold(
      body: StacText(data: 'Hello'),
    ),
  );
}
```

---

## 3. Registering Custom Components

When creating a *new* custom widget or action, ensure the parser is registered in the app's registry.

1. Create the builder in `lib/core/stac/builders`.
2. Create the parser in `lib/core/stac/parsers`.
3. Register the parser in `lib/core/stac/registry/register_custom_parsers.dart`:
```dart
import '../parsers/actions/my_custom_action_parser.dart';

void registerMyCustomActionParser() {
  CustomComponentRegistry.instance.registerAction(const MyCustomActionParser());
}
```

*Note: You do not need to register simple data-transformers like `StacAliasTextStyle` if the underlying parser handles the `"type"` manually.*

---

## 4. Only Import Required Builders

Do not carelessly copy-paste imports across DSL files. The `stac build` tool can sometimes fail if it attempts to resolve an import that is completely unused or if the path is invalid. 

**Rule:** If your DSL file does not use `StacStatefulWidget`, do not import its builder. If it does not use a custom action, do not import `stac_custom_actions.dart`. Ensure your IDE's "unused import" warnings are resolved before compilation.

---

## 5. Widget Extraction & Reusability in DSL Files

To keep DSL screen files readable and maintainable, follow the extraction pattern:

1. **Avoid Giant Nested Trees:** Do not write the entire screen's UI in a single `StacWidget` return block. 
2. **Extract Private Sub-Widgets:** Break down the screen into logical sections (e.g., `_buildIssuerSection()`, `_buildSubmitButton()`) within the same file. These should return `StacWidget`.
3. **Shared Components:** If a widget is used across multiple screens (e.g., a common `StacAppBar`), extract it completely into a separate file in a `widgets/` subdirectory (e.g., `widgets/promissory_app_bar.dart`) and import it.

**Example (Optimized Structure):**
```dart
@StacScreen(screenName: 'my_screen')
StacWidget myScreen() {
  return StacScaffold(
    appBar: buildPromissoryAppBar(title: 'My Title'), // Imported from widgets/
    body: StacColumn(
      children: [
        _buildHeaderSection(), // Defined below
        _buildFormSection(),   // Defined below
      ],
    ),
  );
}

StacWidget _buildHeaderSection() {
  return StacContainer(...);
}
```

---

## 6. Navigation Actions Must Use Typed STAC Syntax

For navigation, prefer typed STAC actions and avoid raw JSON payloads.

**Required rule:**
- Do not use `StacRawJsonAction({... 'actionType': 'navigate' ...})`.
- Use `StacNavigateAction(...)` instead.

### A. Dart STAC Screen Navigation (Preferred in Tobank flows)

Use `routeName` with the screen name defined in `@StacScreen(screenName: '...')`.

```dart
onTap: StacNavigateAction(
  routeName: 'promissory_real_rules',
  navigationStyle: NavigationStyle.push,
),
```

### B. JSON/Asset Navigation

When navigation intentionally targets an asset JSON file, use typed `assetPath`:

```dart
onPressed: StacNavigateAction(
  assetPath: 'lib/stac/tobank/flows/promissory_real/json/promissory_real_payment.json',
  navigationStyle: NavigationStyle.push,
),
```

### C. When Inside Raw Map Contexts

If you are inside a map/list that expects JSON values, still use typed STAC and convert with `.toJson()`:

```dart
'onPressed': StacNavigateAction(
  routeName: 'promissory_real_sign',
  navigationStyle: NavigationStyle.pushReplacement,
).toJson(),
```

---

## Summary Checklist for AI Agents

When generating, refactoring, or creating DSL files or custom parsers for the Tobank project:

1. [ ] **No Flutter in Builders:** Ensure custom models in `lib/core/stac/builders/` import *only* `package:stac_core/stac_core.dart`. 
2. [ ] **No Parsers in DSL:** Ensure DSL files in `lib/stac/ready_for_build/` **never** import `package:flutter/...` or parser files from `lib/core/stac/parsers/`.
3. [ ] **Use Package Imports:** DSL files should use **package imports** (`package:tobank_sdui/...`) to import builders. This prevents fragile relative paths from breaking when files are copied to the build folder.
4. [ ] **Wall of Separation:** If `stac build` crashes with "Method not found", check if your builder is accidentally exporting a parser or importing flutter code!
5. [ ] **Minimal Imports:** Ensure you only import the specific builder files you are actually using to prevent resolution errors.
6. [ ] **Widget Extraction:** Avoid placing the entire UI tree in one massive function. Extract logical sections into private functions (e.g., `_buildHeader()`) within the same file, and extract shared components (like AppBars) into dedicated files in a `widgets/` directory.
7. [ ] **Naming:** Leave `@StacScreen(screenName: '...')` annotations perfectly intact.
8. [ ] **Typed Navigation Only:** For navigate actions, use `StacNavigateAction` (or `StacNavigateAction(...).toJson()` in map contexts), not `StacRawJsonAction` with `"actionType": "navigate"`.
