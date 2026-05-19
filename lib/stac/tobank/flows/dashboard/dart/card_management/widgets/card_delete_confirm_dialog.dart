import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Action builder — shown from "حذف کارت" row in the card details bottom sheet.
/// تایید: closes the details sheet + delete dialog, then shows success snackbar.
/// انصراف: closes only the dialog.
StacAction cardDeleteConfirmDialogAction() {
  return StacShowDialogAction(
    title: 'حذف کارت',
    description: 'آیا از حذف این کارت اطمینان دارید؟',
    positiveText: 'تایید',
    negativeText: 'انصراف',
    positiveAction: StacSequenceAction(
      actions: [
        const StacCloseDialogAction(),
        const StacCloseDialogAction(),
        StacCustomSnackBarAction(
          title: 'کارت حذف شد',
          detail: 'کارت با موفقیت از لیست حذف شد.',
          duration: 3000,
        ),
      ],
    ),
    negativeAction: const StacCloseDialogAction(),
  );
}
