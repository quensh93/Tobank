import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/sign_up/sign_up_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';

class VerifyCodePageWidget extends StatelessWidget {
  const VerifyCodePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<SignUpController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            locale.receive_verification_code,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: ThemeUtil.textTitleColor,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            locale.verify_code_sent_to_phone_number(controller.phoneNumberController.text),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ThemeUtil.textTitleColor,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                locale.wrong_number,
                                style: TextStyle(
                                    color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              InkWell(
                                onTap: () {
                                  AppUtil.previousPageController(controller.pageController, controller.isClosed);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgIcon(
                                        SvgIcons.edit,
                                        colorFilter:
                                            ColorFilter.mode(context.theme.colorScheme.secondary, BlendMode.srcIn),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        locale.edit,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: context.theme.colorScheme.secondary,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.codeController,
                                  keyboardType: TextInputType.number,
                                  autofillHints: const [AutofillHints.oneTimeCode],
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(5),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontFamily: 'IranYekan',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0,
                                    letterSpacing: 8.0,
                                  ),
                                  enabled: controller.enableManualOtp,
                                  readOnly: !controller.enableManualOtp,
                                  decoration: const InputDecoration(
                                    filled: false,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 10.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                constraints: const BoxConstraints(minWidth: 90.0),
                                height: 56.0,
                                child: OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: controller.counter == 0
                                            ? context.theme.colorScheme.secondary
                                            : context.theme.textTheme.bodyLarge!.color!,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (controller.counter == 0 && !controller.isRequestOtpLoading) {
                                      controller.getVerifyCodeRequest();
                                    }
                                  },
                                  child: controller.isRequestOtpLoading
                                      ? SpinKitFadingCircle(
                                          itemBuilder: (_, int index) {
                                            return DecoratedBox(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle, color: context.theme.colorScheme.secondary),
                                            );
                                          },
                                          size: 24.0,
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              controller.counter == 0 ? locale.send_again : controller.getTimerString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: controller.counter == 0
                                                    ? context.theme.colorScheme.secondary
                                                    : ThemeUtil.textTitleColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'IranYekan',
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ],
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
                      controller.submitVerifyCode();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.continue_label,
                  ),
                ),
              ],
            );
          },
        ));
  }
}
