import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_util.dart';
import '../../util/enums_constants.dart';

class TransactionMainController extends GetxController {
  TransactionType currentTransactionType = TransactionType.tobank;

  PageController pageController = PageController();

  void setTransactionType(TransactionType transactionType) {
    currentTransactionType = transactionType;
    update();
    if (currentTransactionType == TransactionType.tobank) {
      AppUtil.changePageController(pageController: pageController, page: 0, isClosed: isClosed);
    } else {
      AppUtil.changePageController(pageController: pageController, page: 1, isClosed: isClosed);
    }
  }
}
