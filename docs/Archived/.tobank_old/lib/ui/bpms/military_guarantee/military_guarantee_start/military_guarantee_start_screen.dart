import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/ui/bpms/feature/rule_page.dart';
import '../../../../../controller/bpms/military_guarantee/military_guarantee_start_controller.dart';
import '../../../bpms/common/task_list_page.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'view/military_guarantee_customer_address_page.dart';
import 'view/military_guarantee_person_address_page.dart';
import 'view/military_guarantee_person_info_confirm_page.dart';
import 'view/military_guarantee_person_info_page.dart';
import 'view/military_guarantee_person_page.dart';

class MilitaryGuaranteeStartScreen extends StatelessWidget {
  const MilitaryGuaranteeStartScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeStartController>(
      init: MilitaryGuaranteeStartController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.military_lg,
                  context: context,
                ),
                body: SafeArea(
                  child: Column(
                    children: [
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
                                controller.getMilitaryGuaranteeStartRulesRequest();
                              },
                            ),
                            BPMSRulePage(
                              callback: controller.validateRules,
                              setChecked: controller.setChecked,
                              title: locale.terms_and_conditions_title_warranty,
                              checkTitle: locale.terms_and_conditions_check_title,
                              scrollbarController: controller.scrollbarController,
                              otherItemData: controller.otherItemData,
                              isRuleChecked: controller.isRuleChecked,
                              isLoading: controller.isLoading,
                            ),
                            const MilitaryGuaranteePersonPage(),
                            const MilitaryGuaranteePersonInfoPage(),
                            const MilitaryGuaranteePersonInfoConfirmPage(),
                            const MilitaryGuaranteePersonAddressPage(),
                            const MilitaryGuaranteeCustomerAddressPage(),
                            VirtualBranchLoadingPage(
                              controller.errorTitle,
                              hasError: controller.hasError,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isLoading,
                              retryFunction: () {
                                controller.getApplicantTaskListRequest();
                              },
                            ),
                            const TaskListPage(
                              taskListControllerTag: MilitaryGuaranteeStartController.taskListControllerTag,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
