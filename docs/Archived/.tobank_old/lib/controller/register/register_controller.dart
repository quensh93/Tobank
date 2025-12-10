import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:zoom_id/zoom_id.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/encryption_key_pair.dart';
import '../../model/other/response/other_item_data.dart';
import '../../model/register/request/authorized_api_token_request_data.dart';
import '../../model/register/request/registration_request_data.dart';
import '../../model/register/response/authorized_api_token_response_data.dart';
import '../../model/register/response/get_jobs_list_response_data.dart';
import '../../model/register/response/registration_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/core/api_core.dart';
import '../../service/other_services.dart';
import '../../ui/authentication/register/authentication_register_screen.dart';
import '../../ui/register/select_job_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class RegisterController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();
  AuthorizedApiTokenResponse? authorizedApiTokenResponse;

  bool isLoading = false;

  ScrollController scrollbarController = ScrollController();

  bool isChecked = false;

  OtherItemData? otherItemData;

  String? errorTitle = '';

  bool hasError = false;

  TextEditingController referrerLoyaltyCodeController = TextEditingController();

  TextEditingController jobDescriptionController = TextEditingController();

  bool isRegistrationLoading = false;

  GetJobsListResponse? getJobsListResponse;

  JobModel? selectedJob;

  bool isJobValid = true;
  bool isJobDescriptionValid = true;

  int openBottomSheets = 0;

  /// Sends a pre-registration request to the authorization service
  /// and handles the response. If the request is successful, it stores the
  /// pre-registration data, updates the authentication information, and
  /// navigates to the next page.
  Future<bool> preRegisterRequest({bool needUpdate = true}) async { // Return Future<bool>
    final locale = AppLocalizations.of(Get.context!)!;

    try {
      final AuthorizedApiTokenRequest authorizedApiTokenRequest = AuthorizedApiTokenRequest();
      authorizedApiTokenRequest.nationalCode = mainController.authInfoData!.nationalCode;
      authorizedApiTokenRequest.birthDate = mainController.authInfoData!.birthdayDate!.replaceAll('/', '-');
      authorizedApiTokenRequest.trackingNumber = const Uuid().v4();

      isLoading = true;
      update();

      final result = await AuthorizationServices.getAuthorizedApiToken( // Await the result
        authorizedApiTokenRequest: authorizedApiTokenRequest,
      );

      print("⭕ getAuthorizedApiToken");
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final AuthorizedApiTokenResponse response, int _)):
          authorizedApiTokenResponse = response;
          mainController.authInfoData!.digitalBankingCustomer =
              authorizedApiTokenResponse!.data!.digitalBankingCustomer;
          if (needUpdate) {
            mainController.update();
            update();
          }
          await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
          await StorageUtil.setEkycPreRegistrationModel(response);
          AppUtil.nextPageController(pageController, isClosed);
          return true; // Return true on success
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
          return false; // Return false on failure
      }
    } catch (e) {
      // Catch any unexpected errors
      print("Error in preRegisterRequest: $e");
      return false; // Return false if an exception occurs
    }
  }



  @override
  Future<void> onInit() async {
    super.onInit();
    getVirtualBranchRulesRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves the rules for the virtual branch.
  void getVirtualBranchRulesRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
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

  /// Retrieves a list of jobs and displays a bottom sheet for selection.
  Future<void> _getJobsListRequest() async {
    isLoading = true;
    update();

    AuthorizationServices.getJobsList().then((result) async {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final GetJobsListResponse response, int _)):
          getJobsListResponse = response;
          update();
          showSelectJobBottomSheet();
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
      }
    });
  }

  /// Runs the authorization process based on the selected EKYC provider.
  ///
  /// This function initiates the authorization process using either ZoomId or
  /// Yekta as the EKYC provider. It checks device security, determines the
  /// appropriate provider, and then calls the corresponding authorization function
  Future<void> runAuthorization() async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool result = false;

    var ekycProvider = EKycProvider.zoomId;
    if (Platform.isIOS) {
      // ZoomId iOS SDK authorization process has bug
      ekycProvider = EKycProvider.yekta;
    } else {
      final String? shouldUseYekta = await StorageUtil.getShouldUseYektaEkyc();
      if (shouldUseYekta != null && shouldUseYekta == 'true') {
        ekycProvider = EKycProvider.yekta;
      } else {
        if (mainController.destinationEKycProvider == null || mainController.destinationEKycProvider == 0) {
          ekycProvider = EKycProvider.zoomId;
        } else {
          ekycProvider = EKycProvider.yekta;
        }
      }
    }

    final bool? isDeviceSecure =kIsWeb ?  await AppUtil.isTrust() : await AppUtil.isDeviceSecure() ;
    if (isDeviceSecure == true) {
      // ZoomId
      if (ekycProvider == EKycProvider.zoomId) {
        result = await _runZoomIdAuthorization();
      } else {
        result = await _runYektaAuthorization();
      }
      if (result) {
        mainController.appEKycProvider = ekycProvider;
        mainController.authInfoData!.virtualBranchStatus = VirtualBranchStatus.enrolled;
        mainController.update();
        await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
        AppUtil.nextPageController(pageController, isClosed);
      } else {
        SnackBarUtil.showInfoSnackBar(
          locale.authentication_not_completed,
        );
      }
      AppUtil.printResponse(result.toString());
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.device_not_secured,
      );
    }
  }

  /// Initiates the ZoomId authorization process for either Android or iOS..
  Future<bool> _runZoomIdAuthorization() async {
    var result = false;
    if (Platform.isAndroid) {
      result = await ZoomId.signUp(
        license: mainController.authInfoData!.zoomIdLicenseAndroid ?? Constants.zoomIdLicense,
        phone: mainController.authInfoData!.mobile!,
        nationalId: mainController.authInfoData!.nationalCode!,
        faceAuthenticate: false,
        autoAddress: true,
        selectImageFromGallery: true,
      );
    } else {
      result = await ZoomId.singUpIos(
          license: mainController.authInfoData!.zoomIdLicenseIos ?? Constants.zoomIdLicenseIos,
          phoneNumber: mainController.authInfoData!.mobile!,
          nationalCode: mainController.authInfoData!.nationalCode!,
          pageControl: 0);
      AppUtil.setStatusBarColor(Get.isDarkMode);
    }
    return result;
  }

  /// Initiates the Yekta authorization process and navigates to the registration screen.
  Future<bool> _runYektaAuthorization() async {
    final result = await Get.to(() => const AuthenticationRegisterScreen()) ?? false;
    return result;
  }

  Future<bool> validateRegistrationPage({bool needUpdate = true}) async {
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (selectedJob != null) {
      isJobValid = true;
      if (selectedJob!.needsDescription ?? false) {
        if (jobDescriptionController.text.trim().length > 2) {
          isJobDescriptionValid = true;
        } else {
          isValid = false;
          isJobDescriptionValid = false;
        }
      } else {
        isJobDescriptionValid = true;
      }
    } else {
      isValid = false;
      isJobValid = false;
    }

    isRegistrationLoading = true;
    if(needUpdate){
      update();
    }


    if (isValid) {
      return await _registerCustomerRequest(needUpdate: needUpdate);
    }
    return false;
  }

  void setSelectedJob(JobModel value, {bool needUpdate = true}) {
    selectedJob = value;
    if(needUpdate){
      Get.back();
      update();
    }
  }

  /// Sends a customer registration request and handles the response.
  Future<bool> _registerCustomerRequest({bool needUpdate = true}) async {
    final locale = AppLocalizations.of(Get.context!)!;

    final String? referrerLoyaltyCode =
    referrerLoyaltyCodeController.text.isNotEmpty ? referrerLoyaltyCodeController.text : null;

    final EncryptionKeyPair keyPair = kIsWeb ? await AppUtil.generateRSAKeyPairWeb() : await AppUtil.generateRSAKeyPair();
    await StorageUtil.setEncryptionKeyPair(jsonEncode(keyPair));

    String publicKey = keyPair.publicKey;
    publicKey = publicKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .trim();

    final List<Job> jobs = [];
    jobs.add(Job(
      jobType: int.parse(selectedJob!.jobType!),
      description: (selectedJob!.needsDescription ?? false) ? jobDescriptionController.text.trim() : null,
    ));

    final RegistrationRequest registrationRequest = RegistrationRequest(
      nationalCode: mainController.authInfoData!.nationalCode!,
      trackingNumber: const Uuid().v4(),
      transactionId: authorizedApiTokenResponse!.data!.transactionId!,
      referrerLoyaltyCode: authorizedApiTokenResponse!.data!.digitalBankingCustomer! ? null : referrerLoyaltyCode,
      customerPublicKey: publicKey,
      jobs: jobs,
    );

    isRegistrationLoading = true;
    if (needUpdate) {
      update();
    }

    try {
      final result = await AuthorizationServices.registerCustomer(
        registrationRequest: registrationRequest,
      );

      isRegistrationLoading = false;
      if (needUpdate) {
        update();
      }

      switch (result) {
        case Success(value: (final RegistrationResponse response, int _)):
          mainController.authInfoData!.shahabCodeAcquired = response.data!.shahabCodeAcquired.toString();
          mainController.authInfoData!.customerNumber = response.data!.customerNumber;
          mainController.authInfoData!.shabahangCustomerStatus = response.data!.customerStatus;
          mainController.authInfoData!.firstName = response.data!.firstName;
          mainController.authInfoData!.lastName = response.data!.lastName;
          mainController.authInfoData!.virtualBranchStatus = VirtualBranchStatus.registered;
          mainController.update();
          await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
          if (needUpdate) {
            update();
            Get.back();
          }

          Timer(Constants.duration200, () {
            SnackBarUtil.showSnackBar(
              title: locale.announcement,
              message: locale.authentication_successful,
            );
          });
          return true; // Return true on success

        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
          return false; // Return false on failure
      }
    } catch (e) {
      isRegistrationLoading = false;
      if (needUpdate) {
        update();
      }
      print('Error during registration: $e');
      SnackBarUtil.showSnackBar(
        title: locale.error,
        message: locale.problem_in_register, // User-friendly error message
      );
      return false; // Return false on error
    }
  }

  void setChecked(bool isChecked) {
    this.isChecked = isChecked;
    update();
  }

  void validateRules() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isChecked) {
      preRegisterRequest();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.validate_terms_warning,
      );
    }
  }

  /// This function is called when the user presses the back button. It checks
  /// if the current page is one of the initial pages (0, 1, or 3) and pops
  /// the current route if so. Otherwise, it navigates to the previous page
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 || pageController.page == 1 || pageController.page == 3) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  Future<void> showSelectJobBottomSheet() async {
    if (isClosed) {
      return;
    }

    if (getJobsListResponse == null) {
      _getJobsListRequest();
    } else {
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
          child: SelectJobBottomSheet(
            jobList: getJobsListResponse!.data!,
            selectJob: (JobModel job) {
              setSelectedJob(job);
            },
          ),
        ),
      );
      openBottomSheets--;
    }
  }
}
