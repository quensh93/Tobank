// lib/new_structure/core/services/network/failures/api_failure/api_failure_factory.dart
import 'package:injectable/injectable.dart';

import 'api_failure.dart';

@lazySingleton
class ApiFailureFactory {
  ApiFailure createFailure({
    required String message,
    required Map<String, dynamic>? response,
  }) {
    if (message == const InvalidTokenFailure().message) {
      return InvalidTokenFailure(
        apiMessage: message,
        response: response,
      );
    }

    return GenericApiFailure(
      message: message,
      apiMessage: message,
      response: response,
    );
  }
}