import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../controller/authentication/authentication_extension/address_verification_flow_methods.dart';
import '../../controller/authentication/authentication_extension/otp_verification_flow_methods.dart';
import '../../controller/authentication/authentication_register_controller.dart';
import '../../controller/dashboard/home_controller.dart';
import '../../controller/main/main_controller.dart' show MainController;
import '../../controller/register/register_controller.dart';
import '../../controller/sign_up/sign_up_controller.dart';
import '../../model/authentication/kyc/request/get_address_info_request_data.dart';
import '../../model/authentication/kyc/request/register_signature_image_request_data.dart';
import '../../model/authentication/kyc/request/upload_national_id_back_image_request_data.dart';
import '../../model/authentication/kyc/request/upload_national_id_front_image_request_data.dart'
    show UploadNationalIdFrontImageRequestData;
import '../../model/authentication/kyc/request/verify_person_image_request_data.dart';
import '../../model/authentication/kyc/response/register_signature_image_response_data.dart'
    show RegisterSignatureImageResponseData;
import '../../model/authentication/kyc/response/upload_national_id_back_image_response_data.dart';
import '../../model/authentication/kyc/response/upload_national_id_front_image_response_data.dart';
import '../../model/register/response/get_jobs_list_response_data.dart'
    show JobModel;
import '../../service/authentication/kyc_services.dart';
import '../../service/core/api_exception.dart' show ApiException;
import '../../service/core/api_result_model.dart'
    show ApiResult, Failure, Success;
import '../../ui/dashboard_screen/dashboard_screen.dart';
import '../log_util.dart';
import 'automation_controller.dart';

/// A simple service exposing each auth‐automation step as its own static method.
class AutomateAuth {
  // 1. private constructor
  AutomateAuth._internal();

  static AutomationController authController = Get.find<AutomationController>();

  // 2. the one and only instance
  static final AutomateAuth _instance = AutomateAuth._internal();

  // 3. factory returns the same instance
  factory AutomateAuth() => _instance;

  static final RxInt _currentStep = 0.obs;
  static final RxBool _isCancelled = false.obs;
  static const int _totalSteps = 17; // Update if you add steps.

  /// Accessors for UI and controllers.
  static int get currentStep => _currentStep.value;

  static int get totalSteps => _totalSteps;

  static bool get isCancelled => _isCancelled.value;

  /// Cancel automation (UI disables controls, APIs stop progressing)
  static void stopAutomation() {
    _isCancelled.value = true;
    Get.find<AutomationController>().requestStop(); // Sync with controller
    debugPrint('🚦 AutomateAuth: Automation cancelled!');
  }

  /// Reset/cooldown all automation state, progress and step.
  static void resetAutomation() {
    _isCancelled.value = false;
    authController.isRunningAll.value = false;
    _currentStep.value = 0;
    debugPrint('🔄 AutomateAuth: Automation reset!');
  }

  static void beginAutomation() {
    resetAutomation();
    // Optionally, initialize form/controllers state here
    debugPrint('🚀 AutomateAuth: BEGIN automation process');
  }

  /// Increment currentStep after successful completion
  static void nextStep() {
    if (_currentStep.value < _totalSteps) {
      _currentStep.value++;
      debugPrint(
          '👉 AutomateAuth: Step +1. Current step: ${_currentStep.value}');
    }
  }

  static void setStep(int stepIndex) {
    if (stepIndex < 0 || stepIndex > _totalSteps) return;
    _currentStep.value = stepIndex;
  }

  static void finishAutomation() {
    _currentStep.value = _totalSteps;
    debugPrint('✅ AutomateAuth: Automation completed!');
  }

  static SignUpController get _ctrl {
    try {
      return Get.find<SignUpController>();
    } catch (_) {
      return Get.put(SignUpController());
    }
  }

  static RegisterController get _registerController {
    try {
      return Get.find<RegisterController>();
    } catch (_) {
      return Get.put(RegisterController(), permanent: true);
    }
  }

  static AuthenticationRegisterController
      get _AuthenticationRegisterController {
    try {
      return Get.find<AuthenticationRegisterController>();
    } catch (_) {
      return Get.put(AuthenticationRegisterController());
    }
  }

