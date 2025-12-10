import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui/launcher/launcher_screen.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class IntroController extends GetxController {
  PageController pageController = PageController();
  MainController mainController = Get.find();

  @override
  Future<void> onInit() async {
    if(mainController.getToPayment) {
      Get.back();
    }
    super.onInit();
  }

  Future<void> handleDoneClick() async {
    await StorageUtil.setIsIntroSeen('true');
    Get.offAll(() => const LauncherScreen());
  }
}
