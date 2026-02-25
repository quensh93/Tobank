# Converting promissory_real Files to Ready-for-Build (Single-Import & Inline)

This document provides an exact, repeatable procedure to convert files from the source directory into a “ready-for-build” format that uses a single import and inlined helpers.

- Source: `/lib/stac/tobank/flows/promissory_real/dart`
- Destination: `/lib/stac/ready_for_build`
- Reference template: `/lib/stac/ready_for_build_stable`

Goal: Preserve behavior and UI entirely while simplifying dependencies to a single import and inlining minimal helper code inside each file.

---

## Core Principles

- Keep only one import at the top of each file:
  ```dart
  import 'package:stac_core/stac_core.dart';
  ```
- Remove all internal project imports (e.g., `stac_common_builders.dart`) and inline the minimal helper implementations those imports provided at the bottom of the same file.
- Do not change the page function name or the `@StacScreen(screenName: ...)` value.
- Do not modify strings, styles, asset paths, or templated variables (`{{...}}`).
- Copy files to the destination using the same filename; create it if missing, overwrite if present.

---

## Destination Pattern (Single-Import & Inline)

File header:
```dart
import 'package:stac_core/stac_core.dart';
```

If they are used within the page, add these two helpers at the end of the file:

```dart
// Raw JSON action helper
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}

// Alias text style helper
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);

  @override
  StacTextStyleType get type => StacTextStyleType.custom;

  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}
```

Notes:
- Only include these helpers if they are actually referenced in the page.
- If other small helpers are required from removed imports, inline a minimal, file-local version at the end following the same approach.

---

## Conversion Steps for Each File

1) Open the source file.  
2) Remove all imports except `stac_core`, or add it if missing.  
3) Keep the page logic intact:  
   - Do not change the `@StacScreen` annotation or its `screenName`.  
   - Do not change the function signature or name returning `StacWidget`.  
4) Identify any now-unresolved symbols due to removed imports and inline the smallest required implementations at the end of the file.  
   - Use the `StacRawJsonAction` helper for raw navigation/actions.  
   - Use `StacAliasTextStyle` for alias-based text styles.  
5) Save the converted file using the same name under the destination path and overwrite existing.  
6) Re-scan the file to ensure no unresolved references remain.

---

## Naming and Placement Rules

- Preserve original filenames; only transform internals to the Single-Import & Inline pattern.
- Destination path: `/lib/stac/ready_for_build`
- Overwrite destination files if they already exist.

---

## Compatibility Requirements

- Do not alter UI content, text keys, or asset paths.  
- Preserve text directions (`StacTextDirection`) and styles exactly.  
- Keep navigation patterns, validations, and form bindings intact.  
- Only dependency structure changes; behavior must remain identical.

---

## Post-Conversion Validation

- Run the project’s standard static checks if available (e.g., `dart analyze` or project lint/typecheck scripts).  
- Manually verify per file:  
  - Exactly one import remains at the top.  
  - No unresolved references.  
  - Helpers are inlined only when required.

---

## Common Pitfalls and Fixes

- Unresolved symbol after removing internal imports:  
  - Inline a minimal version of that symbol at the end of the file.  
  - Check `ready_for_build_stable` for how similar pages solved it.  
- String/text key mismatches:  
  - Keep strings as in the source file; do not change to match “stable” unless explicitly required.  
- Helper duplication across multiple files:  
  - Acceptable; each file must be self-contained with no internal imports.

---

## Final Checklist

- [ ] Only `import 'package:stac_core/stac_core.dart';` at the top.  
|- [ ] `@StacScreen` and the page function name remain unchanged.  
|- [ ] Required helpers (e.g., `StacRawJsonAction`, `StacAliasTextStyle`) are inlined at the bottom.  
|- [ ] No unresolved references remain.  
|- [ ] File saved with the same name under `/lib/stac/ready_for_build` and overwritten if present.

