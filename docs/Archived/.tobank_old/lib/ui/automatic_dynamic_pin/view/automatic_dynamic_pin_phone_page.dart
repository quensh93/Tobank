import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/automatic_dynamic_pin/automatic_dynamic_pin_active_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';

class AutomaticDynamicPinActivePhonePage extends StatelessWidget {
  const AutomaticDynamicPinActivePhonePage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return GetBuilder<AutomaticDynamicPinActiveController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              locale.mobile_number,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            IgnorePointer(
              child: TextField(
                readOnly: true,
                enabled: true,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(11),
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: controller.phoneNumberController,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.right,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: 'IranYekan',
                ),
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.enter_your_mobile_number,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isMobileValid ? null : locale.enter_valid_mobile_number,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            ContinueButtonWidget(
              callback: () {
                controller.preRegisterRequest();
              },
              isLoading: controller.isLoading,
              buttonTitle: locale.receive_verification_code,
            ),
          ],
        ),
      );
    });
  }
}
