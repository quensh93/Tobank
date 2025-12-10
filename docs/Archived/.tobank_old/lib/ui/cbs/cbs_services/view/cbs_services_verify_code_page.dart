import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/cbs/cbs_services/cbs_services_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';

class CBSServicesVerifyCodePage extends StatelessWidget {
  const CBSServicesVerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CBSServicesController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            onChanged: (value) {
                              controller.update();
                            },
                            controller: controller.phoneNumberController,
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              fontFamily: 'IranYekan',
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              hintText: locale.like_09123456789,
                              hintStyle: ThemeUtil.hintStyle,
                              errorText: controller.isPhoneNumberValid ? null : locale.enter_valid_cell_phone,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 16.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Card(
                          elevation: Get.isDarkMode ? 1 : 0,
                          shadowColor: Colors.transparent,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                          ),
                          child: InkWell(
                            onTap: () {
                              AppUtil.previousPageController(controller.pageController, controller.isClosed);
                            },
                            child: SizedBox(
                              height: 56.0,
                              width: 56.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgIcon(
                                  Get.isDarkMode ? SvgIcons.editDark : SvgIcons.edit,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      locale.verification_code_label,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.otpController,
                            keyboardType: TextInputType.number,
                            autofillHints: const [AutofillHints.oneTimeCode],
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              controller.update();
                            },
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24.0,
                              letterSpacing: 20.0,
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              errorText: controller.isOtpValid ? null : locale.enter_sms_code,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 12.0,
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
                              if (controller.counter == 0 && !controller.isLoading) {
                                controller.thirdPersonNotify(isFirst: false);
                              }
                            },
                            child: controller.isLoadingOtp
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
                                        controller.counter == 0 ? locale.send_again : controller.getTimerString()!,
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
                controller.showPaymentBottomSheet();
              },
              isLoading: controller.isLoading,
              buttonTitle: locale.continue_label,
              isEnabled: controller.isVerifyCodeButtonEnabled(),
            ),
          ),
        ],
      );
    });
  }
}
