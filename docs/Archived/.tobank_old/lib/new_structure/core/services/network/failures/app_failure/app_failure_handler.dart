import 'package:injectable/injectable.dart';

import '../api_failure/api_failure_handler.dart';
import 'app_failure.dart';
import 'app_failure_factory.dart';

@lazySingleton
class AppFailureHandler {
  final AppFailureFactory appFailureFactory;
  final ApiFailureHandler apiFailureHandler;

  AppFailureHandler(this.appFailureFactory, this.apiFailureHandler);

  AppFailure handleResponse(Map<String, dynamic> response, int? statusCode) {
    if (statusCode == null) {
      return const AppFailure.checkInternetFailure();
    }

    if (statusCode >= 200 && statusCode < 300) {
      throw Exception('Handle successful response in caller');
    }

    final appFailure = appFailureFactory.createFromStatusCode(
      statusCode: statusCode,
      errorData: response,
    );

    if (appFailure is ApiDetailedFailure || appFailure is UnhandledStatusCodeFailure) {
      final apiFailure = apiFailureHandler.handleErrorResponse(response);
      return AppFailure.apiFailureService(type: apiFailure);
    }

    return appFailure;
  }
}