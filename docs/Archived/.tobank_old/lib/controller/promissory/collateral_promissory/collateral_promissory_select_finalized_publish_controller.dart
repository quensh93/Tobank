import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../../model/promissory/promissory_list_info_detailed.dart';
import '../../../model/promissory/request/promissory_fetch_document_request_data.dart';
import '../../../model/promissory/response/promissory_fetch_document_response_data.dart';
import '../../../service/core/api_core.dart';
import '../../../service/promissory_services.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/enums_constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CollateralPromissorySelectFinalizedPublishController extends GetxController {
  PageController pageController = PageController();
  MainController mainController = Get.find();

  String? errorTitle = '';
  bool hasError = false;
  bool isLoading = false;

  final List<PromissoryListInfoDetail> promissoryListInfoDetailList;
  final void Function(CollateralPromissoryPublishResultData collateralPromissoryPublishResultData) resultCallback;

  PromissoryListInfoDetail? selectedPromissory;

  CollateralPromissorySelectFinalizedPublishController({
    required this.promissoryListInfoDetailList,
    required this.resultCallback,
  });

  void setSelectedPromissory(PromissoryListInfoDetail promissory) {
    selectedPromissory = promissory;
    update();
  }

  void validateSelectPromissory() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (selectedPromissory == null) {
      SnackBarUtil.showSnackBar(title: locale.warning, message: locale.no_promissory_selected);

      return;
    }
    AppUtil.nextPageController(pageController, isClosed);
    Future.delayed(Constants.duration200, () {
      fetchPdfDocumentRequest(
        promissoryId: selectedPromissory!.promissoryId!,
        docType: PromissoryDocType.publish.jsonValue,
      );
    });
  }

  /// Sends a request to fetch a PDF document for a promissory.
  void fetchPdfDocumentRequest({//locale

    required String promissoryId,
    required String docType,
  }) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryFetchDocumentRequest promissoryFetchDocumentRequest = PromissoryFetchDocumentRequest(
      docType: docType,
      nationalNumber: null,
      promissoryId: promissoryId,
      number: null,
    );
    isLoading = true;
    update();
    PromissoryServices.promissoryFetchDocumentRequest(
      promissoryFetchDocument: promissoryFetchDocumentRequest,
    ).then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final PromissoryFetchDocumentResponse response, int _)):
            final resultData = CollateralPromissoryPublishResultData(
                isSuccess: true,
                message: locale.selected_successfully,
                promissoryId: selectedPromissory!.promissoryId,
                promissoryPdfBase64: response.data!.multiSignedPdf!);
            resultCallback(resultData);
            Get.back();
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  //// Handles back press events,
  ///
  /// navigating to the previous screen if the app is not currently loading
  /// and the event hasn't already been handled.
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
