import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/children_loan_procedure/children_loan_customer_document_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/document_picker_widget.dart';

class ChildrenLoanProcedureCustomerDocumentScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const ChildrenLoanProcedureCustomerDocumentScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ChildrenLoanProcedureCustomerDocumentController>(
      init: ChildrenLoanProcedureCustomerDocumentController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.children_loan,
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
                              Text(locale.upload_applicant_identity_info, style: ThemeUtil.titleStyle),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(locale.please_upload_requested_birth_certificate_pages,
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
                              Text(locale.applicant_relationship_with_child, style: ThemeUtil.titleStyle),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        controller.setApplicantIsFathersChild();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                          border: Border.all(
                                            color: controller.applicantIsFathersChild
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
                                              groupValue: controller.applicantIsFathersChild,
                                              value: true,
                                            ),
                                            Text(locale.father,
                                                style: TextStyle(
                                                  color: ThemeUtil.textTitleColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ))
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
                                        controller.setApplicantIsGuardianChild();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                          border: Border.all(
                                            color: !controller.applicantIsFathersChild
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
                                              groupValue: controller.applicantIsFathersChild,
                                              value: false,
                                            ),
                                            Text(locale.legal_guardian,
                                                style: TextStyle(
                                                  color: ThemeUtil.textTitleColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ))
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
                              DocumentPickerWidget(
                                title: locale.birth_certificate_page_one_two,
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
                                title: locale.birth_certificate_page_three_four,
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
                                title: locale.birth_certificate_page_five_six,
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
                              if (!controller.applicantIsFathersChild)
                                const SizedBox(
                                  height: 16.0,
                                )
                              else
                                Container(),
                              if (!controller.applicantIsFathersChild)
                                DocumentPickerWidget(
                                  title: locale.guardianship_document,
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
                                )
                              else
                                Container(),
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
