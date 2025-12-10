import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../controller/authentication/authentication_extension/otp_verification_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/authentication_register_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';

class PreRegisterPage extends StatelessWidget {
  const PreRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AuthenticationRegisterController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(locale.verify_mobile_number_to_start,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(
                height: 32.0,
              ),
              Text( locale.mobile_number, style: ThemeUtil.titleStyle),
              const SizedBox(
                height: 8.0,
              ),
              IgnorePointer(
                child: TextField(
                  readOnly: true,
                  enabled: true,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                  controller: controller.mobileTextEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(11),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    controller.update();
                  },
                  decoration:  InputDecoration(
                    filled: true,
                    hintText:locale.enter_mobile_number,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  controller.validateMobileNumber();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.get_activation_code,
              ),
            ],
          ),
        );
      },
    );
  }
}
