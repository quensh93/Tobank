import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/home_controller.dart';
import '../../common/minify_loading_page.dart';
import '../widget/authentication_status_widget.dart';
import '../widget/home_header_widget.dart';
import '../widget/home_selection_widget.dart';
import 'card_main_page.dart';
import 'deposit_main_page.dart';
import 'disable_deposit_main_page.dart';
import 'finance_main_page.dart';
import 'services_main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Column(
          children: [
            const HomeHeaderWidget(),
            const SizedBox(height: 32),
            const HomeSelectionWidget(),
            const SizedBox(height: 16.0),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  if (controller.isLoading || controller.hasError)
                    MinifyLoadingPage(
                      controller.errorTitle,
                      hasError: controller.hasError,
                      isLoading: controller.isLoading,
                      retryFunction: () {
                        controller.getCustomerInfoRequest();
                      },
                    )
                  else
                    controller.mainController.isCustomerHasFullAccess()
                        ? const DepositMainPage()
                        : controller.mainController.hasCustomerNumber() // TODO: use better way to handle status
                            ? const DisableDepositMainPage()
                            : const AuthenticationStatusWidget(),
                  const CardMainPage(),
                  const FinanceMainPage(),
                  const ServicesMainPage(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
