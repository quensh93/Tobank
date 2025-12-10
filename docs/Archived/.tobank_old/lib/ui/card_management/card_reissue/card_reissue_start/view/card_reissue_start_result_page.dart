import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/card_management/card_reissue_start_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';

class CardReissueStartResultPage extends StatelessWidget {
  const CardReissueStartResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardReissueStartController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  height: 1.6,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                '${locale.tracking_number_label}: ${controller.startProcessResponse!.data!.trackingNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  height: 1.6,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'IranYekan',
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.sms_notification_message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeUtil.textSubtitleColor,
                  height: 1.6,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  Get.back();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.return_to_card_services_list,
              ),
            ],
          ),
        );
      },
    );
  }
}
