# STAC Action Flow Guide (Tobank SDUI)

This document captures the decisions and learnings from implementing and debugging JSON-driven actions in this repo (especially around `stateFull` lifecycle logging and action sequencing).

## Goals

- Make JSON actions **predictable** in both simple and complex flows.
- Support mixing **sync** and **async** actions safely.
- Provide **observability** (logging) to debug lifecycle and action execution.
- Avoid hidden async bugs where an action appears async but is implemented as fire-and-forget.

---

## Key Principle: actions are `FutureOr`

In Dart, an action can be:

- **Sync**: returns immediately (often `null`).
- **Async**: returns a `Future`.

A sequence runner should:

- Execute action
- If the result is a `Future`, **await it**

This allows mixing sync and async actions in a single ordered list.

---

## Sequence action (ordered execution)

### Why we needed it

The login linear splash used:

- `delay` then `navigate`

Without a supported sequence action type, the whole onInit failed.

### Behavior

- Runs actions **in order**.
- Awaits any action that returns a `Future`.

### Example

```json
{
  "actionType": "sequence",
  "actions": [
    { "actionType": "setValue", "key": "splashStartTime", "value": "{{now()}}" },
    { "actionType": "log", "message": "onInit: splash initialized" },
    { "actionType": "delay", "duration": 2000 },
    {
      "actionType": "navigate",
      "assetPath": "lib/stac/tobank/flows/login_flow_linear/json/login_flow_linear_onboarding.json",
      "navigationStyle": "pushReplacement"
    }
  ]
}
```

---

## Template evaluation in actions (`{{...}}`)

### Why it matters

We wanted this to work:

- Store a timestamp at splash init
- Compute duration at dispose

### `setValue` template resolution

```json
{ "actionType": "setValue", "key": "splashStartTime", "value": "{{now()}}" }
```

Meaning:

- Evaluate `now()`
- Store the numeric timestamp in `StacRegistry` under key `splashStartTime`

### `log` template resolution

```json
{ "actionType": "log", "message": "splash duration: {{now() - splashStartTime}}ms" }
```

Meaning:

- Evaluate `now()`
- Read `splashStartTime` from `StacRegistry`
- Subtract
- Log the final value

---

## Avoiding a common pitfall: `StacFormScope` on non-form screens

We saw:

- `StacFormScope.of()` called on splash screen (no form scope)

Root cause:

- A custom `setValue` parser called `StacFormScope.of(context)` unconditionally.

Fix approach:

- Only access `StacFormScope` when resolving `getFormValue`
- Use a safe helper (catch and return null)

---

## Robustness ideas for complex flows

As flows get bigger, you need more than just `sequence`.

### Option A: Per-action await contract (recommended)

Add metadata that makes intent explicit:

- `mustAwait: true`

In a strict runner, if `mustAwait: true` but the action returns non-Future, log error / fail in debug.

### Option B: Parallel runner (concurrent execution)

Use when order does not matter and you want speed.

Example:

```json
{
  "actionType": "parallel",
  "awaitAll": true,
  "actions": [
    { "actionType": "log", "message": "Starting" },
    { "actionType": "networkRequest", "url": "https://api.example.com/a", "method": "get" },
    { "actionType": "networkRequest", "url": "https://api.example.com/b", "method": "get" }
  ]
}
```

### Option C: Strict mode (enforcement)

Strict mode makes mistakes visible early.

Example:

```json
{
  "actionType": "sequence",
  "strict": true,
  "actions": [
    { "actionType": "networkRequest", "mustAwait": true, "url": "https://api.example.com", "method": "get" },
    { "actionType": "navigate", "assetPath": "lib/stac/.../next.json" }
  ]
}
```

Strict mode can be applied to both `sequence` and `parallel` runners.

---

## Lifecycle logging with `stateFull`

We support `type: "stateFull"` (and also `stateful`) with lifecycle hooks mapped to JSON actions.

Typical hooks:

- `onInit`
- `onBuild`
- `onDispose`
- `onDependenciesChanged`
- `onWidgetUpdated`
- `onReassemble`
- App lifecycle: `onResume`, `onPause`, `onInactive`, `onHidden`, `onDetached`

---

## Current implementation notes (repo-specific)

- `sequence` is implemented as a custom action parser.
- `log` resolves templates for debugging.
- `setValue` resolves templates so values like `{{now()}}` are stored as real values.
- `validateFields` is a custom action for field-level validation without relying on Form validation state.
- `reactiveElevatedButton` is a custom widget that enables/disables based on a registry key and rebuilds on registry changes.

