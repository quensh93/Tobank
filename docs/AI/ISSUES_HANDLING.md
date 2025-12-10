# Issues Handling - How to Handle Problems

## 🎯 Overview

This document explains how to handle issues, bugs, and challenges when working on the Tobank STAC SDUI project. **Always check the Issues log first** before attempting to fix problems.

## 📋 Issue Handling Workflow

### Step 1: Check Issues Log

**Location**: `docs/AI/Issues/ISSUES_LOG.md`

**Before doing anything:**
1. Open the Issues log
2. Search for similar issues
3. Check if solution exists
4. If found, follow the documented solution

**What to look for:**
- Similar error messages
- Similar symptoms
- Related components or features
- Common patterns

### Step 2: Understand the Issue

**If issue is not in log:**

1. **Reproduce the issue**
   - Understand when it occurs
   - Note error messages
   - Check logs

2. **Identify the scope**
   - Is it a build error?
   - Is it a runtime error?
   - Is it a UI issue?
   - Is it a framework issue?

3. **Check related documentation**
   - Development workflow
   - Custom components
   - Data binding system
   - Core STAC structure

### Step 3: Investigate

**Based on issue type:**

#### Build Errors
- Check STAC widget syntax
- Verify property types (enum vs string)
- Check `@StacScreen` annotation
- Verify `default_stac_options.dart` exists

#### Runtime Errors
- Check initialization order
- Verify loaders are called
- Check custom parsers are registered
- Verify assets are in `pubspec.yaml`

#### UI Issues
- Check old tobank reference
- Verify colors/styles/strings are loaded
- Check theme-aware colors
- Verify RTL text direction

#### Framework Issues
- Check STAC repository: `docs/Archived/.stac/`
- Check core/stac: `lib/core/stac/`
- Check STAC widget docs: `docs/App_Docs/stac_docs/`

### Step 4: Fix the Issue

**Follow these principles:**

1. **Fix the root cause** - Don't just patch symptoms
2. **Follow project patterns** - Use existing patterns
3. **Test thoroughly** - Verify fix works
4. **Check for side effects** - Ensure no regressions

### Step 5: Document in Issues Log

**If issue was not in log:**

1. **Add to Issues log** using the template:
   ```markdown
   ### Bug #X: [Brief Description]
   **Date**: YYYY-MM-DD
   **Phase**: [Which phase/task]
   
   **Error**:
   ```
   [Paste the exact error message]
   ```
   
   **Root Cause**:
   - [Why did this happen?]
   - [What was misunderstood?]
   
   **Solution**:
   ```dart
   // ❌ WRONG
   [Wrong code]
   
   // ✅ CORRECT
   [Correct code]
   ```
   
   **Prevention**:
   - [How to avoid this in the future]
   - [Which docs to read]
   
   **Related Files**:
   - [List files affected]
   ```

2. **Include:**
   - Clear error message
   - Root cause analysis
   - Solution with code examples
   - Prevention strategies
   - Related files

## 🔍 Common Issue Categories

### 1. Build Errors

**Symptoms:**
- Type errors
- Missing imports
- Syntax errors

**Common Causes:**
- Using strings instead of enums
- Using wrong class types
- Missing annotations

**Solution:**
- Check Issues log for similar errors
- Read STAC widget docs
- Verify property types

### 2. Runtime Errors

**Symptoms:**
- App crashes
- Black screens
- Null errors

**Common Causes:**
- Initialization order
- Missing loaders
- Unregistered parsers
- Missing assets

**Solution:**
- Check initialization flow
- Verify loaders are called
- Check custom parsers registration
- Verify assets in `pubspec.yaml`

### 3. UI Issues

**Symptoms:**
- Wrong colors
- Missing text
- Layout problems

**Common Causes:**
- Colors not loaded
- Strings not loaded
- Wrong variable names
- Hardcoded values

**Solution:**
- Check data binding system
- Verify variables are loaded
- Use theme-aware colors
- Use string variables

### 4. Framework Issues

**Symptoms:**
- STAC framework errors
- Parser not found
- Widget not rendering

**Common Causes:**
- Framework bug
- Missing parser
- Wrong widget type

**Solution:**
- Check STAC repository
- Check core/stac structure
- Verify parser registration

## 📚 Reference Locations for Issues

### Build Errors
- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`
- **STAC Widget Docs**: `docs/App_Docs/stac_docs/`
- **Development Workflow**: `docs/AI/DEVELOPMENT_WORKFLOW.md`

### Runtime Errors
- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`
- **Core STAC Structure**: `docs/AI/CORE_STAC_STRUCTURE.md`
- **Complete Guide**: `docs/TOBANK_STAC_SDUI_COMPLETE_GUIDE.md`

### UI Issues
- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`
- **Data Binding System**: `docs/AI/DATA_BINDING_SYSTEM.md`
- **Old Tobank Reference**: `docs/Archived/.tobank_old/`

### Framework Issues
- **STAC Repository**: `docs/Archived/.stac/`
- **Core STAC Structure**: `docs/AI/CORE_STAC_STRUCTURE.md`
- **STAC Widget Docs**: `docs/App_Docs/stac_docs/`

## 🚨 Critical Rules

1. **Always check Issues log first** - Don't repeat past mistakes
2. **Document new issues** - Help future development
3. **Fix root cause** - Don't just patch symptoms
4. **Test thoroughly** - Verify fix works
5. **Check for side effects** - Ensure no regressions

## 📝 Issue Log Template

When documenting a new issue, use this format:

```markdown
### Bug #X: [Brief Description]
**Date**: YYYY-MM-DD
**Phase**: [Which phase/task]

**Error**:
```
[Paste the exact error message]
```

**Root Cause**:
- [Why did this happen?]
- [What was misunderstood?]

**Solution**:
```dart
// ❌ WRONG
[Wrong code]

// ✅ CORRECT
[Correct code]
```

**Prevention**:
- [How to avoid this in the future]
- [Which docs to read]

**Related Files**:
- [List files affected]
```

## 🔄 Issue Resolution Checklist

- [ ] Checked Issues log
- [ ] Reproduced the issue
- [ ] Identified root cause
- [ ] Checked related documentation
- [ ] Fixed the issue
- [ ] Tested the fix
- [ ] Documented in Issues log (if new)
- [ ] Verified no side effects

## 📚 Related Documentation

- **Issues Log**: `docs/AI/Issues/ISSUES_LOG.md`
- **Development Workflow**: `docs/AI/DEVELOPMENT_WORKFLOW.md`
- **Complete Guide**: `docs/TOBANK_STAC_SDUI_COMPLETE_GUIDE.md`
- **Reference Locations**: `docs/AI/REFERENCE_LOCATIONS.md`

---

**Remember**: Always check the Issues log first! Most problems have been encountered and solved before.

