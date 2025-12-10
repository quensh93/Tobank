import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/controller/tobank_services/tobank_services_controller.dart';
import '/ui/common/text_field_clear_icon_widget.dart';
import '/util/app_state.dart';
import '/util/theme/theme_util.dart';
import '/widget/button/custom_continue_button.dart';

class MobileBankPasswordBottomSheet extends GetView<TobankServicesController> {
  const MobileBankPasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.theme.dividerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
             locale.mobile_bank_services,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              locale.mobile_bank_username,
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
                    hintText: locale.mobile_bank_username_hint,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isUsernameValid
                        ? null
                        : locale.mobile_bank_username_error,
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
            Obx(() {
              final AppState state = controller.changePasswordState;
              return CustomContinueButton(
                callback: () {
                  controller.validatePasswordForm(subsystem: 4);
                },
                buttonTitle: locale.reset_password_continue_button_mobile_bank,
                state: state,
              );
            }),
          ],
        ),
      ),
    );
  }
}
