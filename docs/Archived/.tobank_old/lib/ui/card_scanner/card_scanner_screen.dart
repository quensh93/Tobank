import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';

import '../../controller/card_scanner/card_scanner_controller.dart';
import '../../model/common/card_scanner_data.dart';

class CardScannerScreen extends StatelessWidget {
  const CardScannerScreen({required this.returnDataFunction, super.key});

  final Function(CardScannerData cardScannerData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardScannerController>(
          init: CardScannerController(returnDataFunction: returnDataFunction),
          builder: (controller) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: ScannerWidget(
                    overlayOrientation: CardOrientation.landscape,
                    controller: controller.scannerWidgetController,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
