import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/transaction/request/transaction_filter_data.dart';
import '../../../model/transaction/response/list_transaction_data.dart';
import '../../../model/transaction/response/transaction_data.dart';
import '../../../service/core/api_core.dart';
import '../../../service/transaction_services.dart';
import '../../../ui/cbs/cbs_reports/view/cbs_transaction_item.dart';
import '../../../ui/cbs/cbs_transaction_detail/cbs_transaction_detail_screen.dart';
import '../../../ui/transaction_detail/transaction_detail_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/storage_util.dart';
import '../../main/main_controller.dart';

class CBSReportsController extends GetxController {
  MainController mainController = Get.find();
  TransactionFilterData transactionFilterData = TransactionFilterData();
  List<CBSTransactionItemWidget> transactionItemWidgetList = [];
  List<TransactionData> transactionDataList = [];
  ScrollController scrollControllerTransaction = ScrollController();
  int page = 1;
  bool isLoading = false;
  bool allDataLoaded = false;
  bool isFirstTime = true;

  int filterTypeValue = 0;

  EasyRefreshController refreshController = EasyRefreshController();

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
  /// if it reach to last item & data is not loading, run [_getTransactions] with
  /// new [page] parameter
  void _addListenerToScrollController() {
    scrollControllerTransaction.addListener(() {
      if (scrollControllerTransaction.offset >= scrollControllerTransaction.position.maxScrollExtent &&
          !scrollControllerTransaction.position.outOfRange) {
        if (!isLoading && !allDataLoaded && !isFirstTime) {
          page++;
          _getTransactionsRequest(page);
        }
      }
    });
  }

  /// Sends a request to get transaction items and updates the UI.
  Future _getTransactionsRequest(int page) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    transactionFilterData.page = page;
    transactionFilterData.services = [89, 102];
    transactionFilterData.isSuccess = '1';
    transactionFilterData.sort = '-id';
    isLoading = true;
    update();
    TransactionServices.getTransactionItemsRequest(
      transactionFilterData: transactionFilterData,
    ).then(
      (result) {
        isFirstTime = false;
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final ListTransactionData response, int _)):
            transactionDataList.addAll(response.data!.items!);
            _generateTransactionItemWidgets(response.data!.items!);
            if (response.data!.next == null) {
              allDataLoaded = true;
            }
          case Failure(exception: final ApiException apiException):
            switch (apiException.type) {
              case ApiExceptionType.unhandledStatusCode:
                if (apiException.statusCode == 404) {
                  allDataLoaded = true;
                  update();
                } else {
                  AppUtil.showOverlaySnackbar(
                    message: apiException.displayMessage,
                    buttonText: locale.try_again,
                    callback: () {
                      _getTransactionsRequest(page);
                    },
                  );
                }
              default:
                AppUtil.showOverlaySnackbar(
                  message: apiException.displayMessage,
                  buttonText: locale.try_again,
                  callback: () {
                    _getTransactionsRequest(page);
                  },
                );
            }
        }
      },
    );
  }

  /// Create list of [TransactionItemWidget] from [transactions] list
  void _generateTransactionItemWidgets(List<TransactionData> transactions) {
    for (final TransactionData transactionData in transactions) {
      transactionItemWidgetList.add(
        CBSTransactionItemWidget(
          transactionData: transactionData,
          showDataFunction: (transactionItem) {
            _showTransactionDetail(transactionItem);
          },
          shareDataFunction: (transactionData) {
            _shareTransactionDetail(transactionData);
          },
        ),
      );
    }
    update();
  }

  /// success Show [TransactionDetailScreen]
  void _showTransactionDetail(TransactionData transactionItem) {
    StorageUtil.setShowCBSIntroduction(false);
    Get.to(
      () => CBSTransactionDetailScreen(
        transactionData: transactionItem,
        displayDescription: false,
      ),
    );
  }

  void _shareTransactionDetail(TransactionData transactionData) {}

  void onRefresh() {
    isFirstTime = true;
    page = 1;
    transactionDataList = [];
    transactionItemWidgetList = [];
    allDataLoaded = false;
    update();
    _getTransactionsRequest(page);
  }

  bool isEmptyTransaction() {
    return page == 1 && allDataLoaded && transactionDataList.isEmpty && !isLoading;
  }

  void filterAll() {
    transactionFilterData = TransactionFilterData();
    transactionFilterData.inquiryIsOwn = null;
    filterTypeValue = 0;
    update();
    onRefresh();
  }

  void filterMyOwn() {
    transactionFilterData = TransactionFilterData();
    transactionFilterData.inquiryIsOwn = 'true';
    filterTypeValue = 1;
    update();
    onRefresh();
  }

  void filterOthers() {
    transactionFilterData = TransactionFilterData();
    transactionFilterData.inquiryIsOwn = 'false';
    filterTypeValue = 2;
    update();
    onRefresh();
  }
}
