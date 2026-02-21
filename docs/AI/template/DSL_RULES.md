# STAC DSL Rules & Best Practices for AI Agents

This document is the **source of truth** for writing Dart DSL files that the `stac build` CLI can successfully compile into JSON. AI agents must follow these rules strictly when generating or converting SDUI screens for the Tobank project.

---

## The Golden Rule: Stac CLI is an Isolated Dart Environment

The `stac build` command parses your `.dart` files and executes them to generate JSON. 
**Crucially, it executes in an isolated environment that DOES NOT have access to Flutter (`dart:ui`, `BuildContext`, `MaterialApp`).**

If a DSL file imports *anything* that transitively relies on Flutter, the `stac build` CLI will instantly crash with errors like `Method not found` or `Failed to process`.

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

## Summary Checklist for AI Agents

When generating, refactoring, or creating DSL files or custom parsers for the Tobank project:

1. [ ] **No Flutter in Builders:** Ensure custom models in `lib/core/stac/builders/` import *only* `package:stac_core/stac_core.dart`. 
2. [ ] **No Parsers in DSL:** Ensure DSL files in `lib/stac/ready_for_build/` **never** import `package:flutter/...` or parser files from `lib/core/stac/parsers/`.
3. [ ] **Use Package Imports:** DSL files should use **package imports** (`package:tobank_sdui/...`) to import builders. This prevents fragile relative paths from breaking when files are copied to the build folder.
4. [ ] **Wall of Separation:** If `stac build` crashes with "Method not found", check if your builder is accidentally exporting a parser or importing flutter code!
5. [ ] **Naming:** Leave `@StacScreen(screenName: '...')` annotations perfectly intact.
