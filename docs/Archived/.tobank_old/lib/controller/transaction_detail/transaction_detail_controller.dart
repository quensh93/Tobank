import 'dart:async';
import 'package:universal_html/html.dart' as html;
import 'dart:ui';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app_settings/app_settings.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';

import '../../model/common/menu_data.dart';
import '../../model/shaparak_hub/request/card_to_card/shaparak_hub_transfer_inquiry_request.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../service/core/api_core.dart';
import '../../service/shaparak_hub_services.dart';
import '../../ui/common/key_value_widget.dart';
import '../../ui/common/share_transaction_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/dialog_util.dart';
import '../../util/file_util.dart';
import '../../util/permission_handler.dart';
import '../../util/persian_date.dart';
import '../../util/snack_bar_util.dart';
import '../../util/web_only_utils/image_share_util.dart';
import '../../widget/ui/dotted_separator_widget.dart';
import '../main/main_controller.dart';

class TransactionDetailController extends GetxController {
  MainController mainController = Get.find();
  GlobalKey globalKey = GlobalKey();
  bool isLoading = false;
  late TransactionData transactionData;
  String? amount;
  String? persianDateString;
  String? trackingNumber;
  bool hasDest = false;
  bool hasSource = false;
  bool isCardToCard = false;
  bool isBill = false;
  bool isInternetPlan = false;
  bool isCharity = false;
  bool isCharge = false;
  String? discountPrice;

  bool isWalletTransfer = false;

  bool storeLoading = false;

  bool shareLoading = false;

  int openBottomSheets = 0;

