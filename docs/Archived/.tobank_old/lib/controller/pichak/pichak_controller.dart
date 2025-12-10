import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/common/pichak_item_data.dart';
import '../../model/shaparak_hub/request/tsm/shaparak_hub_renew_card_id_request.dart';
import '../../model/shaparak_hub/response/tsm/shaparak_hub_renew_card_id_response.dart';
import '../../model/shaparak_hub/shaparak_public_key_model.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../service/shaparak_hub_services.dart';
import '../../ui/pichak/owner_credit/owner_credit_inquiry_screen.dart';
import '../../ui/pichak/receive/check_receive_screen.dart';
import '../../ui/pichak/shaparak_hub_submit_pichak/shaparak_hub_submit_pichak_screen.dart';
import '../../ui/pichak/shaparak_payment/shaparak_payment_screen.dart';
import '../../ui/pichak/submit/check_submit_screen.dart';
import '../../ui/pichak/tracking/tracking_credit_inquiry_screen.dart';
import '../../ui/pichak/transfer/check_transfer_screen.dart';
import '../../ui/pichak/transfer_status/transfer_status_inquiry_screen.dart';
import '../../util/app_util.dart';
import '../../util/data_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class PichakController extends GetxController {
  MainController mainController = Get.find<MainController>();
  bool isLoading = false;
  List<PichakItemData> pichakItems = [];
  List<CustomerCard> sourceCustomerCardList = [];
  String? _publicKey;
  bool isPichakItemsEnable = false;

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    getRemoteUserCards(withLoading: true);
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Determines the available Pichak service items based on customer card and public key information.
  void _getPichakServiceItem() {
    if (mainController.customerCardPichak != null && _publicKey != null) {
      final referenceDateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(mainController.customerCardPichak!.hubCardData!.hubRefExpDate!));
      if (!referenceDateTime.isAfter(DateTime.now())) {
        pichakItems = DataConstants.getShaparakItems();
      } else {
        isPichakItemsEnable = true;
        pichakItems = DataConstants.getPichakItems();
      }
      update();
    } else {
      pichakItems = DataConstants.getShaparakItems();
      update();
    }
  }

  /// Navigates to the appropriate Shaparak Hub screen based on customer card and public key information.
  ///
  /// This function determines whether to navigate to the Shaparak Hub submission screen
  /// or the Shaparak card renewal screen based on the customer's card information and the availability of a public key.
  void _showHub() {
    if (mainController.customerCardPichak != null &&
        mainController.customerCardPichak!.hubCardData!.hubCardId != null) {
      if (_publicKey == null) {
        Get.to(
          () => ShaparakHubSubmitPichakScreen(
            hasPublicKey: _publicKey != null,
            isReactivation: true,
            sourceDataList: sourceCustomerCardList,
          ),
        )!
            .then((value) => getRemoteUserCards());
      } else {
        final referenceDateTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(mainController.customerCardPichak!.hubCardData!.hubRefExpDate!));
        if (!referenceDateTime.isAfter(DateTime.now())) {
          _shaparakCardRenewRequest();
        }
      }
    } else {
      Get.to(
        () => ShaparakHubSubmitPichakScreen(
          hasPublicKey: _publicKey != null,
          isReactivation: false,
          sourceDataList: sourceCustomerCardList,
        ),
      )!
          .then((value) => getRemoteUserCards());
    }
  }

  /// Sends a Shaparak card renewal request and handles the response,
  /// updating user cards on success.
  void _shaparakCardRenewRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ShaparakHubRenewCardIdRequest requestData = ShaparakHubRenewCardIdRequest();
    requestData.sourceCard = mainController.customerCardPichak!.cardNumber;
    requestData.cardId = mainController.customerCardPichak!.hubCardData!.hubCardId;
    requestData.referenceExpiryDate = mainController.customerCardPichak!.hubCardData!.hubRefExpDate;
    isLoading = true;
    update();
    ShaparakHubServices.renewCardId(
      requestData,
    ).then((result) async {
      switch (result) {
        case Success(value: (final ShaparakHubRenewCardIdResponse response, int _)):
          if (response.data?.cardId != null) {
            getRemoteUserCards(withLoading: true);
          } else {
            isLoading = false;
            update();
            var message = response.message;
            if (message == null || message == '') {
              message = locale.error_occurred_try_again;
            }
            SnackBarUtil.showInfoSnackBar(
              message,
            );
          }

        case Failure(exception: final ApiException apiException):
          isLoading = false;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void handleItemClick(PichakItemData pichakData) {
    if (pichakData.eventId == 0) {
      _showHub();
    } else if (pichakData.eventId == 1) {
      Get.to(
        () => const OwnerCreditInquiryScreen(),
      );
    } else if (pichakData.eventId == 2) {
      Get.to(
        () => const CheckSubmitScreen(),
      );
    } else if (pichakData.eventId == 3) {
      Get.to(
        () => const CheckReceiveScreen(),
      );
    } else if (pichakData.eventId == 4) {
      Get.to(
        () => const CheckTransferScreen(transferReversal: false),
      );
    } else if (pichakData.eventId == 5) {
    } else if (pichakData.eventId == 6) {
      Get.to(
        () => const TrackingInquiryScreen(),
      );
    } else if (pichakData.eventId == 7) {
      Get.to(
            () => const CheckTransferScreen(transferReversal: true),
      );
    }  else if (pichakData.eventId == 8) {
      Get.to(
            () => const TransferStatusInquiryScreen(),
      );
    } else if (pichakData.eventId == 8) {
      Get.to(
        () => ShaparakPaymentScreen(
          returnDataFunction: (bool isPay, String? manaId) {},
        ),
      );
    }
  }


  /// Retrieves the user's remote cards.
  Future<void> getRemoteUserCards({
    bool? withLoading,
  }) async {
    final String? shaparakHubString = await StorageUtil.getShaparakHubSecureStorage();
    ShaparakPublicKeyModel? shaparakPublicKeyModel;
    if (shaparakHubString != null) {
      shaparakPublicKeyModel = ShaparakPublicKeyModel.fromJson(jsonDecode(shaparakHubString));
    }
    if (shaparakPublicKeyModel != null) {
      _publicKey = shaparakPublicKeyModel.publicKey;
    }
    mainController.customerCardPichak = null;
    _getUserRemoteCardsRequest();
  }

  /// Get data of [ListCardData] from server request
  Future<void> _getUserRemoteCardsRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    CardServices.getCustomerCardsRequest().then(
      (result) async {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final CustomerCardResponseData response, int _)):
            _handleListOfCards(response.data!.cards ?? []);
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
      },
    );
  }

  /// Processes a list of customer cards, filtering for owned cards.
  Future<void> _handleListOfCards(List<CustomerCard> customerCardList) async {
    sourceCustomerCardList = [];
    for (final CustomerCard customerCard in customerCardList) {
      if (customerCard.isMine!) {
        sourceCustomerCardList.add(customerCard);
        if (customerCard.hubCardData != null) {
          mainController.customerCardPichak = customerCard;
        }
      }
    }
    _getPichakServiceItem();
    update();
  }
}
