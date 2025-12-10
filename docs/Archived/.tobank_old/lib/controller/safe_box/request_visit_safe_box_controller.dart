import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/safe_box/request/submit_visit_safe_box_request_data.dart';
import '../../model/safe_box/response/submit_visit_safe_box_response_data.dart';
import '../../model/safe_box/response/user_safe_box_list_response_data.dart';
import '../../model/safe_box/response/visit_date_time_list_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/safe_box_services.dart';
import '../../util/app_util.dart';
import '../../util/date_converter_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class RequestVisitSafeBoxController extends GetxController {
  RequestVisitSafeBoxController({required this.safeBoxData});

  SafeBoxData safeBoxData;
  PageController pageController = PageController();
  MainController mainController = Get.find();
  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = false;

  VisitDateTimeListResponseData? visitDateTimeListResponseData;
  int? selectedDate;
  List<Time> times = [];

  int? selectedTime;
  SubmitVisitSafeBoxResponseData? submitVisitSafeBoxResponseData;

  @override
  void onInit() {
    getListOfReferDateTimeRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the list of available visit date and time options and handles the response.
  void getListOfReferDateTimeRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    SafeBoxServices.getVisitDateTimeRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final VisitDateTimeListResponseData response, int _)):
          visitDateTimeListResponseData = response;
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

  void selectDate(int index) {
    selectedDate = index;
    times = visitDateTimeListResponseData!.data!.results![index].times ?? [];
    update();
  }

  void selectTIme(int index) {
    selectedTime = index;
    update();
  }

  void validateRequestVisitSelectedDate() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedTime != null && selectedDate != null) {
      _submitVisitRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_visit_datetime,
      );
    }
  }

  /// Submits a request for a safe box visit and handles the response.
  void _submitVisitRequest() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final SubmitVisitSafeBoxRequestData submitVisitSafeBoxRequestData = SubmitVisitSafeBoxRequestData();
    submitVisitSafeBoxRequestData.userFundId = safeBoxData.id;
    submitVisitSafeBoxRequestData.visitTimeId = selectedTime;

    isLoading = true;
    update();
    SafeBoxServices.submitVisitRequest(submitVisitSafeBoxRequestData: submitVisitSafeBoxRequestData).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final SubmitVisitSafeBoxResponseData response, int _)):
          submitVisitSafeBoxResponseData = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  String getSelectedDate() {
    return DateConverterUtil.getDateJalaliWithDayName(
      gregorianDate: visitDateTimeListResponseData!.data!.results![selectedDate!].date!,
    );
  }

  String getSelectedTime() {
    final timeData = times.where((element) => element.id == selectedTime).first;
    return '${timeData.fromHour} تا ${timeData.toHour}';
  }

  String getAddressOfBranch() {
    return safeBoxData.fund!.branch!.address!;
  }
}
