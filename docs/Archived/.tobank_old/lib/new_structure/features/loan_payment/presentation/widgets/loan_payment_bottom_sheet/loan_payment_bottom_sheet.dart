import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../util/theme/theme_util.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../pages/loan_payment_list_main_page.dart';
import '../../pages/loan_payment_others_main_page.dart';

class LoanPaymentBottomSheet extends StatelessWidget {
  const LoanPaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color:  MainTheme.of(context).onSurfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              locale.pay_loans,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back();
                    Get.to(() => const LoanPaymentListMainPage());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                    child: Text(
                      locale.pay_your_own_loan,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall.copyWith(
                          color: MainTheme.of(context).surfaceContainerHigh
                      )
                    ),
                  ),
                ),
                Divider(
                  height: 16,
                  thickness: 1,
                  color: MainTheme.of(context).onSurface,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back();
                    Get.to(() => const LoanPaymentOthersMainPage());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                    child: Text(
                      locale.pay_others_loan,
                      textAlign: TextAlign.right,
                       style: MainTheme.of(context).textTheme.titleSmall.copyWith(color: MainTheme.of(context).surfaceContainerHigh)
                       )
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
