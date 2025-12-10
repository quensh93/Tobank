import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/theme/theme_util.dart';

class AmountItemWidget extends StatelessWidget {
  const AmountItemWidget(
      {required this.amount, required this.selectedAmount, required this.returnSelectedFunction, super.key});

  final int amount;
  final int? selectedAmount;
  final Function(int) returnSelectedFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    final bool isSelected = amount == selectedAmount;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          returnSelectedFunction(amount);
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: isSelected ? context.theme.colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? context.theme.colorScheme.secondary : context.theme.disabledColor,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
          child: Center(
            child: Text(locale.amount_format(AppUtil.formatMoney(amount)),
                style: TextStyle(
                  color: isSelected ? context.theme.colorScheme.secondary : ThemeUtil.textTitleColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                )),
          ),
        ),
      ),
    );
  }
}
