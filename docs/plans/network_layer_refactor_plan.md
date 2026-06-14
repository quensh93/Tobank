# Network Layer Refactor Plan

## Overview

Fix 5 structural issues in the network layer without changing the overall directory layout.  
Each phase is independent — can be merged separately.

---

## Phase 1: Shared Dio Factory

**Problem:** 3+ separate Dio instances with duplicated interceptor setup.  
**Goal:** Single factory that produces pre-configured Dio instances.

### New file: `lib/core/api/dio_factory.dart`

```dart
class DioFactory {
  const DioFactory._();

  /// Creates an authenticated Dio for business APIs (promissory, deposits, etc.)
  static Dio authenticated({
    Duration timeout = const Duration(seconds: 30),
  });

  /// Creates a plain Dio for config/public APIs (no auth header)
  static Dio plain({
    Duration timeout = const Duration(seconds: 30),
  });
}
```

### What it does:
- Sets `connectTimeout`, `receiveTimeout`, `sendTimeout`
- Adds `ISpectDioInterceptor` (only if `ISpectConfig.shouldInitialize`)
- Adds `NetworkSimulatorAdapter` (if enabled)
- Adds a shared logging interceptor (replaces the inline `print` + cURL logic)
- For `authenticated()`: adds an `AuthInterceptor` that auto-attaches Bearer token

### Changes to existing files:
| File | Change |
|------|--------|
| `promissory_service.dart` | Replace `final Dio _dio = Dio()` + manual interceptor setup → `DioFactory.authenticated()` |
| `promissory_auth_service.dart` | Same |
| `config_api_service.dart` | Replace internal Dio creation → `DioFactory.plain()` |
| `main.dart` | `stacDio` → `DioFactory.plain()` (STAC runtime requests) |

### New file: `lib/core/api/interceptors/auth_interceptor.dart`

```dart
class AuthInterceptor extends Interceptor {
  final AuthManager authManager;

  @override
  void onRequest(options, handler) {
    // Attach Bearer token from AuthManager
    // Call handler.next(options)
  }
}
```

---

## Phase 2: Common Device Headers

**Problem:** `device-uuid`, `app-platform`, `app-version`, `serviceauthorization` hardcoded in **9 files** (verified), not 2.  
**Goal:** Single source of truth.

> **Scope note (verified):** headers appear in `promissory_service.dart`, `promissory_auth_service.dart`, `custom_network_request_action_parser.dart`, `login.dart`, `promissory_issuer.dart`, `promissory_payment_deposits.dart`, `promissory_preview.dart`, `promissory_receiver.dart`, `promissory_sign.dart`. This phase replaces headers in the **service files only**; flow UI files are a follow-up.

### New file: `lib/core/api/device_headers.dart`

```dart
class DeviceHeaders {
  const DeviceHeaders._();

  static const String appPlatform = 'android';
  static const String appVersion = '456';
  static const String deviceUuid = '5109ab4c-77ca-4f0c-9858-da4df58031d2';
  static const String serviceAuthorization = 'Basic Z2ZRdDVha3U2a...';

  /// All default headers (without Authorization)
  static Map<String, String> get all => {
    'accept': '*/*',
    'app-platform': appPlatform,
    'app-store': 'application/json',
    'app-version': appVersion,
    'device-uuid': deviceUuid,
    'serviceauthorization': serviceAuthorization,
  };
}
```

### Changes to existing files:
| File | Change |
|------|--------|
| `promissory_service.dart` | Replace `_defaultHeaders` → `DeviceHeaders.all` |
| `promissory_auth_service.dart` | Replace `_headers` → `DeviceHeaders.all` |

> **Future:** These values should come from a runtime config / platform info package, not be static constants. But that's a separate task.

---

## Phase 3: Shared cURL Logger

**Problem:** cURL logging duplicated in `custom_network_request_action_parser.dart`, `promissory_service.dart`, `promissory_auth_service.dart`, `stac_mock_dio_setup.dart`.  
**Goal:** One utility, used everywhere.

