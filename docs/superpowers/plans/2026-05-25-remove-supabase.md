# Remove Supabase Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove all Supabase dependencies from the app — the project is local-mock only and Supabase is unused.

**Architecture:** Delete isolated Supabase tool folders, remove `supabase` from `ApiMode` enum (leaving only `mock` and `custom`), strip all Supabase branches from providers/UI, remove packages from pubspec.

**Tech Stack:** Flutter, Dart, Riverpod (riverpod_annotation), pubspec.yaml

---

## File Map

### Delete entirely
- `lib/tools/supabase_cli/` — standalone CLI tool, nothing imports it from app
- `lib/tools/supabase_crud/` — standalone CRUD screens, nothing imports it from app
- `lib/core/api/services/supabase_api_service.dart` — Supabase HTTP impl
- `lib/core/security/supabase_auth_manager.dart` — Supabase auth manager

### Modify (trim Supabase references)
- `pubspec.yaml` — remove `supabase_flutter` and `supabase` packages
- `lib/core/api/api_config.dart` — remove `supabase` from `ApiMode`, remove `ApiConfig.supabase` factory + supabase fields
- `lib/core/api/providers/api_config_provider.dart` — remove supabase env logic, `useSupabaseApi()`, `isSupabaseApiEnabled` provider
- `lib/core/api/providers/api_config_provider.g.dart` — remove generated `isSupabaseApiEnabled` provider
- `lib/core/api/providers/stac_api_service_provider.dart` — remove `ApiMode.supabase` case
- `lib/core/api/providers/stac_api_service_provider.g.dart` — remove supabase import
- `lib/core/api/providers/mock_api_service_provider.dart` — remove `ApiMode.supabase` case
- `lib/core/api/providers/mock_api_service_provider.g.dart` — remove supabase comment
- `lib/core/config/feature_flags.dart` — remove `isSupabaseApiEnabled`, `isSupabaseCliEnabled`, `isSupabaseCrudEnabled` fields
- `lib/core/config/environment_config.dart` — remove `supabaseUrl`, `supabaseAnonKey` fields
- `lib/core/security/secure_config_storage.dart` — remove `saveSupabaseConfig` / `getSupabaseConfig` methods
- `lib/debug_panel/state/debug_panel_settings_state.dart` — remove `supabaseEnabled` field + all its usages
- `lib/debug_panel/widgets/settings_tab.dart` — remove Supabase toggle UI section
- `lib/debug_panel_extensions/widgets/stac_log_viewer.dart` — remove `ApiSource.supabase` case
- `lib/core/logging/stac_log_models.dart` — remove `supabase` from `ApiSource` enum
- `lib/core/logging/stac_logger.dart` — remove supabase reference in comment
- `lib/core/widgets/mock_mode_indicator.dart` — remove Supabase mode option from UI switcher
- `lib/features/stac_test_app/presentation/providers/stac_test_app_providers.dart` — remove `ApiMode.supabase` branches

---

## Task 1: Delete isolated Supabase tool folders and files

**Files:**
- Delete: `lib/tools/supabase_cli/` (11 dart files)
- Delete: `lib/tools/supabase_crud/` (13 dart files)
- Delete: `lib/core/api/services/supabase_api_service.dart`
- Delete: `lib/core/security/supabase_auth_manager.dart`

- [ ] **Step 1: Delete the folders and files**

```bash
rm -rf "lib/tools/supabase_cli"
rm -rf "lib/tools/supabase_crud"
rm "lib/core/api/services/supabase_api_service.dart"
rm "lib/core/security/supabase_auth_manager.dart"
```

- [ ] **Step 2: Verify deletion**

```bash
find lib/tools -name "*.dart" | sort
ls lib/core/api/services/
ls lib/core/security/
```

Expected: no supabase files present.

- [ ] **Step 3: Commit**

```bash
git add -A
git commit -m "chore: delete supabase tool folders and isolated supabase files"
```

---

