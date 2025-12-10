import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/renew_certificate/renew_certificate_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class GenerateCertificatePage extends StatelessWidget {
  const GenerateCertificatePage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RenewCertificateController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/digital_signature.png',
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
                RichText(
                  text: TextSpan(
                    text: locale.certificate_expiration_warning,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      fontFamily: 'IranYekan',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${controller.remainingDays} ${locale.remaining_days_message} ',
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text:
                            locale.renewal_instructions,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ContinueButtonWidget(
            callback: () {
              controller.renewCertificate();
            },
            isLoading: controller.isLoading,
            buttonTitle: locale.continue_label,
          ),
          const SizedBox(
            height: 12.0,
          ),
          SizedBox(
            height: 56,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                locale.not_now,
                style: TextStyle(
                  color: context.theme.iconTheme.color,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: 'IranYekan',
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
