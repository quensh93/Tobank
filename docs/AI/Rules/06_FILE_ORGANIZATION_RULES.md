# File Organization Rules

## 🎯 Mandatory Rules for File Organization

### Rule 1: Follow Exact Folder Structure
**Priority**: CRITICAL

**Action Required:**
- Every feature MUST follow this structure:
  ```
  lib/stac/tobank/{feature_name}/
  ├── dart/
  │   └── {feature_name}.dart
  ├── json/
  │   └── {feature_name}.json (optional)
  └── api/
      └── GET_tobank_{feature_name}.json
  ```

**Why**: Maintains project consistency and organization.

---

### Rule 2: Use Correct Naming Conventions
**Priority**: CRITICAL

**Action Required:**
- **Dart Files**: `{feature_name}.dart` (e.g., `tobank_login.dart`)
- **Screen Names**: `tobank_{feature_name}` (e.g., `tobank_login`)
- **API Files**: `GET_tobank_{feature_name}.json` (e.g., `GET_tobank_login.json`)
- **Function Names**: `tobank{FeatureName}Dart()` (e.g., `tobankLoginDart()`)

**Examples:**
```dart
// File: lib/stac/tobank/login/dart/tobank_login.dart
@StacScreen(screenName: 'tobank_login')
StacWidget tobankLoginDart() {
  // ...
}
```

**Why**: Ensures consistency and makes files easy to find.

---

### Rule 3: Never Edit .build/ Files
**Priority**: CRITICAL

**Action Required:**
- **NEVER** manually edit files in `lib/stac/.build/`
- Always edit Dart source files
- Run `stac build` to regenerate JSON

**Why**: Generated files are overwritten on each build.

---

### Rule 4: Update pubspec.yaml for New Asset Folders
**Priority**: HIGH

**Action Required:**
- When creating new feature folder, add to `pubspec.yaml`:
  ```yaml
  flutter:
    assets:
      - lib/stac/tobank/{feature}/api/
  ```
- Run `flutter pub get` after updating

**Why**: Flutter requires explicit asset folder listing.

---

### Rule 5: Use Correct API File Format
**Priority**: CRITICAL

**Action Required:**
- API files must be wrapped in API response format:
  ```json
  {
    "GET": {
      "statusCode": 200,
      "data": {
        // Screen JSON here
      }
    }
  }
  ```

**Why**: Mock API interceptor expects this format.

---

### Rule 6: Organize Config Files Correctly
**Priority**: HIGH

**Action Required:**
- **Colors**: `lib/stac/config/GET_colors.json`
- **Strings**: `lib/stac/config/GET_strings.json`
- **Styles**: `lib/stac/config/GET_styles.json`
- Don't create new config files without reason

**Why**: Centralizes configuration and ensures consistency.

---

### Rule 7: Place Custom Components in Correct Locations
**Priority**: HIGH

**Action Required:**
- **Custom Actions**: `lib/core/stac/parsers/actions/`
- **Custom Widgets**: `lib/core/stac/parsers/widgets/`
- **Registration**: `lib/core/stac/registry/register_custom_parsers.dart`
- **Utils**: `lib/core/stac/utils/`

**Why**: Maintains organization and makes components easy to find.

---

### Rule 8: Use Assets from assets/ Folder
**Priority**: HIGH

**Action Required:**
- Use assets from `assets/` folder (copied from old tobank)
- Reference using asset paths: `assets/icons/icon.svg`
- Don't use paths from old tobank folder

**Why**: Assets are bundled from `assets/` folder.

---

### Rule 9: Keep default_stac_options.dart in lib/
**Priority**: CRITICAL

**Action Required:**
- File must be: `lib/default_stac_options.dart`
- Not in `stac/` or any subfolder
- Required for `stac build` command

**Why**: STAC CLI looks for it in `lib/` directory.

---

### Rule 10: Document File Purpose
**Priority**: MEDIUM

**Action Required:**
- Add documentation comments to files
- Explain purpose and usage
- Include examples if helpful

**Example:**
```dart
/// Tobank Login Screen
///
/// Matches old tobank login UI exactly.
/// Uses STAC widgets for server-driven UI.
@StacScreen(screenName: 'tobank_login')
StacWidget tobankLoginDart() {
  // ...
}
```

**Why**: Helps other developers understand file purpose.

---

## 🚨 Critical Don'ts for File Organization

1. **DON'T** create files outside defined structure
2. **DON'T** edit `.build/` files manually
3. **DON'T** forget to update `pubspec.yaml` for new folders
4. **DON'T** use wrong naming conventions
5. **DON'T** place `default_stac_options.dart` in wrong location
6. **DON'T** create config files in wrong locations

---

## ✅ File Organization Checklist

Before creating files:

- [ ] Folder structure follows exact pattern
- [ ] Naming conventions followed
- [ ] `pubspec.yaml` updated (if new folder)
- [ ] Files in correct locations
- [ ] Assets referenced from `assets/` folder
- [ ] Documentation added to files

---

## 📋 File Location Reference

| Type | Location | Example |
|------|----------|---------|
| STAC Dart | `lib/stac/tobank/{feature}/dart/` | `tobank_login.dart` |
| STAC JSON | `lib/stac/tobank/{feature}/json/` | `tobank_login.json` |
| API JSON | `lib/stac/tobank/{feature}/api/` | `GET_tobank_login.json` |
| Generated JSON | `lib/stac/.build/` | `tobank_login.json` |
| Config Files | `lib/stac/config/` | `GET_colors.json` |
| Custom Actions | `lib/core/stac/parsers/actions/` | `persian_date_picker_action_parser.dart` |
| Custom Widgets | `lib/core/stac/parsers/widgets/` | `custom_text_form_field_parser.dart` |
| STAC Options | `lib/default_stac_options.dart` | N/A |
| Assets | `assets/` | `assets/icons/icon.svg` |

---

**Next**: Read [07_TESTING_VALIDATION_RULES.md](./07_TESTING_VALIDATION_RULES.md) for testing and validation rules.

