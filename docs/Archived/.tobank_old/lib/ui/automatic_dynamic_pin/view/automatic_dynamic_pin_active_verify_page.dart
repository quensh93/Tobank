import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/automatic_dynamic_pin/automatic_dynamic_pin_active_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';

class AutomaticDynamicPinActiveVerifyPage extends StatelessWidget {
  const AutomaticDynamicPinActiveVerifyPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AutomaticDynamicPinActiveController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(locale.sms_code,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: controller.otpController,
                keyboardType: TextInputType.number,
                autofillHints: const [AutofillHints.oneTimeCode],
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly
                ],
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'IranYekan',
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                  letterSpacing: 20.0,
                ),
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
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
                  suffixIcon: TextFieldClearIconWidget(
                    isVisible: controller.otpController.text.isNotEmpty,
                    clearFunction: () {
                      controller.otpController.clear();
                      controller.update();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 48.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: controller.counter == 0
                            ? context.theme.colorScheme.secondary
                            : context.theme.textTheme.bodyLarge!.color!,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (controller.counter == 0 && !controller.isLoading) {
                      controller.preRegisterRequest();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        locale.receive_verification_code_again,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color:
                              controller.counter == 0 ? context.theme.colorScheme.secondary : ThemeUtil.textTitleColor,
                        ),
                      ),
                      Text(
                        controller.getTimerString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              controller.counter == 0 ? context.theme.colorScheme.secondary : ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateSecondPage();
                },
                isLoading: controller.isLoading,
                buttonTitle:locale.automatic_dynamic_password_activation,
              ),
            ],
          ),
        ),
      );
    });
  }
}
