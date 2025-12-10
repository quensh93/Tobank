import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/enums_constants.dart';

class NationalCardBackSampleController extends GetxController {
  final File userFile;
  final Function(File? file) returnCallback;

  String get sampleUrl => HelperTypeSample.backNationalCard.url;

  NationalCardBackSampleController({required this.userFile, required this.returnCallback});

  /// Handles the back button press, executing a callback and popping the current screen.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    returnCallback(null);
    final NavigatorState navigator = Navigator.of(Get.context!);
    navigator.pop();
  }

  void reloadSamples() {
    update();
  }

  void submitFile() {
    returnCallback(userFile);
    Get.back();
  }
}
