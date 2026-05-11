# Bottom Sheet Action Migration Guide (Custom Action -> `StacShowBottomSheetAction`)

This guide explains exactly how to convert a screen that uses a dedicated custom action class (like `StacShowGiftCardPurchaseBottomSheetAction`) into an inline `StacShowBottomSheetAction` + local sheet widget, **without changing bottom sheet content/behavior**.

## What was changed in the reference case

Reference file:
- `lib/stac/tobank/flows/gift_card_real/dart/gift_card_real_intro.dart`

### 1) Replace button action usage
Before:
```dart
onPressed: const StacShowGiftCardPurchaseBottomSheetAction(
  continueAction: StacNavigateAction(
    routeName: 'gift_card_real_select_amount',
    navigationStyle: NavigationStyle.push,
  ),
),
```

After:
```dart
onPressed: _giftCardPurchaseBottomSheetAction(),
```

### 2) Add action factory method
```dart
StacAction _giftCardPurchaseBottomSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#00000000',
    sheet: _giftCardPurchaseBottomSheet().toJson(),
  );
}
```

### 3) Add local sheet widget function
A local `StacWidget` function was added (`_giftCardPurchaseBottomSheet`) and used as sheet content.

Important: content texts, layout structure, CTA label, and action flow were kept equivalent to previous behavior.

### 4) Add required imports
When using local state + reactive button in the sheet, these imports are needed:
```dart
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
```

## Critical typing rules for `StacCustomReactiveElevatedButton`

`StacCustomReactiveElevatedButton` expects `Map<String, dynamic>?` for style/child fields.

Use:
- `style: StacButtonStyle(...).toJson()`
- `disabledStyle: StacButtonStyle(...).toJson()`
- `child: StacText(...).toJson()`

Do **not** use:
- `style: StacButtonStyle(...)` (without `.toJson()`)
- `disabledBackgroundColor` / `disabledForegroundColor` (these params are not defined)
- `child: StacText(...)` (without `.toJson()`)

## Reusable migration checklist for other bottom sheets

1. Find old usage:
```bash
rg -n "StacShow.*BottomSheetAction\(" lib/stac -S
```

2. In target screen, replace old action in `onPressed` / `onTap` with a local function returning `StacShowBottomSheetAction`.

3. Add a local `_yourSheetAction()`:
```dart
StacAction _yourSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#00000000',
    sheet: _yourSheetWidget().toJson(),
  );
}
```

4. Add `_yourSheetWidget()` and copy structure/content 1:1 from previous behavior (no UX/content changes).

5. If the sheet has interactive state (checkbox, enable/disable button, etc.), wrap with `StacStatefulWidget` and initialize keys with `StacCustomSetValueAction`.

6. For reactive buttons, convert style/child to JSON maps exactly as noted above.

7. Run formatter/analyzer on changed file(s):
```bash
dart format <file>
dart analyze <file>
```

## Minimal template

```dart
StacAction _openSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#00000000',
    sheet: _buildSheet().toJson(),
  );
}

StacWidget _buildSheet() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(key: 'localKey', value: false),
    child: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: const StacBorderRadius.only(topLeft: 12, topRight: 12),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.only(left: 16, top: 12, right: 16, bottom: 16),
        child: StacColumn(
          mainAxisSize: StacMainAxisSize.min,
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            // Keep existing content/behavior unchanged
            StacCustomReactiveElevatedButton(
              enabledKey: 'localKey',
              onPressed: const StacNavigateAction(
                routeName: 'next_route',
                navigationStyle: NavigationStyle.push,
              ),
              style: StacButtonStyle(
                fixedSize: StacSize(999999, 56),
                backgroundColor: '{{appColors.current.primary.color}}',
              ).toJson(),
              disabledStyle: StacButtonStyle(
                fixedSize: StacSize(999999, 56),
                backgroundColor:
                    '{{appColors.current.button.disabled.backgroundColor}}',
              ).toJson(),
              child: StacText(
                data: 'ادامه',
                textDirection: StacTextDirection.rtl,
              ).toJson(),
            ),
          ],
        ),
      ),
    ),
  );
}
```
