import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gardeshpay_app/l10n/gen/app_localizations.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../util/app_util.dart';
import '../../util/persian_date.dart';
import '../main/main_controller.dart';

class PromissoryTransactionDetailPageController extends GetxController {
  String? multiSignPath;
  GlobalKey globalKey = GlobalKey();
  bool isLoading = false;
  late TransactionData transactionData;
  MainController mainController = Get.find<MainController>();

  String? amount;
  String? persianDateString;
  String? trackingNumber;

  Future<void> setValues(TransactionData transactionDataParam, String? multiSignPath) async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    transactionData = transactionDataParam;
    this.multiSignPath = multiSignPath;
    amount = '-';
    if (transactionData.trAmount != null) {
      amount = locale.amount_format(AppUtil.formatMoney(transactionData.trAmount));
    }
    final PersianDate persianDate = PersianDate();
    final String date = transactionData.trDate!.toString().split('+')[0];
    persianDateString = persianDate.parseToFormat(date, 'd MM yyyy - HH:nn');
    trackingNumber = transactionData.hashId;
  }

  void sharePromissoryPdf() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isIOS) {
      Share.shareXFiles([XFile(multiSignPath!)], subject: locale.promissory_file);
    } else {
      Share.shareXFiles([XFile(multiSignPath!)], text:locale.promissory_file);
    }
  }

  void showPreviewScreen() {
    Get.to(() => PromissoryPreviewScreen(pdfData: File(multiSignPath!).readAsBytesSync()));
  }
}
