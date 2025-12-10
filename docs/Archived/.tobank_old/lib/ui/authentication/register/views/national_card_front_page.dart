import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../controller/authentication/authentication_extension/helper_tutorial_flow_methods.dart';
import '../../../../../controller/authentication/authentication_extension/national_card_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/authentication_register_controller.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../new_structure/core/theme/main_theme.dart';
import '../../common/file_picker_widget.dart';
import '../help_button_widget.dart';

class NationalCardFrontPage extends StatelessWidget {
  const NationalCardFrontPage({super.key});

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
                  Text(locale.upload_identity_documents, style: ThemeUtil.titleStyle),
                  HelpButtonWidget(
                    onTap: () {
                      controller.showBottomSheet(
                          voiceTutorial: () =>
                              controller.playSound(helperVoiceType: HelperVoiceType.nationalCardFront),
                          visualTutorial: () {
                            controller.showHelperScreen(helperType: HelperType.frontNationalCard);
                          });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                locale.upload_documents_instruction,
                style: TextStyle(
                  color: ThemeUtil.textSubtitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              FilePickerWidget(
                title: locale.smart_national_card_front_image,
                cameraFunction: (documentId) {
                  controller.selectNationalCardFrontImage(ImageSource.camera);
                },
                galleryFunction: (documentId) {
                  controller.selectNationalCardFrontImage(ImageSource.gallery);
                },
                deleteDocumentFunction: (documentId) {
                  controller.deleteNationalCardFrontImage();
                },
                documentId: 1,
                selectedImageFile: controller.selectedNationalCardFrontImage,
                isSelected: controller.selectedNationalCardFrontImage != null ? true : false,
              ),
               Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                        locale.upload_documents_description,
                      style: MainTheme.of(context).textTheme.bodyMedium,
                    ),
                  )),
              SizedBox(
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    if (!controller.isLoading) {
                      controller.goFrontNationalCardReceiptFlow();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: context.theme.iconTheme.color!),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    locale.no_new_national_card,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: context.theme.iconTheme.color,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.nextPageNationalCardFront();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.confirm_continue,
              ),
            ],
          ),
        );
      },
    );
  }
}
