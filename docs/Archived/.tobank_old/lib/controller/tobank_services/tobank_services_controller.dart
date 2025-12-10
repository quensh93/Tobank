import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/controller/dashboard/dashboard_controller.dart';
import '/controller/main/main_controller.dart';
import '/model/common/menu_data_model.dart';
import '/ui/acceptor/acceptor_screen.dart';
import '/ui/bpms/military_guarantee/military_guarantee_start/military_guarantee_start_screen.dart';
import '/ui/cbs/cbs_introduction_screen.dart';
import '/ui/cbs/cbs_screen.dart';
import '/ui/promissory/promissory_screen.dart';
import '/ui/register/register_screen.dart';
import '/ui/safe_box/safe_box_screen.dart';
import '/ui/tobank_services/widget/internet_bank_password_bottom_sheet.dart';
import '/ui/tobank_services/widget/internet_bank_services_bottom_sheet.dart';
import '/ui/tobank_services/widget/mobile_bank_password_bottom_sheet.dart';
import '/ui/tobank_services/widget/mobile_bank_services_bottom_sheet.dart';
import '/ui/tobank_services/widget/modern_banking_init_bottom_sheet.dart';
import '/util/app_state.dart';
import '/util/app_util.dart';
import '/util/data_constants.dart';
import '/util/dialog_util.dart';
import '/util/enums_constants.dart';
import '/util/snack_bar_util.dart';
import '/util/storage_util.dart';
import '../../model/bpms/modern_banking/request/modern_banking_start_process_variables_data.dart';
import '../../model/bpms/request/start_process_request_data.dart';
import '../../model/bpms/response/start_process_response_data.dart';
import '../../model/bpms/response/user_startable_process_response_data.dart';
import '../../model/common/menu_data.dart';
import '../../model/modern_banking/request/modern_banking_change_password_request.dart';
import '../../model/register/request/customer_info_request_data.dart';
import '../../model/register/response/customer_info_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/bpms_services.dart';
import '../../service/core/api_core.dart';
import '../../service/modern_banking_services.dart';
import '../../ui/azki_loan/azki_loan_screen.dart';

const String eventName = 'vb_dashboard_click_event';

class TobankServicesController extends GetxController {
  MainController mainController = Get.find();
  DashboardController dashboardController = Get.find();
  final Rx<AppState> _state = AppState().obs;
  final Rx<AppState> _modernBankingState = AppState().obs;
  final Rx<AppState> _changePasswordState = AppState().obs;
  PageController pageController = PageController();
  MenuItemData? selectedProcess;
  final RxList<MenuItemData> _virtualBranchMenuItemList = <MenuItemData>[].obs;
  List<ProcessDefinitionData> processDefinitions = [];

  int openBottomSheets = 0;

  bool showPassword = false;
  late String processDefinitionKey;
  StartProcessResponse? startProcessResponse;

  bool isUsernameValid = true;
  TextEditingController usernameController = TextEditingController();

  final List<MenuData> mobileBankServices = AppUtil.getMobileBankServices();
  final List<MenuData> internetBankServices = AppUtil.getInternetBankServices();

  AppState get state => _state.value;

  set state(AppState v) => _state.value = v;

  AppState get modernBankingState => _modernBankingState.value;

  set modernBankingState(AppState v) => _modernBankingState.value = v;

  AppState get changePasswordState => _changePasswordState.value;

  set changePasswordState(AppState v) => _changePasswordState.value = v;

  List<MenuItemData> get virtualBranchMenuItemList => _virtualBranchMenuItemList;

  set virtualBranchMenuItemList(List<MenuItemData> v) => _virtualBranchMenuItemList.value = v;

