import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_self_employed_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/document_picker_widget.dart';

class MilitaryGuaranteeSelfEmployedPage extends StatelessWidget {
  const MilitaryGuaranteeSelfEmployedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeSelfEmployedController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale.upload_employment_documents,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 16.0,
              ),
              DocumentPickerWidget(
                title: locale.business_license_image,
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
                  controller.validateSelfEmployedPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.submit_button,
              ),
            ],
          ),
        );
      },
    );
  }
}
