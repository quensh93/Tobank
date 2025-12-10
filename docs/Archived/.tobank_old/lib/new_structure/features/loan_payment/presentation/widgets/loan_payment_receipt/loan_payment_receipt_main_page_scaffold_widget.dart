import 'package:universal_io/io.dart';
import 'dart:typed_data';
import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../model/common/menu_data.dart';
import '../../../../../../ui/common/share_transaction_bottom_sheet.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/dialog_util.dart';
import '../../../../../../util/file_util.dart';
import '../../../../../../util/permission_handler.dart';
import '../../../../../../util/persian_date.dart';
import '../../../../../../widget/button/button_with_icon.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/receipt_data.dart';
import '../../../../../core/theme/main_theme.dart';
import 'charge_payment_receipt_detail_widget.dart';
import 'loan_payment_receipt_detail_widget.dart';
import 'unknown_payment_receipt_detail_widget.dart';

class LoanPaymentReceiptMainPageScaffoldWidget extends StatefulWidget {
  final ReceiptData receiptData;

  const LoanPaymentReceiptMainPageScaffoldWidget({
    required this.receiptData,
    super.key,
  });

  @override
  State<LoanPaymentReceiptMainPageScaffoldWidget> createState() =>
      _LoanPaymentReceiptMainPageScaffoldWidgetState();
}

