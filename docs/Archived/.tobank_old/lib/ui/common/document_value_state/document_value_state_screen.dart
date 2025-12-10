import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/common/document_value_state_controller.dart';
import '../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../custom_app_bar.dart';
import '../document_picker_widget.dart';

class DocumentValueStateScreen extends StatelessWidget {
  const DocumentValueStateScreen({
    required this.task,
    required this.taskData,
    super.key,
    this.title,
  });

  final String? title;
  final Task task;
  final List<TaskDataFormField> taskData;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DocumentValueStateController>(
      init: DocumentValueStateController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: title ?? locale.documents_edit,
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
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.documents.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return DocumentPickerWidget(
                                    title: controller.documents[index].documentValue.title!,
                                    subTitle: controller.documents[index].documentValue.description ?? '',
                                    cameraFunction: (documentId) {
                                      controller.selectDocumentImage(
                                          documentId: documentId, imageSource: ImageSource.camera);
                                    },
                                    galleryFunction: (documentId) {
                                      controller.selectDocumentImage(
                                          documentId: documentId, imageSource: ImageSource.gallery);
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
                                  controller.validateEditDocument();
                                },
                                isLoading: controller.isLoading,
                                buttonTitle: locale.save,
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
