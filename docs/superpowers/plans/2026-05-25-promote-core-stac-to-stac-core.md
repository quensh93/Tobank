# Promote lib/core/stac/ to lib/stac_core/ Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Move all files from `lib/core/stac/` → `lib/stac_core/` and update every import across the codebase so the Stac runtime lives in its own top-level module, not buried inside `lib/core/`.

**Architecture:** `lib/stac_core/` becomes a self-contained Stac runtime module (builders, parsers, loaders, registry, services, utils, widgets, mock). Screen DSL files stay in `lib/stac/tobank/`. The 5 remaining `lib/core/` dependencies (logger, bootstrap, config_api, auth_manager, storage_util) are imported into `lib/stac_core/` from `lib/core/` — this direction of dependency is fine and intentional.

**Tech Stack:** Flutter/Dart, Riverpod, Stac framework, manual import-path rewriting

---

## File Structure

**Move entire directory tree** (134 dart files, internal structure unchanged):
```
lib/core/stac/  →  lib/stac_core/
  builders/          builders/
  flow/              flow/
  loaders/tobank/    loaders/tobank/
  mock/              mock/
  parsers/actions/   parsers/actions/
  parsers/widgets/   parsers/widgets/
  registry/          registry/
  services/          services/
    navigation/        navigation/
    path/              path/
    theme/             theme/
    widget/            widget/
  utils/             utils/
  widgets/           widgets/
  default_stac_options.dart
```

**Files with imports to update** (262 external files):
- `lib/core/validation/stac_json_validator.dart`
- `lib/core/widgets/tobank_flow_app_bar.dart`
- `lib/features/pre_launch/presentation/screens/pre_launch_screen.dart`
- `lib/features/stac_test_app/presentation/actions/stac_login_action_parser.dart`
- `lib/features/tobank_mock_new/presentation/screens/tobank_stac_dart_screen.dart`
- `lib/main.dart`
- `lib/stac/tobank/**` (majority — ~250 screen dart files)

**Do NOT touch:**
- `lib/stac/tobank/flows/promissory/service/` (explicitly excluded per user decision)

---

### Task 1: Create lib/stac_core/ directory structure and copy all files

**Files:**
- Create: `lib/stac_core/` (entire directory tree)

- [ ] **Step 1: Copy the directory**

```bash
cp -r lib/core/stac lib/stac_core
```

- [ ] **Step 2: Verify copy succeeded**

```bash
find lib/stac_core -name "*.dart" | wc -l
```
Expected: `134`

- [ ] **Step 3: Verify internal structure matches**

```bash
find lib/stac_core -type d | sort
```
Expected directories: `builders`, `flow`, `loaders/tobank`, `mock`, `parsers/actions`, `parsers/widgets`, `registry`, `services/navigation`, `services/path`, `services/theme`, `services/widget`, `utils`, `widgets`

- [ ] **Step 4: Commit**

```bash
git add lib/stac_core/
git commit -m "chore: copy lib/core/stac to lib/stac_core (pre-migration snapshot)"
```

---

### Task 2: Update package-relative imports inside lib/stac_core/ files

