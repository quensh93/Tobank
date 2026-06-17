import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

/// Action builder — shown from "حذف کارت" row in the card details bottom sheet.
/// تایید: closes the details sheet + delete dialog, then shows success snackbar.
/// انصراف: closes only the dialog.
StacAction cardDeleteConfirmDialogAction() {
  return StacShowDialogAction(
    title:
        '{{appStrings.generated.card_management.card_management_root.delete_card}}',
    description:
        '{{appStrings.generated.card_management.card_management_root.delete_card_message}}',
    positiveText: '{{appStrings.common.confirm}}',
    negativeText: '{{appStrings.common.cancel}}',
    positiveAction: StacSequenceAction(
      actions: [
        const StacCloseDialogAction(),
        NavigationAction(
          fileName: 'card_management_root',
          navMode: NavModes.dart,
          navigationStyle: NavigationStyle.pushAndRemoveAll,
        ),
        StacCustomSnackBarAction(
          title:
              '{{appStrings.generated.card_management.card_management_root.delete_card_text}}',
          detail:
              '{{appStrings.generated.card_management.card_management_root.successfully_delete_card_list}}',
          duration: 3000,
        ),
      ],
    ),
    negativeAction: const StacCloseDialogAction(),
  );
}
