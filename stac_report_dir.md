# `lib/core/stac` — Structure & Organization Report

Scope: **`lib/core/stac` only** (runtime STAC layer — 136 files). DSL/screen tree `lib/stac` excluded per request.
Reference: Stac SDUI conventions (docs.stac.dev — `StacParser`, `StacActionParser`, `StacAction`, `StacWidget`).
Mode: analysis only. No files changed.

---

## 1. What This Folder Is

`lib/core/stac` is the **runtime extension layer** for the Stac framework — the Dart code that teaches Stac how to render Tobank-specific widgets and run Tobank-specific actions. It does NOT contain screens (those live in `lib/stac`).

Current top-level layout:

```
lib/core/stac/
├── default_stac_options.dart      # STAC CLI build config
├── actions/                       # action BUILDERS (StacAction subclasses → toJson)
├── builders/                      # widget/action builder helpers
├── compat/                        # stac_registry mock (DSL-build shim)
├── flow/                          # FlowManager (multi-step flow engine)
├── loaders/tobank/                # theme/color/string/style/asset/version loaders
├── mock/                          # mock Dio setup
├── parsers/
│   ├── actions/                   # ~70 action PARSERS (StacActionParser → onCall)
│   └── widgets/                   # ~30 widget PARSERS (StacParser → parse)
├── registry/                      # custom registry + registration + widget loader
├── services/                      # navigation, path, signing, theme, widget
└── utils/                         # resolvers, registries, web stubs
```

**Verdict:** layering by responsibility (parsers / registry / services / loaders / utils) is fundamentally sound and matches Stac's recommended `lib/app/parsers/{widgets,actions}` split. Parser implementations are correct: they extend `StacParser<T>` / `StacActionParser<T>` with proper `type`/`actionType` + `getModel` + `parse`/`onCall`. The problems are **concentration (god files), duplication (3-piece-per-action), inconsistency (no single convention), and cross-tree coupling** — not the overall shape.

---

## 2. Critical Issues

### C1 — The "three pieces per action" duplication
Every custom action is defined up to **three times**:

| Piece | Class | Location | Job |
|-------|-------|----------|-----|
| Builder | `StacXAction extends StacAction` | `actions/stac_custom_actions.dart` (or `actions/*.dart`) | emit JSON from DSL |
| Model | `XActionModel` | `parsers/actions/x_parser.dart` (or `*_action_model.dart`) | parse JSON at runtime |
| Parser | `XActionParser extends StacActionParser` | `parsers/actions/x_parser.dart` | execute (`onCall`) |

Concrete proof — `showThemeSelectorBottomSheet`:
- Builder `StacShowThemeSelectorBottomSheetAction` in [stac_custom_actions.dart](lib/core/stac/actions/stac_custom_actions.dart) defines defaults `'ظاهر برنامه را انتخاب کنید'`, `'حالت روز'`, …
- Model `ShowThemeSelectorBottomSheetActionModel` in [show_theme_selector_bottom_sheet_action_parser.dart](lib/core/stac/parsers/actions/show_theme_selector_bottom_sheet_action_parser.dart) **repeats the exact same Persian default strings**.

Two copies of the same field set + same defaults = guaranteed drift. Change a default in one, forget the other, and DSL-emitted JSON disagrees with runtime parsing.

### C2 — `actions/stac_custom_actions.dart` is a 1041-line god file
One file holds ~30 unrelated action builders: generic infra (`sequence`, `log`, `networkRequest`, `setValue`) mixed with deeply business-specific ones (`showGiftCardPlanSelectorBottomSheet`, `showBankAddressBottomSheet`, `showDeleteAccountConfirmBottomSheet`). It also carries:
- Hardcoded Persian copy + business constants (e.g. `minAmount = 1000000`, `maxAmount = 50000000`, full paragraphs of legal text).
- A `permenent` typo kept alive via `@Deprecated` shim.
- A `@Deprecated` `StacShowMobileBankServicesBottomSheetAction`.

Business copy and amounts do not belong in the core runtime layer — they belong in DSL/config.