---

## Stateful example (stateful_example)

This screen is a full demo of lifecycle + validation + networking + UI state.

### Files

- `lib/stac/tobank/stateful_example/json/tobank_stateful_example.json`
- `lib/stac/tobank/stateful_example/api/GET_tobank_stateful_example.json`
- `lib/core/stac/parsers/actions/validate_fields_action_parser.dart`
- `lib/core/stac/parsers/widgets/reactive_elevated_button_parser.dart`
- `lib/core/stac/utils/registry_notifier.dart`

### Key behavior

- **Live output fields** (`lastStatus`, `lastMessage`, `live.*`) are read-only `textFormField`s and updated via `setValue`.
- **Form validation** uses `validateFields` to check:
  - `mobile_number`: `^09\d{9}$`
  - `national_code`: `^\d{10}$`
  - `birthdate`: `^\d{4}/\d{2}/\d{2}$`
- **Parallel submit button** uses `reactiveElevatedButton` and is disabled until all fields pass validation (`parallelEnabled = true`).
- **Birthdate selection** triggers validation via `onDateSelected`.
- **Login form validation errors** only appear after user interaction because the Form wraps only the login section (live output fields are outside the Form).

### Example: enabling the parallel button

```json
{
  "type": "reactiveElevatedButton",
  "enabledKey": "parallelEnabled",
  "enabled": false,
  "child": { "type": "text", "data": "ارسال موازی (دو درخواست)" },
  "onPressed": { "actionType": "sequence", "actions": [/* ... */] },
  "style": { /* enabled style */ },
  "disabledStyle": { /* disabled style */ }
}
```

### Example: field validation trigger

```json
{
  "actionType": "validateFields",
  "resultKey": "parallelEnabled",
  "fields": [
    { "id": "mobile_number", "rule": "^09\\d{9}$" },
    { "id": "national_code", "rule": "^\\d{10}$" },
    { "id": "birthdate", "rule": "^\\d{4}/\\d{2}/\\d{2}$" }
  ]
}
```

---

## Next improvements (optional)

- Add `parallel` action parser.
- Add `strict` / `mustAwait` contract support.
- Add structured tracing:
  - action name
  - start/end timestamps
  - duration
  - error capture

---

## Production readiness checklist (recommended)

Use this to keep action flows safe and diagnosable as the app grows.

### Error handling

- Add `onError` actions for network calls and critical action chains.
- Log parse or execution failures with enough context to identify the action JSON.
- Prefer fail-fast for critical flows (e.g., auth) and fallback actions for optional flows.

### Async behavior and ordering

- Use `sequence` when order matters and actions must await.
- For concurrent work, add `parallel` only if order is irrelevant.
- If an action is expected to be async, consider a `mustAwait` flag (future improvement).

### Lifecycle safety

- Avoid long-running actions in `onDispose`; keep them lightweight (log, timing).
- Guard against running actions after unmount (already enforced in `stateFull`).
- For `onInit` that triggers navigation, use a delay or post-frame to avoid context issues.

### State integrity

- Define a naming convention for registry keys (e.g., `screenName.key`).
- Avoid writing raw form values without validation.
- Document which registry values are expected to persist across screens.

### Observability

- Standardize log fields: `screen`, `actionType`, `step`, `durationMs`.
- Use a single log action format so backend and mobile can correlate events.
- Record action durations where timing matters (splash, onboarding, network requests).

### Navigation robustness

- Validate `assetPath` or `request.url` before navigation.
- Log and fallback if the target screen cannot be loaded.
- For deep flows, prefer `flow` actions or explicit `sequence` steps.

### Testing guidance

- Maintain a JSON test flow that exercises `sequence`, `delay`, `setValue`, `log`, `navigate`.
- Validate template resolution (`{{now()}}`, `{{registryKey}}`) with real data.

### Example: standardized logging

```json
{
  "actionType": "log",
  "level": "info",
  "message": "screen=login_flow_linear_splash action=sequence step=onInit durationMs={{now() - splashStartTime}}"
}
```

### Example: network request with onError + fallback

