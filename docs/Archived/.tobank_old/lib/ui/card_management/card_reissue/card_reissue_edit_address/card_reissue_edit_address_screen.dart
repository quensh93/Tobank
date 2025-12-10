import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/bpms/card_reissue/card_reissue_edit_address_controller.dart';
import '../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../common/custom_app_bar.dart';
import 'view/card_reissue_edit_address_page.dart';

class CardReissueEditAddressScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const CardReissueEditAddressScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardReissueEditAddressController>(
      init: CardReissueEditAddressController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.issuing_duplicate_card,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          CardReissueEditAddressPage(),
                        ],
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
