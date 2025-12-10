import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_letter_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/document_picker_widget.dart';

class MilitaryGuaranteeLetterPage extends StatelessWidget {
  const MilitaryGuaranteeLetterPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeLetterController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              locale.upload_military_service_letter_image,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              locale.upload_military_service_letter_description,
              style: TextStyle(
                color: ThemeUtil.textSubtitleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            DocumentPickerWidget(
              title: locale.military_service_letter_image_title,
              subTitle: '',
              description: controller.documentFileDescription_1,
              cameraFunction: (documentId) {
                controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
              },
              galleryFunction: (documentId) {
                controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
              },
              isUploading: controller.isUploading,
              isUploaded: controller.isUploaded(1),
              deleteDocumentFunction: (documentId) {
                controller.deleteDocument(documentId);
              },
              documentId: 1,
              selectedDocumentId: controller.selectedDocumentId,
              selectedImageFile: controller.documentFile_1,
            ),
            Expanded(child: Container()),
            ContinueButtonWidget(
              callback: () {
                controller.validateLetterPage();
              },
              isLoading: controller.isLoading,
              buttonTitle: locale.military_service_letter_confirm_button,
            ),
          ],
        ),
      );
    });
  }
}
