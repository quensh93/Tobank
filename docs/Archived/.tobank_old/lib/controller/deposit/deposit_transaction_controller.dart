import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/deposit/request/deposit_statement_request_data.dart';
import '../../model/deposit/response/customer_deposits_response_data.dart';
import '../../model/deposit/response/deposit_statement_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../main/main_controller.dart';

class DepositTransactionController extends GetxController {
  bool hasError = false;
  late Deposit deposit;
  MainController mainController = Get.find();
  bool isLoading = false;

  late JalaliRange selectedDateRange;
  bool datePicked = false;

  List<TurnOver> turnOversList = [];

  ScrollController scrollControllerTransaction = ScrollController();
  int page = 1;
  final int pageSize = 10;
  bool allDataLoaded = false;
  bool callFromConfirm = true;

  String fromDateString = '';
  String toDateString = '';

  EasyRefreshController refreshController = EasyRefreshController();
  final DepositTransactionFilterType depositTransactionFilterType;

  DepositTransactionController(
      this.deposit, List<TurnOver> turnOversList, this.selectedDateRange, this.depositTransactionFilterType) {
    fromDateString = selectedDateRange.start.formatCompactDate();
    toDateString = selectedDateRange.end.formatCompactDate();
    _handleResponse(turnOversList);
  }

  @override
  void onInit() {
    _addListenerToScrollController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    if (mainController.overlayContext != null) {
      Timer(Constants.duration200, () {
        OverlaySupportEntry.of(mainController.overlayContext!)?.dismiss();
      });
    }
    Get.closeAllSnackbars();
  }

  /// Check for position of last item in list view
  /// if it reach to last item & data is not loading, run [_depositTransactionRequest] with
  /// new [page] parameter
  void _addListenerToScrollController() {
    scrollControllerTransaction.addListener(() {
      if (scrollControllerTransaction.offset >= scrollControllerTransaction.position.maxScrollExtent &&
          !scrollControllerTransaction.position.outOfRange) {
        if (!isLoading && !allDataLoaded && depositTransactionFilterType == DepositTransactionFilterType.byTime) {
          page++;
          depositTransactionRequest(page);
        }
      }
    });
  }

  /// Retrieves deposit transaction statements for a specific deposit from the server.
  Future depositTransactionRequest(int page) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final DepositStatementRequestData depositStatementRequestData = DepositStatementRequestData();
    depositStatementRequestData.trackingNumber = const Uuid().v4();
    depositStatementRequestData.depositNumber = deposit.depositNumber;
    depositStatementRequestData.customerNumber = mainController.authInfoData!.customerNumber!;
    depositStatementRequestData.pageNumber = page;
    depositStatementRequestData.pageSize = pageSize;
    depositStatementRequestData.fromDate = fromDateString;
    depositStatementRequestData.toDate = toDateString;

    hasError = false;
    isLoading = true;
    callFromConfirm = false;
    update();

    DepositServices.getDepositStatementRequest(
      depositStatementRequestData: depositStatementRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DepositStatementResponseData response, int _)):
          _handleResponse(response.data!.turnOvers!);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          update();
          AppUtil.showOverlaySnackbar(
            message: apiException.displayMessage,
            buttonText: locale.try_again,
            callback: () {
              depositTransactionRequest(page);
            },
          );
      }
    });
  }

  void _handleResponse(List<TurnOver> turnOvers) {
    if (turnOvers.isEmpty || turnOvers.length < pageSize) {
      allDataLoaded = true;
    }
    turnOversList.addAll(turnOvers);
    update();
  }

  void onRefresh() {
    reset();
    depositTransactionRequest(page);
  }

  void reset() {
    page = 1;
    turnOversList = [];
    allDataLoaded = false;
    update();
  }
}
