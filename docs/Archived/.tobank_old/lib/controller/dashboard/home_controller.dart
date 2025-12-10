import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secure_plugin/secure_plugin.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/authentication_status_item_data.dart';
import '../../model/register/request/customer_info_request_data.dart';
import '../../model/register/response/customer_info_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/branch_map/branch_map_screen.dart';
import '../../ui/customer_club/customer_club_screen.dart';
import '../../ui/migrate_ekyc/migrate_ekyc_screen.dart';
import '../../ui/notification/notification_screen.dart';
import '../../ui/only_register/only_register_screen.dart';
import '../../ui/register/register_screen.dart';
import '../../ui/support/support_screen.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';
import 'dashboard_controller.dart';

class HomeController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  static const String homeEventName = 'Home_Click_Event';
  int selectedTab = 0;

  bool hasError = false;

  String errorTitle = '';

  bool isLoading = false;

  late DashboardController dashboardController;

  @override
  void onInit() {
    super.onInit();
    try {
      dashboardController = Get.find();
    } catch (e) {
      // Handle the case where DashboardController is not found
      print('DashboardController not found: $e');
      //PUT the DashboardController
      Get.put(DashboardController());
      dashboardController = Get.find(); // Set to null if not found
      // Optionally, you can show a snackbar or log an error.
    }
  }

  void showPage({required int index}) {
    selectedTab = index;
    update();
    AppUtil.gotoPageController(pageController: pageController, page: selectedTab, isClosed: isClosed);
  }

  AuthenticationStatusItemData getAuthenticationStatusItem() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String? customerNumber = mainController.authInfoData!.customerNumber;
    final bool isShahabCodeAcquired = mainController.authInfoData!.shahabCodeAcquired?.toLowerCase() == 'true';
    final bool requiredShahabCode = customerNumber != null && !isShahabCodeAcquired;

    final int? customerStatus = mainController.authInfoData!.shabahangCustomerStatus;
    if (customerStatus == 3) {
      return AuthenticationStatusItemData(
          description:
          locale.services_inactive_contact_support,
          buttonTitle: locale.check_again_,
          eventCode: 1);
    }

    if (requiredShahabCode) {
      return AuthenticationStatusItemData(
          description:
              locale.customer_definition_success_wait_for_shahab_code,
          buttonTitle: locale.check_again_,
          eventCode: 2);
    }

    // ignore: prefer_final_locals
    VirtualBranchStatus? virtualBranchStatus = mainController.authInfoData!.virtualBranchStatus;
    if (virtualBranchStatus == VirtualBranchStatus.notEnrolled) {
      return AuthenticationStatusItemData(
          description:
              locale.please_complete_authentication_to_activate_services,
          buttonTitle: locale.authentication_title,
          eventCode: 3);
    }

    if (mainController.shouldMigrateZoomIdToYekta) {
      return AuthenticationStatusItemData(
          description:
          locale.please_complete_information_update_for_services_activation,
          buttonTitle: locale.information_update,
          eventCode: 4);
    }

    if (virtualBranchStatus == VirtualBranchStatus.enrolled || customerNumber == null) {
      return AuthenticationStatusItemData(
          description:
          locale.please_define_customer_for_services_activation,
          buttonTitle: locale.define_customer,
          eventCode: 5);
    }

    if (customerStatus == 0 || customerStatus == 5) {
      return AuthenticationStatusItemData(
          description: locale.due_to_document_deficiency_process_prevented,
          buttonTitle: locale.edit_doc,
          eventCode: 6);
    }

    if (customerStatus == 2) {
      return AuthenticationStatusItemData(
          description: locale.documents_under_review_please_wait,
          buttonTitle: locale.check_again_,
          eventCode: 7);
    }

    if (customerStatus == 6) {
      return AuthenticationStatusItemData(
          description: locale.your_authentication_have_rejected,
          buttonTitle: locale.authentication_title,
          eventCode: 8);
    }

    // will not happen :)
    Sentry.captureMessage('AuthenticationStatusError', params: [
      {
        'customerNumber': customerNumber,
        'shahabCodeAcquired': mainController.authInfoData!.shahabCodeAcquired,
        'virtualBranchStatus': virtualBranchStatus.toString(),
        'appEKycProvider': mainController.appEKycProvider.toString(),
        'customerStatus': customerStatus,
      }
    ]);
    return AuthenticationStatusItemData(
      description: locale.update_in_progress,
      buttonTitle: locale.update_in_progress,
      eventCode: 9,
    );
  }

  Future<void> handleAuthenticationStatusButton({required int eventCode}) async {
    switch (eventCode) {
      // Banned
      case 1:
        getCustomerInfoRequest();
        break;
      // Shahab code
      case 2:
        getCustomerInfoRequest();
        break;
      // Not enrolled or customer number is null
      case 3:
        mainController.analyticsService.logEvent(name: homeEventName, parameters: {'value': 'register'});
        await Get.to(() => const RegisterScreen());
        await mainController.getAppEkycProvider();
        Timer(Constants.duration200, () {
          getCustomerInfoRequest();
        });
        break;
      // Migrate ZoomId to Yekta
      case 4:
        await Get.to(() => const MigrateEkycScreen());
        await mainController.getAppEkycProvider();
        Timer(Constants.duration200, () {
          getCustomerInfoRequest();
        });
        break;
      // Enrolled
      case 5:
        mainController.analyticsService.logEvent(name: homeEventName, parameters: {'value': 'only_register'});
        await Get.to(() => const OnlyRegisterScreen());
        await mainController.getAppEkycProvider();
        Timer(Constants.duration200, () {
          getCustomerInfoRequest();
        });
        break;
      // Complete customer documents
      case 6:
        final DashboardController dashboardController = Get.find();
        dashboardController.setCurrentIndex(2);
        break;
      // Documents not confirmed
      case 7:
        getCustomerInfoRequest();
        break;

      // Yekta Ekyc face detection declined
      case 8:
        // Yekta log out
        await SecurePlugin.removeKey(phoneNumber: mainController.keyAliasModelList.first.keyAlias);
        mainController.authInfoData!.ekycDeviceId = null;
        await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
        await mainController.getAppEkycProvider();

        // Run authorization again
        mainController.analyticsService.logEvent(name: homeEventName, parameters: {'value': 'register'});
        await Get.to(() => const RegisterScreen());
        await mainController.getAppEkycProvider();
        Timer(Constants.duration200, () {
          getCustomerInfoRequest();
        });
        break;

      // Should not happen :)
      case 9:
        mainController.update();
        update();
        break;
    }
  }

  /// Retrieves customer information from the server.
  Future<bool> getCustomerInfoRequest() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final CustomerInfoRequest customerInfoRequest = CustomerInfoRequest(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      forceCacheUpdate: true,
      forceInquireAddressInfo: false,
      getCustomerStartableProcesses: true,
      getCustomerDeposits: true,
      getCustomerActiveCertificate: false,
    );

    hasError = false;
    isLoading = true;
    update();

    try {
      final result = await AuthorizationServices.getCustomerInfo(customerInfoRequest: customerInfoRequest);

      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerInfoResponse response, int _)):
          hasError = false;
          update();
          _storeCustomerInfo(response);
          return true; // Return true on success

        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
          return false; // Return false on failure
      }
    } catch (e) {
      isLoading = false;
      update();
      hasError = true;
      errorTitle = locale.error_in_receive_customer_info; // User-friendly error message
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: errorTitle,
      );
      print('Error during getCustomerInfo: $e'); // Log the error
      return false; // Return false on error
    }
  }


  /// Stores customer information securely.
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
          mainController.authInfoData!.digitalBankingCustomer = customerInfoResponse.data!.digitalBankingCustomer;
          mainController.authInfoData!.loyaltyCode = customerInfoResponse.data!.loyaltyCode;
          mainController.hasDeposit = customerInfoResponse.hasDeposit;
        }
      }
      await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
      mainController.update();
      update();
    }
  }

  Future<void> showNotificationScreen() async {
    mainController.analyticsService.logEvent(name: homeEventName, parameters: {'value': 'NotificationScreen'});
    await Get.to(() => const NotificationScreen());
    // TODO: Get unread notification from server
    update();
  }

  void showSupportScreen() {
    Get.to(() => const SupportScreen());
  }

  void showSoonSnackBar() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    SnackBarUtil.showSnackBar(title: locale.announcement, message: locale.coming_soon_);
  }

  Future<void> showCustomerClubScreen() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (mainController.menuDataModel.customerClub!.isDisable == false) {
      mainController.analyticsService.logEvent(name: homeEventName, parameters: {'value': 'CustomerClubMenuScreen'});
      Get.to(() => const CustomerClubScreen());
    } else {
      SnackBarUtil.showSnackBar(
        title: locale.announcement,
        message: mainController.menuDataModel.customerClub!.message ?? locale.selected_service_unavailable,
      );
    }
  }

  int notificationCount() {
    if (mainController.walletDetailData != null) {
      return mainController.walletDetailData!.data!.unreadMessageCount!;
    } else {
      return 0;
    }
  }

  void showBranchMapScreen() {
    Get.to(() => const BranchMapScreen());
  }
}