## Task 2: Remove supabase packages from pubspec.yaml

**Files:**
- Modify: `pubspec.yaml`

- [ ] **Step 1: Remove supabase packages**

In `pubspec.yaml`, find and delete these two lines under `dependencies:`:
```yaml
  supabase_flutter: ^2.12.0
  supabase: ^2.10.2
```

- [ ] **Step 2: Run pub get to verify**

```bash
flutter pub get
```

Expected: resolves without errors. If `supabase` is still referenced in dart files, it will error — that's expected and will be fixed in later tasks.

- [ ] **Step 3: Commit**

```bash
git add pubspec.yaml pubspec.lock
git commit -m "chore: remove supabase and supabase_flutter packages from pubspec"
```

---

## Task 3: Remove `supabase` from `ApiMode` enum and `ApiConfig`

**Files:**
- Modify: `lib/core/api/api_config.dart`

- [ ] **Step 1: Rewrite api_config.dart**

Replace the entire file content with:

```dart
enum ApiMode {
  mock,
  custom,
}

class ApiConfig {
  final ApiMode mode;
  final String? customApiUrl;
  final bool enableCaching;
  final Duration cacheExpiry;
  final Map<String, String> headers;
  final String? authToken;

  const ApiConfig({
    required this.mode,
    this.customApiUrl,
    this.enableCaching = true,
    this.cacheExpiry = const Duration(minutes: 5),
    this.headers = const {},
    this.authToken,
  });

  factory ApiConfig.mock({
    bool enableCaching = true,
    Duration cacheExpiry = const Duration(minutes: 5),
  }) {
    return ApiConfig(
      mode: ApiMode.mock,
      enableCaching: enableCaching,
      cacheExpiry: cacheExpiry,
    );
  }

  factory ApiConfig.custom(
    String apiUrl, {
    bool enableCaching = true,
    Duration cacheExpiry = const Duration(minutes: 5),
    Map<String, String> headers = const {},
    String? authToken,
  }) {
    return ApiConfig(
      mode: ApiMode.custom,
      customApiUrl: apiUrl,
      enableCaching: enableCaching,
      cacheExpiry: cacheExpiry,
      headers: headers,
      authToken: authToken,
    );
  }

  ApiConfig copyWith({
    ApiMode? mode,
    String? customApiUrl,
    bool? enableCaching,
    Duration? cacheExpiry,
    Map<String, String>? headers,
    String? authToken,
  }) {
    return ApiConfig(
      mode: mode ?? this.mode,
      customApiUrl: customApiUrl ?? this.customApiUrl,
      enableCaching: enableCaching ?? this.enableCaching,
      cacheExpiry: cacheExpiry ?? this.cacheExpiry,
      headers: headers ?? this.headers,
      authToken: authToken ?? this.authToken,
    );
  }

  @override
  String toString() {
    return 'ApiConfig(mode: $mode, customApiUrl: $customApiUrl, '
        'enableCaching: $enableCaching, cacheExpiry: $cacheExpiry)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApiConfig &&
        other.mode == mode &&
        other.customApiUrl == customApiUrl &&
        other.enableCaching == enableCaching &&
        other.cacheExpiry == cacheExpiry &&
        other.authToken == authToken;
  }

  @override
  int get hashCode {
    return mode.hashCode ^
        customApiUrl.hashCode ^
        enableCaching.hashCode ^
        cacheExpiry.hashCode ^
        authToken.hashCode;
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/api/api_config.dart
git commit -m "chore: remove supabase from ApiMode enum and ApiConfig"
```

---

## Task 4: Fix `api_config_provider.dart`

**Files:**
- Modify: `lib/core/api/providers/api_config_provider.dart`

Remove: `useSupabaseApi()` method, supabase env var logic, `isSupabaseApiEnabled` provider, staging Supabase branch.

- [ ] **Step 1: Rewrite the provider**

Replace entire file content with:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tobank_sdui/core/api/api_config.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';

