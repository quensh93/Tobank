import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/address/response/address_inquiry_response_data.dart';
import '../../model/bpms/card/card_reissuance/request/card_reissuance_start_process_variables_data.dart';
import '../../model/bpms/common/bpms_address.dart';
import '../../model/bpms/common/bpms_address_value.dart';
import '../../model/bpms/request/start_process_request_data.dart';
import '../../model/bpms/response/start_process_response_data.dart';
import '../../model/card/request/card_issuance_template_request_data.dart';
import '../../model/card/response/card_issuance_template_response_data.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/card_color_data.dart';
import '../../service/bpms_services.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/common/location_picker_screen.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class CardReissueStartController extends GetxController {
  CardReissueStartController({
    required this.customerCard,
    required this.postalCode,
    required this.customerAddressInquiryResponseData,
  });

  String postalCode;
  CustomerCard customerCard;
  MainController mainController = Get.find();
  PageController pageController = PageController();
  bool isLoading = false;

  String? cityName;

  TextEditingController addressController = TextEditingController();

  bool isAddressValid = true;

  AddressInquiryResponseData? customerAddressInquiryResponseData;

  TextEditingController lastStreetController = TextEditingController();

  TextEditingController provinceCityController = TextEditingController();

  TextEditingController unitController = TextEditingController();

  TextEditingController townshipController = TextEditingController();

  TextEditingController secondLastStreetController = TextEditingController();

  TextEditingController plaqueController = TextEditingController();

  bool isLastStreetValid = true;

  bool isSecondLastStreetValid = true;

  bool isUnitValid = true;

  bool isProvinceValid = true;

  bool isProvinceCityValid = true;

  bool isTownShipValid = true;

  bool isCityValid = true;

  bool isPlaqueValid = true;

  bool isPostalCodeValid = true;

  bool isPostalCodeLoading = false;

  LatLng? selectedLocation;

  bool isLocationValid = true;

  String postalCodeErrorMessage = '';

  StartProcessResponse? startProcessResponse;

  PageController expandablePageViewController = PageController();
  CardColorData? selectedCardColorData;

  List<CardTemplate> cardTemplates = [];
  List<CardColorData> cardColorDataList = [];

  @override
  void onInit() {
    setCustomerTextControllers();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
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

  void setCustomerTextControllers() {
    cityName = customerAddressInquiryResponseData!.data!.detail?.townShip ??
        customerAddressInquiryResponseData!.data!.detail?.localityName;
    townshipController.text = customerAddressInquiryResponseData!.data!.detail!.townShip ?? '';
    isTownShipValid = true;
    isCityValid = true;
    isProvinceValid = true;
    provinceCityController.text = '${customerAddressInquiryResponseData!.data!.detail!.province!}/${cityName!}';
    isProvinceCityValid = true;
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
    plaqueController = TextEditingController(text: (detail?.houseNumber ?? '').toString());
    isPlaqueValid = true;
    update();
  }

  /// Sends a request to initiate a card re-issuance process and handles the response.
  void _cardReIssuanceRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final StartProcessRequest startProcessRequest = StartProcessRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      processDefinitionKey: 'CardReissuanceRequest',
      businessKey: '1234567890',
      trackingNumber: const Uuid().v4(),
      returnNextTasks: false,
      variables: ReIssueCardStartProcessVariables(
        customerNumber: mainController.authInfoData!.customerNumber!,
        customerDepositNumber: customerCard.gardeshgaryCardData!.depositNumber!,
        pan: customerCard.cardNumber!,
        cardTemplateId: selectedCardColorData?.cardId.toString(),
        customerAddress: BPMSAddress(
          value: BPMSAddressValue(
            postalCode: int.parse(postalCode),
            province: customerAddressInquiryResponseData!.data!.detail!.province,
            township: townshipController.text,
            city: cityName,
            village: customerAddressInquiryResponseData!.data!.detail?.village ?? '',
            localityName: customerAddressInquiryResponseData!.data!.detail?.localityName ?? '',
            lastStreet: lastStreetController.text,
            secondLastStreet: secondLastStreetController.text,
            alley: customerAddressInquiryResponseData!.data!.detail?.street2 ?? '',
            plaque: int.tryParse(plaqueController.text),
            unit: int.tryParse(unitController.text),
            description: customerAddressInquiryResponseData!.data!.detail?.description ?? '',
            latitude: selectedLocation?.latitude,
            longitude: selectedLocation?.longitude,
          ),
        ),
      ),
    );

    isLoading = true;
    update();
    BPMSServices.startProcess(
      startProcessRequest: startProcessRequest,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final StartProcessResponse response, int _)):
          startProcessResponse = response;
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

  void removeSelectedMapLocation() {
    selectedLocation = null;
    update();
  }

  void setSelectedCardColorData(int index, CardColorData cardColorData) {
    selectedCardColorData = cardColorData;
    update();
    AppUtil.gotoPageController(pageController: expandablePageViewController, page: index, isClosed: isClosed);
  }

  void validateConfirmPage() {
    bool isValid = true;
    AppUtil.hideKeyboard(Get.context!);
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
    if (townshipController.text.trim().isNotEmpty) {
      isTownShipValid = true;
    } else {
      isTownShipValid = false;
      isValid = false;
    }
    if (provinceCityController.text.trim().isNotEmpty) {
      isProvinceCityValid = true;
    } else {
      isProvinceCityValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _getCardTemplatesRequest();
    }
  }

  void validateSelectedCardTemplate() {
    _cardReIssuanceRequest();
  }

  /// Retrieves card templates for card issuance.

  /// This function sends a request to fetch available card templates.
  /// If successful, it processes the templates (using `_handleCardTemplates`) and navigates to the next page.
  /// If an error occurs, it sets an error state, displays an error message.
  void _getCardTemplatesRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CardIssuanceTemplateRequest cardIssuanceTemplateRequest = CardIssuanceTemplateRequest(
      trackingNumber: const Uuid().v4(),
      customerNumber: mainController.authInfoData!.customerNumber!,
      depositNumber: customerCard.gardeshgaryCardData!.depositNumber!,
    );

    isLoading = true;
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
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
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
}
