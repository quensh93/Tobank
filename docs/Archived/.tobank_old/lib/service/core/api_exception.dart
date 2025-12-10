import 'api_error_response_model.dart';
import 'api_exception_type.dart';

class ApiException<R extends ApiErrorResponseModel> implements Exception {
  final ApiExceptionType type;
  final int? statusCode;
  final String displayMessage;
  final int displayCode;
  R? errorResponse;

  ApiException({
    required this.type,
    required this.statusCode,
    required this.displayMessage,
    required this.displayCode,
    this.errorResponse,
  });
}
