import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_io/io.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app_settings/app_settings.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/controller/main/main_controller.dart';
import '../../util/dialog_util.dart';
import '../../util/file_util.dart';
import '../../util/permission_handler.dart';

class ContractPreviewController extends GetxController {
  MainController mainController = Get.find();

  final Uint8List pdfData;
  final String templateName;

  ContractPreviewController({required this.templateName, required this.pdfData});

  Future<void> sharePdf() async {
    final locale = AppLocalizations.of(Get.context!)!;
    if (kIsWeb) {
      _shareFileWeb();
    } else {
      // Use existing FileUtil for mobile platforms
      FileUtil().shareFile(
        bytes: pdfData.toList(),
        name: '$templateName Contract - ${DateTime.now().millisecondsSinceEpoch}.pdf',
        title: locale.contract_file,
      );
    }
  }

  void _shareFileWeb() {
    // Create a Blob with the PDF data
    final blob = html.Blob(pdfData.toList(), 'application/pdf');

    // Create a URL for the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a filename
    final filename = '$templateName Contract - ${DateTime.now().millisecondsSinceEpoch}.pdf';

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
            locale.to_share_file_download_and_share,
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

  Future<void> storePdf() async {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isAndroid) {
      final bool isGranted = await PermissionHandler.storage.isGranted;
      if (isGranted) {
        await FileSaver.instance.saveAs(
            name: '$templateName Contract - ${DateTime.now().millisecondsSinceEpoch}',
            bytes: pdfData,
            ext: 'pdf',
            mimeType: MimeType.pdf);
      } else {
        DialogUtil.showDialogMessage(
            buildContext: Get.context!,
            message: locale.access_to_device_storage,
            description: locale.storage_permission_needed,
            positiveMessage:locale.confirmation,
            negativeMessage: locale.cancel_laghv,
            positiveFunction: () async {
              Get.back();
              final isGranted = await PermissionHandler.storage.handlePermission();
              if (isGranted) {
                await FileSaver.instance.saveAs(
                    name: '$templateName Contract - ${DateTime.now().millisecondsSinceEpoch}',
                    bytes: pdfData,
                    ext: 'pdf',
                    mimeType: MimeType.pdf);
              } else if (Platform.isIOS && !isGranted) {
                AppSettings.openAppSettings();
              }
            },
            negativeFunction: () {
              Get.back();
            });
      }
    }
  }
}
