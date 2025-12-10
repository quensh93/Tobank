import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../controller/authentication/authentication_extension/birth_certificate_flow_methods.dart';
import '../../../../../controller/authentication/authentication_extension/helper_tutorial_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/authentication_register_controller.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../common/file_picker_widget.dart';
import '../help_button_widget.dart';

class BirthCertificateSecondPage extends StatelessWidget {
  const BirthCertificateSecondPage({super.key});

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
                   locale.upload_identity_documents,
                    style: ThemeUtil.titleStyle,
                  ),
                  HelpButtonWidget(
                    onTap: () {
                      controller.showBottomSheet(
                          voiceTutorial: () =>
                              controller.playSound(helperVoiceType: HelperVoiceType.birthCertificateComments),
                          visualTutorial: () {
                            controller.showHelperScreen(helperType: HelperType.birthCertificateCommentsPages);
                          });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
               locale.upload_documents_instruction,
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
              FilePickerWidget(
                title: locale.birth_certificate_page_three_four,
                cameraFunction: (documentId) {
                  controller.selectBirthCertificateSecondImage(ImageSource.camera);
                },
                galleryFunction: (documentId) {
                  controller.selectBirthCertificateSecondImage(ImageSource.gallery);
                },
                deleteDocumentFunction: (documentId) {
                  controller.deleteBirthCertificateSecondImage();
                },
                documentId: 5,
                selectedImageFile: controller.selectedBirthCertificateSecondImage,
                isSelected: controller.selectedBirthCertificateSecondImage != null ? true : false,
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  controller.nextPageBirthCertificateSecondPage();
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
