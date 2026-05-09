# Biometric Module R&D Task Plan

Date: 2026-05-04

Active repo: `C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui`

Reference repo: `C:\Users\alisi\StudioProjects\tobank_app`

## 1. Summary

This document captures the current biometric implementation in `tobank_sdui`, compares it with the completed biometric/passkey setup in `tobank_app`, and defines the target design for completing the module later.

This is an R&D-only artifact. The implementation phase should keep the biometric service reusable and isolated from STAC screens, UI frameworks, GetX, and app-specific storage. STAC should consume the service through a small public contract, not own the platform logic.

Target platforms:

| Platform | Target behavior |
| --- | --- |
| Android native | Use `local_auth` for generic biometric/device authentication. Keep `secure_plugin` signing flow separate. |
| iOS native | Use `local_auth` for generic biometric/device authentication. Keep `secure_plugin` signing flow separate. |
| Flutter Web / PWA with WebAuthn support | Use WebAuthn/passkey through a JS bridge and Dart interop. |
| Flutter Web / PWA without WebAuthn support | Fall back to the current app passcode flow through an adapter. |

## 2. Current-State Inventory

### STAC action surface

| Path | Status | Notes |
| --- | --- | --- |
| `lib/core/stac/parsers/actions/finger_print_action_parser.dart` | Active, partial | Registers action type `fingerPrint`, checks `BiometricService.isAvailable()`, shows a bottom sheet, then calls `BiometricService.authenticate()`. It directly owns UI copy and a bottom-sheet experience. |
| `lib/core/stac/parsers/actions/finger_print_action_model.dart` | Active | Defines `title`, `description`, `userId`, `onSuccess`, and `onFailure`. `userId` is currently important for web auto-registration. |
| `lib/core/stac/builders/stac_finger_print_action.dart` | Active | Builder-side JSON emitter for action type `fingerPrint`. |
| `lib/core/stac/registry/register_custom_parsers.dart` | Active | Registers `FingerPrintActionParser`. |
| `lib/stac/...` flow JSON/Dart screens | Not used yet | Search did not find direct `actionType: "fingerPrint"` usage in active STAC flows. Current profile settings uses fingerprint icon assets, not the action. |

### Shared biometric service

| Path | Status | Notes |
| --- | --- | --- |
| `lib/core/services/biometric/biometric_service.dart` | Active, partial | Provides only `isAvailable()` and `authenticate()`. Uses `local_auth` on native and delegates to `WebBiometricService` on web. |
| `lib/core/services/biometric/web_biometric_service.dart` | Active, partial | Implements WebAuthn registration/authentication logic plus password fallback. It expects `window.webAuthnCreate` and `window.webAuthnGet` to exist. |
| `lib/core/services/biometric/non_web_biometric_service.dart` | Active stub | Provides web service method stubs for native conditional import. |
| `lib/widgets/dialogs/web_pin_dialog.dart` | Active | Current web fallback UI. This creates a UI dependency inside the biometric web service path. |
| `lib/core/storage/storage_util.dart` | Active dependency | Web fallback reads the stored app password through `StorageUtil.getPassword()`. |
| `lib/core/utils/app_util.dart` | Active dependency | Web fallback compares passcode using `AppUtil.encryptDataWithAES()`, which currently hashes with SHA-256 rather than true AES. |

### Platform setup

| Path | Status | Notes |
| --- | --- | --- |
| `pubspec.yaml` | Active | Includes `local_auth`, `universal_html`, and `get`. |
| `android/app/src/main/AndroidManifest.xml` | Active | Includes `USE_BIOMETRIC` and `USE_FINGERPRINT`. |
| `android/app/src/main/kotlin/com/tobank/sdui/MainActivity.kt` | Active | Extends `FlutterFragmentActivity`, which is required for Android `local_auth`. |
| `ios/Runner/Info.plist` | Active | Includes `NSFaceIDUsageDescription`. |
| `web/manifest.json` | Active | PWA display is set to `standalone`. |
| `web/index.html` | Missing WebAuthn bridge | Does not define `window.webAuthnCreate`, `window.webAuthnGet`, or `window.isWebAuthnAvailable`. Real passkey/WebAuthn calls cannot work reliably without this bridge. |

### Native digital-signing biometric flow

