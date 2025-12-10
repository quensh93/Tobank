import '../../service/core/api_error_response_model.dart';

class ErrorResponsePichakData extends ApiErrorResponseModel {
  ErrorResponsePichakData({
    this.success,
    this.code,
    this.message,
    this.errors,
    this.stack,
  });

  bool? success;
  int? code;
  String? message;
  Errors? errors;
  Stack? stack;

  factory ErrorResponsePichakData.fromJson(Map<String, dynamic> json) => ErrorResponsePichakData(
        success: json['success'],
        code: json['code'],
        message: json['message'],
        errors: json['errors'] == null ? null : Errors.fromJson(json['errors']),
        stack: json['stack'] == null ? null : Stack.fromJson(json['stack']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'code': code,
        'message': message,
        'errors': errors?.toJson(),
        'stack': stack?.toJson(),
      };
}

class Errors {
  Errors({
    this.debug,
  });

  Debug? debug;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        debug: json['debug'] == null ? null : Debug.fromJson(json['debug']),
      );

  Map<String, dynamic> toJson() => {
        'debug': debug?.toJson(),
      };
}

class Debug {
  Debug({
    this.errorCode,
    this.errorDescription,
    this.referenceName,
  });

  int? errorCode;
  String? errorDescription;
  String? referenceName;

  factory Debug.fromJson(Map<String, dynamic> json) => Debug(
        errorCode: json['errorCode'],
        errorDescription: json['errorDescription'],
        referenceName: json['referenceName'],
      );

  Map<String, dynamic> toJson() => {
        'errorCode': errorCode,
        'errorDescription': errorDescription,
        'referenceName': referenceName,
      };
}

class Stack {
  Stack();

  factory Stack.fromJson(Map<String, dynamic>? json) => Stack();

  Map<String, dynamic> toJson() => {};
}