### New file: `lib/core/api/utils/curl_logger.dart`

```dart
class CurlLogger {
  const CurlLogger._();

  /// Generate a cURL string from request parameters
  static String generate({
    required String method,
    required String url,
    Map<String, String>? headers,
    dynamic body,
    bool maskAuth = true,
  });

  /// Log a cURL command using AppLogger (handles chunking for Android 4KB limit)
  static void log({
    required String method,
    required String url,
    Map<String, String>? headers,
    dynamic body,
  });
}
```

### Changes to existing files:
| File | Change |
|------|--------|
| `custom_network_request_action_parser.dart` | Replace `_logCurl()` → `CurlLogger.log()` |
| `promissory_service.dart` | Replace `_logCurl()` → `CurlLogger.log()` (DEAD — see Phase 6; likely deleted before this phase) |
| `promissory_auth_service.dart` | Replace `_logCurl()` → `CurlLogger.log()` |
| `stac_mock_dio_setup.dart` | Replace `_cURLRepresentation()` → `CurlLogger.generate()` |
| `config_api_service.dart` | Also has curl/log logic (verified) — include in this phase |

---

## Phase 4: Move Signing Service Out of `stac_core/services/`

**Problem:** `signing/` is business logic (PDF signing), not STAC infrastructure.  
**Goal:** Move to a proper location.

### Move:
```
FROM: lib/stac_core/services/signing/
  TO: lib/stac/tobank/flows/promissory/signing/
```

Files:
- `signing_service.dart`
- `sign_document_data.dart`

### Reasoning:
- Signing is only used in the promissory flow
- It's not a STAC framework service
- Co-locating with its consumer makes the dependency obvious

### Changes:
- Update all imports that reference `stac_core/services/signing/`

---

## Phase 5: Table-Driven Mock Interceptor

**Problem:** `stac_mock_dio_setup.dart` has ~300 lines of nested if/else path matching.  
**Goal:** Declarative route table + small matching engine.

### Refactored structure:

```dart
// lib/stac_core/mock/stac_mock_dio_setup.dart (simplified)
Dio setupStacMockDio() {
  final dio = Dio();
  dio.interceptors.add(StacMockInterceptor());
  return dio;
}
```

### New file: `lib/stac_core/mock/mock_route_table.dart`

```dart
class MockRouteEntry {
  final String urlPattern;   // regex or exact match
  final String assetPath;
  final bool isScreenJson;

  const MockRouteEntry({...});
}

/// All mock routes declared in one place
const List<MockRouteEntry> mockRoutes = [
  MockRouteEntry(
    urlPattern: r'^screens/(.+)$',
    assetPath: 'lib/stac/tobank/{feature}/api/GET_{screen}.json',
    isScreenJson: true,
  ),
  MockRouteEntry(
    urlPattern: r'^strings$',
    assetPath: 'lib/stac/config/strings.json',
    isScreenJson: false,
  ),
  MockRouteEntry(
    urlPattern: r'^colors$',
    assetPath: 'lib/stac/design_system/colors.json',
    isScreenJson: false,
  ),
  // ... etc
];
```

### New file: `lib/stac_core/mock/stac_mock_interceptor.dart`

```dart
class StacMockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 1. Extract path from URL
    // 2. Match against mockRoutes table
    // 3. Load asset, resolve variables if isScreenJson
    // 4. Return response or handler.next()
  }
}
```

### Benefits:
- Adding a new mock route = adding one line to the table
- Matching logic is tested separately from route definitions
- Much easier to read/maintain

---

## Phase 6: Extract Shared Business Services to `core/api/services/`

> **VERIFIED STATE (2026-06-14) — read before doing this phase:**
> - `PromissoryRealService` (`promissory_service.dart`) with `getDeposits()` / `getCustomerInfo()` is **DEAD CODE**. Never imported, never instantiated anywhere in repo. → **DELETE it**, do NOT move it. Moving dead code to `core/api/services/` just relocates dead code.
> - `PromissoryRealAuthService.login()` (`promissory_auth_service.dart`) is **LIVE** — called by `promissory_login_action_parser.dart:33`. → This is the only piece worth extracting.
> - Both `getDeposits`/`getCustomerInfo` take a `BuildContext` param that is **unused**. Since they have zero callers, removing the param is risk-free (moot — file gets deleted).
>
> **Revised Phase 6 = (a) delete dead deposits/customer service, (b) move live `login()` to `core/api/services/auth_service.dart`.** The "reuse across flows" premise was speculative — only `login` is real today.