class _LoanPaymentReceiptMainPageScaffoldWidgetState extends State<LoanPaymentReceiptMainPageScaffoldWidget> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: RepaintBoundary(
              key: globalKey,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Get.isDarkMode ? const Color(0xff1c222e) : const Color(0xffffffff),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                SvgIcon(
                                  widget.receiptData.receiptType.getIcon(context),
                                  size: 56,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  widget.receiptData.receiptType.getString(context),
                                  style: MainTheme.of(context).textTheme.titleLarge
                                      .copyWith(color: widget.receiptData.receiptType.getColor(context)),
                                ),
                                if (widget.receiptData.paymentData.paymentType ==
                                        PaymentListType.myselfLoan ||
                                    widget.receiptData.paymentData.paymentType == PaymentListType.othersLoan)
                                  const SizedBox(height: 8.0),
                                // if (controller.transactionData.message != null &&
                                //     controller.transactionData.message!.isNotEmpty)
                                if (widget.receiptData.paymentData.paymentType ==
                                        PaymentListType.myselfLoan ||
                                    widget.receiptData.paymentData.paymentType == PaymentListType.othersLoan)
                                  Text(
                                      widget.receiptData.receiptType == ReceiptType.success
                                          ? widget.receiptData.isSettlement!=null? locale.installment_settlement_successfully:locale.installment_paid_successfully
                                          : widget.receiptData.receiptType == ReceiptType.fail
                                              ? widget.receiptData.isSettlement!=null?locale.installment_settlement_unsuccessfully:locale.installment_paid_unsuccessfully
                                              : '',
                                      textAlign: TextAlign.right,
                                      style: MainTheme.of(context).textTheme.bodyLarge
                                          .copyWith(color: MainTheme.of(context).surfaceContainerHigh)),
                              ],
                            ),
                          ),
                          getScaffoldWidget(),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SvgIcon(
                            SvgIcons.tobank,
                            size: 48.0,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Container(
                              width: 1,
                              height: 42,
                              decoration: BoxDecoration(
                                color: MainTheme.of(context).onSurface,
                              )),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locale.virtual_branch_with_you,
                                  style: MainTheme.of(context).textTheme.titleLarge
                                      .copyWith(color: MainTheme.of(context).surfaceContainerHigh)),
                              const SizedBox(height: 8.0),
                              Text(locale.website,
                                  style: MainTheme.of(context).textTheme.titleLarge
                                      .copyWith(color: MainTheme.of(context).surfaceContainerHigh)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Platform.isAndroid
              ? Row(
                  children: [
                    Expanded(
                      child: ButtonWithIcon(
                        buttonTitle: locale.sharing,
                        buttonIcon: SvgIcons.share,
                        onPressed: () {
                          showShareTransactionBottomSheet(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: ButtonWithIcon(
                        buttonTitle: locale.save_to_gallery,
                        buttonIcon: SvgIcons.download,
                        onPressed: () {
                          captureAndSaveTransactionImage();
                        },
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: ButtonWithIcon(
                        buttonTitle: locale.receipt_image,
                        buttonIcon: SvgIcons.shareImage,
                        onPressed: () {
                          captureAndShareTransactionImage();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: ButtonWithIcon(
                        buttonTitle: locale.receipt_text,
                        buttonIcon: SvgIcons.shareText,
                        onPressed: () {
                          shareReceiptText();
                        },
                      ),
                    ),
                  ],
                ),
        ),

        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: ButtonWithIcon(
        //           buttonTitle: locale.sharing,
        //           buttonIcon: SvgIcons.share,
        //           onPressed: () {
        //
        //           },
        //         ),
        //       ),
        //       const SizedBox(
        //         width: 8.0,
        //       ),
        //       Expanded(
        //         child: ButtonWithIcon(
        //           buttonTitle: locale.save_to_gallery,
        //           buttonIcon: SvgIcons.download,
        //           onPressed: () {
        //             captureAndSaveTransactionImage();
        //             },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget getScaffoldWidget() {
    if (widget.receiptData.receiptType == ReceiptType.unknown) {
      return UnknownPaymentReceiptDetailWidget(
        receiptData: widget.receiptData,
      );
    } else if (widget.receiptData.paymentData.paymentType == PaymentListType.myselfLoan ||
        widget.receiptData.paymentData.paymentType == PaymentListType.othersLoan) {
      return LoanPaymentReceiptDetailWidget(
        receiptData: widget.receiptData,
      );
    } else if (widget.receiptData.paymentData.paymentType == PaymentListType.package ||
        widget.receiptData.paymentData.paymentType == PaymentListType.charge) {
      return ChargePaymentReceiptDetailWidget(
        receiptData: widget.receiptData,
      );
    } else {
      return UnknownPaymentReceiptDetailWidget(
        receiptData: widget.receiptData,
      );
    }
  }

  String getRecieptString() {
    final PersianDate persianDate = PersianDate();
    if (widget.receiptData.receiptType == ReceiptType.unknown) {
      return widget.receiptData.paymentData.paymentType == PaymentListType.othersLoan ||
              widget.receiptData.paymentData.paymentType == PaymentListType.myselfLoan
          ? locale.uncertain_loan_payment_status_message
          : locale.uncertain_charge_payment_status_message;
    } else if (widget.receiptData.paymentData.paymentType == PaymentListType.myselfLoan ||
        widget.receiptData.paymentData.paymentType == PaymentListType.othersLoan) {
      String text = '';
      text +=
          '${locale.amount}:${locale.amount_format(AppUtil.formatMoney(widget.receiptData.amount.toString()))}\n';
      text +=
          '${locale.facility_number}:${widget.receiptData.paymentData.getInstallmentPaymentData().fileNumber}\n';
      text +=
          '${locale.transaction_time}:${persianDate.parseToFormat(DateTime.now().toString(), 'd MM yyyy')}\n';
      text +=
          '${locale.paid_via}:${widget.receiptData.destinationType == DestinationType.deposit ? locale.account : locale.wallet}\n';
      text += '${locale.origin}:${widget.receiptData.depositNumber}\n';
      text += '${locale.tracking_number}:${widget.receiptData.trackingNumber}';
      return text;
    } else if (widget.receiptData.paymentData.paymentType == PaymentListType.package ||
        widget.receiptData.paymentData.paymentType == PaymentListType.charge) {
      String text = '';
      text +=
          '${locale.amount}:${locale.amount_format(AppUtil.formatMoney(widget.receiptData.amount.toString()))}\n';
      text +=
          '${locale.transaction_time}:${persianDate.parseToFormat(DateTime.now().toString(), 'd MM yyyy')}\n';
      text +=
          '${widget.receiptData.paymentData.getChargeAndPackagePaymentData().chargeAndPackageType == ChargeAndPackageType.CHARGE ? locale.buy_charge : locale.buy_internet_package}:${widget.receiptData.paymentData.getChargeAndPackagePaymentData().mobile}\n';
      text +=
          '${locale.paid_via}:${widget.receiptData.destinationType == DestinationType.deposit ? locale.account : locale.wallet}\n';
      if (widget.receiptData.depositNumber != '') {
        text += '${locale.origin}:${widget.receiptData.depositNumber}\n';
      }
      if (widget.receiptData.trackingNumber != '') {
        text += '${locale.tracking_number}:${widget.receiptData.trackingNumber}';
      }
      return text;
    } else {
      return (widget.receiptData.paymentData.paymentType == PaymentListType.othersLoan ||
              widget.receiptData.paymentData.paymentType == PaymentListType.myselfLoan)
          ? locale.uncertain_loan_payment_status_message
          : locale.uncertain_charge_payment_status_message;
    }
  }

  void shareReceiptText() {
    final receiptText = getRecieptString();
    Share.share(receiptText, subject: locale.transaction_receipt);
  }

  void _closeBottomSheets(BuildContext context, int bottomSheetCount) {
    for (int i = 0; i < bottomSheetCount; i++) {
      Navigator.pop(context);
    }
  }

  void handleShareTransactionServices(
    BuildContext context,
    MenuData virtualBranchMenuData,
    int bottomSheetCount,
  ) {
    if (virtualBranchMenuData.id == 1) {
      captureAndShareTransactionImage();
    } else if (virtualBranchMenuData.id == 2) {
      shareReceiptText();
    }
    _closeBottomSheets(context, bottomSheetCount);
  }

  Future showShareTransactionBottomSheet(BuildContext context) async {
    int bottomSheetCount = 0; // Track sheets manually if needed
    bottomSheetCount++;

    await showModalBottomSheet(
      elevation: 0,
      context: context,
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
            handleShareTransactionServices(context, virtualBranchMenuData, bottomSheetCount);
          },
        ),
      ),
    );

    bottomSheetCount--;
  }

  Future<void> _storeTransactionImagePng(Uint8List pngBytes) async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isAndroid) {
      final bool isGranted = await PermissionHandler.storage.isGranted;
      if (isGranted) {
        await FileSaver.instance.saveAs(
            //'${transactionData.id ?? DateTime.now().millisecondsSinceEpoch}-transaction'
            name: '${DateTime.now().millisecondsSinceEpoch}-transaction',
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
                    //'${transactionData.id ?? DateTime.now().millisecondsSinceEpoch}-transaction'
                    name: ' DateTime.now().millisecondsSinceEpoch}-transaction',
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

  //Generate image from transaction data and save it
  Future<void> captureAndSaveTransactionImage() async {
    try {
      final RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 6);
      final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      _storeTransactionImagePng(pngBytes);
    } on Exception catch (e) {
      AppUtil.printResponse(e.toString());
    }
  }

  /// Generate image from transaction data and share it with intent
  Future<void> captureAndShareTransactionImage() async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    try {
      final RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 6);
      final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      final File file = await File(FileUtil().generateImagePngPath()).create();
      file.writeAsBytesSync(pngBytes);

      if (Platform.isAndroid) {
        Share.shareXFiles([XFile(file.path)], text: locale.transaction_receipt);
      } else {
        Share.shareXFiles([XFile(file.path)], subject: locale.transaction_receipt);
      }
    } on Exception catch (e) {
      AppUtil.printResponse(e.toString());
    }
  }

  ///show two button as PLATFORM
// Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Platform.isAndroid
//               ? Row(
//             children: [
//               Expanded(
//                 child: ButtonWithIcon(
//                   buttonTitle: locale.sharing,
//                   buttonIcon: SvgIcons.share,
//                   onPressed: (){},
//
//                 ),
//               ),
//               const SizedBox(
//                 width: 8.0,
//               ),
//               Expanded(
//                 child: ButtonWithIcon(
//                   buttonTitle: locale.save_to_gallery,
//                   buttonIcon: SvgIcons.download,
//                   onPressed: (){},
//
//                 ),
//               ),
//             ],
//           )
//               : Row(
//             children: [
//               Expanded(
//                 child: ButtonWithIcon(
//                   buttonTitle: locale.receipt_image,
//                   buttonIcon: SvgIcons.shareImage,
//                   onPressed: (){},
//
//                 ),
//               ),
//               const SizedBox(
//                 width: 8.0,
//               ),
//               Expanded(
//                 child: ButtonWithIcon(
//                   buttonTitle: locale.receipt_text,
//                   buttonIcon: SvgIcons.shareText,
//                   onPressed: (){},
//
//                 ),
//               ),
//             ],
//           ),
//         ),
}
