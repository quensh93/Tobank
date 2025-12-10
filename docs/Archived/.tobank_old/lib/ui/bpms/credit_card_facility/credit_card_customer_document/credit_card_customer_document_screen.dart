import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../controller/bpms/credit_card_facility/credit_card_customer_document_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/document_picker_widget.dart';

class CreditCardCustomerDocumentScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const CreditCardCustomerDocumentScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CreditCardCustomerDocumentController>(
      init: CreditCardCustomerDocumentController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.credit_card_reception,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                locale.upload_applicant_identity_info,
                                style: ThemeUtil.titleStyle,
                              ),
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
                                title: locale.page_marriage_certificate,
                                subTitle: '',
                                cameraFunction: (documentId) {
                                  controller.selectDocumentImage(
                                      documentId: documentId, imageSource: ImageSource.camera);
                                },
                                galleryFunction: (documentId) {
                                  controller.selectDocumentImage(
                                      documentId: documentId, imageSource: ImageSource.gallery);
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
                                title: locale.page_children_certificate_,
                                subTitle: '',
                                cameraFunction: (documentId) {
                                  controller.selectDocumentImage(
                                      documentId: documentId, imageSource: ImageSource.camera);
                                },
                                galleryFunction: (documentId) {
                                  controller.selectDocumentImage(
                                      documentId: documentId, imageSource: ImageSource.gallery);
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
                                title: locale.page_life_certificate_,
                                subTitle: '',
                                cameraFunction: (documentId) {
                                  controller.selectDocumentImage(
                                      documentId: documentId, imageSource: ImageSource.camera);
                                },
                                galleryFunction: (documentId) {
                                  controller.selectDocumentImage(
                                      documentId: documentId, imageSource: ImageSource.gallery);
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
                                height: 16.0,
                              ),
                              Text(
                                locale.upload_professional_certificate,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                locale.upload_professional_certificate_description,
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
                                title: locale.professional_certificate_image,
                                subTitle: '',
                                cameraFunction: (documentId) {
                                  controller.selectDocumentImage(
                                      documentId: documentId, imageSource: ImageSource.camera);
                                },
                                galleryFunction: (documentId) {
                                  controller.selectDocumentImage(
                                      documentId: documentId, imageSource: ImageSource.gallery);
                                },
                                isUploading: controller.isUploading,
                                isUploaded: controller.isUploaded(4),
                                deleteDocumentFunction: (documentId) {
                                  controller.deleteDocument(documentId);
                                },
                                documentId: 4,
                                selectedDocumentId: controller.selectedDocumentId,
                                selectedImageFile: controller.documentFile_4,
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
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
