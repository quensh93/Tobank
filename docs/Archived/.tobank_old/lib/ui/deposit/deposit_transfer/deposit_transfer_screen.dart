import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/deposit/transfer/deposit_transfer_controller.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../util/enums_constants.dart';
import '../../common/loading_page.dart';
import 'page/deposit_transfer_amount_page.dart';
import 'page/deposit_transfer_confirm_page.dart';
import 'page/deposit_transfer_result_page.dart';
import 'page/destination_deposit_selector_page.dart';
import 'page/destination_iban_selector_page.dart';

class DepositTransferScreen extends StatelessWidget {
  const DepositTransferScreen({
    required this.transferType,
    required this.hideTabViewFunction,
    super.key,
    this.deposit,
  });

  final Deposit? deposit;
  final TransferTypeEnum transferType;
  final Function(bool isHideTabView) hideTabViewFunction;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositTransferController>(
      init: DepositTransferController(deposit: deposit, hideTabViewFunction: hideTabViewFunction),
      builder: (controller) {
        controller.setCurrentTransferType(transferType);
        return PopScope(
          canPop: false,
          onPopInvoked: controller.onBackPress,
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
                    retryFunction: () {
                      controller.getDepositNotebookRequest();
                    },
                  ),
                  if (controller.currentTransferType == TransferTypeEnum.iban)
                    const DestinationIbanSelectorPage()
                  else
                    const DestinationDepositSelectorPage(),
                  const DepositTransferAmountPage(),
                  const DepositTransferConfirmPage(),
                  const DepositTransferResultPage(),
                ],
              )),
            ],
          ),
        );
      },
    );
  }
}