| Path | Status | Notes |
| --- | --- | --- |
| `secure_plugin/android/src/main/kotlin/com/gardeshpay/secure_plugin/SecurityImplementation.kt` | Active signing flow | Uses AndroidX `BiometricPrompt` before signing/decrypting/PDF signing operations. This is separate from the STAC `fingerPrint` action. |
| `secure_plugin/ios/Classes/SecurePluginUtil.swift` | Active signing flow | Uses `LAContext().evaluatePolicy(.deviceOwnerAuthentication, ...)` before signing/decrypting/private-key access. |
| `secure_plugin/ios/Classes/KeyChainUtil.swift` | Active key/signing utility | Creates RSA keys in Keychain and signs with `.rsaSignatureMessagePKCS1v15SHA256`. Current iOS key size is 1024-bit. |
| `secure_plugin/ios/Classes/BiometricStatusEnum.swift` | Active status mapping | Maps local auth status into plugin response values. |

### Commented or dead biometric-related code

| Path | Status | Notes |
| --- | --- | --- |
| `lib/core/plugins/web_biometric_service.dart` | Dead/commented | Contains a commented copy of web biometric logic. Should not be treated as active runtime code. |
| `lib/core/plugins/secure_web_plugin.dart` | Dead/commented | Contains commented web signing and biometric-gated signing code. Useful for R&D context only. |

## 3. Reference App Comparison

The reference repo has the same broad approach but is more complete around service API and web bridge setup.

| Area | `tobank_sdui` current state | `tobank_app` reference state | Gap to close later |
| --- | --- | --- | --- |
| Native generic biometric service | `BiometricService.isAvailable()` and `authenticate()` only. | `lib/new_structure/core/services/secure/biometric_service.dart` exposes `canAuthenticate`, `hasFingerprint`, `hasFaceDetect`, `shouldShowBiometricOption`, `isEnabled`, `setEnabled`, `authenticate`, `register`, `isRegistered`, `removeCredential`, and `stopAuthentication`. | Adopt a richer but still small service contract. |
| Web service | `lib/core/services/biometric/web_biometric_service.dart` exists and is close to the reference logic. | `lib/util/web_only_utils/web_biometric_service.dart` provides the reference behavior. | Keep behavior but isolate fallback dependencies and cancellation semantics. |
| WebAuthn JS bridge | Missing from `web/index.html`. | `web/index.html` defines `window.webAuthnCreate`, `window.webAuthnGet`, and `window.isWebAuthnAvailable`. | Add bridge in implementation phase. |
| Web fallback | Directly depends on `Get.context`, `WebPinDialog`, `StorageUtil`, and `AppUtil`. | Similar app-specific fallback exists. | Improve beyond reference by introducing explicit fallback/storage adapters. |
| UI usage | STAC action exists but no active flow consumes `actionType: "fingerPrint"`. | Login/settings/signup controllers consume service capability and enabled-state APIs. | Decide later where STAC flows should use the action or capability checks. |
| Digital signing | Native plugin exists and is independent from STAC action. Web plugin code is commented. | Native signing plus web signing R&D/code exists. | Keep signing auth separate from generic biometric auth. Treat web signing as a different module unless explicitly scoped in. |

## 4. Isolation Assessment

The current implementation is functional in shape but not isolated enough.

### Unwanted dependencies in biometric service

| Dependency | Current use | Why it is a problem | Target boundary |
| --- | --- | --- | --- |
| STAC parser/UI | `FingerPrintActionParser` shows a bottom sheet and calls the service. | STAC UI should not define platform behavior. | STAC action should only map JSON to service calls and result actions. |
| GetX | `WebBiometricService` uses `Get.context` for passcode fallback. | Service becomes impossible to reuse in non-Get contexts. | Inject a `BuildContext`-free fallback provider or callback. |
| `WebPinDialog` | Web service constructs the dialog directly. | Service owns UI and app copy. | `PasscodeFallbackProvider.authenticate(reason)` owns UI. |
| `StorageUtil` | Stores/reads credential enabled state and app password. | Ties service to one storage implementation. | `BiometricPreferenceStore` owns credential id and enabled state; passcode provider owns passcode read/verify. |
| `AppUtil.encryptDataWithAES()` | Used to compare fallback password. | Name says AES, current behavior is SHA-256 hashing. | Passcode verification should be an injected app-auth concern. |
| `window.webAuthnCreate` / `window.webAuthnGet` | Dart interop expects globals. | Runtime breaks if bridge is missing or renamed. | `WebAuthnBridge` wraps feature detection, create, get, error mapping. |

