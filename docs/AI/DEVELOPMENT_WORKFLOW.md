# Development Workflow - Creating STAC Pages

## 🎯 Overview

This document explains the complete workflow for creating new STAC pages in the Tobank SDUI project. **Always follow this workflow** to ensure consistency and avoid issues.

## 📋 Workflow Steps

### Step 1: Prepare Reference Material

**Before writing any code:**

1. **Check old tobank reference**:
   - Location: `docs/Archived/.tobank_old/lib/ui/`
   - Find the corresponding screen in old tobank
   - Note: UI, layout, colors, spacing, text

2. **Read STAC widget docs**:
   - Location: `docs/App_Docs/stac_docs/`
   - Read relevant widget documentation (e.g., `widgets_scaffold.md`, `widgets_textformfield.md`)
   - Understand widget properties and syntax

3. **Check existing examples**:
   - Location: `lib/stac/tobank/login/dart/` (example: `tobank_login.dart`)
   - Study how similar screens are structured
   - Note patterns and conventions

4. **Check Issues log**:
   - Location: `docs/AI/Issues/ISSUES_LOG.md`
   - See if similar issues were encountered
   - Learn from past mistakes

### Step 2: Create Feature Folder Structure

**Create the folder structure:**

```
lib/stac/tobank/{feature_name}/
├── dart/
│   └── {feature_name}.dart
├── json/
│   └── {feature_name}.json (optional)
└── api/
    └── GET_{feature_name}.json (created later)
```

**Example:**
```
lib/stac/tobank/account/
├── dart/
│   └── account_overview.dart
├── json/
└── api/
```

### Step 3: Write STAC Dart Widget

**Create the Dart file** in `dart/{feature_name}.dart`:

```dart
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';

/// Tobank {Feature Name} screen
/// 
/// Matches old tobank UI exactly.
@StacScreen(screenName: 'tobank_{feature_name}')
StacWidget tobank{FeatureName}Dart() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.{feature}.title}}',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
      ),
      centerTitle: true,
    ),
    body: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      textDirection: StacTextDirection.rtl,
      children: [
        // Your widgets here
      ],
    ),
  );
}
```

**Key Rules for Dart Code:**

1. **Use `@StacScreen` annotation** with `screenName`
2. **Always use RTL** (`textDirection: StacTextDirection.rtl`)
3. **Use style aliases** (`StacAliasTextStyle('{{appStyles.*}}')`)
4. **Use theme-aware colors** (`{{appColors.current.*}}`)
5. **Use string variables** (`{{appStrings.*}}`)
6. **Match old UI exactly** - spacing, colors, layout

### Step 4: Preview in App

**Test the Dart widget directly:**

1. Create a screen that loads the Dart widget:
   ```dart
   // In lib/features/tobank_mock_new/presentation/screens/
   class Tobank{Feature}DartScreen extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       final stacWidget = tobank{Feature}Dart();
       final json = stacWidget.toJson();
       return Stac.fromJson(json, context) ?? const SizedBox.shrink();
     }
   }
   ```

2. Navigate to the screen in app
3. Verify UI matches old tobank
4. Test interactions and behavior
5. Fix any issues in Dart code

### Step 5: Build JSON from Dart

**🚨🚨🚨 CRITICAL: This step MUST work - This is THE WHOLE POINT of using Dart STAC syntax!**

**The entire workflow depends on `stac build` working. If it fails, STOP EVERYTHING and fix it first.**

**Run STAC build command:**

```bash
stac build
```

**What happens:**
- Reads Dart files from `lib/stac/tobank/`
- Generates JSON in `lib/stac/.build/`
- Output: `tobank_{feature_name}.json`

**🚨 If build fails - MANDATORY ACTIONS:**
1. **STOP everything immediately** - Do NOT manually edit JSON
2. **DO NOT proceed with manual updates** - Fix the build issue first
3. **This is CRITICAL** - The whole system depends on Dart → JSON generation
4. **Fix the build issue** - Check:
   - Flutter SDK version and dependencies
   - `@StacScreen` annotation exists and is correct
   - `default_stac_options.dart` exists in `lib/`
   - Dart code compiles without errors
   - STAC CLI is properly installed
5. **Once build works**, use the generated JSON - Never manually edit

**Verify generated JSON:**
- Check `lib/stac/.build/tobank_{feature_name}.json`
- Ensure all widgets converted correctly
- Variables should be preserved: `{{appStrings.*}}`, `{{appColors.*}}`
- **DO NOT manually edit** - regenerated on each build
- **Always use generated JSON** - Never manually update JSON files

### Step 6: Create API JSON (Mock Response)

