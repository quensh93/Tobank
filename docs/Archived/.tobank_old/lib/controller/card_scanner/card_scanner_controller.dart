import 'package:get/get.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';

import '../../model/common/card_scanner_data.dart';

class CardScannerController extends GetxController {
  final ScannerWidgetController scannerWidgetController = ScannerWidgetController();
  final Function(CardScannerData cardScannerData) returnDataFunction;

  CardScannerController({required this.returnDataFunction});

  bool isFirstTime = true;

  @override
  Future<void> onInit() async {
    super.onInit();
    initScanner();
  }

  @override
  void onClose() {
    scannerWidgetController.dispose();
    super.onClose();
  }

  /// Initializes the card scanner and sets up listeners for card information and errors.
  void initScanner() {
    scannerWidgetController.setCardListener((cardInfo) {
      if (isFirstTime) {
        isFirstTime = false;
        final String? result = cardInfo?.number;
        if (result != null) {
          returnDataFunction(CardScannerData(cardNumber: result, isSuccess: true));
        } else {
          returnDataFunction(CardScannerData(cardNumber: result, isSuccess: false));
        }
        Get.back();
      }
    });
    scannerWidgetController.setErrorListener((error) {
      if (isFirstTime) {
        isFirstTime = false;
        returnDataFunction(CardScannerData(isSuccess: false));
        Get.back();
      }
    });
  }
}
