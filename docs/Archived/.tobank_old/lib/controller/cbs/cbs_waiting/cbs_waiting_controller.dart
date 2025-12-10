import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/cbs/request/inquiry_cbs_request_data.dart';
import '../../../model/cbs/response/credit_inquiry_order_id_response_data.dart';
import '../../../model/transaction/response/transaction_data.dart';
import '../../../service/cbs_services.dart';
import '../../../service/core/api_core.dart';
import '../../../ui/cbs/cbs_transaction_detail/cbs_transaction_detail_screen.dart';
import '../../../util/dialog_util.dart';
import '../../../util/snack_bar_util.dart';

class CBSWaitingController extends GetxController {
  final TransactionData transactionData;
  bool hasError = false;
  bool isLoading = false;

  String? errorTitle = '';

  int cbsCounter = 30;
  Timer? timer;

  String descriptionString = '';

  CBSWaitingController({required this.transactionData});

  @override
  void onInit() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (transactionData.extraField!.openbankingResponse!.status == 102) {
      descriptionString = locale.status_recive_report_message;
    } else {
      descriptionString = locale.default_status_message;
    }
    _startTimer();
    super.onInit();
  }

  void inquiryCbs() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    final InquiryCbsRequestData inquiryCbsRequestData = InquiryCbsRequestData();
    inquiryCbsRequestData.orderId = transactionData.extraField!.openbankingResponse!.orderId;
    inquiryCbsRequestData.transactionId = transactionData.id;
    CBSServices.creditInquiryOrderIdRequest(inquiryCbsRequestData: inquiryCbsRequestData).then((result) {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final CreditInquiryOrderIdResponseData response, int _)):
          _handleCreditInquiryOrderIdResponse(response);
          break;
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  String getTimer() {
    final DateTime time = DateTime(2024);
    final timer = intl.DateFormat('mm:ss').format(time.add(Duration(seconds: cbsCounter)));
    return timer;
  }

  void _startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (cbsCounter < 1) {
        inquiryCbs();
        timer.cancel();
      } else {
        cbsCounter = cbsCounter - 1;
      }
      update();
    });
  }

  void _handleCreditInquiryOrderIdResponse(CreditInquiryOrderIdResponseData response) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (response.data!.status == 200) {
      Get.off(() => CBSTransactionDetailScreen(transactionData: transactionData, displayDescription: true));
    } else {
      DialogUtil.showAttentionDialogMessage(
        buildContext: Get.context!,
        description:
            locale.failure_to_receive_validation_requestfunds_returned_wallet,
        positiveMessage: locale.understood_button,
        positiveFunction: () {
          Get.back();
          Get.back();
        },
      );
    }
  }
}