**Problem:** Business API calls live inside `promissory/service/` but are not promissory-specific. The login service is live; deposits/customer services are unused dead code.  
**Goal:** Delete dead services; relocate the live auth service to a shared, reusable home.

### New directory: `lib/core/api/services/`

```dart
// lib/core/api/services/auth_service.dart
class AuthService {
  final Dio _dio; // from DioFactory.plain()
  final AuthManager _authManager;

  /// Login to digitalbanking and store tokens
  Future<bool> login({
    required String nationalCode,
    required String password,
  });
}
```

```dart
// lib/core/api/services/deposits_service.dart
class DepositsService {
  final Dio _dio; // from DioFactory.authenticated()

  /// Fetch all deposits for a customer
  Future<List<DepositInfo>> getDeposits(String nationalCode);
}
```

```dart
// lib/core/api/services/customer_service.dart
class CustomerService {
  final Dio _dio; // from DioFactory.authenticated()

  /// Fetch customer info by national code
  Future<CustomerInfo?> getCustomerInfo(String nationalCode);
}
```

### What changes (revised per verified state):

| Current file | Action |
|---|---|
| `promissory_service.dart` (`PromissoryRealService`) | **DELETE** — dead code, zero callers. No move. |
| `promissory_auth_service.dart` (`PromissoryRealAuthService.login`) | Move login → `core/api/services/auth_service.dart`. Update `promissory_login_action_parser.dart:33` import. |

> `deposits_service.dart` / `customer_service.dart` / `DepositInfo` / `CustomerInfo` are **dropped from this phase** — no live consumer. Re-add only when a flow actually needs them.

### How promissory flow uses them after refactor:

```dart
// lib/stac/tobank/flows/promissory/promissory_flow_controller.dart
class PromissoryFlowController {
  final AuthService _auth;
  final DepositsService _deposits;
  final CustomerService _customer;

  // Orchestrates the flow using shared services
}
```

### Rules for `core/api/services/`:
- Each service = one business domain (auth, deposits, customers, transfers, cards, etc.)
- Services receive Dio from `DioFactory` (Phase 1 dependency)
- Services use `DeviceHeaders` (Phase 2 dependency)
- Services return **typed models**, not raw `Map<String, dynamic>`
- No `BuildContext` parameter — services are pure network, UI feedback is caller's job
- No `ScaffoldMessenger.showSnackBar` inside services

### New models: `lib/core/api/models/`

```dart
// lib/core/api/models/deposit_info.dart
class DepositInfo {
  final String id;
  final String title;
  final String depositNumber;
  final String shabaNumber;
}

// lib/core/api/models/customer_info.dart
class CustomerInfo {
  final String nationalCode;
  final String firstName;
  final String lastName;
  // ... other fields from API
}
```

### Benefits:
- Any flow can call `DepositsService.getDeposits()` without duplicating the API call
- Adding a new flow (e.g., transfer) doesn't require copy-pasting network code
- Testable in isolation (no `BuildContext` dependency)
- Clean separation: service = network + parsing, flow = orchestration + UI

---

## Execution Order

| Order | Phase | Risk | Effort |
|-------|-------|------|--------|
| 1 | Phase 2 — Device Headers | Very Low | ~30 min |
| 2 | Phase 3 — cURL Logger | Low | ~45 min |
| 3 | Phase 1 — Dio Factory | Medium | ~2 hours |
| 4 | Phase 4 — Move Signing | Low | ~20 min |
| 5 | Phase 6 — Delete dead service + move live `login` | Low | ~45 min |
| 6 | Phase 5 — Mock Interceptor | Medium | ~2-3 hours |