  @override
  Future<void> onInit() async {
    getMenuItemList();
    getCustomerInfoRequest(clearServerCache: true);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves customer information from the server and handles the response.
  void getCustomerInfoRequest({required bool clearServerCache}) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    state = AppLoading();

    final CustomerInfoRequest customerInfoRequest = CustomerInfoRequest(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      forceCacheUpdate: clearServerCache,
      forceInquireAddressInfo: false,
      getCustomerStartableProcesses: processDefinitions.isEmpty,
      getCustomerDeposits: true,
      getCustomerActiveCertificate: false,
    );

    AuthorizationServices.getCustomerInfo(customerInfoRequest: customerInfoRequest).then((result) async {
      switch (result) {
        case Success(value: (final CustomerInfoResponse response, int _)):
          state = AppLoaded();
          if (processDefinitions.isEmpty) {
            processDefinitions = response.processDefinitions ?? [];
          }
          _storeCustomerInfo(response);
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          state = AppError(
            message: apiException.displayMessage,
          );
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void getMenuItemList() {
    virtualBranchMenuItemList = mainController.menuDataModel.tobankServices;
    if (mainController.azkiMenu == false) {
      virtualBranchMenuItemList.removeWhere((element) => element.uuid == DataConstants.azkiService);
    }
  }

  Future<void> _storeCustomerInfo(CustomerInfoResponse customerInfoResponse) async {
    if (mainController.authInfoData != null) {
      if (customerInfoResponse.data != null) {
        mainController.destinationEKycProvider = customerInfoResponse.data!.ekycProvider ?? 0;
        if (customerInfoResponse.data!.customerNumber != null) {
          mainController.authInfoData!.customerNumber = customerInfoResponse.data!.customerNumber;
          mainController.authInfoData!.shahabCodeAcquired = customerInfoResponse.data!.shahabCodeAcquired.toString();
          if (customerInfoResponse.data!.firstName != null && customerInfoResponse.data!.lastName != null) {
            mainController.authInfoData!.firstName = customerInfoResponse.data!.firstName;
            mainController.authInfoData!.lastName = customerInfoResponse.data!.lastName;
          }
          mainController.authInfoData!.shabahangCustomerStatus = customerInfoResponse.data!.customerStatus;
          print("mjp tobank service");
          print(customerInfoResponse.data!.customerStatus);
          mainController.authInfoData!.digitalBankingCustomer = customerInfoResponse.data!.digitalBankingCustomer;
          mainController.hasDeposit = customerInfoResponse.hasDeposit;
        }
      }

      mainController.update();
      await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
    }
  }

  Future<void> handleMenuItemClick(MenuItemData menuItemData) async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.authInfoData!.virtualBranchStatus == VirtualBranchStatus.registered &&
        !mainController.shouldMigrateZoomIdToYekta) {
      if (menuItemData.isDisable!) {
        SnackBarUtil.showSnackBar(
          title: locale.announcement,
          message: menuItemData.message ?? locale.selected_service_unavailable,
        );
        return;
      }
      if (menuItemData.uuid == DataConstants.mobileBankService) {
        mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'mobile_bank'});
        _showMobileBankServicesBottomSheet();
      } else if (menuItemData.uuid == DataConstants.internetBankService) {
        mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'internet_bank'});
        _showInternetBankServicesBottomSheet();
      } else if (menuItemData.uuid == DataConstants.acceptorService) {
        mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'acceptor'});
        Get.to(() => const AcceptorScreen());
      } else if (menuItemData.uuid == DataConstants.safeBoxService) {
        mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'safe_box'});
        Get.to(() => const SafeBoxScreen());
      } else if (menuItemData.uuid == DataConstants.cbsService) {
        final bool? showIntroduction = await StorageUtil.getShowCBSIntroduction();
        mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'cbs'});
        if (showIntroduction ?? true) {
          Get.to(() => const CBSIntroductionScreen());
        } else {
          Get.to(() => const CBSScreen());
        }
      } else if (menuItemData.uuid == DataConstants.promissoryService) {
        if (menuItemData.requireDeposit! && !mainController.hasDeposit!) {
          showOpenDepositDialog();
        } else {
          _showPromissoryScreen();
        }
      } else if (menuItemData.uuid == DataConstants.militaryGuaranteeService) {
        mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'military_guarantee'});
        Get.to(() => const MilitaryGuaranteeStartScreen());
      } else if (menuItemData.uuid == DataConstants.azkiService) {
        mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'azki_loan'});
        Get.to(() => const AzkiLoanScreen());
      } else {
        SnackBarUtil.showSnackBar(
          title: locale.announcement,
          message: locale.service_coming_soon,
        );
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.digital_signature_required,
      );
    }
  }

  void _showGetCertificateDialog() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
      buildContext: Get.context!,
      message: locale.warning,
      description: locale.update_identity_information,
      positiveMessage: locale.authentication_title,
      negativeMessage:locale.close,
      positiveFunction: () async {
        Get.back();

        // No certificate found get from yekta ekyc
        await StorageUtil.setShouldUseYektaEkyc('true');
        await Get.to(() => const RegisterScreen());
      },
      negativeFunction: () {
        Get.back();
      },
    );
  }

  void _showGssToYektaDialog() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
      buildContext: Get.context!,
      message: locale.warning,
      description: locale.re_authentication_required,
      positiveMessage: locale.authentication_title,
      negativeMessage: locale.close,
      positiveFunction: () async {
        Get.back();
        await StorageUtil.setShouldUseYektaEkyc('true');

        // start authorization using yekta ekyc
        await Get.to(() => const RegisterScreen());
        await mainController.getAppEkycProvider();
        update();
      },
      negativeFunction: () {
        Get.back();
      },
    );
  }

  Future<void> _showPromissoryScreen() async {
    // Check for ekyc provider
    if (Platform.isIOS && mainController.appEKycProvider == EKycProvider.zoomId) {
      // iOS zoomid has bug
      _showGssToYektaDialog();
    } else {
      // Check for ekyc provider
      if (mainController.appEKycProvider == EKycProvider.yekta) {
        // Check for certificate
        final String? certificate = await StorageUtil.getAuthenticateCertificateModel();
        if (certificate != null) {
          mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'promissory'});
          Get.to(() => const PromissoryScreen());
        } else {
          // Dialog for updating ekyc
          _showGetCertificateDialog();
        }
      } else {
        mainController.analyticsService.logEvent(name: eventName, parameters: {'value': 'promissory'});
        Get.to(() => const PromissoryScreen());
      }
    }
  }

  Future<void> activeModernBanking(ModernBankingActivationType modernBankingActivationType) async {
    _requestActivationOfModernBankingRequest(modernBankingActivationType);
  }

  /// Requests activation of modern banking services(internet or mobile banking).
  ///
  /// This function initiates a request to activate either internet or mobile banking for the
  /// customer. It determines the appropriate process definition key based on the activation type,
  /// creates a start process request, and sends it to the BPMS service.
  Future<void> _requestActivationOfModernBankingRequest(ModernBankingActivationType modernBankingActivationType) async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    switch (modernBankingActivationType) {
      case ModernBankingActivationType.internet:
        processDefinitionKey = 'InternetBankingAccountCreationRequest';
        break;
      case ModernBankingActivationType.mobile:
        processDefinitionKey = 'MobileBankingAccountCreationRequest';
        break;
    }
    final StartProcessRequest startProcessRequest = StartProcessRequest(
      customerNumber: mainController.authInfoData!.customerNumber!,
      processDefinitionKey: processDefinitionKey,
      businessKey: '1234567890',
      trackingNumber: const Uuid().v4(),
      returnNextTasks: false,
      variables: ModernBankingStartProcessVariables(
        customerNumber: mainController.authInfoData!.customerNumber!,
      ),
    );

    modernBankingState = AppLoading();
    BPMSServices.startProcess(
      startProcessRequest: startProcessRequest,
    ).then((result) async {
      switch (result) {
        case Success(value: (final StartProcessResponse response, int _)):
          modernBankingState = AppLoaded();
          startProcessResponse = response;
          _showSuccessMessage();
        case Failure(exception: final ApiException apiException):
          final String errorMessage = apiException.displayMessage;
          modernBankingState = AppError(
            message: errorMessage,
          );
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void _showSuccessMessage() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    _closeBottomSheets();
    SnackBarUtil.showSnackBar(
      title: locale.request_success_message,
      message: locale.sms_notification_message,
    );
  }

  Future<void> _showMobileBankServicesBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
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
        child: const MobileBankServicesBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void handleMobileBankServices(MenuData virtualBranchMenuData) {
    if (virtualBranchMenuData.id == 1) {
      _showModernBankingInitBottomSheet(ModernBankingActivationType.mobile);
    } else if (virtualBranchMenuData.id == 2) {
      _showMobileBankPasswordBottomSheet();
    }
  }

  void handleInternetBankServices(MenuData virtualBranchMenuData) {
    if (virtualBranchMenuData.id == 1) {
      _showModernBankingInitBottomSheet(ModernBankingActivationType.internet);
    } else if (virtualBranchMenuData.id == 2) {
      _showInternetBankPasswordBottomSheet();
    }
  }

  Future<void> _showModernBankingInitBottomSheet(ModernBankingActivationType modernBankingActivationType) async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
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
        child: ModernBankingInitBottomSheet(
          modernBankingActivationType: modernBankingActivationType,
        ),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }

  Future<void> _showInternetBankServicesBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
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
        child: const InternetBankServicesBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> validatePasswordForm({required int subsystem}) async {
    bool isValid = true;
    if (usernameController.text.trim().isNotEmpty) {
      isUsernameValid = true;
    } else {
      isUsernameValid = false;
      isValid = false;
    }
    update();
    if (isValid) {
      _changePasswordRequest(subsystem);
    }
  }

  /// Sends a request to change the modern banking password.
  void _changePasswordRequest(int subsystem) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final ModernBankingChangePasswordRequest modernBankingChangePasswordRequest = ModernBankingChangePasswordRequest();
    modernBankingChangePasswordRequest.trackingNumber = const Uuid().v4();
    modernBankingChangePasswordRequest.customerNumber = mainController.authInfoData!.customerNumber;
    modernBankingChangePasswordRequest.subsystem = subsystem;
    modernBankingChangePasswordRequest.authenticationType = 1;
    modernBankingChangePasswordRequest.username = usernameController.text.trim();

    changePasswordState = AppLoading();

    ModernBankingServices.modernBankingPasswordChange(
      modernBankingChangePasswordRequest: modernBankingChangePasswordRequest,
    ).then((result) {
      switch (result) {
        case Success(value: _):
          changePasswordState = AppLoaded();
          _showSuccessMessage();
        case Failure(exception: final ApiException apiException):
          changePasswordState = AppError(
            message: apiException.displayMessage,
          );
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _showMobileBankPasswordBottomSheet() async {
    if (isClosed) {
      return;
    }
    usernameController = TextEditingController(text: mainController.authInfoData!.customerNumber);
    openBottomSheets++;
    await showModalBottomSheet(
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
        child: const MobileBankPasswordBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  Future<void> _showInternetBankPasswordBottomSheet() async {
    if (isClosed) {
      return;
    }
    usernameController = TextEditingController(text: mainController.authInfoData!.customerNumber);
    openBottomSheets++;
    await showModalBottomSheet(
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
        child: const InternetBankPasswordBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void showOpenDepositDialog() {
    DialogUtil.showOpenDepositDialog();
  }
}
