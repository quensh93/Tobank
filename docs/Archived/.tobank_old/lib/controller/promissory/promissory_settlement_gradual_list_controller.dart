import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/controller/main/main_controller.dart';
import '../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../util/file_util.dart';

class PromissorySettlementGradualListController extends GetxController {
  MainController mainController = Get.find();

  final List<String> promissoryBase64List;
  List<Uint8List>? promissoryByteList;

  PromissorySettlementGradualListController({required this.promissoryBase64List});

  @override
  void onInit() {
    promissoryByteList = promissoryBase64List.map((e) => base64Decode(e)).toList();
    super.onInit();
  }

  void showPreviewScreen({required Uint8List pdfData}) {
    Get.to(() => PromissoryPreviewScreen(
          pdfData: pdfData,
        ));
  }


  Future<void> sharePromissoryPdf({required Uint8List pdfData}) async {
    final locale = AppLocalizations.of(Get.context!)!;

    if (kIsWeb) {
      _shareFileWeb(pdfData: pdfData);
    } else {
      // Use existing FileUtil for mobile platforms
      await FileUtil().shareFile(
        bytes: pdfData,
        name: '${DateTime.now().millisecondsSinceEpoch}-MultiSignedPDF.pdf',
        title: locale.promissory_file,
      );
    }
  }

  void _shareFileWeb({required Uint8List pdfData}) {
    // Create a Blob with the PDF data
    final blob = html.Blob(pdfData, 'application/pdf');

    // Create a URL for the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a filename
    final filename = '${DateTime.now().millisecondsSinceEpoch}-MultiSignedPDF.pdf';

    // Show share options dialog
    _showWebShareOptions(url, filename);
  }

  void _showWebShareOptions(String url, String filename) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    // Use Get.dialog for a custom dialog with sharing options
    Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl, // Set RTL direction
        child: AlertDialog(
          title:  Text(
            locale.sharing,
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content:  Text(
            locale.to_share_file_download_and_share_link,
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              child:  Text(locale.download_file),
              onPressed: () {
                // Create an anchor element to download
                final anchor = html.AnchorElement(href: url)
                  ..setAttribute('download', filename)
                  ..style.display = 'none';

                // Add to DOM, click it, then remove
                html.document.body!.children.add(anchor);
                anchor.click();
                html.document.body!.children.remove(anchor);
                Get.back();
              },
            ),
            TextButton(
              child:  Text(locale.cancel),
              onPressed: () {
                html.Url.revokeObjectUrl(url);
                Get.back();
              },
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