part 'api_config_provider.g.dart';

@Riverpod(keepAlive: true)
class ApiConfigNotifier extends _$ApiConfigNotifier {
  @override
  ApiConfig build() {
    const environment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'development',
    );

    switch (environment) {
      case 'production':
        const apiUrl = String.fromEnvironment('API_URL', defaultValue: '');
        if (apiUrl.isNotEmpty) {
          return ApiConfig.custom(apiUrl);
        }
        return ApiConfig.mock();

      case 'development':
      default:
        return ApiConfig.mock();
    }
  }

  void setConfig(ApiConfig config) {
    state = config;
  }

  void useMockApi() {
    state = ApiConfig.mock(
      enableCaching: state.enableCaching,
      cacheExpiry: state.cacheExpiry,
    );
  }

  void useCustomApi(
    String apiUrl, {
    Map<String, String>? headers,
    String? authToken,
  }) {
    state = ApiConfig.custom(
      apiUrl,
      enableCaching: state.enableCaching,
      cacheExpiry: state.cacheExpiry,
      headers: headers ?? state.headers,
      authToken: authToken ?? state.authToken,
    );
  }

  void updateCachingSettings({bool? enableCaching, Duration? cacheExpiry}) {
    state = state.copyWith(
      enableCaching: enableCaching,
      cacheExpiry: cacheExpiry,
    );
  }

  void updateAuthToken(String? token) {
    if (state.mode == ApiMode.custom) {
      state = state.copyWith(authToken: token);
    }
  }

  void updateHeaders(Map<String, String> headers) {
    if (state.mode == ApiMode.custom) {
      state = state.copyWith(headers: headers);
    }
  }
}

@riverpod
bool isMockApiEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode == ApiMode.mock;
}

@riverpod
bool isCustomApiEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode == ApiMode.custom;
}

@riverpod
ApiMode currentApiMode(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode;
}

@riverpod
bool isCachingEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.enableCaching;
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/api/providers/api_config_provider.dart
git commit -m "chore: strip supabase from api_config_provider"
```

---

## Task 5: Fix `stac_api_service_provider.dart` and `mock_api_service_provider.dart`

**Files:**
- Modify: `lib/core/api/providers/stac_api_service_provider.dart`
- Modify: `lib/core/api/providers/mock_api_service_provider.dart`

- [ ] **Step 1: Fix stac_api_service_provider.dart — remove supabase import and case**

Remove the line:
```dart
import 'package:tobank_sdui/core/api/services/supabase_api_service.dart';
```

Replace the switch in `stacApiService`:
```dart
switch (config.mode) {
  case ApiMode.mock:
    return MockApiService(config: config);
  case ApiMode.custom:
    throw UnimplementedError('Custom API service not yet implemented');
}
```

- [ ] **Step 2: Fix mock_api_service_provider.dart — remove supabase case**

Open `lib/core/api/providers/mock_api_service_provider.dart`, find the switch on `ApiMode` and remove `case ApiMode.supabase:` and its body. Only `mock` and `custom` cases should remain.

- [ ] **Step 3: Commit**

```bash
git add lib/core/api/providers/stac_api_service_provider.dart \
        lib/core/api/providers/mock_api_service_provider.dart
git commit -m "chore: remove supabase cases from api service providers"
```

---

## Task 6: Fix generated `.g.dart` files

**Files:**
- Modify: `lib/core/api/providers/api_config_provider.g.dart`
- Modify: `lib/core/api/providers/stac_api_service_provider.g.dart`
- Modify: `lib/core/api/providers/mock_api_service_provider.g.dart`

- [ ] **Step 1: Remove `isSupabaseApiEnabled` from api_config_provider.g.dart**

Search for `isSupabaseApiEnabled` in `api_config_provider.g.dart` and delete the entire generated provider block for it (the `IsSupabaseApiEnabledProvider` class and the `isSupabaseApiEnabled` const). Also remove any `isSupabaseApiEnabled` comments.

- [ ] **Step 2: Remove supabase import from stac_api_service_provider.g.dart**

Search for `supabase` in `stac_api_service_provider.g.dart` and remove any supabase-related comments or imports.

- [ ] **Step 3: Remove supabase comment from mock_api_service_provider.g.dart**

Search for `supabase` in `mock_api_service_provider.g.dart` and remove any supabase-related comments.

- [ ] **Step 4: Commit**

```bash
git add lib/core/api/providers/api_config_provider.g.dart \
        lib/core/api/providers/stac_api_service_provider.g.dart \
        lib/core/api/providers/mock_api_service_provider.g.dart
