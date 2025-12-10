import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/common/document_state_controller.dart';
import '../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../custom_app_bar.dart';
import '../document_picker_edit_widget.dart';

class DocumentStateScreen extends StatelessWidget {
  const DocumentStateScreen({
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
    return GetBuilder<DocumentStateController>(
      init: DocumentStateController(task: task, taskData: taskData),
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
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return DocumentPickerEditWidget(
                                    cameraFunction: (documentStateData) {
                                      controller.selectDocumentImage(
                                          taskDataFormField: documentStateData, imageSource: ImageSource.camera);
                                    },
                                    galleryFunction: (documentStateData) {
                                      controller.selectDocumentImage(
                                          taskDataFormField: documentStateData, imageSource: ImageSource.gallery);
                                    },
                                    deleteDocumentFunction: (documentStateData) {
                                      controller.deleteDocument(documentStateData);
                                    },
                                    documentStateData: controller.documentStateDataList[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 16.0,
                                  );
                                },
                                itemCount: controller.documentStateDataList.length,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ContinueButtonWidget(
                                callback: () {
                                  controller.validateDocumentEdit();
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
