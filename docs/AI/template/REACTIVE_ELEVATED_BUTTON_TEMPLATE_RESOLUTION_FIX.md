# ReactiveElevatedButton Premature Template Resolution Fix

## Summary
In `promissory_real_payment_deposits_screen.dart`, the draft API request uses:

- `{{selectedDeposit.depositNumber}}`
- `{{selectedDeposit.depositIban}}`

These values must be resolved at button tap time, not at screen parse/build time.

The bug was caused by early global template resolution in STAC, which could bake stale values into `onPressed` action JSON.

Final fix is now implemented at framework level and reusable across future screens.

## Problem
`reactiveElevatedButton.onPressed` action payload contained templates, but those templates were resolved too early in some entry paths.

Result:

- user changes selected deposit
- registry updates correctly
- request body still used older baked value in some scenarios

## Root Cause
Even with protection inside `StatefulWidgetParser`, some runtime entry points resolved JSON before that parser could protect `onPressed`.

Main issue:

- `onPressed` needed to be tunneled before first global `{{...}}` resolution pass.

## Final Solution
### 1. Introduced shared tunneling utility
File:

- `lib/core/stac/utils/reactive_button_action_tunneler.dart`

Function:

- `tunnelReactiveButtonActions(dynamic json)`

Behavior:

- detect `type == reactiveElevatedButton`
- convert `onPressed` to `rawOnPressed`
- escape `{{` to `__STAC_OPEN__`
- keep existing `rawOnPressed` unchanged (idempotent)
- recurse through nested maps/lists

### 2. Applied tunneling before early resolution paths
Updated:

- `lib/core/stac/builders/stac_stateful_widget.dart`
- `lib/core/stac/services/widget/stac_widget_resolver.dart`
- `lib/core/stac/mock/stac_mock_dio_setup.dart`

This ensures templates are protected before any parse-time resolution in those paths.

### 3. Kept parser/model backward compatible
Updated:

- `lib/core/stac/parsers/widgets/stateful_widget_parser.dart`
- `lib/core/stac/parsers/widgets/reactive_elevated_button_parser.dart` (existing compatible behavior retained)

Details:

- stateful protection now includes both `onPressed` and `rawOnPressed`
- model prefers `rawOnPressed` decode if present
- fallback to legacy `onPressed` still works

## Flow Validation (Promissory Real Payment Deposits)
Observed in runtime logs after fix:

- `DRAFT PRE-RESOLVE ... hasTemplates=true`
- then runtime resolved values matched current selected deposit
- request sent latest selected account values

This confirms stale template bug is fixed.

Note:

- later `422` responses in logs were backend business validation (insufficient minimum balance), not template staleness.

## Automated Test Coverage
Added tests:

- `test/core/stac/utils/reactive_button_action_tunneler_test.dart`
- `test/core/stac/parsers/widgets/reactive_elevated_button_model_test.dart`

Covered:

- conversion to `rawOnPressed`
- non-reactive no-op behavior
- nested structure handling
- idempotence
- raw decode correctness
- fallback compatibility

## Release Stability
Current status:

- fix validated by runtime logs
- full test suite passes
- targeted analyzer checks for touched stability files pass

This fix is considered stable for release and safe for future reuse.

## Guidance for Future Development
When adding new `reactiveElevatedButton` usage:

- keep templates in `onPressed` payload
- do not manually pre-resolve action templates
- rely on framework tunneling + runtime action resolution

If similar action staleness appears in other custom widgets:

- apply the same pre-resolution tunneling pattern at shared entry points.
