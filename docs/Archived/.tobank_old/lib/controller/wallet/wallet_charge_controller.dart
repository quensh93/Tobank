import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../model/transaction/response/transaction_data_response.dart';
import '../../model/wallet/response/charge_wallet_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/transaction_services.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class WalletChargeController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = false;

  PageController pageController = PageController();
  TransactionData? transactionData;
  ChargeWalletInternetResponseData? chargeWalletResponseData;

  WalletChargeController({
    required this.chargeWalletResponseData,
    required TransactionDataResponse? transactionDataResponse,
  }) {
    if (chargeWalletResponseData == null) {
      pageController = PageController(initialPage: 1);
      transactionData = transactionDataResponse!.data;
      update();
    }
  }

  Future<void> checkPayment() async {
    _transactionDetailByIdRequest();
  }

  /// Retrieves transaction details by ID.
  ///
  /// This function sends a request to the server to retrieve detailed information about a
  /// specific transaction using its ID.
  void _transactionDetailByIdRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    TransactionServices.getTransactionByIdRequest(
      id: chargeWalletResponseData!.data!.transactionId!,
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
              page: 2,
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