```json
{
  "actionType": "sequence",
  "actions": [
    {
      "actionType": "setValue",
      "key": "requestStart",
      "value": "{{now()}}"
    },
    {
      "actionType": "networkRequest",
      "url": "https://api.tobank.com/flows/login_flow_linear/login_flow_linear_onboarding",
      "method": "get",
      "onSuccess": {
        "actionType": "navigate",
        "request": {
          "url": "https://api.tobank.com/flows/login_flow_linear/login_flow_linear_onboarding",
          "method": "get"
        },
        "navigationStyle": "pushReplacement"
      },
      "onError": {
        "actionType": "sequence",
        "actions": [
          {
            "actionType": "log",
            "level": "error",
            "message": "screen=login_flow_linear_splash action=networkRequest status=failed durationMs={{now() - requestStart}}"
          },
          {
            "actionType": "navigate",
            "assetPath": "lib/stac/tobank/flows/login_flow_linear/json/login_flow_linear_onboarding.json",
            "navigationStyle": "pushReplacement"
          }
        ]
      }
    }
  ]
}
```

---

## Full complex example (form + list + mixed actions)

This example shows a single screen with:
- A filter/search form
- A results list
- Pagination
- Error handling
- Logging + timing
- Form-to-registry resolution
- Mixed sync/async actions using `sequence`

### Screen JSON (condensed but complete)

