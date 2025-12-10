import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/gift_card/response/list_gift_card_amount_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';

class GiftCardAmountItemWidget extends StatelessWidget {
  const GiftCardAmountItemWidget({
    required this.physicalGiftCardAmount,
    required this.returnDataFunction,
    required this.mainIndex,
    super.key,
    this.selectedAmount,
  });

  final PhysicalGiftCardAmount physicalGiftCardAmount;
  final int mainIndex;
  final Function(PhysicalGiftCardAmount physicalGiftCardAmount, int mainIndex) returnDataFunction;
  final String? selectedAmount;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        returnDataFunction(physicalGiftCardAmount, mainIndex);
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedAmount != null && selectedAmount == physicalGiftCardAmount.balance.toString()
              ? context.theme.colorScheme.secondary.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              color: selectedAmount != null && selectedAmount == physicalGiftCardAmount.balance.toString()
                  ? context.theme.colorScheme.secondary
                  : context.theme.dividerColor),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              locale.amount_format(AppUtil.formatMoney(physicalGiftCardAmount.balance)),
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
