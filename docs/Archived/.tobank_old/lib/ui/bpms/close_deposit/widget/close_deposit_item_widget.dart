import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../common/key_value_widget.dart';

class CloseDepositItemWidget extends StatelessWidget {
  const CloseDepositItemWidget({
    required this.deposit,
    required this.setSelectedDepositFunction,
    super.key,
    this.selectedDeposit,
  });

  final Deposit deposit;
  final Deposit? selectedDeposit;
  final Function(Deposit deposit) setSelectedDepositFunction;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selectedDeposit != null && deposit.depositNumber == selectedDeposit!.depositNumber
                  ? context.theme.colorScheme.secondary
                  : context.theme.dividerColor,
            ),
          ),
          child: InkWell(
            onTap: () {
              setSelectedDepositFunction(deposit);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          deposit.depositTitle!,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            height: 1.6,
                          ),
                        ),
                      ),
                      Radio(
                          activeColor: context.theme.colorScheme.secondary,
                          value: deposit,
                          groupValue: selectedDeposit,
                          onChanged: (Deposit? deposit) {
                            setSelectedDepositFunction(deposit!);
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  KeyValueWidget(
                    keyString: '${locale.deposit_number}:',
                    valueString: deposit.depositNumber,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  KeyValueWidget(
                    keyString: '${locale.shaba_number}:',
                    valueString: deposit.depositIban,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
