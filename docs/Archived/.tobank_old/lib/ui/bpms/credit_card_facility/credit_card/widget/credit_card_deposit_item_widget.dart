import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../model/bpms/credit_card_facility/response/credit_card_facility_deposit_list_response_data.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';

class CreditCardDepositItemWidget extends StatelessWidget {
  const CreditCardDepositItemWidget({
    required this.deposit,
    required this.selectedDeposit,
    required this.returnDataFunction,
    super.key,
  });

  final DepositList deposit;
  final DepositList? selectedDeposit;
  final Function(DepositList deposit) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selectedDeposit != null && selectedDeposit!.depositNumber == deposit.depositNumber
              ? context.theme.colorScheme.secondary
              : context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        onTap: () {
          returnDataFunction(deposit);
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
                        fontSize: 16.0,
                        height: 1.6,
                      ),
                    ),
                  ),
                  Radio(
                      activeColor: context.theme.colorScheme.secondary,
                      value: deposit,
                      groupValue: selectedDeposit,
                      onChanged: (dynamic deposit) {
                        returnDataFunction(deposit);
                      }),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${locale.deposit_number}: ',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      height: 1.6,
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
                        height: 1.6,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              if (deposit.cardInfo != null)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${locale.card_number}: ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            height: 1.6,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            AppUtil.splitCardNumber(deposit.cardInfo!.pan ?? '', ' - '),
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              height: 1.6,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )
              else
                Container(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${locale.shaba_number}: ',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      height: 1.6,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      deposit.depositIban ?? '',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        height: 1.6,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
