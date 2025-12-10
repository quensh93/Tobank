# Form Validation for Identity Verification Screen

## Status: ✅ Implementation Complete - Ready for Testing

**Last Updated**: 2025-01-27

### Quick Summary
- ✅ Form field validators added (mobile number & national code) - **Updated in mock API JSON**
- ✅ Form validation action implemented - **Updated in mock API JSON**
- ✅ Success dialog created - **Updated in mock API JSON**
- ✅ Auto-validation configured - **Updated in mock API JSON**
- ✅ Fixed pubspec.yaml asset paths (updated from `stac/` to `lib/stac/`)
- ⚠️ **IMPORTANT**: The app uses mock API JSON files, NOT generated JSON from Dart
- ✅ **CORRECT FILE UPDATED**: `lib/stac/api_mock/login/GET_tobank_login.json`
- ✅ **All validation logic added directly to runtime JSON file**
- ✅ **Fixed form structure** - Moved form to wrap entire body so button can access form scope
- ✅ **Fixed JSON syntax error** - Removed extra closing brace, JSON is now valid
- ✅ **Fixed dialog close action** - Changed from `navigateBack` to `navigate` with `navigationStyle: "pop"`
- ✅ **Removed success dialog** - Replaced with network request
- ✅ **Added POST request** - Sends form data to `https://api.tobank.com/verify-identity`
- ✅ **Created mock API response** - `lib/stac/api_mock/login/POST_verify-identity.json`
- ✅ **Added result dialog** - Shows both request and response data
- ⏳ **Next Step**: Test the POST request and dialog display (form values in dialog may need refinement)

### ⚠️ Important Discovery
The app loads screens from **mock API JSON files** (`lib/stac/api_mock/.../GET_*.json`), NOT from generated JSON (`lib/stac/.build/*.json`). The validation has been added to the correct runtime file.

## Overview

This task involves adding form validation to the identity verification form (احراز هویت) in the pre-launch screen's Tobank Mock menu. The form currently exists but lacks validation. We need to implement validation using STAC package's built-in form validation system.

## Current Situation

### Location
- **Screen**: Pre Launch Screen → Tobank Mock → Menu Item "احراز هویت"
- **Dart File**: `lib/stac/tobank/login/dart/login.dart` (source for reference)
- **Generated JSON**: `lib/stac/.build/tobank_login.json` (generated from Dart, not used at runtime)
- **Mock API JSON**: `lib/stac/api_mock/login/GET_tobank_login.json` ⚠️ **THIS IS THE FILE USED AT RUNTIME**
- **Screen Name**: `tobank_login`

### Current Form Structure

The form contains three input fields:
1. **شماره همراه** (Mobile Number) - `id: 'mobile_number'`
2. **کد ملی** (National Code) - `id: 'national_code'`
3. **تاریخ تولد** (Birth Date) - `id: 'birthdate'`

The form is wrapped in a `StacForm` widget and has a submit button labeled "دریافت کد" (Receive Code).

### Current State
- Form fields are present but have no validation
- Submit button currently navigates to OTP screen without validation
- No validation feedback is shown to users

## Requirements

### Validation Rules

#### 1. شماره همراه (Mobile Number)
- **Field ID**: `mobile_number`
- **Validation Rules**:
  - Must start with "09"
  - Must be exactly 11 digits total
- **Valid Examples**:
  - `09162363723` ✅
