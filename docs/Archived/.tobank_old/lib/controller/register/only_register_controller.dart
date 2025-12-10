import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/encryption_key_pair.dart';
import '../../model/register/request/authorized_api_token_request_data.dart';
import '../../model/register/request/registration_request_data.dart';
import '../../model/register/response/authorized_api_token_response_data.dart';
import '../../model/register/response/get_jobs_list_response_data.dart';
import '../../model/register/response/registration_response_data.dart';
import '../../service/authorization_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/register/select_job_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class OnlyRegisterController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  bool isLoading = false;
  bool hasError = false;
  String errorText = '';

  AuthorizedApiTokenResponse? authorizedApiTokenResponse;

  TextEditingController referrerLoyaltyCodeController = TextEditingController();

  TextEditingController jobDescriptionController = TextEditingController();

  GetJobsListResponse? getJobsListResponse;

  JobModel? selectedJob;

  bool isJobValid = true;
  bool isJobDescriptionValid = true;

  bool isRegistrationLoading = false;

  int openBottomSheets = 0;

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    final NavigatorState navigator = Navigator.of(Get.context!);
    navigator.pop();
  }

  /// Retrieves a list of jobs and updates the UI accordingly.
  Future<void> _getJobsListRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    AuthorizationServices.getJobsList().then((result) async {
      isLoading = false;
      update();
      switch (result) {
        case Success(value: (final GetJobsListResponse response, int _)):
          getJobsListResponse = response;
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

  void setSelectedJob(JobModel value) {
    selectedJob = value;
    update();
    Get.back();
  }

  void validateRegistrationPage() {
    print("⭕");
    print("⭕ validateRegistrationPage");
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
    update();

    if (isValid) {
      _checkPreRegistration();
    }
  }

  /// Checks for existing pre-registration data
  /// and initiates registration or pre-registration.
  Future<void> _checkPreRegistration() async {

    // Get from storage if authorizedApiTokenResponse is null
    authorizedApiTokenResponse ??= await StorageUtil.getEkycPreRegistrationModel();

    // Check token is expired
    if (authorizedApiTokenResponse != null &&
        authorizedApiTokenResponse!.data!.tokenExpiryDate! < DateTime.now().millisecondsSinceEpoch) {
      authorizedApiTokenResponse = null;
      await StorageUtil.removeEkycPreRegistrationModel();
    }

    if (authorizedApiTokenResponse == null) {
      _runPreRegisterRequest();
    } else {
      _registerCustomerRequest();
    }
  }

  /// Sends a pre-registration request to the `AuthorizationServices`
  /// and handles the response. If the request is successful, it stores the
  /// pre-registration data, updates the authentication information, and proceeds
  /// with customer registration using [_registerCustomerRequest]
  void _runPreRegisterRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final AuthorizedApiTokenRequest authorizedApiTokenRequest = AuthorizedApiTokenRequest();
    authorizedApiTokenRequest.nationalCode = mainController.authInfoData!.nationalCode;
    authorizedApiTokenRequest.birthDate = mainController.authInfoData!.birthdayDate!.replaceAll('/', '-');
    authorizedApiTokenRequest.trackingNumber = const Uuid().v4();

    isLoading = true;
    update();

    AuthorizationServices.getAuthorizedApiToken(
      authorizedApiTokenRequest: authorizedApiTokenRequest,
    ).then((result) async {
      isLoading = false;
      isRegistrationLoading = false;
      update();
      switch (result) {
        case Success(value: (final AuthorizedApiTokenResponse response, int _)):
          authorizedApiTokenResponse = response;
          mainController.authInfoData!.digitalBankingCustomer =
              authorizedApiTokenResponse!.data!.digitalBankingCustomer;
          mainController.update();
          await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
          await StorageUtil.setEkycPreRegistrationModel(response);
          _registerCustomerRequest();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  /// Sends a customer registration request and handles the response.
  Future<void> _registerCustomerRequest() async { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String? referrerLoyaltyCode =
        referrerLoyaltyCodeController.text.isNotEmpty ? referrerLoyaltyCodeController.text : null;

    final EncryptionKeyPair keyPair = await AppUtil.generateRSAKeyPair();
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

    update();

    AuthorizationServices.registerCustomer(
      registrationRequest: registrationRequest,
    ).then((result) async {
      isRegistrationLoading = false;
      update();
      switch (result) {
        case Success(value: (final RegistrationResponse response, int _)):
          await _handleResponse(response);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  Future<void> _handleResponse(RegistrationResponse response) async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    mainController.authInfoData!.virtualBranchStatus = VirtualBranchStatus.registered;
    mainController.authInfoData!.shahabCodeAcquired = response.data!.shahabCodeAcquired.toString();
    mainController.authInfoData!.customerNumber = response.data!.customerNumber;
    mainController.authInfoData!.firstName = response.data!.firstName;
    mainController.authInfoData!.lastName = response.data!.lastName;
    mainController.update();
    await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
    update();
    Get.back();
    Timer(Constants.duration200, () {
      SnackBarUtil.showSnackBar(
        title: locale.announcement,
        message: locale.authentication_successful,
      );
    });
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