### Target module boundaries

The completed module should be split conceptually as:

| Boundary | Responsibility |
| --- | --- |
| `BiometricAuthenticator` | Public platform-neutral contract used by STAC and app flows. |
| Native implementation | Wrap `local_auth`, expose capability and authentication results. |
| Web implementation | Coordinates WebAuthn bridge, credential store, cancellation handling, and fallback provider. |
| `WebAuthnBridge` | Dart/JS boundary only. No app storage or UI. |
| `PasscodeFallbackProvider` | Current app passcode prompt and verification. |
| `BiometricPreferenceStore` | Enabled flag and credential-id persistence. |
| STAC `fingerPrint` action | JSON input/output mapping only. No platform-specific decisions. |
| `secure_plugin` signing | Native key-backed signing with biometric/device auth. Separate from generic STAC auth. |

## 5. Target Public Contract

The later implementation should expose a small service API with explicit result semantics.

Recommended API shape:

| Method | Purpose |
| --- | --- |
| `canAuthenticate()` | Returns whether local auth is possible on the current platform. |
| `getCapability()` | Returns capability such as none, fingerprint, face, passkey, passcodeFallback, or mixed. This can also be split into `hasFingerprint()` and `hasFaceDetect()` if that better matches existing app patterns. |
| `authenticate(reason, userId?)` | Prompts the user and returns a typed result. `userId` is used only by web auto-registration. |
| `register(userId, passkeyOnly?)` | Web credential registration. Native can return success/no-op. |
| `isRegistered()` | Web credential/passcode readiness check. Native can return true when device auth is available. |
| `isEnabled()` / `setEnabled(value)` | User preference for biometric/passkey login. |
| `removeCredential()` | Clears web credential id and disables preference. Native clears preference only. |
| `stopAuthentication()` | Cancels native in-progress authentication where supported. |

Recommended result model:

| Result | Meaning |
| --- | --- |
| `success` | User authenticated successfully. |
| `cancelled` | User cancelled or system cancelled. Do not silently fall back. |
| `notAvailable` | Platform/browser/device cannot authenticate. |
| `notRegistered` | Web credential/passcode is not ready. |
| `failed` | Authentication failed for a non-cancel reason. |
| `fallbackUsed` | Optional metadata indicating app passcode was used. |

## 6. Web/PWA Behavior

Target behavior for Flutter Web/PWA:

1. Check that the browser is in a secure context and supports `PublicKeyCredential` and `navigator.credentials`.
2. If WebAuthn is supported and a credential exists, call `navigator.credentials.get()` through `window.webAuthnGet`.
3. If WebAuthn is supported but no credential exists and `userId` is available, call `navigator.credentials.create()` through `window.webAuthnCreate`, store the credential id, then authenticate.
4. If WebAuthn/passkey is unsupported, use the current app passcode fallback through `PasscodeFallbackProvider`.
5. If WebAuthn fails for a non-cancel technical reason, fallback is allowed.
6. If the user cancels WebAuthn/passkey, return `cancelled` and do not fall back silently.
7. If no passcode is configured, return `notRegistered` or `notAvailable` with a user-facing path to set passcode.

Important WebAuthn notes:

- WebAuthn requires HTTPS or localhost.
- The current service should not rely only on `navigator.credentials != null`; it should also check `window.PublicKeyCredential`.
- The credential id stored in local storage is not a secret. The private key stays with the authenticator/browser/platform.
- Current WebAuthn usage is local user-presence/authentication gating. It is not full server-verified passkey login unless a backend challenge and assertion verification flow is added.

## 7. Android/iOS Behavior

Target behavior for generic biometric authentication:

| Platform | Target |
| --- | --- |
| Android | Use Flutter `local_auth` for app-level biometric/device authentication. Keep `MainActivity` as `FlutterFragmentActivity`. Keep `USE_BIOMETRIC`; `USE_FINGERPRINT` can remain for older compatibility unless dependency guidance changes. |
| iOS | Use Flutter `local_auth` for app-level Face ID/Touch ID/device owner auth. Keep `NSFaceIDUsageDescription`. |
| Android signing plugin | Keep `secure_plugin` signing with AndroidX `BiometricPrompt`; do not merge it with the STAC `fingerPrint` action. |
| iOS signing plugin | Keep `secure_plugin` signing with `LAContext.evaluatePolicy(.deviceOwnerAuthentication, ...)`; do not merge it with generic biometric service. |

