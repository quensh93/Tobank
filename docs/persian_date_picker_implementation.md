# Persian Date Picker Implementation

## Overview

Implemented a custom STAC action for showing a Persian (Jalali) date picker dialog. When the user taps on the birthdate field in the login page, a Persian date picker appears, and the selected date is automatically formatted and stored in the form field.

## Implementation Details

### 1. Package Dependencies

Added to `pubspec.yaml`:
- `persian_datetime_picker: ^3.2.0` - Persian date picker package
- `shamsi_date: ^1.1.1` - Persian calendar support (automatically added as dependency)

### 2. Custom Action Parser

**File**: `lib/core/stac/parsers/actions/persian_date_picker_action_parser.dart`

#### Action Model: `PersianDatePickerActionModel`
- `formFieldId` (required): The form field ID to update (e.g., "birthdate")
- `initialDate` (optional): Initial date to show (format: YYYY/MM/DD)
- `firstDate` (optional): First selectable date (default: 1350/01/01)
- `lastDate` (optional): Last selectable date (default: 1450/12/29)
- `onDateSelected` (optional): Action to execute after date is selected

#### Action Parser: `PersianDatePickerActionParser`
- Shows Persian date picker dialog using `showPersianDatePicker`
- Parses date strings in YYYY/MM/DD format
- Formats selected date as YYYY/MM/DD
- Updates form field value in `StacFormScope.formData`
- Updates registry with `form.{fieldId}` key
- Executes optional `onDateSelected` action

### 3. Registration

**File**: `lib/core/stac/registry/register_custom_parsers.dart`

The action parser is automatically registered via `registerPersianDatePickerActionParser()` in `_registerExampleParsers()`.

### 4. Localization Setup

**File**: `lib/core/bootstrap/app_root.dart`

Added Persian localization delegates to both `StacApp` and `MaterialApp`:
- `PersianMaterialLocalizations.delegate`
- `PersianCupertinoLocalizations.delegate`
- `GlobalMaterialLocalizations.delegate`
- `GlobalWidgetsLocalizations.delegate`
- `GlobalCupertinoLocalizations.delegate`

Set default locale to Persian: `locale: const Locale('fa', 'IR')`

### 5. JSON Configuration Updates

**Files Updated**:
- `lib/stac/tobank/login/json/tobank_login.json`
- `lib/stac/tobank/login/api/GET_tobank_login.json`

#### Changes:
Wrapped the birthdate `textFormField` in a `gestureDetector` with `onTap` action:

```json
{
  "type": "gestureDetector",
  "onTap": {
    "actionType": "persianDatePicker",
    "formFieldId": "birthdate",
    "firstDate": "1350/01/01",
    "lastDate": "1450/12/29"
  },
  "child": {
    "id": "birthdate",
    "type": "textFormField",
    "readOnly": true,
    // ... rest of field configuration
  }
}
```

## Usage

### In JSON:
```json
{
  "type": "gestureDetector",
  "onTap": {
    "actionType": "persianDatePicker",
    "formFieldId": "birthdate",
    "firstDate": "1350/01/01",
    "lastDate": "1450/12/29"
  },
  "child": {
    "id": "birthdate",
    "type": "textFormField",
    "readOnly": true
  }
}
```

### In Dart (for reference):
```dart
StacGestureDetector(
  onTap: PersianDatePickerActionModel(
    formFieldId: 'birthdate',
    firstDate: '1350/01/01',
    lastDate: '1450/12/29',
  ),
  child: StacTextFormField(
    id: 'birthdate',
    readOnly: true,
    // ...
  ),
)
```

## How It Works

1. **User taps** on the birthdate field (wrapped in gestureDetector)
2. **Action triggered**: `persianDatePicker` action is executed
3. **Date picker shown**: Persian date picker dialog appears
4. **Date selected**: User selects a date from the picker
5. **Form updated**: 
   - `formData[birthdate]` is updated with formatted date (YYYY/MM/DD)
   - `StacRegistry` is updated with `form.birthdate` key
   - `setValue` action is executed to trigger any necessary rebuilds
6. **UI reflects change**: The textFormField displays the selected date

## Date Format

Selected dates are formatted as: `YYYY/MM/DD` (e.g., `1403/09/15`)

This format matches the expected format for the API and form submission.

## Testing

To test:
1. Run the app
2. Navigate to login page
3. Tap on the birthdate field
4. Persian date picker should appear
5. Select a date
6. The field should display the selected date in YYYY/MM/DD format
7. Submit the form to verify the date is correctly sent to the API

## Notes

- The date picker uses Persian (Jalali) calendar
- Friday (day 7) is configured as weekend
- Default date range: 1350/01/01 to 1450/12/29
- The form field is `readOnly: true` to prevent manual editing
- Date picker starts in year selection mode for easier navigation
