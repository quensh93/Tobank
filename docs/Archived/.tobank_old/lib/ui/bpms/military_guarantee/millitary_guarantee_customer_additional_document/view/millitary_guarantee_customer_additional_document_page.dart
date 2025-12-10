import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/millitary_guarantee_customer_additional_document_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/document_picker_widget.dart';

class MillitaryGuaranteeCustomerAdditionalDocumentPage extends StatelessWidget {
  const MillitaryGuaranteeCustomerAdditionalDocumentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MillitaryGuaranteeCustomerAdditionalDocumentController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.upload_additional_documents,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.upload_instructions,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return DocumentPickerWidget(
                      title: controller.documents[index].title!,
                      subTitle: '',
                      cameraFunction: (documentId) {
                        controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
                      },
                      galleryFunction: (documentId) {
                        controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
                      },
                      isUploading: controller.isUploading,
                      isUploaded: controller.isUploaded(index),
                      deleteDocumentFunction: (documentId) {
                        controller.deleteDocument(documentId);
                      },
                      documentId: index,
                      selectedDocumentId: controller.selectedDocumentId,
                      selectedImageFile: controller.documentFiles[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16.0,
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateCustomerBirthCertificate();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.submit_button,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