Native signing R&D note:

- Android plugin signing currently uses RSA 2048-bit and `SHA256withRSA`.
- iOS plugin key generation currently uses RSA 1024-bit in `KeyChainUtil.makeAndStoreKey()`. If signing is in scope later, evaluate moving to 2048-bit for parity and security.
- Android key generation currently uses `setUserAuthenticationRequired(false)`, while the signing operation is gated by `BiometricPrompt`. If stronger key-level auth is required later, that is a separate signing-plugin hardening task.

## 8. Later Implementation Roadmap

No implementation is part of this R&D task. For the later code phase, use this order:

1. Add the missing web bridge in `web/index.html` based on the reference app:
   - `window.webAuthnCreate`
   - `window.webAuthnGet`
   - `window.isWebAuthnAvailable`
2. Introduce an isolated biometric service contract and typed result model.
3. Refactor the current native service to expose capability, enabled state, register/no-op, remove, and stop methods.
4. Refactor web auth into `WebAuthnBridge`, `BiometricPreferenceStore`, and `PasscodeFallbackProvider`.
5. Update `FingerPrintActionParser` to depend only on the new service contract and typed results.
6. Add or update STAC action schema examples for `fingerPrint` usage.
7. Add the manual SDUI biometric test entry point under the Tobank menu.
8. Add structured biometric logs through the existing app logger.
9. Keep `secure_plugin` signing flows separate. Only document integration points if a flow requires "authenticate before sign".

## 9. Agent TODO List

Use this as the implementation checklist for the next AI agent.

### Service and platform work

- [ ] Define the platform-neutral biometric contract and typed result model.
- [ ] Move web decision logic behind explicit `WebAuthnBridge`, `BiometricPreferenceStore`, and `PasscodeFallbackProvider` boundaries.
- [x] Add the missing `window.webAuthnCreate`, `window.webAuthnGet`, and `window.isWebAuthnAvailable` bridge in `web/index.html`.
- [x] Preserve native `local_auth` behavior for Android/iOS and keep the Android/iOS platform setup intact.
- [ ] Make `FingerPrintActionParser` consume only the new biometric contract and translate typed results into `onSuccess` / `onFailure`.
- [x] Keep `secure_plugin` signing flows independent from generic biometric auth.

### Manual SDUI test entry point

- [x] Add a new Tobank menu item in `lib/stac/tobank/menu/dart/tobank_menu.dart`, next to the existing real-flow buttons such as promissory, verify identity, and dashboard.
- [x] The new menu item should use `_buildSingleButtonMenuItemCard(...)` and navigate to a new widget route such as `biometric_test_menu`.
- [x] Register the new test widget route in `lib/core/stac/services/widget/stac_widget_loader.dart`, following the same pattern as `verify_identity_real_menu`, `promissory_real_menu`, and `dashboard_real_menu`.
- [x] The test route should open a dedicated SDUI biometric test screen, not production UX.

### Logging and verification

- [ ] Use the existing logger system instead of `print` or `debugPrint`.
- [x] Prefer `AppLogger.dc(...)`, `AppLogger.ic(...)`, `AppLogger.wc(...)`, and `AppLogger.ec(...)` from `lib/core/helpers/logger.dart`.
- [x] Use `LogCategory.action` for generic biometric service logs and `LogCategory.stacAction` for STAC action execution logs.
- [ ] If biometric logs become important enough for filtering, add a dedicated `LogCategory.biometric` in a later cleanup. Do not block the first implementation on that category.

### Tests

- [ ] Add logic tests for the web decision engine using fake bridge/store/fallback implementations.
- [ ] Add parser/action tests for `fingerPrint` success, failure, cancellation, and unavailable results.
- [x] Add manual test cases to the SDUI biometric test screen so behavior can be verified from the app.

## 10. Manual SDUI Biometric Test Screen

The manual verification surface should live inside the existing Tobank SDUI menu because that menu already acts as the entry point for real-flow testing.

Current menu path:

- `lib/stac/tobank/menu/dart/tobank_menu.dart`

Current route registration path:

