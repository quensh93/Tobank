import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/card/card_change_password_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class CardPrimaryPasswordConfirmPage extends StatelessWidget {
  const CardPrimaryPasswordConfirmPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardChangePasswordController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
                  border: Border.all(
                    color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${locale.card_number}:',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          height: 1.6,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        AppUtil.splitCardNumber(controller.customerCard.cardNumber!, ' - '),
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          height: 1.6,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  controller.validateFirstPage(pinType: 0);
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.confirm_receive_first_password,
              ),
            ],
          ),
        );
      },
    );
  }
}
