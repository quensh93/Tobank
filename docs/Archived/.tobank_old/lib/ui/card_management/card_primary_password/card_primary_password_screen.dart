import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/card/card_change_password_controller.dart';
import '../../../model/card/pin_type_data.dart';
import '../../../model/card/response/customer_card_response_data.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'view/card_primary_password_change_first_page.dart';
import 'view/card_primary_password_change_second_page.dart';
import 'view/card_primary_password_confirm_page.dart';
import 'view/card_primary_password_result_page.dart';

class CardPrimaryPasswordScreen extends StatelessWidget {
  const CardPrimaryPasswordScreen({
    required this.customerCard,
    required this.pinTypeData,
    super.key,
  });

  final CustomerCard customerCard;
  final PinTypeData pinTypeData;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardChangePasswordController>(
      init: CardChangePasswordController(customerCard: customerCard),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: pinTypeData.title,
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
                              controller.getDibalitePublicKeyRequest();
                            },
                          ),
                          if (pinTypeData.eventId == 1)
                            const CardPrimaryPasswordConfirmPage()
                          else
                            const CardPrimaryPasswordChangeFirstPage(),
                          if (pinTypeData.eventId == 1)
                            const CardPrimaryPasswordResultPage()
                          else
                            const CardPrimaryPasswordChangeSecondPage(),
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
