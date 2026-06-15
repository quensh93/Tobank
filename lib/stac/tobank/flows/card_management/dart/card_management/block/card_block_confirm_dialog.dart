import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

/// Action builder — shown from "ادامه" in card_block_bottom_sheet.
/// تایید: closes sheet + dialog, then shows success snackbar (mock).
/// انصراف: closes dialog only.
StacAction cardBlockConfirmDialogAction() {
  return StacShowDialogAction(
    title: 'مسدودسازی کارت',
    description:
        'کارت [[cardsManagement.sheet.cardNumber]] مسدود خواهد شد. این عملیات قابل بازگشت نیست.',
    positiveText: 'تایید',
    negativeText: 'انصراف',
    positiveAction: StacSequenceAction(
      actions: [
        const StacCloseDialogAction(),
        NavigationAction(fileName: 'card_management_root', navMode: NavModes.dart, navigationStyle: NavigationStyle.pushAndRemoveAll),
        StacCustomSnackBarAction(
          title: 'درخواست مسدودسازی ثبت شد',
          detail: 'کارت در اسرع وقت مسدود خواهد شد. (mock)',
          duration: 3500,
        ),
      ],
    ),
    negativeAction: const StacCloseDialogAction(),
  );
}
