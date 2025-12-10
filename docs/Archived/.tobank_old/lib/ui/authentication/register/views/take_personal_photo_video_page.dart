import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../controller/authentication/authentication_extension/helper_tutorial_flow_methods.dart';
import '../../../../../controller/authentication/authentication_extension/personal_verification_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/authentication_register_controller.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../new_structure/core/theme/main_theme.dart';
import '../../../../new_structure/core/widgets/dialogs/dialog_handler.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../../common/personal_photo_capture_widget.dart';
import '../../common/personal_video_capture_widget.dart';
import '../help_button_widget.dart';

class TakePersonalPhotoVideoPage extends StatelessWidget {
  const TakePersonalPhotoVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AuthenticationRegisterController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (controller.isNationalSerialNumberUsed)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              locale.check_serial,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.6,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          HelpButtonWidget(
                            onTap: () {
                              if (controller.isLoading) {
                                return;
                              }
                              controller.showBottomSheet(
                                  voiceTutorial: () => controller.playSound(
                                      helperVoiceType: controller.isNationalSerialNumberUsed
                                          ? HelperVoiceType.personalPhotoVideoCardSerial
                                          : HelperVoiceType.personalPhotoVideoReceiptSerial),
                                  visualTutorial: () {
                                    controller.showHelperScreen(helperType: HelperType.personalVideo);
                                  });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(locale.serial_number, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        controller: controller.nationalCardSerialTextController,
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
                        ],
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_serial_number,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isNationalCodeValid ? null : locale.please_enter_serial,
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
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              locale.enter_receipt_code,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.6,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          HelpButtonWidget(
                            onTap: () {
                              controller.showBottomSheet(
                                  voiceTutorial: () => controller.playSound(
                                      helperVoiceType: controller.isNationalSerialNumberUsed
                                          ? HelperVoiceType.personalPhotoVideoCardSerial
                                          : HelperVoiceType.personalPhotoVideoReceiptSerial),
                                  visualTutorial: () {
                                    controller.showHelperScreen(helperType: HelperType.personalVideo);
                                  });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(locale.tracking_number_label, style: ThemeUtil.titleStyle),
                      const SizedBox(height: 8.0),
                      TextField(
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        controller: controller.nationalCardReceiptTextController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.right,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.receipt_code_on_reciept,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText:
                              controller.isNationalCardReceiptValid ? null : locale.enter_receipt_code_error,
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
                            isVisible: controller.nationalCardReceiptTextController.text.isNotEmpty,
                            clearFunction: () {
                              controller.nationalCardReceiptTextController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  locale.capture_instruction,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                PersonalPhotoCaptureWidget(
                  title: locale.capture_photo_from_face,
                  buttonText: locale.camera,
                  cameraFunction: (documentId) {
                    DialogHandler.showDialogMessage(
                      buildContext: context,
                      description: locale.upload_documents_selfie_description,
                      message: locale.upload_documents_message,
                      iconPath: SvgIcons.camera,
                      iconColor: Get.isDarkMode ? Colors.white : Colors.black ,
                      iconBottomSizedBox: 4,
                      descriptionAlign: TextAlign.right,
                      messageStyle: MainTheme.of(context).textTheme.titleMedium,
                      positiveMessage: locale.understood_button,
                      colorPositive: MainTheme.of(context).green,
                      positiveFunction: () async {
                        Get.back();
                        controller.deletePersonalPhotoImage();
                        controller.showTakePersonalPhotoScreen();
                      },
                    );
                  },
                  deleteDocumentFunction: (documentId) {
                    controller.deletePersonalPhotoImage();
                  },
                  documentId: 3,
                  selectedImageFile: controller.selectedPersonalPicture,
                  isSelected: controller.selectedPersonalPicture != null ? true : false,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                PersonalVideoCaptureWidget(
                  iconPath:  SvgIcons.videoHint,
                  iconPathDark:  SvgIcons.videoHint,
                  title: locale.capture_video_from_face,
                  buttonText: locale.camera,
                  cameraFunction: (documentId) async {
                    DialogHandler.showDialogMessage(
                      buildContext: context,
                      description: locale.upload_documents_video_description,
                      message: locale.upload_documents_video_message,
                      iconPath: SvgIcons.videoHint,
                      iconColor: Get.isDarkMode ? Colors.white : Colors.black ,
                      iconsize: 52,
                      iconBottomSizedBox: 0,
                      descriptionAlign: TextAlign.right,
                      messageStyle: MainTheme.of(context).textTheme.titleMedium,
                      positiveMessage: locale.understood_button,
                      colorPositive: MainTheme.of(context).green,
                      positiveFunction: () async {
                        Get.back();
                        controller.showTakePersonalVideoScreen();
                      },
                    );
                  },
                  deleteDocumentFunction: (documentId) {
                    controller.deletePersonalVideo();
                  },
                  documentId: 3,
                  selectedImageFile: controller.selectedPersonalVideo,
                  isSelected: controller.selectedPersonalVideo != null ? true : false,
                ),
                const SizedBox(height: 24.0),
                ContinueButtonWidget(
                  callback: () {
                    controller.validatePersonalPicture();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_continue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
