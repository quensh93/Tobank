import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class CBSLowRateAlertBottomSheet extends StatelessWidget {
  const CBSLowRateAlertBottomSheet({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: context.theme.dividerColor,
                      borderRadius: BorderRadius.circular(4),
                    )),
              ],
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.asset(
                'assets/images/cbs_low_rate_alert.png',
                height: 95.0,
              ),
            ),
            const SizedBox(height: 24.0),
            Card(
              elevation: Get.isDarkMode ? 1 : 0,
              margin: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(locale.validation_check_result, style: ThemeUtil.titleStyle),
                    const Divider(thickness: 1),
                    Text(
                      message,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            ContinueButtonWidget(
              callback: () {
                Get.back();
              },
              isLoading: false,
              buttonTitle: locale.return_,
            ),
          ],
        ),
      ),
    );
  }
}
