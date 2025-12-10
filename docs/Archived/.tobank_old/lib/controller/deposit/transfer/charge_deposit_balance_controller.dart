import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/deposit/response/increase_deposit_balance_response_data.dart';
import '../../../model/transaction/response/transaction_data.dart';
import '../../../model/transaction/response/transaction_data_response.dart';
import '../../../service/core/api_core.dart';
import '../../../service/transaction_services.dart';
import '../../../util/app_util.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class DepositChargeBalanceController extends GetxController {
  MainController mainController = Get.find();
  bool hasError = false;
  String errorTitle = '';
  bool isLoading = false;

  IncreaseDepositBalanceResponseData increaseDepositBalanceResponseData;
  PageController pageController = PageController();

  bool storeLoading = false;

  bool shareLoading = false;

  TransactionData? transactionData;

  DepositChargeBalanceController({
    required this.increaseDepositBalanceResponseData,
  });

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> checkPayment() async {
    _transactionDetailByIdRequest();
  }

  void _transactionDetailByIdRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: increaseDepositBalanceResponseData.data!.transactionId!,
    ).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            transactionData = response.data;
            update();
            AppUtil.changePageController(
              pageController: pageController,
              page: 1,
              isClosed: isClosed,
            );
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }
}
