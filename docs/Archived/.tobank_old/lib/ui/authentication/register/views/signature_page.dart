import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';

import '../../../../../controller/authentication/authentication_extension/helper_tutorial_flow_methods.dart';
import '../../../../../controller/authentication/authentication_extension/singnature_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/authentication_register_controller.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../help_button_widget.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    locale.signature,
                    style: ThemeUtil.titleStyle,
                  ),
                  HelpButtonWidget(
                    onTap: () {
                      controller.showBottomSheet(
                          voiceTutorial: () => controller.playSound(helperVoiceType: HelperVoiceType.signaturePage),
                          visualTutorial: () {
                            controller.showHelperScreen(helperType: HelperType.signature);
                          });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.signature_instruction,
                style: TextStyle(
                  color: ThemeUtil.textSubtitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                locale.signature_location,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: HandSignature(
                          control: controller.handSignatureController,
                          width: 3.0,
                          maxWidth: 3.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFFd0d5dd),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(48.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.clearSignature();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIcon(
                          Get.isDarkMode ? SvgIcons.deleteDark : SvgIcons.delete,
                          size: 24.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                         locale.delete,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              ContinueButtonWidget(
                callback: () {
                  controller.submitSignature();
                },
                isLoading: controller.isLoading,
                buttonTitle:locale.confirm_continue,
              ),
            ],
          ),
        );
      },
    );
  }
}
