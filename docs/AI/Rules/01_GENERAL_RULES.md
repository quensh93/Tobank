# General Rules - Tobank STAC SDUI

## 🎯 Mandatory Rules for All Tasks

### Rule 1: Always Check Issues Log First
**Priority**: CRITICAL  
**Location**: `docs/AI/Issues/ISSUES_LOG.md`

**Action Required:**
- Before starting ANY task, read the Issues log
- Search for similar issues or errors
- If issue exists, follow the documented solution
- If issue is new, document it after fixing

**Why**: Prevents repeating past mistakes and saves time.

---

### Rule 2: UI Must Match Old Tobank Exactly
**Priority**: CRITICAL  
**Location**: `docs/Archived/.tobank_old/lib/ui/`

**Action Required:**
- Before creating any page, check the old tobank reference
- Match UI elements exactly: spacing, colors, layout, text
- Use assets from `assets/` folder (copied from old tobank)
- Verify visual appearance matches old app

**Why**: Consistency with existing app design and user expectations.

---

### Rule 3: Follow Three-Source Workflow
**Priority**: CRITICAL  
**Workflow**: Dart → Build JSON → API JSON

**Action Required:**
1. **Always start with Dart** - Create `lib/stac/tobank/{feature}/dart/{feature}.dart`
2. **Preview in app** - Test Dart widget before building
3. **Build JSON** - Run `stac build` to generate JSON
4. **Create API JSON** - Copy to `api/GET_{feature}.json` and wrap

**Why**: Ensures consistency and allows preview before finalization.

---

### Rule 4: Read Documentation Before Starting
**Priority**: HIGH  
**Required Reading:**
- `docs/AI/PROJECT_OVERVIEW.md` - Understand project structure
- `docs/AI/DEVELOPMENT_WORKFLOW.md` - Understand workflow
- `docs/App_Docs/stac_docs/` - Understand STAC widget syntax

**Action Required:**
- Read relevant documentation before coding
- Understand widget properties and types
- Check examples in existing code

**Why**: Prevents type errors and ensures correct implementation.

---

### Rule 5: Use Reference Locations
**Priority**: HIGH

**When to use each reference:**
- **STAC Widget Docs** (`docs/App_Docs/stac_docs/`): Before creating STAC Dart pages
- **Old Tobank Reference** (`docs/Archived/.tobank_old/`): When matching UI
- **STAC Repository** (`docs/Archived/.stac/`): When facing framework-level issues
- **Core STAC** (`lib/core/stac/`): When understanding custom components

**Action Required:**
- Know which reference to use for each situation
- Check `docs/AI/REFERENCE_LOCATIONS.md` for guidance

**Why**: Ensures using correct resources for each task.

---

### Rule 6: Never Edit Generated Files
**Priority**: CRITICAL  
**Location**: `lib/stac/.build/`

**Action Required:**
- **NEVER** manually edit files in `.build/` folder
- Always edit Dart source files
- Run `stac build` to regenerate JSON

**Why**: Generated files are overwritten on each build.

---

### Rule 7: Always Use Variables, Never Hardcode
**Priority**: CRITICAL

**Action Required:**
- **Colors**: Use `{{appColors.current.*}}` - NEVER hardcode hex colors
- **Strings**: Use `{{appStrings.*}}` - NEVER hardcode text
- **Styles**: Use `{{appStyles.*}}` - NEVER define inline styles

**Why**: Enables theming, localization, and reduces JSON size.

---

### Rule 8: Document New Issues
**Priority**: HIGH  
**Location**: `docs/AI/Issues/ISSUES_LOG.md`

**Action Required:**
- When encountering a new issue, document it
- Use the issue log template
- Include error, root cause, solution, and prevention

**Why**: Helps future development and prevents repeating mistakes.

---

### Rule 9: Test Before Completing
**Priority**: HIGH

**Action Required:**
- Preview Dart widget in app
- Test all interactions
- Verify UI matches old tobank
- Test in both light and dark themes
- Verify all variables resolve correctly

**Why**: Ensures quality and prevents regressions.

---

### Rule 10: Follow File Organization Rules
**Priority**: HIGH

**Action Required:**
- Follow exact folder structure: `dart/`, `json/`, `api/`
- Use correct naming conventions
- Update `pubspec.yaml` when adding new asset folders
- Keep files organized by feature

**Why**: Maintains project consistency and organization.

---

## 🚨 Critical Don'ts

1. **DON'T** edit `.build/` files manually
2. **DON'T** use hardcoded colors or strings
3. **DON'T** skip checking Issues log
4. **DON'T** create pages without checking old tobank reference
5. **DON'T** use `{{appColors.light.*}}` - use `{{appColors.current.*}}`
6. **DON'T** define inline style objects - use style aliases
7. **DON'T** skip preview/testing
8. **DON'T** forget to document new issues

---

## ✅ Mandatory Checklist

Before considering any task complete:

- [ ] Issues log checked
- [ ] Old tobank reference checked (for UI pages)
- [ ] Documentation read
- [ ] Workflow followed (Dart → JSON → API)
- [ ] Variables used (no hardcoding)
- [ ] Previewed and tested
- [ ] UI matches old tobank (for UI pages)
- [ ] Files organized correctly
- [ ] New issues documented (if encountered)

---

**Next**: Read [02_STAC_PAGE_CREATION_RULES.md](./02_STAC_PAGE_CREATION_RULES.md) for specific rules on creating STAC pages.