git commit -m "chore: remove supabase from generated provider files"
```

---

## Task 7: Fix `stac_log_models.dart` and `stac_logger.dart`

**Files:**
- Modify: `lib/core/logging/stac_log_models.dart`
- Modify: `lib/core/logging/stac_logger.dart`

- [ ] **Step 1: Remove `supabase` from `ApiSource` enum in stac_log_models.dart**

Find the `ApiSource` enum and remove the `supabase` value:
```dart
// Before
enum ApiSource { mock, supabase, custom }

// After
enum ApiSource { mock, custom }
```

Also remove any field/comment referencing supabase in the same file.

- [ ] **Step 2: Remove supabase comment in stac_logger.dart**

Find the line referencing supabase (in a comment like `// HTTP/HTTPS URLs (Supabase, etc.)`) and either remove the mention or just remove the comment entirely.

- [ ] **Step 3: Commit**

```bash
git add lib/core/logging/stac_log_models.dart \
        lib/core/logging/stac_logger.dart
git commit -m "chore: remove supabase from log models and logger"
```

---

## Task 8: Fix `stac_log_viewer.dart`

**Files:**
- Modify: `lib/debug_panel_extensions/widgets/stac_log_viewer.dart`

- [ ] **Step 1: Remove `ApiSource.supabase` case**

Find line 586 (approximately):
```dart
case ApiSource.supabase:
  // ... body
```
Delete the entire case block.

- [ ] **Step 2: Commit**

```bash
git add lib/debug_panel_extensions/widgets/stac_log_viewer.dart
git commit -m "chore: remove ApiSource.supabase case from log viewer"
```

---

## Task 9: Fix `debug_panel_settings_state.dart`

**Files:**
- Modify: `lib/debug_panel/state/debug_panel_settings_state.dart`

- [ ] **Step 1: Remove `supabaseEnabled` field**

- Remove `this.supabaseEnabled = false,` from the constructor
- Remove `final bool supabaseEnabled;` field declaration
- Remove `supabaseEnabled` from `copyWith()` parameter and body
- Remove `'supabaseEnabled': supabaseEnabled,` from `toJson()`
- Remove `supabaseEnabled: json['supabaseEnabled'] as bool? ?? false,` from `fromJson()`
- Remove `void setSupabaseEnabled(bool enabled)` method from controller

- [ ] **Step 2: Commit**

```bash
git add lib/debug_panel/state/debug_panel_settings_state.dart
git commit -m "chore: remove supabaseEnabled from debug panel settings state"
```

---

## Task 10: Fix `settings_tab.dart`

**Files:**
- Modify: `lib/debug_panel/widgets/settings_tab.dart`

- [ ] **Step 1: Remove the Supabase UI section**

Find and delete the entire block starting around line 141 that contains:
```dart
'Use Supabase',
...
settings.supabaseEnabled
...
controller.setSupabaseEnabled(enabled);
...
if (settings.supabaseEnabled) ...[
  // Supabase Configuration card
```

Delete everything from the Supabase toggle card through the end of the `if (settings.supabaseEnabled)` block (around line 234).

Also find line ~471:
```dart
controller.setSupabaseEnabled(false);
```
Delete that line.

- [ ] **Step 2: Commit**

