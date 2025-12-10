import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_marriage_license_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/document_picker_widget.dart';

class MarriageLoanProcedureMarriageLicenseScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const MarriageLoanProcedureMarriageLicenseScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanProcedureMarriageLicenseController>(
      init: MarriageLoanProcedureMarriageLicenseController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.upload_marriage_certificate_pages,
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
                                locale.upload_marriage_certificate_pages,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                locale.upload_original_marriage_documents,
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
                              Text(locale.marriage_certificate_type, style: ThemeUtil.titleStyle),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        controller.setLicenseIsSinglePage();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                          border: Border.all(
                                            color: controller.licenseIsSinglePage
                                                ? context.theme.colorScheme.primary
                                                : context.theme.dividerColor,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Radio(
                                              onChanged: (bool? value) {
                                                controller.radioOnChanged(value);
                                              },
                                              groupValue: controller.licenseIsSinglePage,
                                              value: true,
                                            ),
                                            Text(
                                              locale.single_page,
                                              style: TextStyle(
                                                color: ThemeUtil.textTitleColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        controller.setLicenseIsMultiPage();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                          border: Border.all(
                                            color: !controller.licenseIsSinglePage
                                                ? context.theme.colorScheme.primary
                                                : context.theme.dividerColor,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Radio(
                                              onChanged: (bool? value) {
                                                controller.radioOnChanged(value);
                                              },
                                              groupValue: controller.licenseIsSinglePage,
                                              value: false,
                                            ),
                                            Text(
                                              locale.booklet,
                                              style: TextStyle(
                                                color: ThemeUtil.textTitleColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              if (controller.licenseIsSinglePage) ...[
                                DocumentPickerWidget(
                                  title: locale.upload_marriage_certificate_front_page,
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
                                  title:locale.upload_marriage_certificate_back_page,
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
                              ] else ...[
                                DocumentPickerWidget(
                                  title: locale.upload_second_third_marriage_certificate_pages,
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
                                DocumentPickerWidget(
                                  title: locale.upload_fourth_fifth_marriage_certificate_pages,
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
                                  height: 16.0,
                                ),
                                DocumentPickerWidget(
                                  title: locale.upload_notary_information,
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
                                  isUploaded: controller.isUploaded(5),
                                  deleteDocumentFunction: (documentId) {
                                    controller.deleteDocument(documentId);
                                  },
                                  documentId: 5,
                                  selectedDocumentId: controller.selectedDocumentId,
                                  selectedImageFile: controller.documentFile_5,
                                ),
                              ],
                              const SizedBox(
                                height: 40,
                              ),
                              ContinueButtonWidget(
                                callback: () {
                                  controller.validateMarriageLicense();
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