  static MainController get _mainController {
    try {
      return Get.find<MainController>();
    } catch (_) {
      return Get.put(MainController(), permanent: true);
    }
  }

  static HomeController get _homeController {
    try {
      return Get.find<HomeController>();
    } catch (_) {
      return Get.put(HomeController(), permanent: true);
    }
  }

  static ApiLogService get _logService {
    try {
      return Get.find<ApiLogService>();
    } catch (_) {
      return Get.put(ApiLogService());
    }
  }

  /// STEP 1: Fill in the test data into your form fields.
  static Future<void> fillTestData() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 1: fillTestData – START');
    try {
      final c = _ctrl;
      c.phoneNumberController.text =
          authController.selectedUser.value.phoneNumber;
      c.nationalCodeController.text =
          authController.selectedUser.value.nationalCode;
      c.dateController.text = authController.selectedUser.value.birthdate;
      debugPrint('🤖 [AutomateAuth] STEP 1: fillTestData – SUCCESS');
      nextStep();
    } catch (e) {
      debugPrint('🤖 [AutomateAuth] STEP 1: fillTestData – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 2: Fire off the OTP request.
  static Future<void> callOtpRequest() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 2: callOtpRequest – START');
    try {
      final c = _ctrl;
      final bool isDone = await c.getVerifyCodeRequest(needUpdate: false);
      print("⭕");
      print(isDone);
      if (!isDone) {
        throw (Exception("FAILED"));
      }
      debugPrint('🤖 [AutomateAuth] STEP 2: callOtpRequest – SUCCESS');
      nextStep();
    } catch (e) {
      debugPrint('🤖 [AutomateAuth] STEP 2: callOtpRequest – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 3: Show a dialog for the user to enter the OTP they just received.
  static Future<String?> showOtpDialog(BuildContext context) async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 3: showOtpDialog – START');
    try {
      final code = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (_) => _CodeInputDialog(),
      );

      if (code != null && code.trim().isNotEmpty) {
        _ctrl.codeController.text = code.trim();
        debugPrint('🤖 [AutomateAuth] STEP 3: showOtpDialog – SUCCESS ($code)');
        nextStep();
        return code.trim();
      } else {
        debugPrint('🤖 [AutomateAuth] STEP 3: showOtpDialog – CANCELLED/EMPTY');
        return null;
      }
    } catch (e) {
      debugPrint('🤖 [AutomateAuth] STEP 3: showOtpDialog – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 4: Submit whatever is currently in codeController to your backend.
  static Future<void> submitOtp() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 4: submitOtp – START');
    try {
      final bool isDone = await _ctrl.submitVerifyCode(needUpdate: false);
      if (!isDone) {
        throw (Exception("FAILED"));
      }
      debugPrint('🤖 [AutomateAuth] STEP 4: submitOtp – SUCCESS');
      nextStep();
    } catch (e) {
      debugPrint('🤖 [AutomateAuth] STEP 4: submitOtp – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 5: Fill in the password (and confirm) so you can finish signup.
  static Future<void> setPassword() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 5: setPassword – START');
    try {
      final bool success = await _ctrl.setPassword(
          authController.selectedUser.value.userPassword,
          needUpdate: false);
      if (success) {
        _logService.clearLogHistory();
        debugPrint('🤖 [AutomateAuth] STEP 5: setPassword – SUCCESS');
        nextStep();
      } else {
        debugPrint(
            '🤖 [AutomateAuth] STEP 5: setPassword – FAILED: setPassword returned false');
        throw Exception('setPassword failed'); // Or a more specific exception
      }
    } catch (e) {
      debugPrint('🤖 [AutomateAuth] STEP 5: setPassword – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 6: preRegisterRequest
  static Future<void> preRegisterRequest() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 6: preRegisterRequest – START');
    try {
      final bool isDone =
          await _registerController.preRegisterRequest(needUpdate: false);
      if (isDone) {
        debugPrint('🤖 [AutomateAuth] STEP 6: preRegisterRequest – SUCCESS');
        nextStep();
      } else {
        debugPrint(
            '🤖 [AutomateAuth] STEP 6: preRegisterRequest – FAILED: preRegisterRequest returned false');
        throw Exception('preRegisterRequest failed'); // Throw an exception
      }
    } catch (e) {
      debugPrint('🤖 [AutomateAuth] STEP 6: preRegisterRequest – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 7: get EKYS OTP
  static Future<void> getEkysOtp() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 7: getEkysOtp – START');
    try {
      final bool isDone =
          await _AuthenticationRegisterController.validateMobileNumber();
      if (!isDone) {
        throw Exception('validateMobileNumber failed');
      }
      debugPrint('🤖 [AutomateAuth] STEP 7: getEkysOtp – SUCCESS');
      nextStep();
    } catch (e) {
      debugPrint('🤖 [AutomateAuth] STEP 7: getEkysOtp – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 8: Show a dialog for the user to enter the EKYC OTP.
  static Future<String?> showOtpForEkysDialog(BuildContext context) async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 8: showOtpForEkysDialog – START');
    try {
      final code = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (_) => _CodeInputDialog(),
      );

      if (code != null && code.trim().isNotEmpty) {
        _AuthenticationRegisterController.otpTextController.text = code.trim();
        debugPrint(
            '🤖 [AutomateAuth] STEP 8: showOtpForEkysDialog – SUCCESS ($code)');
        nextStep();
        return code.trim();
      } else {
        debugPrint(
            '🤖 [AutomateAuth] STEP 8: showOtpForEkysDialog – CANCELLED/EMPTY');
        return null;
      }
    } catch (e) {
      debugPrint('🤖 [AutomateAuth] STEP 8: showOtpForEkysDialog – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 9: Submit EKYC OTP
  static Future<void> submitEkycOtp() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 9: submitEkycOtp – START');
    try {
      final bool isDone = await _AuthenticationRegisterController.verifyOtp();
      if (!isDone) {
        throw Exception('verifyOtp failed');
      }
      debugPrint('🤖 [AutomateAuth] STEP 9: submitEkycOtp – SUCCESS');
      nextStep();
    } catch (e) {
      debugPrint('🤖 [AutomateAuth] STEP 9: submitEkycOtp – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 10: upload NationalCode Front image
  static Future<void> uploadNationalCodeFront() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 10: uploadNationalCodeFront – START');
    try {
      final uploadRequest = UploadNationalIdFrontImageRequestData(
        trackingNumber: const Uuid().v4(),
        nationalCode: _mainController.authInfoData!.nationalCode!,
        nationalIdFrontImage:
            authController.selectedUser.value.nationCardFrontImage,
        deviceId: _mainController.authInfoData!.ekycDeviceId!,
      );

      final ApiResult<(UploadNationalIdFrontImageResponseData, int),
          ApiException> result = await KycServices.uploadNationalCodeFront(
        uploadNationalIdFrontImageRequestData: uploadRequest,
      );

      switch (result) {
        case Success(
            value: (
              final UploadNationalIdFrontImageResponseData response,
              final int statusCode
            )
          ):
          // Handle successful response
          debugPrint(
              '🤖 [AutomateAuth] STEP 10: uploadNationalCodeFront – SUCCESS: Response = $response, Status Code = $statusCode');
          nextStep();
          break;
        case Failure(exception: final ApiException apiException):
          // Handle API exception
          debugPrint(
              '🤖 [AutomateAuth] STEP 10: uploadNationalCodeFront – API FAILED: ${apiException.displayCode} - ${apiException.displayMessage}');
          throw apiException; // Re-throw the exception
      }

      debugPrint(
          '🤖 [AutomateAuth] STEP 10: uploadNationalCodeFront – COMPLETE');
    } catch (e) {
      debugPrint(
          '🤖 [AutomateAuth] STEP 10: uploadNationalCodeFront – GENERAL FAILED: $e');
      rethrow;
    }
  }

  /// STEP 11: upload NationalCode Back image
  static Future<void> uploadNationalCodeBack() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 11: uploadNationalCodeBack – START');
    try {
      final uploadRequest = UploadNationalIdBackImageRequestData(
        trackingNumber: const Uuid().v4(),
        nationalCode: _mainController.authInfoData!.nationalCode!,
        nationalIdBackImage:
            authController.selectedUser.value.nationalCardBackImage,
        deviceId: _mainController.authInfoData!.ekycDeviceId!,
      );

      final ApiResult<(UploadNationalIdBackImageResponseData, int),
          ApiException> result = await KycServices.uploadNationalCodeBack(
        uploadNationalIdBackImageRequestData: uploadRequest,
      );

      switch (result) {
        case Success(
            value: (
              final UploadNationalIdBackImageResponseData response,
              final int statusCode
            )
          ):
          // Handle successful response
          debugPrint(
              '🤖 [AutomateAuth] STEP 11: uploadNationalCodeBack – SUCCESS: Response = $response, Status Code = $statusCode');
          nextStep();
          break;
        case Failure(exception: final ApiException apiException):
          // Handle API exception
          debugPrint(
              '🤖 [AutomateAuth] STEP 11: uploadNationalCodeBack – API FAILED: ${apiException.displayCode} - ${apiException.displayMessage}');
          throw apiException; // Re-throw the exception
      }

      debugPrint(
          '🤖 [AutomateAuth] STEP 11: uploadNationalCodeBack – COMPLETE');
    } catch (e) {
      debugPrint(
          '🤖 [AutomateAuth] STEP 11: uploadNationalCodeBack – GENERAL FAILED: $e');
      rethrow;
    }
  }

  /// STEP 12: verify Personal Image Request
  static Future<void> verifyPersonalImageRequest() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 12: verifyPersonalImageRequest – START');
    try {
      final verifyPersonImageRequestData = VerifyPersonImageRequestData(
        trackingNumber: const Uuid().v4(),
        nationalCode: _mainController.authInfoData!.nationalCode!,
        nationalIdSerial: authController.selectedUser.value.nationalIdSerial,
        personImage: authController.selectedUser.value.personalImage,
        personVideo: authController.selectedUser.value.personalVideo,
        deviceId: _mainController.authInfoData!.ekycDeviceId!,
      );

      final result = await KycServices.verifyPersonImage(
        verifyPersonImageRequestData: verifyPersonImageRequestData,
      );

      switch (result) {
        case Success(value: (_, 200)):
          debugPrint(
              '🤖 [AutomateAuth] STEP 12: verifyPersonalImageRequest – COMPLETE');
          nextStep();
        case Success(value: (_, 421)):
        //
        case Success(value: _):
          break;
        case Failure(exception: final ApiException apiException):
          throw apiException;
      }
    } catch (e) {
      debugPrint(
          '🤖 [AutomateAuth] STEP 12: verifyPersonalImageRequest – GENERAL FAILED: $e');
      rethrow;
    }
  }

  /// STEP 13: verify User address request
  static Future<void> getAddressInfoRequest() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 13: getAddressInfoRequest – START');
    try {
      final req = GetAddressInfoRequestData(
        trackingNumber: const Uuid().v4(),
        nationalCode: _mainController.authInfoData!.nationalCode!,
        postalCode: authController.selectedUser.value.postalCode,
        declaredAddress: authController.selectedUser.value.declaredAddress,
        deviceId: _mainController.authInfoData!.ekycDeviceId!,
      );

      final result = await KycServices.getAddressInfo(
        getAddressInfoRequestData: req,
      );

      switch (result) {
        case Success(value: (_, 200)):
          debugPrint(
              '🤖 [AutomateAuth] STEP 13: getAddressInfoRequest – COMPLETE');
          nextStep();
        case Success(value: (_, 421)):
        //
        case Success(value: _):
          break;
        case Failure(exception: final ApiException apiException):
          throw apiException;
      }
    } catch (e) {
      debugPrint(
          '🤖 [AutomateAuth] STEP 13: getAddressInfoRequest – GENERAL FAILED: $e');
      rethrow;
    }
  }

  /// STEP 14: register Signature Image
  static Future<void> registerSignatureImage() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 14: registerSignatureImage – START');
    try {
      final req = RegisterSignatureImageRequestData(
        trackingNumber: const Uuid().v4(),
        nationalCode: _mainController.authInfoData!.nationalCode!,
        personSignatureImage:
            authController.selectedUser.value.personalSignatureImage,
        deviceId: _mainController.authInfoData!.ekycDeviceId!,
      );

      final ApiResult<(RegisterSignatureImageResponseData, int), ApiException>
          result = await KycServices.registerSignatureImage(
        registerSignatureImageRequestData: req,
      );

      switch (result) {
        case Success(
            value: (
              final RegisterSignatureImageResponseData response,
              final int statusCode
            )
          ):
          // Handle successful response
          debugPrint(
              '🤖 [AutomateAuth] STEP 14: registerSignatureImage – SUCCESS: Status Code = $statusCode, Response = $response');
          nextStep();
          break;
        case Failure(exception: final ApiException apiException):
          // Handle API exception
          debugPrint(
              '🤖 [AutomateAuth] STEP 14: registerSignatureImage – API FAILED: ${apiException.displayCode} - ${apiException.displayMessage}');
          throw apiException; // Re-throw the exception to be caught in the outer catch block
      }

      debugPrint(
          '🤖 [AutomateAuth] STEP 14: registerSignatureImage – COMPLETE'); //Move this out of Try, so it always triggers after success or error
    } catch (e) {
      debugPrint(
          '🤖 [AutomateAuth] STEP 14: registerSignatureImage – GENERAL FAILED: $e');
      rethrow;
    }
  }

  /// STEP 15: validate user form data
  static Future<void> validateUserFormData() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 15: validateUserFormData – START');
    try {
      _AuthenticationRegisterController.englishNameEditingController.text =
          authController.selectedUser.value.globalFirstName;
      _AuthenticationRegisterController.englishFamilyTextEditingController
          .text = authController.selectedUser.value.globalLastName;
      _AuthenticationRegisterController.emailEditingController.text =
          authController.selectedUser.value.email;
      _AuthenticationRegisterController.homePhoneNumberTextEditingController
          .text = authController.selectedUser.value.landLineNumber;

      final bool isDone = await _AuthenticationRegisterController.validateFrom(
          needUpdate: false);

      if (!isDone) {
        throw Exception('validateFrom failed');
      }

      debugPrint('🤖 [AutomateAuth] STEP 15: validateUserFormData – SUCCESS');
      nextStep();
    } catch (e) {
      debugPrint(
          '🤖 [AutomateAuth] STEP 15: validateUserFormData – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 16 : register user
  static Future<void> validateRegistration() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 16: validateRegistration – START');
    try {
      _registerController.setSelectedJob(
        JobModel(jobType: "3"),
        needUpdate: false,
      );
      final bool isDone =
          await _registerController.validateRegistrationPage(needUpdate: false);
      if (!isDone) {
        throw Exception('validateRegistrationPage failed');
      }
      debugPrint('🤖 [AutomateAuth] STEP 16: validateRegistration – SUCCESS');
      nextStep();
    } catch (e) {
      debugPrint(
          '🤖 [AutomateAuth] STEP 16: validateRegistration – FAILED: $e');
      rethrow;
    }
  }

  /// STEP 17 : get Customer Info Request
  static Future<void> getCustomerInfoRequest() async {
    if (isCancelled) throw Exception('Automation cancelled!');
    debugPrint('🤖 [AutomateAuth] STEP 17: getCustomerInfoRequest – START');
    try {
      final bool isDone = await _homeController.getCustomerInfoRequest();
      _homeController.update();

      if (!isDone) {
        throw Exception('getCustomerInfoRequest failed');
      }

      debugPrint('🤖 [AutomateAuth] STEP 17: getCustomerInfoRequest – SUCCESS');
      finishAutomation();
      Get.offAll(DashboardScreen());
    } catch (e) {
      debugPrint(
          '🤖 [AutomateAuth] STEP 17: getCustomerInfoRequest – FAILED: $e');
      rethrow;
    }
  }
}

/// A little dialog widget for OTP entry.
class _CodeInputDialog extends StatefulWidget {
  @override
  State<_CodeInputDialog> createState() => _CodeInputDialogState();
}

class _CodeInputDialogState extends State<_CodeInputDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('OTP'),
      content: TextField(
        controller: _controller,
        maxLength: 6,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Enter Code',
          errorText: _showError ? 'Can\'t be empty' : null,
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            debugPrint('🤖 [_CodeInputDialog] User cancelled OTP dialog');
            Navigator.of(context).pop(null);
          },
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {
            if (_controller.text.trim().isEmpty) {
              setState(() => _showError = true);
            } else {
              debugPrint(
                  '🤖 [_CodeInputDialog] User entered code: ${_controller.text.trim()}');
              Navigator.of(context).pop(_controller.text.trim());
            }
          },
        ),
      ],
    );
  }
}
