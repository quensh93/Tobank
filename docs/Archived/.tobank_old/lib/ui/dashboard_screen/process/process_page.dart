import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/process_controller.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'view/process_list_page.dart';

class ProcessPage extends StatelessWidget {
  const ProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<ProcessController>(
          init: ProcessController(),
          builder: (controller) {
            return Column(
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
                          controller.getCustomerProcess();
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
            );
          }),
    );
  }
}
