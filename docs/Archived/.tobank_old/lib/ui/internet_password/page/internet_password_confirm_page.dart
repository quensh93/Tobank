import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/modern_banking_change_password_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';

class InternetPasswordFirstPage extends StatelessWidget {
  const InternetPasswordFirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ModernBankingChangePasswordController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.internet_bank_username_hint,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    height: 1.4,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.internet_bank_username,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: controller.usernameController,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        fontFamily: 'IranYekan',
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        controller.update();
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: locale.internet_bank_username_hint,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText:
                            controller.isUsernameValid ? null : locale.internet_bank_username_error,
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
                          isVisible: controller.usernameController.text.isNotEmpty,
                          clearFunction: () {
                            controller.usernameController.clear();
                            controller.update();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateFirstPage(subsystem: 1);
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_and_recover_password_internet_bank,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
