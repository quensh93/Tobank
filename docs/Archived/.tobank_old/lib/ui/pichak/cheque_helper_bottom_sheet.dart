import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';

class ChequeHelperBottomSheet extends StatelessWidget {
  const ChequeHelperBottomSheet({super.key});

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
                    decoration:
                        BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(locale.guide_register_code_title, style: ThemeUtil.titleStyle),
            const SizedBox(
              height: 16.0,
            ),
            Image.asset('assets/images/cheque_id.png'),
            const SizedBox(
              height: 24.0,
            ),
            Text(locale.guide_scan_barcode_title, style: ThemeUtil.titleStyle),
            const SizedBox(
              height: 16.0,
            ),
            Image.asset('assets/images/cheque_scan.png'),
            const SizedBox(
              height: 24.0,
            ),
            ContinueButtonWidget(
              callback: () {
                Get.back();
              },
              isLoading: false,
              buttonTitle: locale.understood_button,
            ),
          ],
        ),
      ),
    );
  }
}
