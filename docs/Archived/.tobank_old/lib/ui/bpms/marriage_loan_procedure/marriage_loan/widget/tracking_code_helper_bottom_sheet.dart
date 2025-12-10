import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';

class TrackingCodeHelperBottomSheet extends StatelessWidget {
  const TrackingCodeHelperBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<MarriageLoanProcedureController>(
        builder: (controller) {
          return Padding(
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
                Text(locale.tracking_code_info_title, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                    locale.tracking_code_info_message,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.central_bank_system,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.showUrl();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.open_in_browser_rounded),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              locale.website_link_cbi,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                ContinueButtonWidget(
                  callback: () {
                    Get.back();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle:locale.close,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
