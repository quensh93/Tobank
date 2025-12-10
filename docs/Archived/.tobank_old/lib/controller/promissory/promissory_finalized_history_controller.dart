import 'dart:async';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../model/promissory/promissory_finalized_role_type_filter_item_data.dart';
import '../../model/promissory/promissory_list_info.dart';
import '../../model/promissory/response/my_promissory_inquiry_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/promissory_services.dart';
import '../../ui/promissory/promissory_detail/promissory_detail_screen.dart';
import '../../ui/promissory/promissory_endorsement/promissory_endorsement_screen.dart';
import '../../ui/promissory/promissory_finalized_history/widget/promissory_filter_bottom_sheet.dart';
import '../../ui/promissory/promissory_finalized_history/widget/promissory_finalized_services_bottom_sheet.dart';
import '../../ui/promissory/promissory_settlement/promissory_settlement_screen.dart';
import '../../ui/promissory/promissory_settlement_gradual/promissory_settlement_gradual_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../main/main_controller.dart';

class PromissoryFinalizedHistoryController extends GetxController {
  MainController mainController = Get.find();
  bool isLoading = false;

  bool hasError = false;

  EasyRefreshController refreshController = EasyRefreshController();
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool allDataLoaded = false;
  bool isFirstTime = true;
  PromissoryRoleType? selectedRole;

  List<PromissoryListInfo> promissoryInfoList = [];
  ScrollController selectedScrollController = ScrollController();

  int openBottomSheets = 0;

  @override
  void onInit() {
    _addListenerToScrollController();
    // TODO: Replace with on start refresh
    _getMyPromissoryInquiryRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    if (mainController.overlayContext != null) {
      Timer(Constants.duration200, () {
        OverlaySupportEntry.of(mainController.overlayContext!)?.dismiss();
      });
    }
    Get.closeAllSnackbars();
  }

  /// Check for position of last item in list view
  /// if it reach to last item & data is not loading, run [_getTransactions] with
  /// new [page] parameter
  void _addListenerToScrollController() {
    scrollController.addListener(() {
      if (scrollController.offset >= scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (!isLoading && !allDataLoaded && !isFirstTime) {
          page++;
          _getMyPromissoryInquiryRequest();
        }
      }
    });
  }

  /// Fetches a list of promissory notes
  void _getMyPromissoryInquiryRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();

    PromissoryServices.myPromissoryInquiry(
      size: 10,
      page: page,
      role: selectedRole?.jsonValue,
    ).then((result) {
      isFirstTime = false;
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final MyPromissoryInquiryResponse response, int _)):
          promissoryInfoList.addAll(response.data!.promissoryInfoList!);
          allDataLoaded = !response.data!.hasNext!;
          isFirstTime = false;
          update();
        case Failure(exception: final ApiException apiException):
          hasError = true;
          update();
          AppUtil.showOverlaySnackbar(
            message: apiException.displayMessage,
            buttonText: locale.try_again,
            callback: () {
              _getMyPromissoryInquiryRequest();
            },
          );
      }
    });
  }

  Future<void> showFilterBottomSheet() async {
    AppUtil.hideKeyboard(Get.context!);
    if (isClosed) {
      return;
    }
    openBottomSheets++;
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
        child: const PromissoryFilterBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> showPromissoryServicesBottomSheet(PromissoryListInfo promissoryInfo) async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
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
        child: PromissoryFinalizedServicesBottomSheet(
          promissoryInfo: promissoryInfo,
          handleEventClick: (int eventId) {
            _handleEvent(promissoryInfo: promissoryInfo, eventId: eventId);
          },
        ),
      ),
    );
    openBottomSheets--;
  }

  Future<void> _handleEvent({
    required PromissoryListInfo promissoryInfo,
    required int eventId,
  }) async {
    _closeBottomSheets();
    if (eventId == 0) {
      Get.to(() => PromissoryDetailScreen(
            promissoryId: promissoryInfo.promissoryId!,
            promissoryInfo: null,
            issuerNn: promissoryInfo.issuerNn,
          ));
    } else if (eventId == 1) {
      await Get.to(() => PromissoryEndorsementScreen(promissoryInfo: promissoryInfo));
      onRefresh();
    } else if (eventId == 2) {
      await Get.to(() => PromissorySettlementScreen(promissoryInfo: promissoryInfo));
      onRefresh();
    } else if (eventId == 3) {
      await Get.to(() => PromissorySettlementGradualScreen(promissoryInfo: promissoryInfo));
      onRefresh();
    }
  }

  void onRefresh() {
    isFirstTime = true;
    page = 1;
    promissoryInfoList = [];
    allDataLoaded = false;
    update();
    _getMyPromissoryInquiryRequest();
  }

  bool isEmptyPromissoryList() {
    return page == 1 && allDataLoaded && promissoryInfoList.isEmpty && !isLoading;
  }

  void filterRoleType(PromissoryFinalizedRoleTypeFilterItemData item) {
    _closeBottomSheets();
    selectedRole = item.promissoryRoleType;
    update();
    onRefresh();
  }

  void deleteFilters() {
    _closeBottomSheets();
    _getMyPromissoryInquiryRequest();
    selectedRole = null;
    update();
    onRefresh();
  }

  /// Handles the back press action, navigating back if not loading.
  ///
  /// If the back press was already handled ([didPop] is true), it does nothing.
  /// Otherwise, if not currently loading ([isLoading] is false), it pops the
  /// current route using the navigator.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }
}
