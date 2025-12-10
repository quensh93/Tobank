import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../controller/renew_certificate/renew_certificate_controller.dart';

class RenewCertificateResultPage extends StatelessWidget {
  const RenewCertificateResultPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RenewCertificateController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/digital_signature_accepted.png',
                  height: 140.0,
                  width: 140.0,
                ),
                const SizedBox(height: 24.0),
                Text(
                  locale.digital_signature_renewal,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  locale.digital_signature_creation_success,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            ContinueButtonWidget(
              callback: () {
                controller.submitCertificateRequest();
              },
              isLoading: controller.isLoading,
              buttonTitle: locale.final_confirmation_button,
            ),
          ],
        );
      },
    );
  }
}