**Create the API mock file:**

1. **Location**: `lib/stac/tobank/{feature}/api/GET_tobank_{feature}.json`

2. **Format as API response**:
   ```json
   {
     "GET": {
       "statusCode": 200,
       "data": {
         // Copy content from .build/tobank_{feature}.json here
         // OR reference it if using dynamicView
       }
     }
   }
   ```

3. **Option 1: Direct copy** (for simple screens):
   - Copy entire JSON from `.build/` into `data` field
   
4. **Option 2: Reference** (for dynamic screens):
   - Use `dynamicView` to load from another file
   - Or use network request to load JSON

**Update pubspec.yaml** (if new folder):
```yaml
flutter:
  assets:
    - lib/stac/tobank/{feature}/api/
```

**Run:**
```bash
flutter pub get
```

### Step 7: Use in App

**Load from API** (recommended):
```dart
StacNavigateAction(
  request: StacNetworkRequest(
    url: 'https://api.tobank.com/screens/tobank_{feature}',
    method: Method.get,
  ),
  navigationStyle: NavigationStyle.push,
)
```

**Or load from asset** (alternative):
```dart
StacNavigateAction(
  assetPath: 'lib/stac/.build/tobank_{feature}.json',
  navigationStyle: NavigationStyle.push,
)
```

## 🔄 Complete Workflow Diagram

```
┌─────────────────────────────────────────────────────────┐
│ 1. PREPARE                                              │
│    - Check old tobank reference                         │
│    - Read STAC widget docs                             │
│    - Check existing examples                           │
│    - Check Issues log                                  │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 2. CREATE FOLDER STRUCTURE                              │
│    lib/stac/tobank/{feature}/                           │
│    ├── dart/                                            │
│    ├── json/                                            │
│    └── api/                                             │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 3. WRITE DART WIDGET                                    │
│    lib/stac/tobank/{feature}/dart/{feature}.dart       │
│    - Use @StacScreen annotation                        │
│    - Match old UI exactly                              │
│    - Use style aliases, theme-aware colors             │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 4. PREVIEW IN APP                                       │
│    - Create Dart screen wrapper                         │
│    - Navigate and test                                 │
│    - Verify UI matches old tobank                       │
│    - Fix issues in Dart                                │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 5. BUILD JSON                                           │
│    stac build                                           │
│    ↓                                                     │
│    lib/stac/.build/tobank_{feature}.json               │
│    (Auto-generated, DO NOT edit manually)             │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 6. CREATE API JSON                                      │
│    lib/stac/tobank/{feature}/api/GET_{feature}.json   │
│    - Wrap in {"GET": {"data": {...}}}                  │
│    - Copy from .build/ or reference                     │
│    - Update pubspec.yaml                               │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 7. USE IN APP                                           │
│    - Navigation loads from API URL or asset path        │
│    - Mock interceptor maps URL → API JSON file         │
└─────────────────────────────────────────────────────────┘
```

## ✅ Checklist

Before considering a page complete:

- [ ] Dart widget written and matches old UI
- [ ] Previewed in app and tested interactions
- [ ] `stac build` run successfully
- [ ] Generated JSON verified
- [ ] API JSON file created and wrapped correctly
- [ ] `pubspec.yaml` updated if new folder
- [ ] Navigation tested in app
- [ ] Colors, styles, strings use variables
- [ ] Style aliases used (not inline styles)
- [ ] Theme-aware colors used (`appColors.current.*`)
- [ ] RTL text direction set correctly
- [ ] Assets referenced correctly

## 🚨 Common Mistakes to Avoid

1. **❌ Editing `.build/` JSON manually** - Always edit Dart, rebuild
2. **❌ Using `{{appColors.light.*}}`** - Use `{{appColors.current.*}}`
3. **❌ Inline styles** - Use style aliases from `GET_styles.json`
4. **❌ Hardcoded strings** - Use `{{appStrings.*}}`
5. **❌ Skipping preview** - Always preview Dart before building
6. **❌ Not matching old UI** - Must match old tobank exactly
7. **❌ Forgetting `@StacScreen`** - Required for `stac build`

## 📚 Related Documentation

- **STAC Widget Docs**: `docs/App_Docs/stac_docs/`
- **Complete Guide**: `docs/TOBANK_STAC_SDUI_COMPLETE_GUIDE.md`
- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`
- **Custom Components**: `docs/AI/CUSTOM_COMPONENTS.md`

---

**Next Steps**: Read [CUSTOM_COMPONENTS.md](./CUSTOM_COMPONENTS.md) to learn about creating custom actions and parsers.

