import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/destination_notebook/deposit_notebook_controller.dart';
import '../../../common/loading_page.dart';
import 'deposit_list_page.dart';

class DepositNotebookPage extends StatelessWidget {
  const DepositNotebookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<DepositNotebookController>(
        init: DepositNotebookController(),
        builder: (controller) {
          return Column(
            children: <Widget>[
              Expanded(
                child: controller.isLoading || controller.hasError
                    ? LoadingPage(
                        controller.errorTitle,
                        hasError: controller.hasError,
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        isLoading: controller.isLoading,
                        retryFunction: () => controller.getDepositNotebookRequest(),
                      )
                    : const DepositListPage(),
              ),
            ],
          );
        },
      ),
    );
  }
}
