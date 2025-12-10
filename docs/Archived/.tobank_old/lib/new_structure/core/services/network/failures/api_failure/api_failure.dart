// lib/new_structure/core/services/network/failures/api_failure/api_failure.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_failure.freezed.dart';

@freezed
class ApiFailure with _$ApiFailure {
  const ApiFailure._();

  const factory ApiFailure.generic({
    required String message,
    String? apiMessage,
    Map<String, dynamic>? response,
  }) = GenericApiFailure;

  const factory ApiFailure.invalidToken({
    @Default('Given token not valid for any token type') String message,
    String? apiMessage,
    Map<String, dynamic>? response,
  }) = InvalidTokenFailure;

  String get message => when(
    generic: (message, _, __) => message,
    invalidToken: (message, _, __) => message,
  );

  String? get apiMessage => when(
    generic: (_, apiMessage, __) => apiMessage,
    invalidToken: (_, apiMessage, __) => apiMessage,
  );
}