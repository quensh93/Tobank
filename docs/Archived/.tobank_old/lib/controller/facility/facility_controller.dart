import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '/controller/dashboard/dashboard_controller.dart';
import '/controller/main/main_controller.dart';
import '/model/common/menu_data_model.dart';
import '/ui/bpms/children_loan_procedure/children_loan/children_loan_screen.dart';
import '/ui/bpms/credit_card_facility/credit_card/credit_card_screen.dart';
import '/ui/bpms/marriage_loan_procedure/marriage_loan/marriage_loan_screen.dart';
import '/ui/bpms/rayan_card_facility/rayan_card/rayan_card_screen.dart';
import '/ui/bpms/retail_loan/retail_loan/retail_loan_screen.dart';
import '/ui/register/register_screen.dart';
import '/util/app_state.dart';
import '/util/app_util.dart';
import '/util/data_constants.dart';
import '/util/dialog_util.dart';
import '/util/enums_constants.dart';
import '/util/snack_bar_util.dart';
import '/util/storage_util.dart';
import '../../model/bpms/response/user_startable_process_response_data.dart';
import '../../model/register/request/customer_info_request_data.dart';
import '../../model/register/response/customer_info_response_data.dart';
import '../../new_structure/core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../new_structure/features/loan_payment/presentation/widgets/loan_payment_bottom_sheet/loan_payment_bottom_sheet.dart';
import '../../service/authorization_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/micro_lending_loan/micro_lending_loan_screen.dart';
import '../../ui/parsa_loan/parsa_loan/parsa_loan_screen.dart';
const String eventName = 'vb_dashboard_click_event';

class FacilityController extends GetxController {
  final MainController mainController = Get.find();
  final DashboardController dashboardController = Get.find();
  final Rx<AppState> _state = AppState().obs;
  final PageController pageController = PageController();
  MenuItemData? selectedProcess;
  List<MenuItemData> virtualBranchMenuItemList = [];
  List<ProcessDefinitionData> processDefinitions = [];

  AppState get state => _state.value;

  set state(AppState v) => _state.value = v;

