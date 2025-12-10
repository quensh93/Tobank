import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/customer_referrals/request/customer_referrals_request_data.dart';
import '../../model/customer_referrals/response/customer_referrals_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/customer_referrals_services.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class CustomerReferralsController extends GetxController {
  bool isLoading = false;
  MainController mainController = Get.find();
  bool hasError = false;
  PageController pageController = PageController();
  String? errorTitle = '';

  final scrollController = ScrollController();

  CustomerReferralsResponse? customerReferralsResponse;

  @override
  void onInit() {
    super.onInit();
    getCustomerReferralsRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Sends a request to get customer referrals, updates the UI,
  /// and potentially navigates to the next page or shows an error message.
  void getCustomerReferralsRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.authInfoData!.customerNumber == null) {
      return;
    }
    final CustomerReferralsRequest customerReferralsRequest = CustomerReferralsRequest(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
    );

    hasError = false;
    isLoading = true;
    update();

    CustomerReferralsServices.getCustomerReferrals(
      customerReferralsRequest: customerReferralsRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerReferralsResponse response, int _)):
          customerReferralsResponse = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }
}
