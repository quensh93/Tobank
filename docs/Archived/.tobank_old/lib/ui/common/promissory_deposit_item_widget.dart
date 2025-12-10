import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../util/theme/theme_util.dart';

class PromissoryDepositItemWidget extends StatelessWidget {
  const PromissoryDepositItemWidget({
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
                            fontSize: 16.0,
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
                  const SizedBox(height: 8),
                  const Divider(thickness: 1),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${locale.deposit_number}: ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          deposit.depositNumber ?? '',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        '${locale.shaba_number}: ',
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          deposit.depositIban ?? '',
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
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
