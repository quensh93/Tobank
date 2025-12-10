import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/destination_notebook/iban_notebook_controller.dart';
import '../../../common/loading_page.dart';
import 'iban_list_page.dart';

class IbanNotebookPage extends StatelessWidget {
  const IbanNotebookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<IbanNotebookController>(
        init: IbanNotebookController(),
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
                    : const IbanListPage(),
              ),
            ],
          );
        },
      ),
    );
  }
}
