import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/sign_document_data.dart';
import '../../model/promissory/promissory_list_info.dart';
import '../../model/promissory/request/promissory_settlement_gradual_finalize_request_data.dart';
import '../../model/promissory/request/promissory_settlement_gradual_request_data.dart';
import '../../model/promissory/response/promissory_settlement_gradual_finalize_response_data.dart';
import '../../model/promissory/response/promissory_settlement_gradual_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/promissory_services.dart';
import '../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../util/app_util.dart';
import '../../util/dialog_util.dart';
import '../../util/digit_to_word.dart';
import '../../util/file_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class PromissorySettlementGradualController extends GetxController {
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

  PromissorySettlementGradualResponse? promissorySettlementGradualResponse;
  PromissorySettlementGradualFinalizeResponse? promissorySettlementGradualFinalizeResponse;

  String? base64SignedPdf;

  String? signedPath;

  String? multiSignPath;

  PromissorySettlementGradualController({required this.promissoryInfo});

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void validateCheckoutInfoPage() {}

  Future<void> validateConfirmPage() async {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (amount > 0 && amount <= promissoryInfo.remainingAmount!) {
      isAmountValid = true;
    } else {
      isAmountValid = false;
      isValid = false;
    }
    update();

    if (isValid) {
      _promissorySettlementRequest();
    }
  }

  /// Sends a promissory note gradual settlement request.
  Future<void> _promissorySettlementRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final PromissorySettlementGradualRequest promissorySettlementGradualRequest = PromissorySettlementGradualRequest(
      promissoryId: promissoryInfo.promissoryId!,
      ownerNn: mainController.authInfoData!.nationalCode!,
      settlementAmount: amount,
    );

    PromissoryServices.settlementGradualRequest(
      promissorySettlementGradualRequest: promissorySettlementGradualRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissorySettlementGradualResponse response, int _)):
          promissorySettlementGradualResponse = response;
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
    amountController.text = AppUtil.formatMoney(promissoryInfo.remainingAmount!);
    amount = promissoryInfo.remainingAmount!;
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

  /// Signs a PDF document and proceeds with the gradual settlement finalization.
  Future<void> _signPdf() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final signDocumentData = SignDocumentData.fromPromissoryMainController(
      documentBase64: promissorySettlementGradualResponse!.data!.unSignedPdf!,
    );
    final response = await AppUtil.signPdf(signDocumentData: signDocumentData);

    if (response.isSuccess != null && response.isSuccess!) {
      base64SignedPdf = response.data;
      final PromissorySettlementGradualFinalizeRequest promissorySettlementGradualFinalizeRequest =
          PromissorySettlementGradualFinalizeRequest(
        id: promissorySettlementGradualResponse!.data!.id!,
        signedPdf: base64SignedPdf!,
      );

      _promissorySettlementFinalizeRequest(promissorySettlementGradualFinalizeRequest);
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

  /// Sends a request to finalize the gradual settlement process using the provided data.
  void _promissorySettlementFinalizeRequest(
      PromissorySettlementGradualFinalizeRequest promissorySettlementGradualFinalizeRequest) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();
    PromissoryServices.promissorySettlementGradualFinalizeRequest(
      promissorySettlementGradualFinalizeRequest: promissorySettlementGradualFinalizeRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissorySettlementGradualFinalizeResponse response, int _)):
          promissorySettlementGradualFinalizeResponse = response;
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
      source: promissorySettlementGradualFinalizeResponse!.data!.multiSignedPdf!,
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

  /// Handles the back press action, navigating back if not loading.
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