- `lib/core/stac/services/widget/stac_widget_loader.dart`

Recommended new route:

- `biometric_test_menu`

Recommended test screen responsibilities:

| Test control | Expected behavior |
| --- | --- |
| Capability check | Calls the service capability API and displays platform, availability, registered state, enabled state, and detected method. |
| Authenticate | Calls `authenticate(reason, userId?)` and displays the typed result. |
| Web register passkey | On web only, calls `register(userId, passkeyOnly: true)` and displays success/cancel/failure. |
| Web authenticate passkey | On web only, calls WebAuthn authentication with an existing credential. |
| Web fallback passcode | Forces or simulates unsupported WebAuthn and verifies app passcode fallback behavior. |
| Remove credential | Calls `removeCredential()` and verifies credential/enable state is cleared. |
| STAC action test | Triggers `actionType: "fingerPrint"` and verifies `onSuccess` / `onFailure` routing. |
| Logger visibility check | Emits one debug/info/warn/error biometric log so the tester can confirm logs appear in console/ISpect/debug panel. |

Manual test screen rules:

- This screen is for QA/R&D only and should not be part of production customer navigation.
- The screen should show the latest result and a short event history so testers can see multi-step behavior.
- The screen must not print secrets, passcodes, raw private keys, assertion payloads, or full credential material.
- The screen may show safe metadata such as platform, support flags, result enum, elapsed time, and whether fallback was used.

## 11. Logic Test Plan

The biometric module should have logic tests in addition to manual device testing. The most useful tests are for branching behavior, because the real platform prompts cannot be reliably unit-tested.

### Web decision-engine tests

Use fake implementations for `WebAuthnBridge`, `BiometricPreferenceStore`, and `PasscodeFallbackProvider`.

| Scenario | Expected result |
| --- | --- |
| Secure context + WebAuthn supported + credential exists + bridge get succeeds | `success`, fallback not used. |
| Secure context + WebAuthn supported + no credential + `userId` present + create succeeds + get succeeds | `success`, credential stored. |
| WebAuthn unsupported + passcode fallback succeeds | `success`, fallback metadata set. |
| WebAuthn unsupported + no passcode configured | `notRegistered` or `notAvailable`. |
| WebAuthn create/get throws user cancellation | `cancelled`, fallback not called. |
| WebAuthn create/get throws non-cancel error + passcode fallback succeeds | `success`, fallback metadata set. |
| Stored credential id is corrupt/empty | Clears or ignores bad id and follows register/fallback policy. |

### Native service tests

Use a wrapper/fake around `LocalAuthentication` if the implementation introduces an injectable native adapter.

| Scenario | Expected result |
| --- | --- |
| `canCheckBiometrics` true | `canAuthenticate()` true. |
| `isDeviceSupported` true but no biometric enrolled | capability reflects device credential path if allowed. |
| `authenticate()` returns true | typed result is `success`. |
| `authenticate()` throws platform exception | typed result is `failed` or `notAvailable` depending on exception mapping. |
| `stopAuthentication()` called on native | delegates to local auth and does not throw. |

### STAC action tests

| Scenario | Expected result |
| --- | --- |
| Service returns `success` | `onSuccess` action is called once. |
| Service returns `cancelled` | `onFailure` action is called once. |
| Service returns `notAvailable` | `onFailure` action is called once and logs reason. |
| Context is unmounted before callback | No navigation/action callback is invoked. |
| `userId` provided in JSON | It is passed to the service for web registration/authentication. |

## 12. Logger Requirements

The biometric module must be observable through the existing logging system.

Existing logger paths:

- `lib/core/helpers/logger.dart`
- `lib/core/helpers/log_category.dart`
- `lib/core/helpers/log_config.dart`
- `lib/core/logging/stac_logger.dart`

Required log events:

| Event | Level/category | Required fields |
| --- | --- | --- |
| Capability check started/completed | debug or info, `LogCategory.action` | platform, isWeb, canAuthenticate, capability. |
| WebAuthn availability check | debug, `LogCategory.action` | secureContext, hasPublicKeyCredential, hasNavigatorCredentials. |
| WebAuthn register started/completed | info/warn/error, `LogCategory.action` | userId presence only, result, cancel flag, elapsed time. |
| WebAuthn authenticate started/completed | info/warn/error, `LogCategory.action` | credentialExists, result, fallbackUsed, elapsed time. |
| Passcode fallback started/completed | info/warn, `LogCategory.action` | result only; never log passcode or hash. |
| Native authenticate started/completed | info/warn/error, `LogCategory.action` | platform, result, exception type if any. |
| STAC `fingerPrint` action called | debug/info, `LogCategory.stacAction` | title presence, userId presence, result, callback route. |
| Credential removed | info, `LogCategory.action` | platform, result. |