  Widget getSourceUser() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Column(
      children: <Widget>[
        KeyValueWidget(
          keyString: locale.origin,
          valueString: transactionData.sourceUser!.mobile,
        ),
        const DottedSeparatorWidget(),
      ],
    );
  }

  Widget getDestUser() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Column(
      children: <Widget>[
        KeyValueWidget(
          keyString: locale.wallet_destination,
          valueString: transactionData.destUser!.mobile,
        ),
        const DottedSeparatorWidget(),
      ],
    );
  }

  Widget getCardToCardDetail() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Column(
      children: <Widget>[
        KeyValueWidget(
          keyString: locale.origin,
          valueString: AppUtil.splitCardNumber(AppUtil.maskCardNumber(transactionData.trOrigin!), ' - '),
          ltrDirection: true,
        ),
        const DottedSeparatorWidget(),
        KeyValueWidget(
          keyString: locale.destination,
          valueString: AppUtil.splitCardNumber(AppUtil.maskCardNumber(transactionData.trDest!), ' - '),
          ltrDirection: true,
        ),
        if (transactionData.dstCardFullName != null) const DottedSeparatorWidget() else Container(),
        if (transactionData.dstCardFullName != null)
          KeyValueWidget(
            keyString: locale.name_of_card_owner,
            valueString: transactionData.dstCardFullName ?? '',
          )
        else
          Container(),
        const DottedSeparatorWidget(),
      ],
    );
  }

  void init({required TransactionData passedTransactionData}) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    transactionData = passedTransactionData;
    amount = '-';
    if (transactionData.trAmount != null) {
      amount = locale.amount_format(AppUtil.formatMoney(transactionData.trAmount));
    }
    if (transactionData.discountPrice != null) {
      discountPrice = locale.amount_format(AppUtil.formatMoney(transactionData.discountPrice));
    }
    final PersianDate persianDate = PersianDate();
    final String date = transactionData.trDate!.toString().split('+')[0];
    persianDateString = persianDate.parseToFormat(date, 'd MM yyyy - HH:nn');
    trackingNumber = transactionData.hashId;

    // Check for type of transaction to showing widgets according to it
    if (transactionData.serviceId == 5) {
      isWalletTransfer = true;
      if (transactionData.destUser != null) {
        hasDest = true;
      }
      if (transactionData.sourceUser != null) {
        hasSource = true;
      }
    }
    if (transactionData.serviceId == 8) {
      isCardToCard = true;
    }
    if (transactionData.serviceId == 6) {
      if (transactionData.destUser != null) {
        hasDest = true;
      }
      if (transactionData.sourceUser != null) {
        hasSource = true;
      }
    }
    if (transactionData.serviceId == 12 &&
        transactionData.extraField != null &&
        transactionData.extraField!.billId != null &&
        transactionData.extraField!.payId != null) {
      isBill = true;
    }
    if (transactionData.serviceId == 4) {
      isInternetPlan = true;
    }
    if (transactionData.serviceId == 2) {
      isCharity = true;
    }
    if (transactionData.serviceId == 3) {
      isCharge = true;
    }
  }

  Widget getBillDataWidget() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Column(
      children: <Widget>[
        KeyValueWidget(
          keyString: locale.bill_id_label,
          valueString: transactionData.extraField?.billId,
        ),
        const DottedSeparatorWidget(),
        KeyValueWidget(
          keyString: locale.pay_id_label,
          valueString: transactionData.extraField?.payId,
        ),
        const DottedSeparatorWidget(),
        KeyValueWidget(
          keyString: locale.bill_type,
          valueString: _getBillType(),
        ),
        const DottedSeparatorWidget(),
        KeyValueWidget(
          keyString: locale.distributor_company,
          valueString: _getBillCompany(),
        ),
        const DottedSeparatorWidget(),
      ],
    );
  }

  String _getBillCompany() {
    final split = transactionData.trCode!.split('#');
    if (split.length == 2) {
      return split[1];
    } else {
      return '-';
    }
  }

  String _getBillType() {
    final split = transactionData.trCode!.split('#');
    if (split.length == 2) {
      return split[0];
    } else {
      return '-';
    }
  }

  /// Sends a request to inquire about a Shaparak Hub transfer.
  ///
  /// This function initiates a request to inquire about the status of a Shaparak Hub transfer
  void shaparakHubTransferInquiryRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ShaparakHubTransferInquiryRequest keyRequestData = ShaparakHubTransferInquiryRequest();
    keyRequestData.registrationDate = transactionData.extraField!.registrationDate;
    keyRequestData.transactionId = transactionData.extraField!.transactionId;
    keyRequestData.amount = transactionData.trAmount;

    isLoading = true;
    update();

    ShaparakHubServices.transferInquiry(
      keyRequestData,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          init(passedTransactionData: transactionData);
          update();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Widget getInternetPlanWidget() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Column(
      children: [
        KeyValueWidget(
          keyString: locale.mobile_number,
          valueString: _getInternetPlanMobile(),
        ),
        const DottedSeparatorWidget(),
      ],
    );
  }

  String? _getInternetPlanName() {
    if (transactionData.extraField != null) {
      return transactionData.extraField!.chargeTitle;
    } else {
      return null;
    }
  }

  String? _getInternetPlanMobile() {
    if (transactionData.extraField != null) {
      return transactionData.extraField!.destMobile;
    } else {
      return null;
    }
  }

  Widget getCharityWidget() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Column(
      children: [
        KeyValueWidget(
          keyString: locale.charity_type,
          valueString: transactionData.charityName,
        ),
        const DottedSeparatorWidget(),
      ],
    );
  }

  Widget getChargeWidget() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Column(
      children: [
        KeyValueWidget(
          keyString: locale.charge_type,
          valueString: transactionData.extraField?.chargeTitle,
        ),
        const DottedSeparatorWidget(),
        KeyValueWidget(
          keyString: locale.mobile_number,
          valueString: transactionData.extraField?.destMobile,
        ),
        const DottedSeparatorWidget(),
      ],
    );
  }

  Future<void> showShareTransactionBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    update();
    await showModalBottomSheet(
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
    openBottomSheets--;
    update();
  }

  /// Generate image from transaction data and save it
  Future<void> captureAndSaveTransactionImage() async {
    try {
      storeLoading = true;
      update();
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

  /// Saves a transaction image represented by a `Uint8List` of PNG bytes
  /// to the device's storage.
  Future<void> _storeTransactionImagePng(Uint8List pngBytes) async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isAndroid) {
      final bool isGranted = await PermissionHandler.storage.isGranted;
      if (isGranted) {
        await FileSaver.instance.saveAs(
            name: '${transactionData.id ?? DateTime.now().millisecondsSinceEpoch}-transaction',
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
                    name: '${transactionData.id ?? DateTime.now().millisecondsSinceEpoch}-transaction',
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

  void handleShareTransactionServices(MenuData virtualBranchMenuData) {
    if (virtualBranchMenuData.id == 1) {
      captureAndShareTransactionImage();
    } else if (virtualBranchMenuData.id == 2) {
      shareTransactionText();
    }
    _closeBottomSheets();
  }

  /// Generate image from transaction data and share it with intent
  Future<void> captureAndShareTransactionImage() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    shareLoading = true;
    update();
    try {
      await ImageShareUtil.captureAndShareWidget(
        globalKey: globalKey,
        pixelRatio: 6.0,
        fileName: '${locale.transaction_receipt_file_name}.png',
        shareText: locale.transaction_receipt,
      );

      shareLoading = false;
      update();
    } on Exception catch (e) {
      shareLoading = false;
      update();
      AppUtil.printResponse(e.toString());
    }
  }

  void shareTransactionText() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    String status = '';
    if (transactionData.isSuccess == true) {
      status = locale.request_status_success;
    } else {
      status = locale.request_status_failed;
    }
    String text = '';
    text += '${locale.paid_amount}: $amount\n';
    text += '${locale.transaction_type}: ${transactionData.service}\n';
    text += '${locale.transaction_status}: $status\n';
    text += '${locale.transaction_time}: $persianDateString\n';
    text += '${locale.paid_via}: ${transactionData.trTypeFa}\n';
    if (hasSource) {
      text += '${locale.origin}: ${transactionData.sourceUser!.mobile}\n';
    }
    if (hasDest) {
      text += '${locale.wallet_destination}: ${transactionData.destUser!.mobile}\n';
    }
    if (isCardToCard) {
      text += "${locale.origin}:\n${AppUtil.splitCardNumber(AppUtil.maskCardNumber(transactionData.trOrigin!), ' - ')}\n";
      text += "${locale.destination}:\n${AppUtil.splitCardNumber(AppUtil.maskCardNumber(transactionData.trDest!), ' - ')}\n";
      text += "${locale.name_of_card_owner}: ${transactionData.dstCardFullName ?? ''}\n";
    }
    if (isBill) {
      text += '${locale.bill_id_label}: ${transactionData.extraField?.billId}\n';
      text += '${locale.pay_id_label}: ${transactionData.extraField?.payId}\n';
      text += '${locale.bill_type}: ${_getBillType()}\n';
      text += '${locale.distributor_company}: ${_getBillCompany()}\n';
    }
    if (isInternetPlan) {
      text += '${locale.package_type}: ${_getInternetPlanName()}\n';
      text += '${(locale.mobile_number)}: ${_getInternetPlanMobile()}\n';
    }
    if (isCharity) {
      text += '${locale.charity_type}: ${transactionData.charityName}\n';
    }
    if (isCharge) {
      text += '${locale.charge_type}: ${transactionData.extraField?.chargeTitle}\n';
      text += '${(locale.mobile_number)}: ${transactionData.extraField?.destMobile}\n';
    }
    if (transactionData.discountPrice != null) {
      text += '${locale.discounted_amount}: $discountPrice\n';
    }
    if ((isCardToCard || isWalletTransfer) &&
        transactionData.srcComment != null &&
        transactionData.srcComment!.isNotEmpty) {
      text += "${locale.process_detail}: ${transactionData.srcComment ?? '-'}\n";
    }
    text += '${locale.tracking_number}: $trackingNumber\n';
    text += '\n${locale.tobank_website}\n';
    Share.share(text, subject: locale.transaction_receipt);
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
