import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:uuid/uuid.dart';

import '../../model/transfer/request/transfer_history_request_data.dart';
import '../../model/transfer/request/transfer_status_request_data.dart';
import '../../model/transfer/response/transfer_history_response_data.dart';
import '../../model/transfer/response/transfer_status_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/transfer_services.dart';
import '../../ui/deposit/deposit_transfer/transfer_detail_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class DepositTransferListController extends GetxController {
  MainController mainController = Get.find();

  bool isLoading = false;

  List<Transaction> transactions = [];

  PageController pageController = PageController();

  Transaction? selectedTransaction;

  ScrollController scrollControllerTransaction = ScrollController();
  int page = 0;
  bool allDataLoaded = false;
  bool hasError = false;
  String? errorTitle = '';

  EasyRefreshController refreshController = EasyRefreshController();

  @override
  void onInit() {
    _addListenerToScrollController();
    onRefresh();
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
        if (!isLoading && !allDataLoaded) {
          page++;
          getTransferListRequest(page);
        }
      }
    });
  }

  /// Retrieves a list of transfer history records from the server.
  void getTransferListRequest(int page) {
    final TransferHistoryRequestData transferHistoryRequestData = TransferHistoryRequestData();
    transferHistoryRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    transferHistoryRequestData.trackingNumber = const Uuid().v4();
    transferHistoryRequestData.pageSize = 10;
    transferHistoryRequestData.offset = page;

    hasError = false;
    isLoading = true;
    update();

    TransferServices.getTransferHistory(
      transferHistoryRequestData: transferHistoryRequestData,
    ).then((result) {//locale
      final locale = AppLocalizations.of(Get.context!)!;
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransferHistoryResponseData response, int _)):
          _handleResponse(response);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = locale.show_error(apiException.displayCode);
          update();
          AppUtil.showOverlaySnackbar(
            message: '${apiException.displayMessage} - ${apiException.displayCode}',
            buttonText: locale.try_again,
            callback: () {
              getTransferListRequest(page);
            },
          );
      }
    });
  }

  void _handleResponse(TransferHistoryResponseData response) {
    if (response.data!.transactions!.isEmpty || response.data!.transactions!.length < 10) {
      allDataLoaded = true;
    }
    transactions.addAll(response.data!.transactions!);
    update();
  }

  /// Sends a request to the server to check the status of a specific transfer transaction.
  void checkTransactionStatusRequest(Transaction transaction) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final TransferStatusRequestData transferStatusRequestData = TransferStatusRequestData();
    transferStatusRequestData.customerNumber = mainController.authInfoData!.customerNumber;
    transferStatusRequestData.trackingNumber = const Uuid().v4();
    transferStatusRequestData.financialTransactionId = transaction.financialTransactionId;

    selectedTransaction = transaction;
    isLoading = true;
    update();
    TransferServices.transferStatusRequest(
      transferStatusRequestData: transferStatusRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final TransferStatusResponseData response, int _)):
          _handleResponseOfStatus(response);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _handleResponseOfStatus(TransferStatusResponseData response) {
    final int index = transactions.indexWhere((element) => element.transactionId == response.data!.transactionId);
    if (index != -1) {
      transactions[index].financialTransactionStatus = response.data!.financialTransactionStatus;
      update();
    }
  }

  void showTransferDetailScreen(Transaction transaction) {
    Get.to(() => TransferDetailScreen(transaction: transaction));
  }

  void onRefresh() {
    reset();
    getTransferListRequest(page);
  }

  void reset() {
    page = 0;
    transactions = [];
    allDataLoaded = false;
    update();
  }
}
