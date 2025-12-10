import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/customer_tasks/customer_tasks_controller.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'view/process_list_page.dart';

class CardboardPage extends StatelessWidget {
  const CardboardPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerTasksController>(
      init: CustomerTasksController(),
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvoked: controller.onBackPress,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                          // update customer status only when status is unconfirmed
                          controller.refreshTaskList(
                              shouldUpdateCustomerStatus:
                                  controller.mainController.authInfoData!.shabahangCustomerStatus == 2);
                        },
                        backFunction: () {
                          controller.onBackPressed();
                        },
                      ),
                      const ProcessListPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
