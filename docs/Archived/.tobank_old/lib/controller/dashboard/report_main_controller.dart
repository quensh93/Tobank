import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_util.dart';
import '../../util/enums_constants.dart';

class ReportMainController extends GetxController {
  PageController pageController = PageController();
  ReportPageType currentHistoryCardScreen = ReportPageType.cardBoard;

  void selectCardBoard() {
    currentHistoryCardScreen = ReportPageType.cardBoard;
    update();
    AppUtil.changePageController(pageController: pageController, page: 0, isClosed: isClosed);
  }

  void selectProcess() {
    currentHistoryCardScreen = ReportPageType.process;
    update();
    AppUtil.changePageController(pageController: pageController, page: 1, isClosed: isClosed);
  }
}