  @override
  void onInit() {
    virtualBranchMenuItemList = mainController.menuDataModel.facilityServices;
    getCustomerInfoRequest(clearServerCache: true);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves customer information from the server.
  void getCustomerInfoRequest({required bool clearServerCache}) { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerInfoRequest customerInfoRequest = CustomerInfoRequest(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      forceCacheUpdate: clearServerCache,
      forceInquireAddressInfo: false,
      getCustomerStartableProcesses: processDefinitions.isEmpty,
      getCustomerDeposits: true,
      getCustomerActiveCertificate: false,
    );

    state = AppLoading();

    AuthorizationServices.getCustomerInfo(
            customerInfoRequest: customerInfoRequest)
        .then((result) async {
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

  Future<void> _storeCustomerInfo(
      CustomerInfoResponse customerInfoResponse) async {
    if (mainController.authInfoData != null) {
      if (customerInfoResponse.data != null) {
        mainController.destinationEKycProvider =
            customerInfoResponse.data!.ekycProvider ?? 0;
        if (customerInfoResponse.data!.customerNumber != null) {
          mainController.authInfoData!.customerNumber =
              customerInfoResponse.data!.customerNumber;
          mainController.authInfoData!.shahabCodeAcquired =
              customerInfoResponse.data!.shahabCodeAcquired.toString();
          if (customerInfoResponse.data!.firstName != null &&
              customerInfoResponse.data!.lastName != null) {
            mainController.authInfoData!.firstName =
                customerInfoResponse.data!.firstName;
            mainController.authInfoData!.lastName =
                customerInfoResponse.data!.lastName;
          }
          mainController.authInfoData!.shabahangCustomerStatus =
              customerInfoResponse.data!.customerStatus;
          mainController.authInfoData!.digitalBankingCustomer =
              customerInfoResponse.data!.digitalBankingCustomer;
          mainController.hasDeposit = customerInfoResponse.hasDeposit;
        }
      }

      mainController.update();
      await StorageUtil.setAuthInfoDataSecureStorage(
          mainController.authInfoData!);
    }
  }

  Future<void> handleMenuItemClick(MenuItemData menuItemData) async {
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.authInfoData!.virtualBranchStatus ==
            VirtualBranchStatus.registered &&
        !mainController.shouldMigrateZoomIdToYekta) {
      if (menuItemData.isDisable!) {
        return SnackBarUtil.showSnackBar(
          title: locale.announcement,
          message: menuItemData.message ?? locale.selected_service_unavailable,
        );
      }
      if (menuItemData.requireDeposit! && !mainController.hasDeposit!) {
        return DialogUtil.showOpenDepositDialog();
      }
      if (menuItemData.uuid == DataConstants.loanPaymentService) {
        mainController.analyticsService.logEvent(
          name: eventName,
          parameters: {'value': 'loan_payment'},
        );

        showMainBottomSheet(
            context: Get.context!,
            bottomSheetWidget: const LoanPaymentBottomSheet());
      } else if (menuItemData.uuid == DataConstants.marriageLoanService) {
        mainController.analyticsService.logEvent(
          name: eventName,
          parameters: {'value': 'marriage_loan'},
        );
        Get.to(() => const MarriageLoanProcedureScreen());
      } else if (menuItemData.uuid == DataConstants.creditCardLoanService) {
        mainController.analyticsService.logEvent(
          name: eventName,
          parameters: {'value': 'credit_card'},
        );
        Get.to(() => const CreditCardScreen());
      } else if (menuItemData.uuid == DataConstants.rayanCardService) {
        // Check for ekyc provider
        if (Platform.isIOS &&
            mainController.appEKycProvider == EKycProvider.zoomId) {
          // iOS zoomid has bug
          _showGssToYektaDialog();
        } else {
          // Check for ekyc provider
          if (mainController.appEKycProvider == EKycProvider.yekta) {
            // Check for certificate
            final String? certificate =
                await StorageUtil.getAuthenticateCertificateModel();
            if (certificate != null) {
              mainController.analyticsService.logEvent(
                name: eventName,
                parameters: {'value': 'rayan_card'},
              );
              Get.to(() => const RayanCardScreen());
            } else {
              // Dialog for updating ekyc
              _showGetCertificateDialog();
            }
          } else {
            mainController.analyticsService.logEvent(
              name: eventName,
              parameters: {'value': 'rayan_card'},
            );
            Get.to(() => const RayanCardScreen());
          }
        }
      } else if (menuItemData.uuid == DataConstants.childrenLoanService) {
        mainController.analyticsService.logEvent(
          name: eventName,
          parameters: {'value': 'children_loan'},
        );
        Get.to(() => const ChildrenLoanProcedureScreen());
      } else if (menuItemData.uuid == DataConstants.retailLoanService) {
        // Check for ekyc provider
        if (Platform.isIOS &&
            mainController.appEKycProvider == EKycProvider.zoomId) {
          // iOS zoomid has bug
          _showGssToYektaDialog();
        } else {
          // Check for ekyc provider
          if (mainController.appEKycProvider == EKycProvider.yekta) {
            // Check for certificate
            final String? certificate =
                await StorageUtil.getAuthenticateCertificateModel();
            if (certificate != null) {
              mainController.analyticsService.logEvent(
                name: eventName,
                parameters: {'value': 'retail_loan'},
              );
              Get.to(() => const RetailLoanScreen());
            } else {
              // Dialog for updating ekyc
              _showGetCertificateDialog();
            }
          } else {
            mainController.analyticsService.logEvent(
              name: eventName,
              parameters: {'value': 'retail_loan'},
            );
            Get.to(() => const RetailLoanScreen());
          }
        }
      } else if (menuItemData.uuid ==
          DataConstants.tobankMicroLendingLoanService) {
        // Check for ekyc provider
        if (Platform.isIOS &&
            mainController.appEKycProvider == EKycProvider.zoomId) {
          // iOS zoomid has bug
          _showGssToYektaDialog();
        } else {
          // Check for ekyc provider
          if (mainController.appEKycProvider == EKycProvider.yekta) {
            // Check for certificate
            final String? certificate =
                await StorageUtil.getAuthenticateCertificateModel();
            if (certificate != null) {
              mainController.analyticsService.logEvent(
                name: eventName,
                parameters: {'value': 'micro_lending_loan'},
              );
              Get.to(() => const MicroLendingLoanScreen());
            } else {
              // Dialog for updating ekyc
              _showGetCertificateDialog();
            }
          } else {
            mainController.analyticsService.logEvent(
              name: eventName,
              parameters: {'value': 'micro_lending_loan'},
            );
            Get.to(() => const MicroLendingLoanScreen());
          }
        }
      } else if (menuItemData.uuid == DataConstants.parsaLoanService) {
        // Check for ekyc provider
        if (Platform.isIOS &&
            mainController.appEKycProvider == EKycProvider.zoomId) {
          // iOS zoomid has bug
          _showGssToYektaDialog();
        } else {
          // Check for ekyc provider
          if (mainController.appEKycProvider == EKycProvider.yekta) {
            // Check for certificate
            final String? certificate =
                await StorageUtil.getAuthenticateCertificateModel();
            if (certificate != null) {
              mainController.analyticsService.logEvent(
                name: eventName,
                parameters: {'value': 'parsa_loan'},
              );
              Get.to(() => const ParsaLoanScreen());
            } else {
              // Dialog for updating ekyc
              _showGetCertificateDialog();
            }
          } else {
            mainController.analyticsService.logEvent(
              name: eventName,
              parameters: {'value': 'parsa_loan'},
            );
            Get.to(() => const ParsaLoanScreen());
          }
        }
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
      },
      negativeFunction: () {
        Get.back();
      },
    );
  }
}
