import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../util/theme/theme_util.dart';
import '../../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../controller/parsa_loan/parsa_loan_customer_document_controller.dart';
import '../../../common/document_picker_widget.dart';

class ParsaLoanUploadDocumentPage extends StatelessWidget {
  const ParsaLoanUploadDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanCustomerDocumentController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(locale.upload_identity_documents, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.please_upload_requested_birth_certificate_pages,
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
                  title: locale.first_page_of_birth_certificate,
                  subTitle: '',
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
                DocumentPickerWidget(
                  title: locale.second_page_of_birth_certificate,
                  subTitle: '',
                  cameraFunction: (documentId) {
                    controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
                  },
                  galleryFunction: (documentId) {
                    controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
                  },
                  isUploading: controller.isUploading,
                  isUploaded: controller.isUploaded(2),
                  deleteDocumentFunction: (documentId) {
                    controller.deleteDocument(documentId);
                  },
                  documentId: 2,
                  selectedDocumentId: controller.selectedDocumentId,
                  selectedImageFile: controller.documentFile_2,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DocumentPickerWidget(
                  title: locale.birth_certificate_description_page,
                  subTitle: '',
                  cameraFunction: (documentId) {
                    controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
                  },
                  galleryFunction: (documentId) {
                    controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
                  },
                  isUploading: controller.isUploading,
                  isUploaded: controller.isUploaded(3),
                  deleteDocumentFunction: (documentId) {
                    controller.deleteDocument(documentId);
                  },
                  documentId: 3,
                  selectedDocumentId: controller.selectedDocumentId,
                  selectedImageFile: controller.documentFile_3,
                ),
                const SizedBox(height: 32.0),
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
