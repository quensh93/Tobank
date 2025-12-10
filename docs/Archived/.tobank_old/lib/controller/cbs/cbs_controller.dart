import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_util.dart';
import '../../util/enums_constants.dart';

class CBSController extends GetxController {
  PageController pageController = PageController();

  CBSMenuType cbsMenuType = CBSMenuType.cbsServices;

  void showCBSServices() {
    cbsMenuType = CBSMenuType.cbsServices;
    update();
    AppUtil.previousPageController(pageController, isClosed);
  }

  void showCBSReports() {
    cbsMenuType = CBSMenuType.cbsReports;
    update();
    AppUtil.nextPageController(pageController, isClosed);
  }
}