```json
{
  "type": "stateFull",
  "onInit": {
    "actionType": "sequence",
    "actions": [
      { "actionType": "setValue", "key": "screenId", "value": "customer_search" },
      { "actionType": "setValue", "key": "page", "value": 1 },
      { "actionType": "setValue", "key": "isLoading", "value": true },
      { "actionType": "setValue", "key": "initAt", "value": "{{now()}}" },
      {
        "actionType": "log",
        "message": "screen=customer_search action=onInit"
      },
      {
        "actionType": "networkRequest",
        "url": "https://api.example.com/customers/search",
        "method": "post",
        "body": {
          "page": "{{page}}",
          "query": "",
          "status": "all"
        },
        "onSuccess": {
          "actionType": "sequence",
          "actions": [
            { "actionType": "setValue", "key": "results", "value": "{{response.data.items}}" },
            { "actionType": "setValue", "key": "total", "value": "{{response.data.total}}" },
            { "actionType": "setValue", "key": "isLoading", "value": false },
            {
              "actionType": "log",
              "message": "screen=customer_search action=initLoad durationMs={{now() - initAt}}"
            }
          ]
        },
        "onError": {
          "actionType": "sequence",
          "actions": [
            { "actionType": "setValue", "key": "isLoading", "value": false },
            {
              "actionType": "log",
              "level": "error",
              "message": "screen=customer_search action=initLoad status=failed"
            }
          ]
        }
      }
    ]
  },
  "child": {
    "type": "scaffold",
    "appBar": {
      "type": "appBar",
      "title": { "type": "text", "data": "Customer Search" }
    },
    "body": {
      "type": "column",
      "children": [
        {
          "type": "padding",
          "padding": { "left": 16, "right": 16, "top": 12, "bottom": 8 },
          "child": {
            "type": "form",
            "key": "searchForm",
            "child": {
              "type": "column",
              "children": [
                {
                  "type": "textFormField",
                  "id": "query",
                  "labelText": "Name / Phone",
                  "hintText": "Type to search",
                  "validator": { "type": "required", "message": "Query required" }
                },
                {
                  "type": "dropdownMenu",
                  "id": "status",
                  "label": "Status",
                  "items": [
                    { "label": "All", "value": "all" },
                    { "label": "Active", "value": "active" },
                    { "label": "Blocked", "value": "blocked" }
                  ]
                },
                {
                  "type": "row",
                  "children": [
                    {
                      "type": "filledButton",
                      "text": "Search",
                      "onPressed": {
                        "actionType": "sequence",
                        "actions": [
                          { "actionType": "setValue", "key": "page", "value": 1 },
                          { "actionType": "setValue", "key": "isLoading", "value": true },
                          { "actionType": "setValue", "key": "searchAt", "value": "{{now()}}" },
                          {
                            "actionType": "setValue",
                            "key": "query",
                            "value": { "actionType": "getFormValue", "id": "query" }
                          },
                          {
                            "actionType": "setValue",
                            "key": "status",
                            "value": { "actionType": "getFormValue", "id": "status" }
                          },
                          {
                            "actionType": "networkRequest",
                            "url": "https://api.example.com/customers/search",
                            "method": "post",
                            "body": {
                              "page": "{{page}}",
                              "query": "{{query}}",
                              "status": "{{status}}"
                            },
                            "onSuccess": {
                              "actionType": "sequence",
                              "actions": [
                                { "actionType": "setValue", "key": "results", "value": "{{response.data.items}}" },
                                { "actionType": "setValue", "key": "total", "value": "{{response.data.total}}" },
                                { "actionType": "setValue", "key": "isLoading", "value": false },
                                {
                                  "actionType": "log",
                                  "message": "screen=customer_search action=search durationMs={{now() - searchAt}}"
                                }
                              ]
                            },
                            "onError": {
                              "actionType": "sequence",
                              "actions": [
                                { "actionType": "setValue", "key": "isLoading", "value": false },
                                {
                                  "actionType": "log",
                                  "level": "error",
                                  "message": "screen=customer_search action=search status=failed"
                                }
                              ]
                            }
                          }
                        ]
                      }
                    },
                    {
                      "type": "textButton",
                      "text": "Clear",
                      "onPressed": {
                        "actionType": "sequence",
                        "actions": [
                          { "actionType": "setValue", "key": "query", "value": "" },
                          { "actionType": "setValue", "key": "status", "value": "all" },
                          { "actionType": "setValue", "key": "results", "value": [] },
                          { "actionType": "setValue", "key": "total", "value": 0 }
                        ]
                      }
                    }
                  ]
                }
              ]
            }
          }
        },
        {
          "type": "conditional",
          "condition": "isLoading",
          "trueChild": { "type": "linearProgressIndicator" },
          "falseChild": {
            "type": "expanded",
            "child": {
              "type": "listView",
              "itemCount": "{{results.length}}",
              "itemBuilder": {
                "type": "card",
                "margin": { "left": 16, "right": 16, "top": 8, "bottom": 8 },
                "child": {
                  "type": "listTile",
                  "title": { "type": "text", "data": "{{item.name}}" },
                  "subtitle": { "type": "text", "data": "Status: {{item.status}}" },
                  "trailing": {
                    "type": "textButton",
                    "text": "Details",
                    "onPressed": {
                      "actionType": "navigate",
                      "arguments": { "customerId": "{{item.id}}" },
                      "assetPath": "lib/stac/tobank/flows/customer/details.json"
                    }
                  }
                }
              }
            }
          }
        },
        {
          "type": "padding",
          "padding": { "left": 16, "right": 16, "top": 8, "bottom": 12 },
          "child": {
            "type": "row",
            "mainAxisAlignment": "spaceBetween",
            "children": [
              {
                "type": "text",
                "data": "Total: {{total}}"
              },
              {
                "type": "filledButton",
                "text": "Load more",
                "onPressed": {
                  "actionType": "sequence",
                  "actions": [
                    { "actionType": "setValue", "key": "page", "value": "{{page + 1}}" },
                    { "actionType": "setValue", "key": "isLoading", "value": true },
                    { "actionType": "setValue", "key": "pageAt", "value": "{{now()}}" },
                    {
                      "actionType": "networkRequest",
                      "url": "https://api.example.com/customers/search",
                      "method": "post",
                      "body": {
                        "page": "{{page}}",
                        "query": "{{query}}",
                        "status": "{{status}}"
                      },
                      "onSuccess": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "setValue",
                            "key": "results",
                            "value": "{{results + response.data.items}}"
                          },
                          { "actionType": "setValue", "key": "isLoading", "value": false },
                          {
                            "actionType": "log",
                            "message": "screen=customer_search action=loadMore durationMs={{now() - pageAt}}"
                          }
                        ]
                      },
                      "onError": {
                        "actionType": "sequence",
                        "actions": [
                          { "actionType": "setValue", "key": "isLoading", "value": false },
                          {
                            "actionType": "log",
                            "level": "error",
                            "message": "screen=customer_search action=loadMore status=failed"
                          }
                        ]
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```

### Weaknesses and risks exposed by this example

- Heavy reliance on registry variables can create hidden coupling (naming conflicts).
- Large `sequence` blocks are hard to debug without structured tracing.
- Template evaluation is string-based; complex expressions are limited.
- `getFormValue` in `setValue` is custom behavior (not upstream).
- Network errors only log; no built-in retry/backoff.
- Long action chains can re-run on rebuild if not guarded.
- Pagination "append" uses `{{results + response.data.items}}` which assumes list concatenation support.
