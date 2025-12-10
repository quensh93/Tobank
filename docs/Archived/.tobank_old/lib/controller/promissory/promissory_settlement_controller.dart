import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/sign_document_data.dart';
import '../../model/promissory/promissory_list_info.dart';
import '../../model/promissory/request/promissory_settlement_finalize_request_data.dart';
import '../../model/promissory/request/promissory_settlement_request_data.dart';
import '../../model/promissory/response/promissory_settlement_finalize_response_data.dart';
import '../../model/promissory/response/promissory_settlement_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/promissory_services.dart';
import '../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../util/app_util.dart';
import '../../util/dialog_util.dart';
import '../../util/digit_to_word.dart';
import '../../util/file_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class PromissorySettlementController extends GetxController {
  PageController pageController = PageController();
  MainController mainController = Get.find();

  bool isLoading = false;

  final PromissoryListInfo promissoryInfo;

  TextEditingController noteUniqueIdController = TextEditingController();

  bool isNoteUniqueIdValid = true;

  TextEditingController nationalCodeController = TextEditingController();

  bool isNationalCodeValid = true;

  bool isAmountValid = true;

  TextEditingController amountController = TextEditingController();

  int amount = 0;

  PromissorySettlementResponse? promissorySettlementResponse;
  PromissorySettlementFinalizeResponse? promissorySettlementFinalizeResponse;

  String? base64SignedPdf;

  String? multiSignPath;

  PromissorySettlementController({
    required this.promissoryInfo,
  });

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void validateConfirmPage() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (amount > 0) {
      isAmountValid = true;
    } else {
      isValid = false;
      isAmountValid = false;
    }
    update();
    if (isValid) {
      _promissorySettlementRequest();
    }
  }

  /// Sends a request to settle a promissory note
  /// using the provided promissory ID, owner's national number, and settlement amount.
  Future<void> _promissorySettlementRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissorySettlementRequest promissorySettlementRequest = PromissorySettlementRequest(
      promissoryId: promissoryInfo.promissoryId!,
      ownerNn: mainController.authInfoData!.nationalCode!,
      settlementAmount: amount,
    );

    isLoading = true;
    update();

    PromissoryServices.settlementRequest(
      promissorySettlementRequest: promissorySettlementRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissorySettlementResponse response, int _)):
          promissorySettlementResponse = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void validateAmountValue(String value) {
    value.replaceAll(',', '');
    if (value.length > 3) {
      amountController.text = AppUtil.formatMoney(value);
      amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
    }
    if (value != '') {
      amount = int.parse(value.replaceAll(',', ''));
    } else {
      amount = 0;
    }
    update();
  }

  void setAllAmount() {
    amountController.text = AppUtil.formatMoney(promissoryInfo.remainingAmount);
    amount = promissoryInfo.remainingAmount!;
    update();
  }

  String getAmountDetail() {
    if (amountController.text.isEmpty || amountController.text.length == 1) {
      return '';
    } else {
      final int amountInToman = amount ~/ 10;
      return DigitToWord.toWord(amountInToman.toString(), StrType.numWord, isMoney: true).replaceAll('  ', ' ');
    }
  }

  void showConfirmDialog() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.sure_settlement_promissory,
        description: '',
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _signPdf();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  /// Signs a PDF document and proceeds with the settlement finalization.
  Future<void> _signPdf() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final signDocumentData = SignDocumentData.fromPromissoryMainController(
      documentBase64: promissorySettlementResponse!.data!.unSignedPdf!,
    );
    final response = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (response.isSuccess != null && response.isSuccess!) {
      base64SignedPdf = response.data;
      final PromissorySettlementFinalizeRequest promissorySettlementFinalizeRequest =
          PromissorySettlementFinalizeRequest(
        id: promissorySettlementResponse!.data!.id!,
        signedPdf: base64SignedPdf!,
      );

      _promissorySettlementFinalizeRequest(promissorySettlementFinalizeRequest);
    } else {
      isLoading = false;
      update();

      SnackBarUtil.showSnackBar(title: locale.error, message: response.message ?? locale.error_in_signature);

      await Sentry.captureMessage('sign pdf error',
          params: [
            {'status code': response.statusCode},
            {'message': response.message},
          ],
          level: SentryLevel.warning);
    }
  }

  /// Finalizes the promissory note settlement process.
  void _promissorySettlementFinalizeRequest(PromissorySettlementFinalizeRequest promissorySettlementFinalizeRequest) {
    isLoading = true;//locale
    final locale = AppLocalizations.of(Get.context!)!;
    update();
    PromissoryServices.promissorySettlementFinalizeRequest(
      promissorySettlementFinalizeRequest: promissorySettlementFinalizeRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissorySettlementFinalizeResponse response, int _)):
          promissorySettlementFinalizeResponse = response;
          await setValues();
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> setValues() async {
    multiSignPath = await FileUtil().writeAsBytesMultiSignedPDF(
      source: promissorySettlementFinalizeResponse!.data!.multiSignedPdf!,
    );
  }

  void showPreviewScreen() {
    Get.to(() => PromissoryPreviewScreen(
          pdfData: File(multiSignPath!).readAsBytesSync(),
          promissoryId: promissoryInfo.promissoryId,
        ));
  }

  void sharePromissoryPdf() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (Platform.isIOS) {
      Share.shareXFiles([XFile(multiSignPath!)], subject: locale.promissory_file);
    } else {
      Share.shareXFiles([XFile(multiSignPath!)], text: locale.promissory_file);
    }
  }

  /// Handles the back press action.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }
}
