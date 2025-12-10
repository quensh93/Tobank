# Testing and Validation Rules

## 🎯 Mandatory Rules for Testing and Validation

### Rule 1: Always Preview Dart Before Building
**Priority**: CRITICAL

**Action Required:**
1. Create Dart widget
2. Create screen wrapper to preview
3. Navigate to screen in app
4. Verify UI matches old tobank
5. Test all interactions
6. Fix any issues in Dart
7. Only then run `stac build`

**Why**: Catches issues early and saves time.

---

### Rule 2: Test in Both Light and Dark Themes
**Priority**: HIGH

**Action Required:**
- Test page in light theme
- Test page in dark theme
- Verify colors adapt correctly
- Verify text is readable in both themes
- Verify all UI elements visible in both themes

**Why**: Ensures theme support works correctly.

---

### Rule 3: Verify All Variables Resolve
**Priority**: CRITICAL

**Action Required:**
- Check that all `{{appStrings.*}}` variables resolve
- Check that all `{{appColors.current.*}}` variables resolve
- Check that all `{{appStyles.*}}` variables resolve
- Verify no literal `{{variable}}` text appears

**Debug:**
```dart
// Check variable in registry
final value = StacRegistry.instance.getValue('appStrings.login.title');
if (value == null) {
  print('⚠️ Variable not found!');
}
```

**Why**: Ensures data binding works correctly.

---

### Rule 4: Test All Interactions
**Priority**: HIGH

**Action Required:**
- Test all buttons and actions
- Test form field interactions
- Test navigation
- Test custom actions (e.g., date picker)
- Verify all interactions work as expected

**Why**: Ensures functionality works correctly.

---

### Rule 5: Verify UI Matches Old Tobank
**Priority**: CRITICAL

**Action Required:**
- Compare side-by-side with old tobank reference
- Verify spacing matches
- Verify colors match
- Verify layout matches
- Verify text matches
- Verify all visual elements match

**Why**: Ensures UI consistency with existing app.

---

### Rule 6: Test Form Validation
**Priority**: HIGH

**Action Required:**
- Test all form field validations
- Verify error messages appear correctly
- Test form submission
- Verify form data is collected correctly

**Why**: Ensures forms work correctly.

---

### Rule 7: Test Custom Actions
**Priority**: HIGH

**Action Required:**
- Test all custom actions (e.g., date picker)
- Verify actions trigger correctly
- Verify actions update form/data correctly
- Test error handling in actions

**Why**: Ensures custom components work correctly.

---

### Rule 8: Verify Generated JSON
**Priority**: HIGH

**Action Required:**
- After `stac build`, check generated JSON
- Verify all widgets converted correctly
- Verify variables preserved
- Check for any conversion errors

**Why**: Ensures JSON generation works correctly.

---

### Rule 9: Test API JSON Loading
**Priority**: HIGH

**Action Required:**
- Test loading screen from API JSON
- Verify mock interceptor works
- Test navigation to screen
- Verify screen renders correctly

**Why**: Ensures API JSON works correctly.

---

### Rule 10: Check for Console Errors
**Priority**: HIGH

**Action Required:**
- Monitor console for errors
- Check for warnings
- Verify no critical errors
- Fix any issues found

**Why**: Ensures app stability.

---

### Rule 11: Test on Different Screen Sizes
**Priority**: MEDIUM

**Action Required:**
- Test on different device sizes
- Verify layout adapts correctly
- Check for overflow issues
- Verify responsive design works

**Why**: Ensures app works on all devices.

---

### Rule 12: Verify Assets Load Correctly
**Priority**: MEDIUM

**Action Required:**
- Check all images load
- Verify icons display correctly
- Check fonts load correctly
- Verify asset paths are correct

**Why**: Ensures visual elements display correctly.

---

## 🚨 Critical Don'ts for Testing

1. **DON'T** skip preview before building
2. **DON'T** test only in one theme
3. **DON'T** skip variable resolution checks
4. **DON'T** skip UI matching verification
5. **DON'T** ignore console errors
6. **DON'T** skip interaction testing

---

## ✅ Testing Checklist

Before considering a page complete:

- [ ] Dart widget previewed in app
- [ ] UI matches old tobank exactly
- [ ] Tested in light theme
- [ ] Tested in dark theme
- [ ] All variables resolve correctly
- [ ] All interactions tested
- [ ] Form validation tested
- [ ] Custom actions tested
- [ ] Generated JSON verified
- [ ] API JSON loading tested
- [ ] No console errors
- [ ] Assets load correctly

---

## 📋 Testing Workflow

```
1. Create Dart Widget
   ↓
2. Preview in App
   ↓
3. Test Interactions
   ↓
4. Verify UI Matches Old Tobank
   ↓
5. Test in Both Themes
   ↓
6. Verify Variables Resolve
   ↓
7. Fix Issues
   ↓
8. Build JSON
   ↓
9. Verify Generated JSON
   ↓
10. Create API JSON
   ↓
11. Test API JSON Loading
   ↓
12. Final Verification
```

---

**Next**: Read [README.md](../README.md) for complete documentation index.

