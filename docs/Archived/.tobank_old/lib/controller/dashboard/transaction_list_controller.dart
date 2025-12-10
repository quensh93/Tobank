import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/transaction/request/transaction_filter_data.dart';
import '../../model/transaction/response/list_transaction_data.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../service/core/api_core.dart';
import '../../service/transaction_services.dart';
import '../../ui/transaction_detail/transaction_detail_screen.dart';
import '../../ui/transaction_filter/transaction_filter_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../main/main_controller.dart';
import 'dashboard_controller.dart';

class TransactionListController extends GetxController {
  MainController mainController = Get.find();
  DashboardController dashboardController = Get.find();
  TransactionFilterData _transactionFilterData = TransactionFilterData();
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

  /// Retrieves transaction data from the server.
  Future _getTransactionsRequest(int page) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    _transactionFilterData.page = page;
    isLoading = true;
    update();
    TransactionServices.getTransactionItemsRequest(
      transactionFilterData: _transactionFilterData,
    ).then(
      (result) {
        isFirstTime = false;
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final ListTransactionData response, int _)):
            transactionDataList.addAll(response.data!.items!);
            if (response.data!.next == null) {
              allDataLoaded = true;
            }
            update();
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

  /// success Show [TransactionDetailScreen]
  void showTransactionDetail(TransactionData transactionItem) {
    Get.to(
      () => TransactionDetailScreen(
        transactionData: transactionItem,
      ),
    );
  }

  void _filterTransaction(TransactionFilterData transactionData) {
    filterTypeValue = 4;
    _transactionFilterData = transactionData;
    update();
    onRefresh();
  }

  void filterCardToCard() {
    _transactionFilterData = TransactionFilterData();
    _transactionFilterData.services = [];
    _transactionFilterData.services.add(8);
    filterTypeValue = 1;
    _transactionFilterData.isCredit = null;
    update();
    onRefresh();
  }

  void filterBuyCharge() {
    _transactionFilterData = TransactionFilterData();
    _transactionFilterData.services = [];
    _transactionFilterData.services.add(3);
    filterTypeValue = 2;
    _transactionFilterData.isCredit = null;
    update();
    onRefresh();
  }

  void showTransactionFilterScreen() {
    Get.to(
      () => TransactionFilterScreen(
        transactionFilterData: _transactionFilterData,
        transactionFilterType: TransactionFilterType.all,
        isWallet: _transactionFilterData.isWallet!,
        returnDataFunction: (transactionData) {
          _filterTransaction(transactionData);
        },
      ),
    );
  }

  void onRefresh() {
    isFirstTime = true;
    page = 1;
    transactionDataList = [];
    allDataLoaded = false;
    update();
    _getTransactionsRequest(page);
  }

  bool isEmptyTransaction() {
    return page == 1 && allDataLoaded && transactionDataList.isEmpty && !isLoading;
  }

  void filterAll() {
    _transactionFilterData = TransactionFilterData();
    _transactionFilterData.isWallet = '0';
    _transactionFilterData.isCredit = null;
    filterTypeValue = 0;
    onRefresh();
  }

  void filterWallet() {
    _transactionFilterData = TransactionFilterData();
    _transactionFilterData.isWallet = '1';
    _transactionFilterData.isCredit = null;
    filterTypeValue = 1;
    onRefresh();
  }
}