```bash
git add lib/debug_panel/widgets/settings_tab.dart
git commit -m "chore: remove supabase toggle UI from settings tab"
```

---

## Task 11: Fix `mock_mode_indicator.dart`

**Files:**
- Modify: `lib/core/widgets/mock_mode_indicator.dart`

- [ ] **Step 1: Remove all ApiMode.supabase references**

Find every occurrence of `ApiMode.supabase` in the file (approximately lines 79, 90, 129, 182, 185, 205, 208, 211, 219, 224, 229, 256, 258, 267, 269, 278, 280) and:

- Remove the Supabase `DropdownMenuItem` block (value: `ApiMode.supabase`)
- Remove `ApiMode.supabase:` cases from all switch statements — replace with nothing or fall-through to `default`
- Remove any `if (apiMode == ApiMode.supabase)` checks

- [ ] **Step 2: Commit**

```bash
git add lib/core/widgets/mock_mode_indicator.dart
git commit -m "chore: remove supabase mode option from mock mode indicator UI"
```

---

## Task 12: Fix `stac_test_app_providers.dart`

**Files:**
- Modify: `lib/features/stac_test_app/presentation/providers/stac_test_app_providers.dart`

- [ ] **Step 1: Remove ApiMode.supabase branches**

Find both `if (apiConfig.mode == ApiMode.supabase)` blocks (around lines 25 and 91) and delete each entire `if` block and its body. The code should fall through directly to the mock/local path.

- [ ] **Step 2: Commit**

```bash
git add lib/features/stac_test_app/presentation/providers/stac_test_app_providers.dart
git commit -m "chore: remove supabase branches from stac_test_app_providers"
```

---

## Task 13: Fix `feature_flags.dart`, `environment_config.dart`, `secure_config_storage.dart`

**Files:**
- Modify: `lib/core/config/feature_flags.dart`
- Modify: `lib/core/config/environment_config.dart`
- Modify: `lib/core/security/secure_config_storage.dart`

- [ ] **Step 1: feature_flags.dart — remove supabase fields**

Remove fields: `isSupabaseApiEnabled`, `isSupabaseCliEnabled`, `isSupabaseCrudEnabled`  
Remove their constructor parameters, `copyWith` parameters, and all factory constructor assignments for these three fields.  
Remove from `isApiEnabled` getter: `|| isSupabaseApiEnabled`.

- [ ] **Step 2: environment_config.dart — remove supabase fields**

Remove fields: `supabaseUrl`, `supabaseAnonKey`  
Remove their constructor parameters and `copyWith` parameters.  
Remove from all factory constructors (`development`, `staging`, `production`) the supabase URL/key assignments.

- [ ] **Step 3: secure_config_storage.dart — remove supabase methods**

Delete the entire `// ==================== Supabase Configuration ====================` section including `saveSupabaseConfig()` and `getSupabaseConfig()` methods, and the `_supabaseConfigKey` constant.

- [ ] **Step 4: Commit**

```bash
git add lib/core/config/feature_flags.dart \
        lib/core/config/environment_config.dart \
        lib/core/security/secure_config_storage.dart
git commit -m "chore: remove supabase fields from feature_flags, environment_config, secure_config_storage"
```

---

## Task 14: Final verification

- [ ] **Step 1: Check for remaining supabase references**

```bash
grep -r "supabase\|Supabase" lib/ --include="*.dart" -l
```

Expected: zero results. If any remain, fix them.

- [ ] **Step 2: Check pubspec has no supabase**

```bash
grep -i "supabase" pubspec.yaml
```

Expected: zero results.

- [ ] **Step 3: Run flutter pub get**

```bash
flutter pub get
```

Expected: success with no errors.

- [ ] **Step 4: Run dart analyze**

```bash
dart analyze lib/
```

Expected: zero errors. Warnings are OK.

- [ ] **Step 5: Commit any remaining fixes**

```bash
git add -A
git commit -m "chore: final supabase cleanup"
```
