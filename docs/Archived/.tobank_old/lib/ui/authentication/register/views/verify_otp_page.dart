import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../controller/authentication/authentication_extension/otp_verification_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/authentication_register_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AuthenticationRegisterController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(locale.receive_verification_code,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          )),
                      const SizedBox(height: 24.0),
                      Text(
                        locale.otp_to_phone_number(controller.mobileTextEditingController.text),
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        crossAxisAlignment:
                            controller.isOtpValid ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.otpTextController,
                              autofillHints: const [AutofillHints.oneTimeCode],
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                              onSubmitted: (value) {
                                if (controller.isConfirmOtpButtonEnabled()) {
                                  controller.verifyOtp();
                                }
                              },
                              onChanged: (value) {
                                controller.update();
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(controller.otpLength),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                filled: false,
                                hintText: locale.verification_code_label,
                                hintStyle: ThemeUtil.hintStyle,
                                errorText: controller.isOtpValid ? null : locale.enter_activion_code,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 16.0,
                                ),
                                suffixIcon: TextFieldClearIconWidget(
                                  isVisible: controller.otpTextController.text.isNotEmpty,
                                  clearFunction: () {
                                    controller.otpTextController.clear();
                                    controller.update();
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Container(
                            constraints: const BoxConstraints(minWidth: 120.0),
                            height: 56,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (controller.counter == 0 && !controller.isRequestOtpLoading) {
                                    controller.requestNewOtpRequest();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  alignment: controller.isRequestOtpLoading ? Alignment.center : Alignment.centerLeft,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: controller.counter == 0 ? ThemeUtil.primaryColor : ThemeUtil.textHintColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: controller.isRequestOtpLoading
                                    ? SpinKitFadingCircle(
                                        itemBuilder: (_, int index) {
                                          return DecoratedBox(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle, color: ThemeUtil.textSubtitleColor),
                                          );
                                        },
                                        size: 24.0,
                                      )
                                    : controller.counter != 0
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                controller.getCurrentTime(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.0,
                                                  color: ThemeUtil.textSubtitleColor,
                                                ),
                                              ),
                                              const SizedBox(width: 10.0),
                                              SvgIcon(
                                                SvgIcons.timer,
                                                colorFilter:
                                                    ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                                                size: 24.0,
                                              ),
                                            ],
                                          )
                                        : Text(
                                            locale.send_again,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                              color: ThemeUtil.textTitleColor,
                                            ),
                                          )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButtonWidget(
                callback: () {
                  controller.verifyOtp();
                },
                isEnabled: controller.isConfirmOtpButtonEnabled(),
                isLoading: controller.isLoading,
                buttonTitle: locale.verify_code,
              ),
            ),
          ],
        );
      },
    );
  }
}
