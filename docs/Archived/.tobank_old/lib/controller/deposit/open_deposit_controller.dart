import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/address/request/address_inquiry_request_data.dart';
import '../../model/address/response/address_inquiry_response_data.dart';
import '../../model/card/request/card_issuance_request_data.dart';
import '../../model/card/request/card_issuance_template_request_data.dart';
import '../../model/card/response/card_issuance_response_data.dart';
import '../../model/card/response/card_issuance_template_response_data.dart';
import '../../model/card_color_data.dart';
import '../../model/common/encryption_key_pair.dart';
import '../../model/deposit/request/open_deposit_request_data.dart';
import '../../model/deposit/response/deposit_type_response_data.dart';
import '../../model/deposit/response/open_deposit_response_data.dart';
import '../../model/other/response/other_item_data.dart';
import '../../model/register/request/get_public_key_request_data.dart';
import '../../model/register/request/upload_customer_public_key_request_data.dart';
import '../../model/register/response/get_public_key_response_data.dart';
import '../../model/register/response/upload_customer_public_key_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../service/deposit_services.dart';
import '../../service/other_services.dart';
import '../../service/update_address_services.dart';
import '../../ui/common/location_picker_screen.dart';
import '../../ui/open_long_term_deposit/open_long_term_deposit_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class OpenDepositController extends GetxController {
  MainController mainController = Get.find();

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = false;

  bool issuanceCard = false;

  ScrollController scrollbarController = ScrollController();

  bool isChecked = false;

  TextEditingController addressController = TextEditingController();

  bool isAddressValid = true;

  TextEditingController postalCodeController = TextEditingController();

  bool isPostalCodeValid = true;

  bool showPassword = false;
  bool showCVV2 = false;

  late DepositTypeResponseData depositTypeResponseData;

  late OpenDepositResponse openDepositResponse;

  List<CardTemplate> cardTemplates = [];
  List<CardColorData> cardColorDataList = [];

  late OtherItemData otherItemData;

  TextEditingController inviteCodeController = TextEditingController();

  bool isInviteCodeValid = true;

  LatLng? selectedLocation;

  bool isLocationValid = true;

  bool isPostalCodeLoading = false;

  String postalCodeErrorMessage = '';

  AddressInquiryResponseData? customerAddressInquiryResponseData;

  TextEditingController provinceController = TextEditingController();

  bool isProvinceValid = true;

  TextEditingController cityController = TextEditingController();

  bool isCityValid = true;

  TextEditingController townshipController = TextEditingController();

  bool isTownShipValid = true;

  TextEditingController lastStreetController = TextEditingController();

  bool isLastStreetValid = true;

  TextEditingController secondLastStreetController = TextEditingController();

  bool isSecondLastStreetValid = true;

  String? cityName;

  TextEditingController plaqueController = TextEditingController();

  bool isPlaqueValid = true;

  TextEditingController unitController = TextEditingController();

  bool isUnitValid = true;

  CardIssuanceResponse? cardIssuanceResponse;

  DepositType selectedDepositType;

  bool isAddressInquirySuccessful = false;

  PageController expandablePageViewController = PageController();
  CardColorData? selectedCardColorData;

  int? branchCode;

  OpenDepositController({
    required this.selectedDepositType,
    this.branchCode,
  });

  @override
  void onInit() {
    super.onInit();
    validateFirstPage();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void setIssuanceCard(bool? isChecked) {
    issuanceCard = isChecked!;
    update();
  }

  void setChecked(bool isCheck) {
    isChecked = isCheck;
    update();
  }

  void toggleShowCVV2(bool isChecked) {
    showCVV2 = !showCVV2;
    update();
  }

  void toggleShowPassword(bool isChecked) {
    showPassword = !showPassword;
    update();
  }

  void validateFirstPage() {
    switch (selectedDepositType.generalType!) {
      case 1:
        _getShabahangGharzolhasaneRulesRequest();
        break;
      case 2:
        _getShabahangDepositShortTermRulesRequest();
        break;
      case 3:
        _showOpenLongTermDepositScreen();
        break;
      default:
        _getShabahangRulesRequest();
        break;
    }
  }

  /// Sends a request to open a new deposit account for the customer.
  void _openDepositRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final OpenDepositRequest openDepositRequest = OpenDepositRequest(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      depositTypeCode: selectedDepositType.typeCode!,
      branchCode: branchCode.toString(),
    );

    isLoading = true;
    update();

    DepositServices.openDeposit(
      openDepositRequest: openDepositRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OpenDepositResponse response, int _)):
          openDepositResponse = response;
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

  void validateSecondPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isChecked) {
      _openDepositRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_read_and_accept_terms,
      );
    }
  }

  /// Retrieves Shabahang rules from the server.
  void _getShabahangRulesRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    OtherServices.getShabahangRules().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
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

  /// Retrieves Shabahang Gharzolhasane rules from the server.
  void _getShabahangGharzolhasaneRulesRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    OtherServices.getShabahangDepositGharzolhasaneRules().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
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

  /// Retrieves ShabahangDeposit Short-Term rules from the server.
  void _getShabahangDepositShortTermRulesRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    OtherServices.getShabahangDepositShortTermRules().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
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

  /// Retrieves the Dibalite public key from the server.
  void validateDepositResultPage() {
    AppUtil.nextPageController(pageController, isClosed);
    Timer(const Duration(milliseconds: 500), () {
      getDibalitePublicKeyRequest();
    });
  }

  /// Retrieves the Dibalite public key from the server.
  void getDibalitePublicKeyRequest() {
    final GetPublicKeyRequestData getPublicKeyRequestData = GetPublicKeyRequestData(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber,
    );

    hasError = false;
    isLoading = true;
    update();

    AuthorizationServices.getDibalitePublicKeyRequest(
      getPublicKeyRequestData: getPublicKeyRequestData,
    ).then((result) async {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final GetPublicKeyResponseData response, int _)):
          _handlePublicKey(response);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
      }
    });
  }

  /// Compares the server public key with the device public key.
  /// If they are different, it calls the [_uploadKeyRequest] function to upload the device public key to the server.
  Future<void> _handlePublicKey(GetPublicKeyResponseData response) async {
    final String? customerKeyPairString = await StorageUtil.getEncryptionKeyPair();
    final EncryptionKeyPair deviceDibaliteKeypair = EncryptionKeyPair.fromJson(jsonDecode(customerKeyPairString!));

    String serverPublicKey = response.data!.customerPublicKey!;
    String devicePublicKey = deviceDibaliteKeypair.publicKey;

    serverPublicKey = serverPublicKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .trim();

    devicePublicKey = devicePublicKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .trim();

    if (devicePublicKey == serverPublicKey) {
      _getCardTemplatesRequest();
    } else {
      _uploadKeyRequest();
    }
  }

  /// Uploads the device public key to the server.
  Future<void> _uploadKeyRequest() async {
    final EncryptionKeyPair keyPair = await AppUtil.generateRSAKeyPair();
    await StorageUtil.setEncryptionKeyPair(jsonEncode(keyPair));

    String publicKey = keyPair.publicKey;
    publicKey = publicKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .trim();

    final UploadCustomerPublicKeyRequest uploadCustomerPublicKeyRequest = UploadCustomerPublicKeyRequest(
        customerNumber: mainController.authInfoData!.customerNumber!,
        trackingNumber: const Uuid().v4(),
        customerPublicKey: publicKey);

    hasError = false;
    isLoading = true;
    update();

    AuthorizationServices.uploadCustomerPublicKey(
      uploadCustomerPublicKeyRequest: uploadCustomerPublicKeyRequest,
    ).then((result) async {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final UploadCustomerPublicKeyResponse _, int _)):
          _getCardTemplatesRequest();
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
      }
    });
  }

  /// Retrieves the card templates from the server.
  void _getCardTemplatesRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CardIssuanceTemplateRequest cardIssuanceTemplateRequest = CardIssuanceTemplateRequest(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      depositNumber: openDepositResponse.data!.depositId!,
    );

    isLoading = true;
    hasError = false;
    update();

    CardServices.getCardIssuanceTemplates(
      cardIssuanceTemplateRequest: cardIssuanceTemplateRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CardIssuanceTemplateResponse response, int _)):
          cardTemplates = response.data!.cardTemplates ?? [];
          _handleCardTemplates();
          update();
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

  /// Validates the card request form fields.
  void validateRequestCard() {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (postalCodeController.text.trim().length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
    } else {
      isPostalCodeValid = false;
      isValid = false;
    }
    if (lastStreetController.text.trim().length > 3) {
      isLastStreetValid = true;
    } else {
      isLastStreetValid = false;
      isValid = false;
    }
    if (secondLastStreetController.text.trim().length > 3) {
      isSecondLastStreetValid = true;
    } else {
      isSecondLastStreetValid = false;
      isValid = false;
    }
    if (plaqueController.text.trim().isNotEmpty) {
      isPlaqueValid = true;
    } else {
      isPlaqueValid = false;
      isValid = false;
    }
    if (unitController.text.trim().isNotEmpty) {
      isUnitValid = true;
    } else {
      isUnitValid = false;
      isValid = false;
    }
    if (cityController.text.trim().isNotEmpty) {
      isCityValid = true;
    } else {
      isCityValid = false;
      isValid = false;
    }
    if (townshipController.text.trim().isNotEmpty) {
      isTownShipValid = true;
    } else {
      isTownShipValid = false;
      isValid = false;
    }
    if (provinceController.text.trim().isNotEmpty) {
      isProvinceValid = true;
    } else {
      isProvinceValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      AppUtil.nextPageController(pageController, isClosed);
    }
  }

  void checkZaerCard() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final depositType = openDepositResponse.data!.depositId!.split('.')[1];
    if (depositType == '9298') {
      DialogUtil.showZaerCardWarningDialog(
        buildContext: Get.context!,
        title: locale.warning,
        description:
            locale.arbaeein_qr_code_credit_card,
        confirmMessage: locale.confirmation,
        cancelMessage: locale.return_,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _cardIssuanceRequest();
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        },
      );
    } else {
      _cardIssuanceRequest();
    }
  }

  /// Sends a card issuance request to the server.
  void _cardIssuanceRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CardIssuanceRequest cardIssuanceRequest = CardIssuanceRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      trackingNumber: const Uuid().v4(),
      postalCode: int.parse(postalCodeController.text),
      addressInfo: AddressInfo(
        province: provinceController.text,
        township: townshipController.text,
        city: cityController.text,
        village: customerAddressInquiryResponseData!.data!.detail?.village ?? '',
        localityName: customerAddressInquiryResponseData!.data!.detail?.localityName ?? '',
        lastStreet: lastStreetController.text,
        secondLastStreet: secondLastStreetController.text,
        alley: customerAddressInquiryResponseData!.data!.detail?.street2 ?? '',
        plaque: int.tryParse(plaqueController.text) ?? 1,
        unit: int.tryParse(unitController.text) ?? 0,
        description: customerAddressInquiryResponseData!.data!.detail?.description ?? '',
      ),
      depositNumber: openDepositResponse.data!.depositId!,
      latitude: selectedLocation?.latitude,
      longitude: selectedLocation?.longitude,
      templateId: selectedCardColorData?.cardId,
    );

    isLoading = true;
    update();
    CardServices.cardIssuance(
      cardIssuanceRequest: cardIssuanceRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CardIssuanceResponse response, int _)):
          cardIssuanceResponse = response;
          if (cardIssuanceResponse!.data!.cvv2 != null) {
            cardIssuanceResponse!.data!.cvv2 = await AppUtil.decryptRSAData(cardIssuanceResponse!.data!.cvv2!);
          }
          if (cardIssuanceResponse!.data!.pin2 != null) {
            cardIssuanceResponse!.data!.pin2 = await AppUtil.decryptRSAData(cardIssuanceResponse!.data!.pin2!);
          }
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

  void showSelectLocationScreen() {
    AppUtil.hideKeyboard(Get.context!);
    Get.to(
      () => LocationPickerScreen(
        returnDataFunction: (latLng) {
          selectedLocation = latLng;
          isLocationValid = true;
          update();
        },
      ),
    );
  }

  void _showOpenLongTermDepositScreen() {
    Get.back();
    Get.to(() => OpenLongTermDepositScreen(
          selectedDepositType: selectedDepositType,
          branchCode: branchCode,
        ));
  }

  /// Copies the given value to the clipboard.
  void copyClipboard(String value) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    Clipboard.setData(ClipboardData(text: value));
    SnackBarUtil.showInfoSnackBar(locale.valued_copied);
  }

  /// Handles back button press events.
  /// If the current page is one of the specified pages, it pops the current route.
  /// Otherwise, it navigates to the previous page.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 ||
          pageController.page == 1 ||
          pageController.page == 3 ||
          pageController.page == 4 ||
          pageController.page == 5) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  void validateCustomerAddressInquiry() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    if (postalCodeController.text.length == Constants.postalCodeLength) {
      isPostalCodeValid = true;
      _customerAddressInquiryRequest();
    } else {
      isPostalCodeValid = false;
      postalCodeErrorMessage = locale.enter_valid_postal_code;
    }
    update();
  }

  /// Performs a customer address inquiry request based on the provided postal code.
  void _customerAddressInquiryRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AddressInquiryRequestData addressInquiryRequestData = AddressInquiryRequestData();
    addressInquiryRequestData.postalCode = postalCodeController.text;
    addressInquiryRequestData.isProviderRequired = false;

    isPostalCodeLoading = true;
    isAddressInquirySuccessful = false;
    update();

    UpdateAddressServices.addressInquiryRequest(
      addressInquiryRequestData: addressInquiryRequestData,
    ).then((result) {
      isPostalCodeLoading = false;
      update();

      switch (result) {
        case Success(value: (final AddressInquiryResponseData response, int _)):
          customerAddressInquiryResponseData = response;
          setCustomerTextControllers();
          update();
        case Failure(exception: final ApiException apiException):
          customerAddressInquiryResponseData = null;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setCustomerTextControllers() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    cityName = customerAddressInquiryResponseData!.data!.detail?.townShip ??
        customerAddressInquiryResponseData!.data!.detail?.localityName;
    if (cityName != null && customerAddressInquiryResponseData!.data!.detail!.province != null) {
      isAddressInquirySuccessful = true;
      townshipController.text = customerAddressInquiryResponseData!.data!.detail!.townShip ?? '';
      isTownShipValid = true;
      cityController.text = cityName ?? '';
      isCityValid = true;
      provinceController.text = customerAddressInquiryResponseData!.data!.detail!.province ?? '';
      isProvinceValid = true;
      final detail = customerAddressInquiryResponseData?.data?.detail;
      if (detail?.subLocality != null && detail?.street != null && detail?.street2 != null) {
        lastStreetController = TextEditingController(text: '${detail?.subLocality ?? ''} ${detail?.street ?? ''}');
        isLastStreetValid = true;
        secondLastStreetController = TextEditingController(text: detail?.street2 ?? '');
        isSecondLastStreetValid = true;
      } else {
        lastStreetController.text = '';
        secondLastStreetController.text = '';
      }
      final sideFloor = int.tryParse(detail?.sideFloor ?? '');
      if (sideFloor != null) {
        unitController = TextEditingController(text: detail?.sideFloor);
        isUnitValid = true;
      } else {
        unitController.text = '';
      }
      final plaqueString = (detail?.houseNumber ?? '').toString();
      final plaqueInt = int.tryParse(plaqueString) ?? 0;
      plaqueController = TextEditingController(text: (plaqueInt).toString());
      isPlaqueValid = true;
      update();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.no_address_for_postal_code,
      );
    }
  }

  void removeSelectedMapLocation() {
    selectedLocation = null;
    update();
  }

  void _handleCardTemplates() {
    cardColorDataList = [];
    for (final cardTemplate in cardTemplates) {
      cardColorDataList.add(CardColorData(
        cardName: cardTemplate.templateImage!.colorName,
        cardColor: cardTemplate.templateImage!.color,
        cardId: cardTemplate.templateId,
      ));
    }
    if (cardColorDataList.isNotEmpty) {
      selectedCardColorData = cardColorDataList[0];
    }
    update();
  }

  void setSelectedCardColorData(int index, CardColorData cardColorData) {
    selectedCardColorData = cardColorData;
    update();
    AppUtil.gotoPageController(pageController: expandablePageViewController, page: index, isClosed: isClosed);
  }
}
