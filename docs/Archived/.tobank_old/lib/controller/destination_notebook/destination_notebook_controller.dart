import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_util.dart';
import '../../util/enums_constants.dart';

class DestinationNotebookController extends GetxController {
  PageController pageController = PageController();
  DestinationType currentDepositScreenType = DestinationType.card;

  @override
  void onInit() {
    addListenerToPageController();
    super.onInit();
  }

  /// Check current page of [PageView] widget
  /// if page change to 0, change to buy screen
  /// else change to show screen
  void addListenerToPageController() {
    pageController.addListener(() {
      if (pageController.page == 0) {
        currentDepositScreenType = DestinationType.card;
        update();
      } else if (pageController.page == 1) {
        currentDepositScreenType = DestinationType.deposit;
        update();
      } else if (pageController.page == 2) {
        currentDepositScreenType = DestinationType.iban;
        update();
      }
    });
  }

  void selectCard() {
    currentDepositScreenType = DestinationType.card;
    update();
    AppUtil.gotoPageController(
      pageController: pageController,
      page: 0,
      isClosed: isClosed,
    );
  }

  void selectDeposit() {
    currentDepositScreenType = DestinationType.deposit;
    update();
    AppUtil.gotoPageController(
      pageController: pageController,
      page: 1,
      isClosed: isClosed,
    );
  }

  void selectIban() {
    currentDepositScreenType = DestinationType.iban;
    update();
    AppUtil.gotoPageController(
      pageController: pageController,
      page: 2,
      isClosed: isClosed,
    );
  }
}
