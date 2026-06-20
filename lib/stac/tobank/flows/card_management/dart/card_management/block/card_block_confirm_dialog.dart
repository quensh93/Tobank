import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

/// Action builder — shown from "ادامه" in card_block_bottom_sheet.
/// تایید: closes sheet + dialog, then shows success snackbar (mock).
/// انصراف: closes dialog only.
StacAction cardBlockConfirmDialogAction() {
  return StacShowDialogAction(
    title: '{{appStrings.cardsManagement.block.title}}',
    description: '{{appStrings.cardsManagement.block.confirmDescription}}',
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
          title: '{{appStrings.cardsManagement.block.successTitle}}',
          detail: '{{appStrings.cardsManagement.block.successDetail}}',
          duration: 3500,
        ),
      ],
    ),
    negativeAction: const StacCloseDialogAction(),
  );
}
