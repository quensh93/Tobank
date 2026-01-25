# Quick Rules - Tobank STAC SDUI

> **One-page reference for AI agents. Read this first before any task.**

## 🚨 Critical Rules (MUST DO)

### Before Starting
- ✅ Check `docs/AI/Issues/ISSUES_LOG.md` first
- ✅ Check old tobank reference: `docs/Archived/.tobank_old/lib/ui/`
- ✅ Read STAC widget docs: `docs/App_Docs/stac_docs/`

### Creating STAC Pages
1. **Create Dart** → `lib/stac/tobank/{feature}/dart/{feature}.dart`
2. **Preview in app** → Test before building
3. **🚨🚨🚨 CRITICAL: Build JSON MUST WORK** → Run `stac build`
   - **Copy file to `ready_for_build`** → Only files in `lib/stac/ready_for_build/` are built
   - **🚨 IF BUILD FAILS, STOP EVERYTHING AND FIX IT FIRST**
   - **This is THE WHOLE POINT of using Dart STAC syntax** - to generate JSON from Dart
   - **NEVER manually update JSON files** - Always use `stac build` to generate from Dart
   - **Dart is the ONLY source of truth** - JSON must ALWAYS be generated from Dart
   - **If you can't build, the workflow is broken** - Fix build issues immediately
   - **Never proceed with manual JSON edits** - Fix the build, then use generated JSON
4. **Create API JSON** → `api/GET_tobank_{feature}.json` (wrap in `{"GET": {"data": {...}}}`)

### Code Style
- ❌ `fontWeight: 'bold'` → ✅ `fontWeight: StacFontWeight.bold`
- ❌ `borderRadius: 12` → ✅ `borderRadius: StacBorderRadius.all(12)`
- ❌ `StacTextStyle(...)` → ✅ `StacCustomTextStyle(...)` or `StacAliasTextStyle('{{appStyles.*}}')`
- ❌ `color: '#101828'` → ✅ `color: '{{appColors.current.text.title}}'`
- ❌ `data: 'Text'` → ✅ `data: '{{appStrings.section.key}}'`

### Data Binding
- ✅ Always use `{{appColors.current.*}}` (NOT `{{appColors.light.*}}`)
- ✅ Always use style aliases: `StacAliasTextStyle('{{appStyles.styleName}}')`
- ✅ Never hardcode colors or strings
- ✅ Colors loaded before styles

### File Structure
```
lib/stac/tobank/{feature}/
├── dart/{feature}.dart
├── json/{feature}.json (optional)
└── api/GET_tobank_{feature}.json
```

### Required Annotations
```dart
@StacScreen(screenName: 'tobank_{feature}')
StacWidget tobank{Feature}Dart() {
  return StacScaffold(
    // Always use RTL
    textDirection: StacTextDirection.rtl,
    // ...
  );
}
```

## 🚫 Critical Don'ts

- ❌ Don't edit `.build/` files (auto-generated)
- ❌ Don't hardcode colors/strings
- ❌ Don't use inline styles (use aliases)
- ❌ Don't use `{{appColors.light.*}}` (use `current.*`)
- ❌ Don't skip preview/testing
- ❌ Don't forget `@StacScreen` annotation
- ❌ Don't use strings for enums

## ✅ Quick Checklist

Before completing any task:
- [ ] Issues log checked
- [ ] Old tobank reference checked (for UI)
- [ ] Variables used (no hardcoding)
- [ ] Style aliases used
- [ ] Theme-aware colors used
- [ ] RTL text direction set
- [ ] Previewed and tested
- [ ] `stac build` run
- [ ] API JSON created

## 📍 Key Locations

- **Issues**: `docs/AI/Issues/ISSUES_LOG.md`
- **Old UI**: `docs/Archived/.tobank_old/lib/ui/`
- **STAC Docs**: `docs/App_Docs/stac_docs/`
- **STAC Repo**: `docs/Archived/.stac/` (framework issues)
- **Assets**: `assets/` (not old tobank folder)

## 🔧 Common Fixes

**Type Error?** → Check if using enum (not string) or object (not primitive)

**Variable Not Resolving?** → Check loaders called, variable name correct

**UI Doesn't Match?** → Check old tobank reference, verify spacing/colors

**Build Fails?** → **🚨🚨🚨 STOP EVERYTHING - FIX BUILD FIRST!**
- **This is CRITICAL** - The entire workflow depends on `stac build` working
- **Do NOT manually edit JSON** - Fix the build issue instead
- **Check file is in `ready_for_build`** - Only files there are built
- Check `@StacScreen` annotation exists and is correct
- Check `default_stac_options.dart` in `lib/` exists
- Check Flutter SDK/dependencies are correct
- Check for compilation errors in Dart code
- **Never proceed without fixing build** - Dart → JSON build is THE CORE WORKFLOW
- **If build doesn't work, the whole system is broken** - Fix it before doing anything else

---

**That's it! For details, see other docs in `docs/AI/`**