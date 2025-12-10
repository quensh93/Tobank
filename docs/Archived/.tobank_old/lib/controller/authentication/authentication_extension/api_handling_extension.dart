import 'dart:async';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../service/core/api_core.dart';
import '../../../util/snack_bar_util.dart';
import '../authentication_extension/authentication_status_flow_methods.dart';
import '../authentication_register_controller.dart';

extension ApiHandlingExtension on AuthenticationRegisterController {
  /// Handles API errors uniformly across the application
  void handleApiErrorGlobal(ApiException apiException) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    print('🌐 Handling API error: ${apiException.type}');

    switch (apiException.type) {
      case ApiExceptionType.connectionTimeout:
        checkEkycStatusTimeout();
        break;
      default:
        SnackBarUtil.showSnackBar(
          title: locale.show_error(apiException.displayCode),
          message: apiException.displayMessage,
        );
    }
  }

  /// Generic handler for upload responses with proper error handling and loading state management
  Future<(bool, dynamic)> handleUploadWithResponse(Future<dynamic> Function() uploadFunc) async {
    print('🌐 Starting upload request');

    if (isLoading) {
      print('🌐 Already processing, skipping request');
      return (false, null);
    }

    isLoading = true;
    update();

    try {
      print('🌐 Executing upload function');
      final result = await uploadFunc();

      switch (result) {
        case Success(value: (final response, 200)):
          print('🌐 Upload successful');
          return (true, response);
        case Success(value: (_, 421)):
          print('🌐 Upload timeout');
          checkEkycStatusTimeout();
          return (false, null);
        case Failure(exception: final ApiException apiException):
          print('🌐 Upload failed with error');
          handleApiErrorGlobal(apiException);
          return (false, null);
        default:
          print('🌐 Upload failed with unknown error');
          return (false, null);
      }
    } finally {
      isLoading = false;
      update();
      print('🌐 Upload request completed');
    }
  }
}