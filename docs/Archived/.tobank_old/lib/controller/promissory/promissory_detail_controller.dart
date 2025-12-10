import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/promissory/promissory_single_info.dart';
import '../../model/promissory/request/promissory_fetch_document_request_data.dart';
import '../../model/promissory/request/promissory_inquiry_request_data.dart';
import '../../model/promissory/response/promissory_fetch_document_response_data.dart';
import '../../model/promissory/response/promissory_inquiry_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/promissory_services.dart';
import '../../ui/promissory/promissory_preview/promissory_preview_screen.dart';
import '../../util/app_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class PromissoryDetailController extends GetxController {
  MainController mainController = Get.find();
  PromissoryDetailType promissoryDetailType = PromissoryDetailType.detail;

  PageController pageController = PageController();

  bool isGetInfoLoading = false;

  bool isLoading = false;

  bool hasError = false;
  String errorTitle = '';

  final String promissoryId;
  PromissorySingleInfo? promissoryInfo;
  String? issuerNn;

  PromissoryDetailController({
    required this.promissoryId,
    required this.promissoryInfo,
    required this.issuerNn,
  });

  @override
  void onInit() {
    super.onInit();
    if (promissoryInfo == null) {
      isGetInfoLoading = true;
      update();
      promissoryInquiryRequest();
    } else {
      pageController = PageController(initialPage: 1);
      update();
    }
  }

  void showDetailPage() {
    if (isGetInfoLoading == false) {
      promissoryDetailType = PromissoryDetailType.detail;
      update();
      AppUtil.changePageController(
        pageController: pageController,
        page: 1,
        isClosed: isClosed,
      );
    }
  }

  void showTransferPage() {
    if (isGetInfoLoading == false) {
      promissoryDetailType = PromissoryDetailType.transfer;
      update();
      AppUtil.changePageController(
        pageController: pageController,
        page: 2,
        isClosed: isClosed,
      );
    }
  }

  void showGuaranteePage() {
    if (isGetInfoLoading == false) {
      promissoryDetailType = PromissoryDetailType.guarantee;
      update();
      AppUtil.changePageController(
        pageController: pageController,
        page: 3,
        isClosed: isClosed,
      );
    }
  }

  void showSettlementsPage() {
    if (isGetInfoLoading == false) {
      promissoryDetailType = PromissoryDetailType.settlements;
      update();
      AppUtil.changePageController(
        pageController: pageController,
        page: 4,
        isClosed: isClosed,
      );
    }
  }

  /// Sends a request to inquire about a promissory info.
  void promissoryInquiryRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryInquiryRequestData promissoryInquiryRequestData = PromissoryInquiryRequestData(
      nationalNumber: issuerNn!,
      promissoryId: promissoryId,
    );

    isGetInfoLoading = true;
    hasError = false;
    update();

    PromissoryServices.promissoryInquiryRequest(
      promissoryInquiryRequestData: promissoryInquiryRequestData,
    ).then((result) {
      isGetInfoLoading = false;
      update();

      switch (result) {
        case Success(value: (final PromissoryInquiryResponseData response, int _)):
          promissoryInfo = response.data!;
          AppUtil.nextPageController(pageController, isClosed);
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

  /// Fetches the PDF document using the provided promissory ID and document type.
  /// If successful, it navigates to a preview screen to display the PDF.
  Future<void> _fetchPdfDocumentRequest({
    required String promissoryId,
    required String docType,
    required String? nationalNumber,
    required String? number,
  }) async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final PromissoryFetchDocumentRequest promissoryFetchDocumentRequest = PromissoryFetchDocumentRequest(
      promissoryId: promissoryId,
      docType: docType,
      nationalNumber: nationalNumber,
      number: number,
    );

    PromissoryServices.promissoryFetchDocumentRequest(
      promissoryFetchDocument: promissoryFetchDocumentRequest,
    ).then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final PromissoryFetchDocumentResponse response, int _)):
            Get.to(() => PromissoryPreviewScreen(
                  promissoryId: promissoryId,
                  pdfData: base64Decode(response.data!.multiSignedPdf!),
                ));
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void fetchPublishPdfDocument() {
    _fetchPdfDocumentRequest(
      docType: PromissoryDocType.publish.jsonValue,
      promissoryId: promissoryId,
      nationalNumber: null,
      number: null,
    );
  }

  void fetchEndorsementPdfDocument(Endorsement endorsement) {
    _fetchPdfDocumentRequest(
      docType: PromissoryDocType.endorsement.jsonValue,
      promissoryId: promissoryId,
      nationalNumber: endorsement.ownerNn!,
      number: null,
    );
  }

  void fetchGuaranteePdfDocument(Guarantor guarantor) {
    _fetchPdfDocumentRequest(
      docType: PromissoryDocType.guarantee.jsonValue,
      promissoryId: promissoryId,
      nationalNumber: guarantor.guaranteeNn!,
      number: null,
    );
  }

  void fetchSettlementPdfDocument(Settlement settlement) {
    _fetchPdfDocumentRequest(
      docType: settlement.docType!.jsonValue,
      nationalNumber: null,
      promissoryId: promissoryId,
      number: settlement.docType! == PromissoryDocType.gradualSettlement ? settlement.number : null,
    );
  }

  void copyPromissoryId() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Clipboard.setData(ClipboardData(text: promissoryInfo!.promissoryId!));
    SnackBarUtil.showSnackBar(title: locale.announcement, message: locale.promissory_unique_id_copied);
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
