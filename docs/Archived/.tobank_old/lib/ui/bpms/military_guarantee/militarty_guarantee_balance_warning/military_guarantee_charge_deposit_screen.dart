import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/military_guarantee/military_guarantee_charge_deposit_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'view/military_guarantee_charge_deposit_page.dart';

class MilitaryGuaranteeChargeDepositScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const MilitaryGuaranteeChargeDepositScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeChargeDepositController>(
      init: MilitaryGuaranteeChargeDepositController(task: task, taskData: taskData),
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
                          children: [
                            VirtualBranchLoadingPage(
                              controller.errorTitle,
                              hasError: controller.hasError,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isLoading,
                              retryFunction: () {
                                controller.getCashDepositBalanceRequest();
                              },
                            ),
                            VirtualBranchLoadingPage(
                              controller.errorTitle,
                              hasError: controller.hasError,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isLoading,
                              retryFunction: () {
                                controller.getCollateralDepositBalanceRequest();
                              },
                            ),
                            const MilitaryGuaranteeChargeDepositPage(),
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
