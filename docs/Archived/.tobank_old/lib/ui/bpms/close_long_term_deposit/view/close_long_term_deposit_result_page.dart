import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../controller/bpms/close_long_term_deposit/close_long_term_deposit_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';

class CloseLongTermDepositResultPage extends StatelessWidget {
  const CloseLongTermDepositResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CloseLongTermDepositController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SvgIcon(
                        SvgIcons.successNew,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.request_success_message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.review_message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  Get.back();
                },
                isLoading: false,
                buttonTitle: locale.return_,
              ),
            ],
          ),
        );
      },
    );
  }
}
