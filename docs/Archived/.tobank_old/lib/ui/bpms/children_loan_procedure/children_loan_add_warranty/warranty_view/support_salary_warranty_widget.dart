import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/children_loan_procedure/children_loan_add_warranty_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../common/document_picker_widget.dart';

class SupportSalaryWarrantyWidget extends StatelessWidget {
  const SupportSalaryWarrantyWidget({required this.pageIndex, super.key});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ChildrenLoanProcedureAddWarrantyController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            locale.guarantee_salary_deduction_upload_message,
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
            title: locale.guarantee_salary_deduction_upload_title,
            subTitle: '',
            cameraFunction: (documentId) {
              controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
            },
            galleryFunction: (documentId) {
              controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
            },
            isUploading: controller.isUploading,
            isUploaded: controller.isUploaded(pageIndex),
            deleteDocumentFunction: (documentId) {
              controller.deleteDocument(documentId);
            },
            documentId: pageIndex,
            selectedDocumentId: controller.selectedDocumentId,
            selectedImageFile: controller.collateralsImages[pageIndex],
          ),
        ],
      );
    });
  }
}