**Total estimated effort: ~6-7 hours** (Phase 6 shrank — most of it was dead code)

> **Note:** Phase 6 depends on Phase 1 (Dio Factory) and Phase 2 (Device Headers) being done first.
> **Note:** Phase 6 is now mostly a deletion + one file move, not a multi-service extraction.

---

## Final Directory Structure (after all phases)

```
lib/core/api/
├── dio_factory.dart              ← NEW: Shared Dio builder
├── device_headers.dart           ← NEW: Common headers
├── api_config.dart
├── stac_api_service.dart
├── auth/
│   └── auth_manager.dart
├── interceptors/                 ← NEW
│   └── auth_interceptor.dart
├── config_api/
│   ├── config_api.dart
│   ├── config_api_models.dart
│   └── config_api_service.dart
├── exceptions/
│   └── api_exceptions.dart
├── models/
│   └── cached_data.dart
└── utils/                        ← NEW
    └── curl_logger.dart

lib/stac_core/mock/
├── stac_mock_dio_setup.dart      ← SIMPLIFIED
├── stac_mock_interceptor.dart    ← NEW: Interceptor class
└── mock_route_table.dart         ← NEW: Declarative routes

lib/core/api/services/                    ← NEW: Shared business services
└── auth_service.dart                      (login — moved from promissory_auth_service.dart)
    # deposits_service.dart / customer_service.dart NOT created — were dead code, deleted

lib/core/api/models/
└── cached_data.dart
    # deposit_info.dart / customer_info.dart deferred — no live consumer

lib/stac/tobank/flows/promissory/
└── signing/                          ← MOVED from stac_core/services/signing/
    # promissory_service.dart DELETED (dead). promissory_auth_service.dart → core/api/services/
    # promissory_flow_controller.dart dropped — no orchestration needed yet
    ├── signing_service.dart
    └── sign_document_data.dart
```

---

## Rules (STRICT — Zero Tolerance for Breakage)

### Core Principle
**This is a STRUCTURAL refactor only. No logic changes. No behavior changes. The app must work identically before and after each phase.**

### Before Each Phase:
1. **Run the app** — confirm it builds and runs without errors
2. **Run `dart analyze`** — zero warnings/errors baseline
3. **Document the current behavior** — note what works so you can verify after

### During Each Phase:
4. **Move/extract code as-is first** — do NOT "improve" or "fix" anything while moving
5. **Keep exact same method signatures** — same parameters, same return types, same exceptions
6. **Keep exact same logic** — copy-paste the implementation, don't rewrite it
7. **No new dependencies** — only internal reorganization
8. **No API behavior changes** — same requests, same headers, same responses, same error handling

### After Each Phase:
9. **Run `dart analyze`** — must be zero errors
10. **Run the app** — must build and launch without issues
11. **Test the affected flows manually** — login, deposits, customer info, STAC screens must all work
12. **Compare network requests** — cURL output must be identical before and after
13. **If ANYTHING is broken** — revert the phase entirely, do not try to "fix forward"

### What "no logic change" means specifically:
- If a service currently has a hardcoded timeout of 30s → keep 30s, don't "make it configurable"
- If a service catches `DioException` and returns `null` → keep that exact behavior
- If headers are in a specific order → keep that order
- If there's a `try/catch` that swallows errors → keep it, don't "improve" error handling
- If `BuildContext` is passed but unused → keep it in the signature until a separate cleanup task
- If there's duplicate code between old and new location during transition → that's OK temporarily

### Deprecation strategy:
- When moving a file, leave a forwarding export at the old path:
  ```dart
  // OLD LOCATION — deprecated, use new import path
  export 'package:tobank_sdui/core/api/services/auth_service.dart';
  ```
- Remove old forwarding files only after confirming all imports are updated
- Never delete a file until you've grep-searched for all its imports

### One phase at a time:
- Complete phase N fully (including verification) before starting phase N+1
- Each phase = one commit with a clear message
- If a phase feels risky, split it into smaller sub-steps
