import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/children_loan_procedure/children_loan_child_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/document_picker_widget.dart';

class ChildrenLoanProcedureChildDocumentPage extends StatelessWidget {
  const ChildrenLoanProcedureChildDocumentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ChildrenLoanProcedureChildController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(locale.child_documents_title, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.child_documents_description,
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
                  title: locale.birth_certificate_page_one_two,
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
                const SizedBox(
                  height: 16.0,
                ),
                DocumentPickerWidget(
                  title:  locale.birth_certificate_page_three_four,
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
                  title: locale.birth_certificate_page_five_six,
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
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateChildBirthCertificate();
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
