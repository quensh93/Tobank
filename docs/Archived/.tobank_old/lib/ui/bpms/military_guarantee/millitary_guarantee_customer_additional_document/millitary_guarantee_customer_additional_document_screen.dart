import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/military_guarantee/millitary_guarantee_customer_additional_document_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../common/custom_app_bar.dart';
import 'view/millitary_guarantee_customer_additional_document_page.dart';

class MillitaryGuaranteeCustomerAdditionalDocumentScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const MillitaryGuaranteeCustomerAdditionalDocumentScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MillitaryGuaranteeCustomerAdditionalDocumentController>(
      init: MillitaryGuaranteeCustomerAdditionalDocumentController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.military_service_guarantee,
                context: context,
              ),
              body: SafeArea(
                child: Container(
                  color: context.theme.colorScheme.surface,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Expanded(
                        child: PageView(
                          controller: controller.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            MillitaryGuaranteeCustomerAdditionalDocumentPage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
