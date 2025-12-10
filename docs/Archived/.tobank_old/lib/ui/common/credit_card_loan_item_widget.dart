import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/credit_card_facility/response/credit_card_facility_check_deposit_response_data.dart';
import '../../util/app_util.dart';
import '../../util/theme/theme_util.dart';

class CreditCardLoanItemWidget extends StatelessWidget {
  const CreditCardLoanItemWidget({required this.loanData, super.key});

  final LoanData loanData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(color: loanData.amount == 0 ? context.theme.dividerColor : Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   locale.credit_card_amount_label,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    loanData.amount == 0
                        ? locale.credit_card_amount_unavailable
                        : locale.credit_card_amount_range(AppUtil.formatMillions(loanData.amount! ~/ 10)),
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: context.theme.colorScheme.surface,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  '${loanData.month}${locale.month}',
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
