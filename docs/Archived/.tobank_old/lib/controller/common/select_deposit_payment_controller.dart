import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/deposit/request/deposit_balance_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/deposit/response/deposit_balance_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class SelectDepositPaymentController extends GetxController {
  final mainController = Get.find<MainController>();
  final List<Deposit> depositList;
  final Function(Deposit deposit) selectDeposit;

  Deposit? selectedDeposit;

  Map<String, bool> depositBalanceLoadingMap = {};

  SelectDepositPaymentController({
    required this.depositList,
    required this.selectDeposit,
  });

  @override
  void onInit() {
    for (var i = 0; i < depositList.length; i++) {
      getDepositBalanceRequest(depositList[i], true);
    }
    super.onInit();
  }

  void setSelectedDepositFunction(Deposit deposit) {
    selectedDeposit = deposit;
    update();
  }

  /// Sends a request to get the balance of a deposit
  void getDepositBalanceRequest(Deposit deposit, bool isAuto) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DepositBalanceRequestData depositBalanceRequestData = DepositBalanceRequestData();
    depositBalanceRequestData.trackingNumber = const Uuid().v4();
    depositBalanceRequestData.depositNumber = deposit.depositNumber;
    depositBalanceRequestData.customerNumber = mainController.authInfoData!.customerNumber!;

    depositBalanceLoadingMap[deposit.depositNumber!] = true;
    update();

    DepositServices.getDepositBalanceRequest(
      depositBalanceRequestData: depositBalanceRequestData,
    ).then((result) {
      depositBalanceLoadingMap[deposit.depositNumber!] = false;
      update();

      switch (result) {
        case Success(value: (final DepositBalanceResponseData response, int _)):
          deposit.balance = response.data?.balance;
          update();
        case Failure(exception: final ApiException apiException):
          if (!isAuto) {
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
          }
      }
    });
  }

  void validateDeposit() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedDeposit != null) {
      Get.back();
      selectDeposit(selectedDeposit!);
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.warning,
        message: locale.select_deposit_for_payment,
      );
    }
  }
}
