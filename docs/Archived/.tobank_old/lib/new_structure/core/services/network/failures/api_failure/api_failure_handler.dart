// lib/new_structure/core/network/failures/api_failure/api_failure_handler.dart

import 'package:injectable/injectable.dart';

import 'api_failure.dart';
import 'api_failure_factory.dart';

@lazySingleton
class ApiFailureHandler {
  final ApiFailureFactory failureFactory;

  ApiFailureHandler(this.failureFactory);

  ApiFailure handleErrorResponse(Map<String, dynamic> response) {
    final message = _extractErrorMessage(response);
    return failureFactory.createFailure(
      message: message,
      response: response,
    );
  }

  String _extractErrorMessage(Map<String, dynamic> response) {
    if (response.containsKey('message')) {
      return _manageErrorValue(response['message']);
    }
    if (response.containsKey('error')) {
      return _manageErrorValue(response['error']);
    }
    if (response.containsKey('errors')) {
      return _manageErrorValue(response['errors']);
    }
    return 'Unknown error';
  }

  String _manageErrorValue(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is List && value.isNotEmpty) {
      return value.first.toString();
    } else if (value is Map) {
      if (value.keys.every((key) => key is String)) {
        return _extractErrorMessage(value.cast<String, dynamic>());
      } else {
        return 'Invalid error response: Map keys must be strings';
      }
    }
    return 'Unknown error';
  }
}