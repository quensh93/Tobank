import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/promissory/request/promissory_inquiry_request_data.dart';
import '../../model/promissory/response/promissory_inquiry_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/promissory_services.dart';
import '../../ui/promissory/promissory_detail/promissory_detail_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class PromissoryInquiryController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = false;

  TextEditingController promissoryIdController = TextEditingController();

  bool isPromissoryIdValid = true;

  TextEditingController nationalCodeController = TextEditingController();

  bool isNationalCodeValid = true;

  PromissoryInquiryResponseData? promissoryInquiryResponseData;

  void validateInquiryInfoPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;

    if (promissoryIdController.text.isNotEmpty) {
      isPromissoryIdValid = true;
    } else {
      isPromissoryIdValid = false;
      isValid = false;
    }

    if (nationalCodeController.text.isNotEmpty) {
      if (nationalCodeController.text.length == Constants.nationalCodeLength &&
          AppUtil.validateNationalCode(nationalCodeController.text)) {
        isNationalCodeValid = true;
      } else {
        isNationalCodeValid = false;
        isValid = false;
      }
    } else {
      isNationalCodeValid = false;
      isValid = false;
    }

    update();
    if (isValid) {
      _promissoryInquiryRequest();
    }
  }

  /// Sends a promissory note inquiry request and navigates to the detail screen.
  void _promissoryInquiryRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryInquiryRequestData promissoryInquiryRequestData = PromissoryInquiryRequestData(
      promissoryId: promissoryIdController.text,
      nationalNumber: nationalCodeController.text,
    );

    isLoading = true;
    update();

    PromissoryServices.promissoryInquiryRequest(
      promissoryInquiryRequestData: promissoryInquiryRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryInquiryResponseData response, int _)):
          Get.off(() => PromissoryDetailScreen(
                promissoryInfo: response.data!,
                promissoryId: response.data!.promissoryId!,
                issuerNn: response.data!.issuerNn!,
              ));
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}