### C3 — `actions/` builder placement has no rule
Most builders live in the `stac_custom_actions.dart` mega-file, but a handful have their own file: `close_dialog_action.dart`, `amount_to_words_action.dart`, `format_number_action.dart`, `format_date_action.dart`, `stac_finger_print_action.dart`, `stac_promissory_sign_action.dart`. No discernible criterion for which gets its own file. The barrel (`export` lines at top of `stac_custom_actions.dart`) only re-exports two of them — inconsistent.

### C4 — `registry/register_custom_parsers.dart` is a 750-line manual registrar
- 100 imports + giant hand-maintained `_registerExampleParsers()` — merge-conflict hotspot.
- **Misnamed:** `_registerExampleParsers()` registers ALL production parsers, not examples.
- **Two registration conventions** mixed: free functions `registerFooParser()` vs `CustomComponentRegistry.instance.registerAction(const FooParser())`. Pick one.
- **Dead code:** commented-out `registerThemeToggleActionParser` + TODO (suggests `theme_toggle_action_model.dart` / `theme_toggle_action_parser.dart` are orphaned).
- **Duplicated override list:** the `type == 'image' || 'visibility' || 'stateful' || …` block appears twice.
- **Cross-tree import:** line 29 imports `promissory_login_action_parser.dart` from the `lib/stac` DSL tree — one parser lives outside its 70 siblings.

### C5 — `registry/stac_widget_loader.dart` is a 630-line hardcoded screen map
A static `Map<String, Function>` of ~130 entries, each importing a screen builder deep inside `lib/stac/tobank/...`. This is the **single largest cross-tree coupling point** — the runtime layer hard-depends on nearly every DSL screen file.
- Doc-comment claims "Open/Closed Principle — new types without modifying this class," but in practice every new screen requires editing this map. The claim is false.
- Contains stale/by-string paths to a `login_flow/` directory (lines ~309–321) that may no longer exist.

### C6 — `services/signing/external_signer.dart` is empty (0 bytes) — ✅ RESOLVED (2026-05-30)
Was a dead 0-byte file. Deleted.

---

## 3. Moderate Issues

