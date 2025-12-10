# Theme Comparison: Reference vs Current JSON Configuration

## Reference Theme Analysis (`main_theme.dart`)

### Color Properties in Reference:

#### Light Theme Colors:
- `primary`: #D61F2C ✅
- `onPrimaryContainer`: #D61F2C with alpha 15 ❌ **MISSING**
- `secondary`: #00BABA ✅
- `onSecondary`: #66D6D6 ❌ **MISSING** (we have #ffffff)
- `secondaryContainer`: #00BABA with alpha 10 ❌ **MISSING**
- `tertiary`: #F7941D ❌ **MISSING**
- `onTertiary`: #FCB900 ❌ **MISSING**
- `onTertiaryContainer`: #FFF9EA ❌ **MISSING**
- `surface`: #F9FAFB ✅ (as background.surface)
- `onSurface`: #EFEFEF ❌ **MISSING** (we have #101828 - different!)
- `onSurfaceVariant`: #E2E2E2 ❌ **MISSING**
- `surfaceContainerLowest`: #D9D9D9 ❌ **MISSING**
- `surfaceContainerLow`: #344054 with alpha 35 ❌ **MISSING**
- `surfaceContainer`: #7D7D7D ❌ **MISSING**
- `surfaceContainerHigh`: #344054 ❌ **MISSING**
- `green`: #039855 ✅ (as success)
- `white`: #FFFFFF ❌ **MISSING**
- `staticWhite`: #FFFFFF ❌ **MISSING**
- `black`: #101828 ❌ **MISSING**

#### Dark Theme Colors:
- `primary`: #D61F2C ✅
- `onPrimaryContainer`: #D61F2C with alpha 15 ❌ **MISSING**
- `secondary`: #00BABA ✅
- `onSecondary`: #66D6D6 ❌ **MISSING** (we have #f3f3f6)
- `secondaryContainer`: #00BABA with alpha 10 ❌ **MISSING**
- `tertiary`: #F7941D ❌ **MISSING**
- `onTertiary`: #FCB900 ❌ **MISSING**
- `onTertiaryContainer`: #FFF9EA ❌ **MISSING**
- `surface`: #202633 ✅ (as background.surface)
- `onSurface`: #7D7D7D ❌ **MISSING** (we have #ececec - different!)
- `onSurfaceVariant`: #7D7D7D ❌ **MISSING**
- `surfaceContainerLowest`: #7D7D7D ❌ **MISSING**
- `surfaceContainerLow`: #344054 with alpha 35 ❌ **MISSING**
- `surfaceContainer`: #D9D9D9 ❌ **MISSING**
- `surfaceContainerHigh`: #D9D9D9 ❌ **MISSING**
- `green`: #039855 ✅ (as success)
- `white`: #101828 ❌ **MISSING**
- `staticWhite`: #FFFFFF ❌ **MISSING**
- `black`: #FFFFFF ❌ **MISSING**

### Text Theme Properties in Reference:

#### Light Theme Text Styles:
- `titleLarge`: fontWeight 700, color #101828, fontSize 16, fontFamily IranYekan ❌ **MISSING**
- `titleMedium`: fontWeight 500, color #101828, fontSize 16, fontFamily IranYekan ❌ **MISSING**
- `titleSmall`: fontWeight 400, color #101828, fontSize 16, fontFamily IranYekan ❌ **MISSING**
- `labelSmall`: fontWeight 400, color #101828, fontSize 10, fontFamily IranYekan ❌ **MISSING**
- `bodyLarge`: fontWeight 400, color #101828, fontSize 14, fontFamily IranYekan ❌ **MISSING**
- `bodyMedium`: fontWeight 400, color #101828, fontSize 12, fontFamily IranYekan ❌ **MISSING**

#### Dark Theme Text Styles:
- `titleLarge`: fontWeight 700, color #FFFFFF, fontSize 16, fontFamily IranYekan ❌ **MISSING**
- `titleMedium`: fontWeight 500, color #FFFFFF, fontSize 16, fontFamily IranYekan ❌ **MISSING**
- `titleSmall`: fontWeight 400, color #FFFFFF, fontSize 16, fontFamily IranYekan ❌ **MISSING**
- `labelSmall`: fontWeight 400, color #FFFFFF, fontSize 10, fontFamily IranYekan ❌ **MISSING**
- `bodyLarge`: fontWeight 400, color #FFFFFF, fontSize 14, fontFamily IranYekan ❌ **MISSING**
- `bodyMedium`: fontWeight 400, color #FFFFFF, fontSize 12, fontFamily IranYekan ❌ **MISSING**

## Current JSON Configuration Analysis

### GET_colors.json - What We Have:
✅ `primary.color` and `primary.onPrimary`
✅ `secondary.color` and `secondary.onSecondary` (but wrong values)
✅ `background.surface` and `background.onSurface` (but wrong values)
✅ `button.primary.backgroundColor` and `button.primary.foregroundColor`
✅ `text.title`, `text.subtitle`, `text.hint`
✅ `input.hint`, `input.borderEnabled`, `input.borderFocused`
✅ `error.color`, `success.color`, `warning.color`

### GET_styles.json - What We Have:
✅ Button styles (primary)
✅ Input styles (login, loginDatePicker)
✅ Text styles (pageTitle, subtitle, label, agreementRegular, agreementLink)

## Missing Properties Summary

### Colors Missing:
1. **Tertiary colors**: tertiary, onTertiary, onTertiaryContainer
2. **Container colors**: onPrimaryContainer, secondaryContainer, surfaceContainer variants
3. **Surface variants**: onSurfaceVariant, surfaceContainerLowest, surfaceContainerLow, surfaceContainer, surfaceContainerHigh
4. **Base colors**: white, staticWhite, black
5. **Incorrect values**: onSecondary, onSurface

### Text Theme Missing:
1. **Standard text styles**: titleLarge, titleMedium, titleSmall, labelSmall, bodyLarge, bodyMedium
2. **Font family**: IranYekan (not specified in styles)
3. **Complete text theme structure** matching reference

## Action Required

Update `GET_colors.json` and `GET_styles.json` to include all missing properties from the reference theme.
