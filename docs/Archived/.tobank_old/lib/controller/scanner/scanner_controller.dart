import 'dart:async';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../util/constants.dart';

class ScannerController extends GetxController {
  MobileScannerController mobileScannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  ScannerController({
    required this.returnData,
  });

  Function(String? data) returnData;

  void onDetect(BarcodeCapture? barcodeCapture) {
    if (barcodeCapture != null && barcodeCapture.barcodes.isNotEmpty) {
      Timer(Constants.duration200, () {
        Get.back();
        returnData(barcodeCapture.barcodes[0].rawValue);
      });
    }
  }
}