Logging rules:

- Do not use `print` in the completed biometric module.
- Do not log passcodes, raw credential ids, WebAuthn assertion payloads, private keys, signatures, or full personal identifiers.
- It is acceptable to log whether `userId` exists, but not the raw value unless a later security review explicitly approves it.
- Logs should be visible in the console and in the app debug/ISpect logger path where available.
- Cancellation should be logged as a normal user outcome, not as an error.

## 13. Acceptance Checklist

### Static checks

- `fingerPrint` action still serializes and parses `title`, `description`, `userId`, `onSuccess`, and `onFailure`.
- No biometric service file imports STAC parser classes.
- No core biometric service file imports `Get`.
- No core biometric service file constructs `WebPinDialog` directly.
- WebAuthn JS globals are present before Flutter bootstrap or otherwise guaranteed before Dart calls them.
- Web credential id and enabled state are stored through one abstraction.
- Biometric implementation uses `AppLogger` category logging, not `print`.
- `tobank_menu_dart` exposes a QA-only route to the biometric test screen.
- `stac_widget_loader.dart` registers the biometric test route.

### Android scenarios

- Device with enrolled fingerprint authenticates successfully.
- Device with face/biometric class support authenticates successfully where available.
- Device with only PIN/pattern/passcode follows the chosen `local_auth` options.
- User cancellation returns a cancellation result and triggers `onFailure`.
- Missing biometric enrollment returns a clear not-available/not-registered result.

### iOS scenarios

- Face ID device authenticates successfully.
- Touch ID device authenticates successfully.
- Device passcode fallback follows the chosen `local_auth` policy.
- User cancellation returns a cancellation result and triggers `onFailure`.
- Missing `NSFaceIDUsageDescription` should be impossible in release setup because the key is already present.

### Web/PWA scenarios

- Chrome/Edge on HTTPS with platform authenticator can register and authenticate with WebAuthn.
- Chrome/Edge on unsupported/no-authenticator device falls back to app passcode.
- Safari/iOS PWA tries passkey where supported and falls back to app passcode on non-cancel failure.
- Browser without `PublicKeyCredential` uses app passcode fallback.
- User cancels passkey/WebAuthn and the app does not silently fall back.
- No app passcode configured returns not-registered/not-available and does not authenticate.
- Missing JS bridge is detected as a setup failure rather than a silent false result.
- Manual biometric test screen shows the latest result and logger-visible event history.

## 14. Source Links

- Flutter `local_auth`: https://pub.dev/packages/local_auth
- Flutter `local_auth_android` setup: https://pub.dev/packages/local_auth_android
- AndroidX `BiometricPrompt`: https://developer.android.com/reference/androidx/biometric/BiometricPrompt
- AndroidX `BiometricManager.Authenticators`: https://developer.android.com/reference/androidx/biometric/BiometricManager.Authenticators
- Apple `LAContext`: https://developer.apple.com/documentation/localauthentication/lacontext
- Apple `LAPolicy.deviceOwnerAuthentication`: https://developer.apple.com/documentation/localauthentication/lapolicy/deviceownerauthentication
- MDN `PublicKeyCredential`: https://developer.mozilla.org/en-US/docs/Web/API/PublicKeyCredential
- MDN Web Authentication API: https://developer.mozilla.org/en-US/docs/Web/API/Web_Authentication_API

## 15. Final Recommendation

Complete the biometric module as a service-first feature, not as a STAC-first feature. The STAC `fingerPrint` action should become a thin consumer of an isolated cross-platform biometric contract.

The highest-priority implementation gap is Web/PWA: the Dart web service already expects WebAuthn globals, but `web/index.html` does not provide them. After that, the service should be refactored to remove GetX, direct dialog construction, and app-storage dependencies from core biometric logic.

For agent handoff, the implementation should be considered incomplete until both automated logic tests and the `biometric_test_menu` manual SDUI verification path pass on the target platforms.
