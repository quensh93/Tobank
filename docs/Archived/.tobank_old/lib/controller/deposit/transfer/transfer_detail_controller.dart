import 'package:universal_io/io.dart';
import 'dart:typed_data';
import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../util/web_only_utils/image_share_util.dart';
import '/controller/main/main_controller.dart';
import '../../../model/common/menu_data.dart';
import '../../../model/transfer/response/transfer_history_response_data.dart';
import '../../../ui/common/share_transaction_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/dialog_util.dart';
import '../../../util/file_util.dart';
import '../../../util/permission_handler.dart';

class TransferDetailController extends GetxController {
  MainController mainController = Get.find();

  GlobalKey globalKey = GlobalKey();
  final Transaction transaction;

  bool storeLoading = false;

  bool shareLoading = false;

  TransferDetailController({
    required this.transaction,
  });

  void showShareTransactionBottomSheet() {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ShareTransactionBottomSheet(
          returnDataFunction: (MenuData virtualBranchMenuData) {
            handleShareTransactionServices(virtualBranchMenuData);
          },
        ),
      ),
    );
  }

  /// Captures a screenshot of the widget associated with the `globalKey`
  /// and shares it using the `Share` package.
  Future<void> captureAndShareTransactionImage() async {
    try {
      shareLoading = true;
      update();

      await ImageShareUtil.captureAndShareWidget(
        globalKey: globalKey,
        pixelRatio: 6.0,
        fileName: 'image.png',
        shareText: '',
      );

      shareLoading = false;
      update();
    } on Exception catch (e) {
      shareLoading = false;
      update();
      AppUtil.printResponse(e.toString());
    }
  }

  void handleShareTransactionServices(MenuData virtualBranchMenuData) {
    if (virtualBranchMenuData.id == 1) {
      captureAndShareTransactionImage();
    } else if (virtualBranchMenuData.id == 2) {
      shareTransactionText();
    }
    Get.back();
  }

  void shareTransactionText() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    String text = '';
    text += '${locale.transfer_type}: ${getTransferType()}\n';
    text += '{locale.transfer_status}: ${getStatus()}\n';
    text += '{locale.transfer_amount}: ${AppUtil.formatMoney(transaction.amount)} ${locale.rial}\n';
    text += '{locale.source_deposit_number}: ${transaction.sourceDepositNumber}\n';
    text += '{locale.destination_deposit_number}: ${transaction.destinationIban}\n';
    text += '{locale.destination_account_owner}: ${getDestinationCustomer()}\n';
    text += '{locale.tracking_number}: ${transaction.transactionId}\n';
    text += '\nhttps://tobank.ir';
    Share.share(text, subject: locale.transaction_receipt);
  }

  /// Generate image from transaction data and save it
  Future<void> captureAndSaveTransactionImage() async {
    storeLoading = true;
    update();
    try {
      final RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 6);
      final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      storeLoading = false;
      update();
      _storeTransactionImagePng(pngBytes);
    } on Exception catch (e) {
      storeLoading = false;
      update();
      AppUtil.printResponse(e.toString());
    }
  }

  /// Stores the provided PNG image data to the device's storage.
  Future<void> _storeTransactionImagePng(Uint8List pngBytes) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isAndroid) {
      final bool isGranted = await PermissionHandler.storage.isGranted;
      if (isGranted) {
        await FileSaver.instance.saveAs(
            name: '${transaction.transactionId ?? DateTime.now().millisecondsSinceEpoch}-transaction',
            bytes: pngBytes,
            ext: 'png',
            mimeType: MimeType.png);
      } else {
        DialogUtil.showDialogMessage(
            buildContext: Get.context!,
            message: locale.access_to_device_storage,
            description: locale.storage_permission_transaction_description,
            positiveMessage: locale.confirmation,
            negativeMessage: locale.cancel_laghv,
            positiveFunction: () async {
              Get.back();
              final isGranted = await PermissionHandler.storage.handlePermission();
              if (isGranted) {
                await FileSaver.instance.saveAs(
                    name: '${transaction.transactionId ?? DateTime.now().millisecondsSinceEpoch}-transaction',
                    bytes: pngBytes,
                    ext: 'png',
                    mimeType: MimeType.png);
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

  String getTransferType() {
    return AppUtil.transferMethodDataList().where((element) => element.id == transaction.transferType).first.title;
  }

  String getDestinationCustomer() {
    final String customer = '${transaction.receiverFirstName!} ${transaction.receiverLastName!}';
    return customer;
  }

  bool showExternalTransactionId() {
    final transferType =
        AppUtil.transferMethodDataList().where((element) => element.id == transaction.transferType).first;
    if (transferType.id != 0) {
      // PAYA & SATNA
      return transaction.externalTransactionId != null;
    } else {
      return false;
    }
  }

  String? getReferenceNumber() {
    return transaction.referenceNumber;
  }

  String getTrackingCode() {
    final String trackingCode =
        showExternalTransactionId() ? transaction.externalTransactionId! : transaction.transactionId ?? '-';
    return trackingCode;
  }

  String getStatus() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (transaction.financialTransactionStatus == 1) {
      return locale.request_status_success;
    } else if (transaction.financialTransactionStatus == 0) {
      return locale.request_status_failed;
    } else {
      return locale.unknown;
    }
  }
}