- **Invalid Examples**:
  - `90162363723` ❌ (doesn't start with "09")
  - `0916236372` ❌ (only 10 digits, needs 11)

#### 2. کد ملی (National Code)
- **Field ID**: `national_code`
- **Validation Rules**:
  - Must be exactly 10 digits
- **Valid Examples**:
  - `1272125191` ✅
- **Invalid Examples**:
  - `127212519` ❌ (only 9 digits)
  - `12721251911` ❌ (11 digits)

#### 3. تاریخ تولد (Birth Date)
- **Field ID**: `birthdate`
- **Validation Rules**:
  - No validation required for now
  - Field can remain empty or filled

### STAC Form Validation Implementation

#### Using STAC Form Validate Action

The STAC package provides `validateForm` action that should be used for form validation:

```json
{
  "actionType": "validateForm",
  "isValid": {
    // Action to perform if form is valid
  },
  "isNotValid": {
    // Action to perform if form is not valid
  }
}
```

#### Form Field Validation

STAC `textFormField` supports validation through the `validator` property. However, since we're working with JSON generated from Dart, we need to:

1. Add validation logic to the Dart file using STAC's validation system
2. Use `StacFormValidateAction` on the submit button
3. Configure each field with appropriate validation rules

### Success Dialog

When the form is valid and the user taps "دریافت کد":
- Show a dialog with text "success" (or appropriate success message)
- Use STAC's `showDialog` action

## STAC Documentation References

### Form Actions

#### Form Validate Action
- **Class**: `StacFormValidateAction`
- **Properties**:
  - `isValid`: `Map<String, dynamic>` - Action to perform if form is valid
  - `isNotValid`: `Map<String, dynamic>` - Action to perform if form is not valid

**Example JSON**:
```json
{
  "actionType": "validateForm",
  "isValid": {
    "actionType": "showDialog",
    "widget": {
      "type": "text",
      "data": "Form is valid!"
    }
  },
  "isNotValid": {
    "actionType": "showDialog",
    "widget": {
      "type": "text",
      "data": "Form is not valid!"
    }
  }
}
```

#### Get Form Value Action
- **Class**: `StacGetFormValueAction`
- **Properties**:
  - `id`: `String` - The ID of the form field to get

**Example JSON**:
```json
{
  "actionType": "getFormValue",
  "id": "username"
}
```

### Form Widget

The `StacForm` widget supports:
- `autovalidateMode`: Controls when validation occurs
- `child`: The widget to display inside the form

**Example JSON**:
```json
{
  "type": "form",
  "autovalidateMode": "always",
  "child": {
    "type": "column",
    "children": [
      {
        "type": "textFormField",
        "id": "username",
        "decoration": {
          "labelText": "Username"
        }
      }
    ]
  }
}
```

## Implementation Plan

### Phase 1: Add Validation to Form Fields

#### Task 1.1: Add Validator to Mobile Number Field
- [x] Add `validatorRules` property to `StacTextFormField` with `id: 'mobile_number'`
- [x] Validation logic:
  - Check if field starts with "09"
  - Check if field length is exactly 11 digits
  - Return error message if validation fails
- [x] Error message should be in Persian (use data binding if available)
- **Implementation**: Added `validatorRules` with regex pattern `^09\\d{9}\$` and Persian error message "شماره همراه باید با 09 شروع شود و 11 رقم باشد"

#### Task 1.2: Add Validator to National Code Field
- [x] Add `validatorRules` property to `StacTextFormField` with `id: 'national_code'`
- [x] Validation logic:
  - Check if field length is exactly 10 digits
  - Return error message if validation fails
- [x] Error message should be in Persian (use data binding if available)
- **Implementation**: Added `validatorRules` with regex pattern `^\\d{10}\$` and Persian error message "کد ملی باید 10 رقم باشد"

#### Task 1.3: Birth Date Field
- [x] No validation needed for now
- [x] Field can remain as is

### Phase 2: Implement Form Validation Action

#### Task 2.1: Update Submit Button Action
- [x] Replace current `StacNavigateAction` on submit button with `StacFormValidate`
- [x] Configure `isValid` action:
  - Show success dialog with text "success"
  - Use `StacDialogAction` with AlertDialog widget
- [x] Configure `isNotValid` action:
  - Set to `null` to let field validators handle errors automatically
- **Implementation**: Replaced `StacNavigateAction` with `StacFormValidate` action. Success dialog uses `StacAlertDialog` with "success" text and a "تأیید" (Confirm) button that closes the dialog.

#### Task 2.2: Configure Form Auto-Validation
- [x] Set `autovalidateMode` on `StacForm` widget
- [x] Options: `always`, `onUserInteraction`, `disabled`
- [x] Recommended: `onUserInteraction` for better UX
- **Implementation**: Set `autovalidateMode: StacAutovalidateMode.onUserInteraction` on `StacForm` widget

### Phase 3: Success Dialog Implementation

#### Task 3.1: Create Success Dialog
- [x] Use `StacDialogAction` for success dialog
- [x] Dialog content:
  - AlertDialog widget with "success" text message
  - Persian "تأیید" button to dismiss dialog
- [x] Dialog should be dismissible
- **Implementation**: Created `StacAlertDialog` with content text "success" and action button that navigates back to close the dialog

### Phase 4: Testing & Validation

#### Task 4.1: Test Validation Rules
- [ ] Test mobile number validation:
  - Valid: `09162363723`
  - Invalid: `90162363723` (wrong prefix)
  - Invalid: `0916236372` (wrong length)
- [ ] Test national code validation:
  - Valid: `1272125191`
  - Invalid: `127212519` (too short)
  - Invalid: `12721251911` (too long)
- [ ] Test birth date field (should accept any value or empty)

#### Task 4.2: Test Form Submission
- [ ] Test form submission with all valid fields → should show success dialog
- [ ] Test form submission with invalid fields → should show validation errors
- [ ] Test form submission with empty fields → should show validation errors

#### Task 4.3: Update Mock API JSON (Runtime File)
- [x] Fixed pubspec.yaml asset paths (updated from `stac/` to `lib/stac/`)
- [x] Updated mock API JSON file: `lib/stac/api_mock/login/GET_tobank_login.json`
  - ✅ **Fixed form structure** - Moved form to wrap entire body (button was outside form scope)
  - Added `autovalidateMode: "onUserInteraction"` to form
  - Added `validatorRules` to mobile_number field (regex: `^09\\d{9}$`)
  - Added `validatorRules` to national_code field (regex: `^\\d{10}$`)
  - Updated button `onPressed` to use `validateForm` action
  - Added success dialog with AlertDialog widget
- [ ] Test the form in the app (just restart app, no build needed)

## How to Test

### Step 1: Build and Prepare
1. **Run `flutter pub get`** to refresh asset manifest after pubspec.yaml changes (if you haven't already)
2. ⚠️ **NO NEED TO RUN `stac build`** - The app uses mock API JSON files directly, not generated JSON
3. The validation has been added directly to `lib/stac/api_mock/login/GET_tobank_login.json`

### Step 2: Run the App
1. **Start the Flutter app** (any platform: mobile, web, desktop)
2. The app will start at the **Pre Launch Screen**

### Step 3: Navigate to the Form
1. On the **Pre Launch Screen**, tap the **"Tobank Mock"** card (with bank icon)
2. This opens the **Tobank Mock Menu** screen
3. In the menu, find and tap **"احراز هویت"** (Identity Verification)
   - It's the second menu item with a login icon
   - Subtitle: "صفحه ورود و ثبت نام"
4. This will navigate to the **Identity Verification Form** (tobank_login screen)

### Step 4: Test Validation

#### Test Mobile Number Field (شماره همراه)
- **Valid Input**: `09162363723` ✅
  - Should accept without error
- **Invalid - Wrong Prefix**: `90162363723` ❌
  - Should show error: "شماره همراه باید با 09 شروع شود و 11 رقم باشد"
- **Invalid - Wrong Length**: `0916236372` ❌ (10 digits)
  - Should show error: "شماره همراه باید با 09 شروع شود و 11 رقم باشد"
- **Empty Field**: Leave empty and tap submit
  - Should show validation error

#### Test National Code Field (کد ملی)
- **Valid Input**: `1272125191` ✅
  - Should accept without error
- **Invalid - Too Short**: `127212519` ❌ (9 digits)
  - Should show error: "کد ملی باید 10 رقم باشد"
- **Invalid - Too Long**: `12721251911` ❌ (11 digits)
  - Should show error: "کد ملی باید 10 رقم باشد"
- **Empty Field**: Leave empty and tap submit
  - Should show validation error

#### Test Birth Date Field (تاریخ تولد)
- **Any Value or Empty**: Should accept any input (no validation)

#### Test Form Submission
1. **With Valid Fields**:
   - Enter valid mobile: `09162363723`
   - Enter valid national code: `1272125191`
   - Tap **"دریافت کد"** button
   - ✅ Should show success dialog with "success" message
   - Tap "تأیید" to close dialog

2. **With Invalid Fields**:
   - Enter invalid mobile or national code
   - Tap **"دریافت کد"** button
   - ❌ Should show validation errors under invalid fields
   - ❌ Should NOT show success dialog

3. **With Empty Fields**:
   - Leave fields empty
   - Tap **"دریافت کد"** button
   - ❌ Should show validation errors
   - ❌ Should NOT show success dialog

### Expected Behavior
- ✅ Validation errors appear **as you type** (due to `autovalidateMode: onUserInteraction`)
- ✅ Error messages are in **Persian (Farsi)**
- ✅ Success dialog appears **only when all fields are valid**
- ✅ Form does NOT navigate to OTP screen (validation prevents navigation)

## STAC Package Documentation Sources

### Primary Documentation
1. **STAC Form Documentation**: 
   - Location: `docs/App_Docs/stac_docs` (if available)
   - Location: `docs/Archived/.stac` (STAC package clone)

2. **Form Actions Documentation**:
   - Form Validate Action
   - Get Form Value Action
   - Show Dialog Action

### Key Files to Reference
- `lib/stac/tobank/login/dart/login.dart` - Current form implementation
- STAC package source code for validation examples
- Existing form examples in the codebase

## Implementation Notes

### Validation Approach

Since STAC uses JSON for UI definition, validation can be implemented in two ways:

1. **Dart-level validation** (Recommended):
   - Add validators directly in the Dart `StacTextFormField` widgets
   - Use Flutter's `TextFormField` validator pattern
   - STAC will convert this to JSON during build

2. **JSON-level validation**:
   - Add validation rules directly in the generated JSON
   - Requires understanding STAC's JSON validation format

### Error Messages

Error messages should:
- Be in Persian (Farsi) to match the app's language
- Be clear and helpful
- Use data binding if error messages are available in `appStrings`

### Form State Management

STAC's `StacForm` widget manages form state automatically. The `validateForm` action will:
- Check all field validators
- Return validation result
- Execute appropriate action based on result

## Success Criteria

- [x] Mobile number field validates correctly (starts with "09", 11 digits) - **Implemented with regex `^09\\d{9}\$`**
- [x] National code field validates correctly (10 digits) - **Implemented with regex `^\\d{10}\$`**
- [x] Birth date field accepts any value (no validation) - **No validation added as required**
- [x] Form validation action works correctly - **Implemented using `StacFormValidate`**
- [x] Success dialog appears when form is valid and user taps "دریافت کد" - **Implemented with `StacAlertDialog`**
- [x] Validation errors are displayed appropriately - **Error messages in Persian, displayed via `autovalidateMode`**
- [x] Generated JSON contains validation logic - **Updated in mock API JSON file directly**
- [ ] Form works correctly in the app - **Ready to test - just restart app**

## Implementation Status

### ✅ Completed
1. **Form Field Validators**: Added validation rules to mobile number and national code fields
2. **Form Validation Action**: Implemented `StacFormValidate` on submit button
3. **Success Dialog**: Created AlertDialog with success message
4. **Auto-Validation**: Configured form to validate on user interaction
5. **Error Messages**: Added Persian error messages for both fields

### ⏳ Pending
1. **Fix Asset Paths**: ✅ Fixed - Updated pubspec.yaml and critical asset-loading files to use `lib/stac/` instead of `stac/`
   - Updated `pubspec.yaml` asset paths
   - Updated `lib/core/stac/stac_mock_dio_setup.dart`
   - Updated `lib/features/tobank_mock_new/data/theme/tobank_theme_loader.dart`
   - Updated `lib/features/tobank_mock_new/presentation/screens/tobank_mock_new_screen.dart`
   - Updated `lib/core/api/services/mock_api_service.dart`
   - ⚠️ **Note**: There are still references to `stac/.build/` in Dart widget files (e.g., `lib/stac/tobank/.../dart/*.dart`). These will be included in generated JSON. May need to update those paths too, or they may work if Flutter resolves them correctly.
2. **Update Mock API JSON**: ✅ Fixed - Updated the correct file `lib/stac/api_mock/login/GET_tobank_login.json` with validation
3. **Testing**: Ready to test - No build needed, just restart the app:
   - Test valid inputs
   - Test invalid inputs
   - Test form submission flow
   - Verify error messages display correctly
   - Verify success dialog appears
   - Verify asset loading works correctly

### 📝 Implementation Details

#### Validation Rules
- **Mobile Number**: Regex pattern `^09\\d{9}\$` validates:
  - Must start with "09"
  - Must be exactly 11 digits total
  - Error message: "شماره همراه باید با 09 شروع شود و 11 رقم باشد"

- **National Code**: Regex pattern `^\\d{10}\$` validates:
  - Must be exactly 10 digits
  - Error message: "کد ملی باید 10 رقم باشد"

#### Form Validation Flow
1. User interacts with form fields
2. Validation triggers on user interaction (due to `autovalidateMode: onUserInteraction`)
3. User taps "دریافت کد" button
4. `StacFormValidate` action checks all field validators
5. If valid: Shows success dialog with "success" message
6. If invalid: Field validators display error messages (no additional dialog)

#### Files Modified
- ✅ `lib/stac/api_mock/login/GET_tobank_login.json` - **PRIMARY FILE** - Added validation logic, form validation action, and success dialog
- ⚠️ `lib/stac/tobank/login/dart/login.dart` - Also updated for consistency, but app uses mock API JSON at runtime

## Related Files

### Files to Modify
- ✅ `lib/stac/api_mock/login/GET_tobank_login.json` - **PRIMARY FILE** - Mock API JSON used at runtime
- `lib/stac/tobank/login/dart/login.dart` - Source Dart file (updated for consistency)

### Files Generated (Auto-generated, do not edit)
- `lib/stac/.build/tobank_login.json` - Generated from Dart, but NOT used at runtime (app uses mock API JSON)

### Reference Files
- `docs/Archived/.stac/` - STAC package source code
- `docs/App_Docs/stac_docs/` - STAC documentation
- `lib/stac/tobank/login/dart/verify_otp.dart` - Related OTP screen

## Additional Resources

### STAC Form Validation Example

Based on the provided documentation, here's a complete example:

```json
{
  "type": "form",
  "autovalidateMode": "onUserInteraction",
  "child": {
    "type": "column",
    "children": [
      {
        "type": "textFormField",
        "id": "mobile_number",
        "decoration": {
          "labelText": "Mobile Number"
        },
        "validator": {
          // Validation logic here
        }
      },
      {
        "type": "filledButton",
        "child": {
          "type": "text",
          "data": "Submit"
        },
        "onPressed": {
          "actionType": "validateForm",
          "isValid": {
            "actionType": "showDialog",
            "widget": {
              "type": "text",
              "data": "success"
            }
          },
          "isNotValid": {
            "actionType": "showDialog",
            "widget": {
              "type": "text",
              "data": "Form is not valid!"
            }
          }
        }
      }
    ]
  }
}
```

## Notes

- This task focuses ONLY on adding validation, not modifying other form functionality
- The form already exists and works, we're just adding validation
- Use STAC's built-in validation system, don't create custom validation logic
- Ensure validation messages are user-friendly and in Persian
- Test thoroughly with various input combinations
- Remember to rebuild JSON after making Dart changes
