import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/settings/settings_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';

class ConfirmDeleteBottomSheet extends StatelessWidget {
  const ConfirmDeleteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<SettingsController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 36,
                      height: 4,
                      decoration:
                          BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgIcon(SvgIcons.warningRed),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locale.delete_account_information,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.user_message_delete_account,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  color: ThemeUtil.textSubtitleColor,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgIcon(
                    Get.isDarkMode ? SvgIcons.alertDark : SvgIcons.alertLight,
                    colorFilter: ColorFilter.mode(context.theme.colorScheme.primary, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: Text(
                      locale.alert_message_1_move_wallet_credit,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgIcon(
                    Get.isDarkMode ? SvgIcons.alertDark : SvgIcons.alertLight,
                    colorFilter: ColorFilter.mode(context.theme.colorScheme.primary, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: Text(
                     locale.alert_message_2_forbidden_24hrs,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: context.theme.colorScheme.secondary,
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (!states.contains(WidgetState.selected)) {
                        return Colors.transparent;
                      }
                      return null;
                    }),
                    value: controller.isConfirm,
                    onChanged: (bool? value) {
                      controller.setIsConfirm(value);
                    },
                  ),
                  Flexible(
                    child: Text(
                     locale.confirmation_text_to_delete_account,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  if (controller.isConfirm) {
                    controller.getDeleteOtpRequest();
                  }
                },
                isEnabled: controller.isConfirm,
                isLoading: controller.isLoading,
                buttonTitle:locale.continue_label,
              ),
            ],
          ),
        );
      }),
    );
  }
}
