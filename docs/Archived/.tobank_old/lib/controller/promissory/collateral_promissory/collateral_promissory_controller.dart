import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/select_promissory_collateral_data.dart';
import '../../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../../model/promissory/collateral_promissory/collateral_promissory_request_data.dart';
import '../../../model/promissory/response/get_full_detailed_my_promissory_response_data.dart';
import '../../../service/core/api_core.dart';
import '../../../service/promissory_services.dart';
import '../../../ui/promissory/collateral_promissory/collateral_promissory_continue_publish/collateral_promissory_continue_publish_screen.dart';
import '../../../ui/promissory/collateral_promissory/collateral_promissory_finalized_publish/collateral_promissory_finalized_publish_screen.dart';
import '../../../ui/promissory/collateral_promissory/collateral_promissory_publish/collateral_promissory_publish_screen.dart';
import '../../../util/app_util.dart';
import '../../../util/enums_constants.dart';
import '../../../util/snack_bar_util.dart';
import '../../main/main_controller.dart';

class CollateralPromissoryController extends GetxController {
  final CollateralPromissoryRequestData collateralPromissoryRequestData;
  final Function(CollateralPromissoryPublishResultData? collateralPromissoryPublishResultData) returnDataFunction;

  MainController mainController = Get.find();
  PageController pageController = PageController();

  String errorTitle = '';
  bool hasError = false;
  bool isLoading = false;

  final List<SelectPromissoryCollateralData> selectPromissoryCollateralDataList = [];

  GetMyFullDeatiledPromissoryResponse? getMyFullDeatiledPromissoryResponse;

  CollateralPromissoryController({required this.collateralPromissoryRequestData, required this.returnDataFunction});

  @override
  Future<void> onInit() async {
    getMyFullDetailedPromissoryRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  // Sends a request to retrieve the user's full detailed promissory information.
  Future<void> getMyFullDetailedPromissoryRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    hasError = false;
    update();
    PromissoryServices.getMyFullDetailedPromissory().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final GetMyFullDeatiledPromissoryResponse response, int _)):
          getMyFullDeatiledPromissoryResponse = response;
          update();

          _handleMyPromissoryResponse();
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

  void _handleMyPromissoryResponse() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    // Check if there is other open publish request
    final openRequest = getMyFullDeatiledPromissoryResponse!.data!.publishOpenRequest;
    if (openRequest != null) {
      if (openRequest.amount == collateralPromissoryRequestData.amount &&
          openRequest.dueDate == collateralPromissoryRequestData.dueDate &&
          openRequest.description == collateralPromissoryRequestData.description &&
          openRequest.recipientNn == collateralPromissoryRequestData.recipientNN &&
          openRequest.recipientCellphone == collateralPromissoryRequestData.recipientCellPhone) {
        // open request and collateral promissory detail matches
        selectPromissoryCollateralDataList.add(SelectPromissoryCollateralData(
          eventId: 3,
          title: locale.finalize_open_request,
        ));
        update();
        AppUtil.nextPageController(pageController, isClosed);
      } else {
        hasError = true;
        errorTitle =
            locale.promissory_request_error;
        update();
      }
    } else {
      final publishedRequests =
          getMyFullDeatiledPromissoryResponse!.data!.publishedFinalized!.promissoryInfoDetailList!;
      final usablePromissory = publishedRequests.firstWhereOrNull((promissory) {
        return !promissory.isUsed! &&
            promissory.amount == collateralPromissoryRequestData.amount &&
            promissory.dueDate?.trim() == (collateralPromissoryRequestData.dueDate ?? locale.due_on_demand) &&
            promissory.description == collateralPromissoryRequestData.description &&
            promissory.recipientNn == collateralPromissoryRequestData.recipientNN &&
            promissory.recipientCellphone == collateralPromissoryRequestData.recipientCellPhone &&
            promissory.state == PromissoryStateType.published;
      });

      if (usablePromissory != null) {
        // User has eligable finalized promissory
        selectPromissoryCollateralDataList.add(SelectPromissoryCollateralData(
          eventId: 1,
          title: locale.promissory_issuance,
        ));
        selectPromissoryCollateralDataList.add(SelectPromissoryCollateralData(
          eventId: 2,
          title: locale.select_promissory_from_issued,
        ));
        update();
        AppUtil.nextPageController(pageController, isClosed);
      } else {
        selectPromissoryCollateralDataList.add(SelectPromissoryCollateralData(
          eventId: 1,
          title: locale.promissory_issuance_title,
        ));
        update();
        AppUtil.nextPageController(pageController, isClosed);
      }
    }
  }

  void handlePromissoryActionEvent(int eventId) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (eventId == 1) {
      // Publish
      Get.to(
        () => CollateralPromissoryPublishScreen(
          collateralPromissoryRequestData: collateralPromissoryRequestData,
          resultCallback: (collateralPromissoryPublishResultData) {
            if (collateralPromissoryPublishResultData.isSuccess) {
              returnDataFunction(collateralPromissoryPublishResultData);
            }
          },
        ),
      );
    } else if (eventId == 2) {
      // Select from finalized
      final eligableList = getMyFullDeatiledPromissoryResponse!.data!.publishedFinalized!.promissoryInfoDetailList!
          .where((promissory) =>
              !promissory.isUsed! &&
              promissory.amount == collateralPromissoryRequestData.amount &&
              promissory.dueDate?.trim() == (collateralPromissoryRequestData.dueDate ?? locale.due_on_demand) &&
              promissory.description == collateralPromissoryRequestData.description &&
              promissory.recipientNn == collateralPromissoryRequestData.recipientNN &&
              promissory.recipientCellphone == collateralPromissoryRequestData.recipientCellPhone &&
              promissory.state == PromissoryStateType.published)
          .toList();
      Get.to(
        () => CollateralPromissoryFinalizedPublishScreen(
          promissoryListInfoDetailList: eligableList,
          resultCallback: (collateralPromissoryPublishResultData) {
            if (collateralPromissoryPublishResultData.isSuccess) {
              returnDataFunction(collateralPromissoryPublishResultData);
            }
          },
        ),
      );
    } else if (eventId == 3) {
      // Continue publish request
      Get.to(
        () => CollateralPromissoryContinuePublishScreen(
          promissoryRequest: getMyFullDeatiledPromissoryResponse!.data!.publishOpenRequest!,
          resultCallback: (collateralPromissoryPublishResultData) {
            if (collateralPromissoryPublishResultData.isSuccess) {
              returnDataFunction(collateralPromissoryPublishResultData);
            }
          },
        ),
      );
    }
  }
}
