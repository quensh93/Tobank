import 'package:get/get.dart';

import '../../model/wallet/response/wallet_balance_response_data.dart';
import '../../model/wallet/response/wallet_detail_data.dart';
import '../../service/core/api_core.dart';
import '../../service/wallet_services.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

class CardWalletController extends GetxController {
  MainController mainController = Get.find();

  late WalletBalanceResponseData walletBalanceResponseData;
  int currentAmount = 0;

  bool isWalletLoading = true;
  bool hasWalletError = false;

  @override
  void onInit() {
    super.onInit();
    getWalletDetailRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Sends a request to get wallet details and updates the UI.
  /// Get data of [WalletDetailData] from server request
  Future<void> getWalletDetailRequest() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasWalletError = false;
    isWalletLoading = true;
    update();
    WalletServices.getWalletBalance().then(
      (result) {
        isWalletLoading = false;
        update();

        switch (result) {
          case Success(value: (final WalletBalanceResponseData response, int _)):
            walletBalanceResponseData = response;
            currentAmount = response.data!.amount ?? 0;
            update();
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
