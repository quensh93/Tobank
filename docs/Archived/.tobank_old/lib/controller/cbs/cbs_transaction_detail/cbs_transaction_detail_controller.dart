import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/cbs/response/cbs_fetch_document_response_data.dart';
import '../../../model/transaction/response/transaction_data.dart';
import '../../../service/cbs_services.dart';
import '../../../service/core/api_core.dart';
import '../../../ui/cbs/cbs_preview/cbs_preview_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/file_util.dart';
import '../../../util/persian_date.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CBSTransactionDetailController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  GlobalKey globalKey = GlobalKey();
  bool isLoading = false;
  final TransactionData transactionData;
  String? amount;
  String? persianDateString;
  Uint8List? fileBytes;

  bool isWalletTransfer = false;

  String? errorTitle = '';
  bool hasError = false;

  CBSFetchDocumentResponse? cbsFetchDocumentResponse;

  CBSTransactionDetailController({
    required this.transactionData,
  });

  @override
  void onInit() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    amount = '-';
    if (transactionData.trAmount != null) {
      amount = locale.amount_format(AppUtil.formatMoney(transactionData.trAmount));
    }
    final PersianDate persianDate = PersianDate();
    final String date = transactionData.trDate!.toString().split('+')[0];
    persianDateString = persianDate.parseToFormat(date, 'd MM yyyy - HH:nn');
    fetchPdfDocumentRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> shareCBSPdf() async {
    final locale = AppLocalizations.of(Get.context!)!;
    if (kIsWeb) {
      _shareFileWeb();
    } else {
      // Use existing FileUtil for mobile platforms
      FileUtil().shareFile(
        bytes: fileBytes!.toList(),
        name: '${transactionData.extraField?.nationalCode ?? DateTime.now().millisecondsSinceEpoch}-CBS.pdf',
        title: locale.file_validation_title,
      );
    }
  }

  void _shareFileWeb() {
    // Create a Blob with the PDF data
    final blob = html.Blob(fileBytes!.toList(), 'application/pdf');

    // Create a URL for the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a filename
    final filename = '${transactionData.extraField?.nationalCode ?? DateTime.now().millisecondsSinceEpoch}-CBS.pdf';

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

  /// Sends a request to fetch a PDF document, updates the UI,
  /// and potentially navigates to the next page or shows an error message.
  void fetchPdfDocumentRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    CBSServices.cbsFetchDocumentRequest(id: transactionData.id!).then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final CBSFetchDocumentResponse response, int _)):
            fileBytes = base64Decode(response.data!.pdfFile!);
            cbsFetchDocumentResponse = response;
            update();
            AppUtil.nextPageController(pageController, isClosed);
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
            hasError = true;
            errorTitle = apiException.displayMessage;
            update();
        }
      },
    );
  }

  void showPreview() {
    Get.to(() => CBSPreviewScreen(
          pdfData: fileBytes!,
          nationalCode: transactionData.extraField?.nationalCode,
        ));
  }
}
