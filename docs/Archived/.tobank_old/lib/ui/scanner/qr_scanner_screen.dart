import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/scanner/scanner_controller.dart';
import '../../widget/svg/svg_icon.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({
    required this.returnData,
    super.key,
    this.isInvoice = false,
  });

  final Function(String? data) returnData;
  final bool isInvoice;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: GetBuilder<ScannerController>(
            init: ScannerController(returnData: returnData),
            builder: (controller) {
              return SafeArea(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                       Positioned(
                        top: 32,
                        left: 0,
                        right: 0,
                        child: Text(
                          locale.scan_barcode,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 24.0,
                        left: 24.0,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            splashColor: Colors.grey.withOpacity(0.2),
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8),
                                    bottom: Radius.circular(8),
                                  ),
                                  color: context.theme.colorScheme.surface),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SvgIcon(
                                  SvgIcons.close,
                                  colorFilter: ColorFilter.mode(context.theme.colorScheme.secondary, BlendMode.srcIn),
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 24.0,
                        left: 24.0,
                        right: 24.0,
                        child: SizedBox(
                          height: 56.0,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: context.theme.colorScheme.surface,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: context.theme.iconTheme.color!,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                locale.return_,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: context.theme.iconTheme.color,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: MobileScanner(
                          fit: BoxFit.contain,
                          controller: controller.mobileScannerController,
                          onDetect: (barcode) {
                            controller.onDetect(barcode);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