### M1 — `parsers/actions/` is a flat ~70-file dir
No domain grouping. `gift_card`, `transfer`, `profile`, `promissory`, `biometric`, and generic actions all sit in one directory.
**Resolution (2026-05-30): keep flat by type — NOT a defect to fix.** Feature subfolders rejected (boundary ambiguity + 100-import churn, no behavior gain). Navigation handled by filename search. Any logical grouping lives in the split registrar (#4), not the file tree. See §5.

### M2 — Model-file placement inconsistent
Only 5 actions get a separate `*_action_model.dart` (`biometric_register`, `file_picker`, `finger_print`, `persian_date_picker`, `theme_toggle`); the rest inline the model in the parser file. `stateful_widget_model.dart` sits in `parsers/widgets/` next to parsers. Models are scattered with no rule.

### M3 — `compat/stac_registry.dart` shadows the real `StacRegistry`
A mock `StacRegistry` (for DSL build without Flutter) shares the exact class name with `package:stac`'s real one, re-exported through `builders/stac_common_builders.dart`. Name collision is a comprehension trap. Rename (e.g. `DslBuildRegistryStub`) or isolate it under a clearly-named build-only path.

### M4 — Business specifics leak into generic services
[stac_widget_resolver.dart](lib/core/stac/services/widget/stac_widget_resolver.dart) hardcodes feature paths/keys (`dashboard_shell`, `ipaam.builder.form.form.deposit_more_intro`, `deposit_turnover_intro`) into a "generic" resolver via `_shouldSingleParse*` predicates. Each new screen needing single-parse caching forces a core edit. Make it a JSON/widget flag (e.g. `keepAlive: true`) read from the payload instead.

### M5 — `utils/variable_resolver.dart` heuristics are fragile
Type-preservation relies on substring sniffing of variable names (`contains('mobile')`, `endsWith('code')`, `contains('color')` carve-outs). Works, but brittle and hard to reason about. Document the contract or drive it from explicit type hints in the JSON.

### M6 — `builders/` vs `actions/` overlap
`builders/stac_common_builders.dart` holds widget builders AND some action builders (`StacShowResultAction`, `StacSaveFileAction`, `StacShareTextAction`, …), while `actions/` also holds action builders. Two homes for the same category.

---

## 4. Naming — Mostly Good

- Parser files `snake_case_parser.dart` → `PascalCaseParser`. Consistent. ✅
- `type` / `actionType` strings camelCase (`tobankBannerCarousel`, `showThemeSelectorBottomSheet`). Matches Stac JSON convention. ✅
- Tobank widgets prefixed `tobank_`. Good namespacing. ✅
- Inconsistencies: model-file suffix used unevenly (M2); a couple action files prefixed `stac_` (`stac_finger_print_action.dart`) while most are not.

---

## 5. Suggested Target Structure

**Decision (2026-05-30):** keep the **flat, type-based** layout (`parsers/{actions,widgets}`) — do NOT split into feature folders.

Rationale:
- Boundary ambiguity — cross-domain actions (e.g. `showGiftCardPaymentAccountsBottomSheet`) have no clear single feature home; every ambiguous file becomes a judgment call.
- Moving ~100 files across feature folders rewrites ~100 import paths for pure layout taste = churn risk, no behavior gain.
- Flat-by-type already matches the Stac convention (`lib/app/parsers/{widgets,actions}`) and is `Ctrl+P`-navigable by filename.
- The real debt is **concentration (god files)** and **triplication (C1)**, not folder layout — those are bad regardless of where files sit.

Grouping, where wanted, lives in the **registrar** (split into per-feature register functions, #4), NOT in the file tree.

```
lib/core/stac/
├── default_stac_options.dart
├── stac.dart                          # single barrel (public API of this layer)
│
├── registry/
│   ├── custom_component_registry.dart
│   └── registration/                  # split the 750-line registrar (grouping lives HERE)
│       ├── register_all.dart          # calls the per-group registrars
│       ├── register_core_actions.dart
│       ├── register_gift_card.dart
│       ├── register_transfer.dart
│       ├── register_profile.dart
│       ├── register_promissory.dart
│       └── register_widgets.dart
│
├── parsers/                           # KEEP flat, by type (not by feature)
│   ├── actions/                       # all action parsers (+ their inline models)
│   └── widgets/                       # all widget parsers
│
├── actions/                           # action BUILDERS (break up the god file, keep flat)
├── builders/                          # widget builders
├── flow/                              # FlowManager (fine as-is)
├── loaders/tobank/                    # fine as-is
├── services/                          # navigation, path, theme, signing(empty deleted), widget
├── mock/
├── compat/                            # StacRegistry shadow is intentional — keep (see #6)
└── utils/
```

### Per-action consolidation (kills C1)
Independent of folder layout: keep one file per action holding all three pieces, with **defaults defined once** and shared between builder and model:

```dart
// parsers/actions/show_theme_selector_bottom_sheet.dart
class _Defaults {
  static const title = 'ظاهر برنامه را انتخاب کنید';
  static const light = 'حالت روز';
  // single source of truth
}
class StacShowThemeSelectorBottomSheetAction extends StacAction { /* uses _Defaults */ }
class ShowThemeSelectorBottomSheetModel { /* uses _Defaults */ }
class ShowThemeSelectorBottomSheetParser extends StacActionParser<...> { /* onCall */ }
```

---

## 6. Usage Map (verified via grep across `lib/`)

Importer counts measured against the whole `lib/` tree (so DSL screens in `lib/stac` are included — they are the main consumers of the builder files).

| File | Importers | Who / notes | Status |
|------|-----------|-------------|--------|
| `services/signing/external_signer.dart` | **0** | no reference anywhere (also 0 bytes) | ✅ **DELETED 2026-05-30** |
| `parsers/actions/theme_toggle_action_parser.dart` | **0** | only appeared in a commented-out line in `register_custom_parsers.dart` | ✅ **DELETED 2026-05-30** |
| `parsers/actions/theme_toggle_action_model.dart` | 1 | imported only by its own (orphan) parser | ✅ **DELETED 2026-05-30** |
| `StacShowMobileBankServicesBottomSheetAction` (`@Deprecated`) | 1 | `show_bottom_sheet_action_parser.dart` | ✅ **DELETED 2026-05-30** (verified 0 DSL/JSON usage; screen already uses `showBottomSheet`) |
| `signing/signing_service.dart` | 1 | `promissory_sign_action_parser.dart` | **live — keep** |
| `flow/flow_manager.dart` | 1 | `flow_next_action_parser.dart` | ✅ **DELETED 2026-05-30** — flow engine removed (see Flow Removal note) |
| `compat/stac_registry.dart` | 1 | `builders/stac_common_builders.dart` (which re-exports it) | live (indirect fan-out) |
| `registry/register_custom_parsers.dart` | 1 | `main.dart` → `registerCustomParsers()` | live entrypoint |
| `registry/stac_widget_loader.dart` | 4 | `flow_manager`, `custom_navigate_action_parser`, `on_mount_action_parser`, `timed_splash_parser` | live, contained |
| `services/widget/stac_widget_resolver.dart` | 3 | navigate/asset/network paths | live |
| `utils/variable_resolver.dart` | 3 | resolver + single-parse widgets | live |
| `registry/custom_component_registry.dart` | 52 | all parser registrations | core hub |
| `actions/stac_custom_actions.dart` | **163** | mostly `lib/stac` DSL screens (emit JSON) | **high blast radius** |
| `builders/stac_common_builders.dart` | **186** | mostly `lib/stac` DSL screens | **highest blast radius** |

Key takeaway: the two builder files (163 / 186 importers) are load-bearing for nearly the entire DSL tree. Any refactor of them must preserve a **re-export barrel** so existing `import` lines keep resolving — otherwise it's a 180-file edit.

## 7. Prioritized Action List

Risk = chance a change breaks something. Effort = work to do it.

| # | Action | Issue | Importers affected | Risk of change | Cleanup safety | Effort |
|---|--------|-------|--------------------|----------------|----------------|--------|
| 1 | ✅ DONE — Deleted empty `external_signer.dart` | C6 | 0 | **none** | **100% safe** | trivial |
| 2 | ✅ DONE — Deleted orphan `theme_toggle` parser+model; dropped commented TODO in registrar | C4 | 0 live (1 commented) | **none** | **100% safe** | trivial |
| 3 | ✅ DONE — Deleted deprecated `ShowMobileBankServices…` builder + parser + registration. Verified 0 usage in DSL/JSON (live screen already uses `showBottomSheet`); `dart analyze` clean | C2 | 1 | low | safe after 1 edit | low |
| 4 | ✅ PARTIAL (2026-05-30) — de-duped doubled override list into `_overridableBuiltinWidgetTypes` Set; renamed `_registerExampleParsers`→`_registerAllParsers` + fixed misleading doc. Registration counts unchanged (27 action / 20 widget / 50 free-fn), `dart analyze` clean. **Deferred:** physical 6-file split + convention-unification (pure churn, low value, adds import risk) | C4 | 1 (`main.dart`) | **low** — kept `registerCustomParsers()` signature | safe | medium |
| 5 | ❌ DROPPED (2026-05-30) — feature subfolders rejected; keep flat by type (see §5). Grouping moves to the registrar (#4) instead | M1 | — | — | — | — |
| 6 | ⚠️ RISK RE-RATED (2026-05-30) — Rename mock `StacRegistry` in `compat/` | M3 | **72 files** reference `StacRegistry` | **HIGH, not low** — the shadow is intentional: DSL build files call `StacRegistry.instance` expecting that exact symbol when `package:stac` is absent. Renaming the class changes the re-exported symbol and breaks the DSL build for every consumer. Needs DSL-wide migration + build test, not a local rename. **DEFER** | unsafe as a quick rename | high |
| 7 | ⛔ BLOCKED ON RUNTIME (2026-05-30) — Replace hardcoded business paths in `stac_widget_resolver` with payload flag | M4 | 3 | low–medium | **Structural blocker:** network-request single-parse is decided from the URL *before* the payload is fetched (`_shouldSingleParseNetworkRequest`, line ~63), so a `keepAlive` flag inside the JSON is not available at decision time. Asset-path branch could read it, but a split rule risks the dashboard-shell bottom-nav-reset regression. Needs runtime smoke test (can't run app here) | low |
| 8 | ⛔ NOT DONE — needs runtime (2026-05-30). Break up `stac_custom_actions.dart`; move Persian copy + amounts to DSL/config | C2 | **163** | **medium–high** — must keep re-export barrel; moving copy = DSL JSON edits across consumers | silent drift risk, needs app run | medium |
| 9 | ⛔ NOT DONE — needs runtime (2026-05-30). Consolidate builder+model+parser per action; defaults defined once | C1 | builders (163/186) + parsers | **high** | dropped/renamed registration = silently dead action; `dart analyze` won't catch. Needs flow testing | high |
| 10 | ⛔ NOT DONE — needs runtime (2026-05-30). Data-drive / generate `stac_widget_loader.dart`; verify stale `login_flow` paths | C5 | 4 | **medium** import-wise, **high** behavior-wise (130 screens) | one mistyped entry = screen fails to load at runtime; needs per-screen smoke test | high |

**Do-now (zero risk):** #1, #2 — ✅ completed 2026-05-30 (3 files deleted, registrar TODO removed, `dart analyze lib/core/stac` clean).
**Low risk, high payoff:** #3–#6 — internal splits/renames behind stable public surfaces.
**Plan carefully (barrel + tests first):** #8–#10 — touch the 163/186-importer builders or the 130-screen loader.

### Execution log (2026-05-30)
Completed all statically-verifiable items: **#1, #2, #3 done; #4 partial (safe parts)**. Each verified by zero-residual grep + `dart analyze lib/core/stac` clean (only pre-existing `info` lints remain).
Stopped before **#7–#10**: all require running the app / per-screen smoke tests to verify (silent runtime regressions that `dart analyze` cannot catch). Doing them blind conflicts with the "do not break the app" constraint. **#5 dropped** (flat-by-type kept), **#6 deferred** (StacRegistry shadow is intentional — see row).

### Flow Removal (2026-05-30)
Removed the unused multi-step flow engine; migrated `flowNext` callers to plain `navigate`.
- **Why:** `FlowManager`/`FlowManagerWidget`/`FlowProvider` were never instantiated — `loginFlowOverview` (the only trigger) had 0 live DSL/JSON references. `flowNext`'s in-flow branch was dead (FlowProvider never in tree); its standalone fallback `navigate` was unimplemented (no-op bug). Both end screens already carried a `fallback: navigate` that this migration promotes to the real action — which also **fixes** the latent no-op.
- **Migrated 7 DSL files** (flowNext+fallback wrapper → the inner `navigate`): login `verify_otp` (dart/json/api), onboarding `tobank_onboarding` (dart/json/api), `login_flow_linear/api/GET_login_flow_linear_verify_otp.json`. Uses `navigationStyle` `popAll`/`pop` — a pattern already proven in many other screens (charge, dashboard, cartable).
- **Deleted:** `flow/flow_manager.dart` (dir now empty), `parsers/actions/flow_next_action_parser.dart`, its import+registration in `register_custom_parsers.dart`, and 3 dead loader entries (`tobank_login_flow_dart`, `login_flow_config`, `login_flow_config_api`) in `stac_widget_loader.dart`.
- **Verified:** 0 residual `flowNext`/`FlowManager`/`loginFlowOverview` refs; all 5 edited JSON parse; `dart analyze` clean on all touched files (only pre-existing `info` lints).

---

## 7. Summary Scorecard

| Area | Verdict |
|------|---------|
| Overall layering (parsers/registry/services/loaders/utils) | Good, docs-aligned |
| Parser/action implementation correctness | Good |
| Naming conventions | Good (minor inconsistencies) |
| Action definition model (3 pieces, dup defaults) | **Poor** — drift risk |
| `stac_custom_actions.dart` (god file + business copy) | **Poor** |
| `register_custom_parsers.dart` (god registrar) | **Poor** |
| `stac_widget_loader.dart` (hardcoded cross-tree map) | **Poor** — worst coupling |
| Dead/empty files | ✅ cleared — `external_signer.dart` + `theme_toggle` orphans deleted 2026-05-30 |
| Folder grouping inside `parsers/` | Flat, needs feature subfolders |

The architecture is correct in concept and Stac-idiomatic at the unit level. The debt is **concentration + triplication + hardcoded cross-tree maps**. Fixing items 1–3 first removes most day-to-day pain with low risk; items 4–5 are the larger structural wins.