Every file in `lib/stac_core/` that imports another `lib/stac_core/` file currently uses a path like `'package:tobank_sdui/core/stac/...'` or relative `'../...'` paths. After the move, package imports from outside are still `package:tobank_sdui/core/stac/...` — we need them to become `package:tobank_sdui/stac_core/...`. Internal relative imports between `lib/stac_core/` files stay as-is (relative paths don't change inside the module).

**Files:**
- Modify: all `lib/stac_core/**/*.dart` files that use `package:tobank_sdui/core/stac/` self-references

- [ ] **Step 1: Find self-referencing package imports inside stac_core**

```bash
grep -rl "package:tobank_sdui/core/stac/" lib/stac_core/ --include="*.dart"
```

- [ ] **Step 2: Rewrite them**

```bash
find lib/stac_core -name "*.dart" -exec sed -i 's|package:tobank_sdui/core/stac/|package:tobank_sdui/stac_core/|g' {} +
```

- [ ] **Step 3: Verify no old self-references remain**

```bash
grep -rl "package:tobank_sdui/core/stac/" lib/stac_core/ --include="*.dart"
```
Expected: empty output

- [ ] **Step 4: Commit**

```bash
git add lib/stac_core/
git commit -m "chore: fix self-referencing imports inside lib/stac_core/"
```

---

### Task 3: Update imports in lib/main.dart and lib/core/ files

**Files:**
- Modify: `lib/main.dart`
- Modify: `lib/core/validation/stac_json_validator.dart`
- Modify: `lib/core/widgets/tobank_flow_app_bar.dart`

- [ ] **Step 1: Update lib/main.dart**

Find lines like:
```dart
import 'package:tobank_sdui/core/stac/default_stac_options.dart';
// or
import 'core/stac/...';
```
Replace `core/stac/` → `stac_core/` in all import paths in this file.

```bash
sed -i "s|'package:tobank_sdui/core/stac/|'package:tobank_sdui/stac_core/|g" lib/main.dart
sed -i "s|'core/stac/|'../stac_core/|g" lib/main.dart
```

- [ ] **Step 2: Update lib/core/validation/stac_json_validator.dart**

```bash
sed -i "s|'package:tobank_sdui/core/stac/|'package:tobank_sdui/stac_core/|g" lib/core/validation/stac_json_validator.dart
sed -i "s|'../stac/|'../../stac_core/|g" lib/core/validation/stac_json_validator.dart
```

- [ ] **Step 3: Update lib/core/widgets/tobank_flow_app_bar.dart**

```bash
sed -i "s|'package:tobank_sdui/core/stac/|'package:tobank_sdui/stac_core/|g" lib/core/widgets/tobank_flow_app_bar.dart
sed -i "s|'../stac/|'../../stac_core/|g" lib/core/widgets/tobank_flow_app_bar.dart
```

- [ ] **Step 4: Verify**

```bash
grep "core/stac" lib/main.dart lib/core/validation/stac_json_validator.dart lib/core/widgets/tobank_flow_app_bar.dart
```
Expected: empty output

- [ ] **Step 5: Commit**

```bash
git add lib/main.dart lib/core/validation/stac_json_validator.dart lib/core/widgets/tobank_flow_app_bar.dart
git commit -m "chore: update core/stac imports in main.dart and lib/core/ files"
```

---

### Task 4: Update imports in lib/features/ files

**Files:**
- Modify: `lib/features/pre_launch/presentation/screens/pre_launch_screen.dart`
- Modify: `lib/features/stac_test_app/presentation/actions/stac_login_action_parser.dart`
- Modify: `lib/features/tobank_mock_new/presentation/screens/tobank_stac_dart_screen.dart`

- [ ] **Step 1: Bulk rewrite all features/ imports**

```bash
find lib/features -name "*.dart" -exec sed -i 's|package:tobank_sdui/core/stac/|package:tobank_sdui/stac_core/|g' {} +
```

- [ ] **Step 2: Handle any relative imports**

```bash
grep -rn "core/stac" lib/features/ --include="*.dart"
```
If any relative imports remain (e.g., `'../../../../core/stac/...'`), rewrite manually to use `package:tobank_sdui/stac_core/...` — package imports are always safer for cross-module references.

- [ ] **Step 3: Verify clean**

```bash
grep -rl "core/stac" lib/features/ --include="*.dart"
```
Expected: empty output

- [ ] **Step 4: Commit**

```bash
git add lib/features/
git commit -m "chore: update core/stac imports in lib/features/"
```

---

### Task 5: Update imports in lib/stac/tobank/ files (bulk)

This is the largest batch — approximately 250 screen dart files under `lib/stac/tobank/`. All use either package imports or relative imports pointing to `core/stac/`.

**Files:**
- Modify: all `lib/stac/tobank/**/*.dart` EXCEPT `lib/stac/tobank/flows/promissory/service/` (do NOT touch)

- [ ] **Step 1: Rewrite package imports (bulk)**

```bash
find lib/stac/tobank -name "*.dart" \
  ! -path "*/flows/promissory/service/*" \
  -exec sed -i 's|package:tobank_sdui/core/stac/|package:tobank_sdui/stac_core/|g' {} +
```

- [ ] **Step 2: Check for remaining relative imports pointing to core/stac**

```bash
grep -rn "core/stac" lib/stac/tobank/ --include="*.dart" \
  --exclude-dir=service
```

- [ ] **Step 3: Fix any relative imports found in step 2**

Relative imports from `lib/stac/tobank/flows/xyz/dart/screen.dart` to `core/stac/` look like:
```dart
import '../../../../../core/stac/builders/stac_registry.dart';
```
Replace with package form:
```dart
import 'package:tobank_sdui/stac_core/builders/stac_registry.dart';
```

Run:
```bash
find lib/stac/tobank -name "*.dart" \
  ! -path "*/flows/promissory/service/*" \
  -exec sed -i "s|'[.\/]*core/stac/|'package:tobank_sdui/stac_core/|g" {} +
```

- [ ] **Step 4: Verify promissory service NOT touched**

```bash
grep "stac_core\|core/stac" lib/stac/tobank/flows/promissory/service/ --include="*.dart" -r
```
The promissory service files should still reference `core/stac` if they did before, OR have no such imports — either is fine. What matters is they weren't changed.

- [ ] **Step 5: Verify bulk clean**

```bash
grep -rl "core/stac" lib/stac/tobank/ --include="*.dart" | grep -v "promissory/service"
```
Expected: empty output

- [ ] **Step 6: Commit**

```bash
git add lib/stac/tobank/
git commit -m "chore: update core/stac imports in lib/stac/tobank/ screen files"
```

---

### Task 6: Delete lib/core/stac/ and run dart analyze

**Files:**
- Delete: `lib/core/stac/` (entire directory)

- [ ] **Step 1: Confirm no remaining imports of core/stac (outside promissory)**

```bash
grep -rl "core/stac" lib --include="*.dart" | grep -v "promissory/service"
```
Expected: empty output. If not empty, fix those files before deleting.

- [ ] **Step 2: Delete old directory**

```bash
rm -rf lib/core/stac
```

- [ ] **Step 3: Run dart analyze**

```bash
dart analyze lib/
```
Expected: `No issues found!`

If errors appear — they will be `Target of URI doesn't exist` errors. Each error names a file and the bad import. Fix by updating that file's import from `core/stac/...` to `stac_core/...`.

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "chore: delete lib/core/stac/ after migration to lib/stac_core/"
```

---

### Task 7: Update lib/core/bootstrap/app_root.dart and any barrel/export files

Some files may re-export from `core/stac` or reference it in ways not caught by simple grep (e.g., comments, string references in test mocks).

**Files:**
- Modify: `lib/core/bootstrap/app_root.dart` (known to reference stac setup)
- Modify: any barrel export files found

- [ ] **Step 1: Check app_root.dart**

```bash
grep "stac" lib/core/bootstrap/app_root.dart
```

- [ ] **Step 2: Update any remaining references**

```bash
sed -i 's|core/stac/|stac_core/|g' lib/core/bootstrap/app_root.dart
sed -i 's|package:tobank_sdui/core/stac/|package:tobank_sdui/stac_core/|g' lib/core/bootstrap/app_root.dart
```

- [ ] **Step 3: Search for any other stragglers**

```bash
grep -rn "core/stac" lib --include="*.dart" | grep -v "promissory/service"
```
Fix any remaining hits.

- [ ] **Step 4: Final dart analyze**

```bash
dart analyze lib/
```
Expected: `No issues found!`

- [ ] **Step 5: Commit**

```bash
git add -A
git commit -m "chore: finalize stac_core migration — zero analyzer errors"
```

---

### Task 8: Verify and update stac_mock_dio_setup references

`lib/core/bootstrap/app_root.dart` and similar setup files may reference the mock setup that moved to `lib/stac_core/mock/`.

**Files:**
- Modify: any file importing `stac_mock_dio_setup.dart`

- [ ] **Step 1: Find all imports of stac_mock_dio_setup**

```bash
grep -rn "stac_mock_dio_setup" lib --include="*.dart"
```

- [ ] **Step 2: Update each to stac_core path**

For each file found:
```dart
// Old:
import 'package:tobank_sdui/core/stac/mock/stac_mock_dio_setup.dart';
// New:
import 'package:tobank_sdui/stac_core/mock/stac_mock_dio_setup.dart';
```

```bash
find lib -name "*.dart" -exec sed -i 's|package:tobank_sdui/core/stac/mock/|package:tobank_sdui/stac_core/mock/|g' {} +
```

- [ ] **Step 3: Verify**

```bash
grep -rn "core/stac/mock" lib --include="*.dart"
```
Expected: empty

- [ ] **Step 4: Run dart analyze**

```bash
dart analyze lib/
```
Expected: `No issues found!`

- [ ] **Step 5: Commit**

```bash
git add -A
git commit -m "chore: update stac_mock_dio_setup import paths to stac_core"
```

---

## Post-Migration Verification Checklist

After all tasks complete:

```bash
# 1. No stale core/stac imports (except promissory service, which is intentionally untouched)
grep -rn "core/stac" lib --include="*.dart" | grep -v "promissory/service"

# 2. stac_core module exists with all 134 files
find lib/stac_core -name "*.dart" | wc -l

# 3. lib/core/stac does NOT exist
ls lib/core/stac 2>&1

# 4. Zero analyzer errors
dart analyze lib/
```

All four checks should pass before merging.

---

## Notes

- **Promissory service** (`lib/stac/tobank/flows/promissory/service/`) — explicitly excluded from this migration. Leave all files in it unchanged.
- **Relative vs package imports** — prefer converting all cross-module imports to `package:tobank_sdui/stac_core/...` form during this migration. It's explicit and won't break if files move within a module.
- **`.g.dart` files** — Riverpod generated files don't import `core/stac` directly; they reference only their parent file. No action needed.
- **`default_stac_options.dart`** — now at `lib/stac_core/default_stac_options.dart`. Update `lib/main.dart` import accordingly (covered in Task 3).
