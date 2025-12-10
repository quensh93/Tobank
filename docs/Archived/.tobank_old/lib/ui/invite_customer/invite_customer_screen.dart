import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/invite_customer/invite_customer_controller.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import 'view/invite_customer_page.dart';

class InviteCustomerScreen extends StatelessWidget {
  const InviteCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<InviteCustomerController>(
        init: InviteCustomerController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString:locale.invite_friends,
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
                        LoadingPage(
                          controller.errorTitle,
                          hasError: controller.hasError,
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          isLoading: controller.isLoading,
                          retryFunction: () {},
                        ),
                        const InviteCustomerPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
