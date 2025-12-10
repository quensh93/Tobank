// lib/new_structure/core/network/failures/app_failure/app_failure.dart

import 'package:freezed_annotation/freezed_annotation.dart';

import '../api_failure/api_failure.dart';

part 'app_failure.freezed.dart';

@freezed
class AppFailure with _$AppFailure {
  const AppFailure._();

  const factory AppFailure.unexpectedFailure({
    required Object? error,
    @Default('Unexpected error') String displayMessage,
    @Default(2010) int displayCode,
  }) = UnexpectedFailure;

  const factory AppFailure.apiDetailedFailure({
    required String? message,
    required int? statusCode,
    required Map<String, dynamic>? errorData,
    @Default('Bad request') String displayMessage,
    @Default(3400) int displayCode,
  }) = ApiDetailedFailure;

  const factory AppFailure.modelMapFailure({
    required String message,
    @Default('Failed to decode response') String displayMessage,
    @Default(2005) int displayCode,
  }) = ModelMapFailure;

  const factory AppFailure.apiFailureService({
    required ApiFailure type,
  }) = ApiFailureService;

  const factory AppFailure.checkInternetFailure({
    @Default('No internet connection') String displayMessage,
    @Default(2004) int displayCode,
  }) = CheckInternetFailure;

  const factory AppFailure.connectionTimeoutFailure({
    @Default('Connection timeout') String displayMessage,
    @Default(2000) int displayCode,
  }) = ConnectionTimeoutFailure;

  const factory AppFailure.noConnectionFailure({
    @Default('No internet connection') String displayMessage,
    @Default(2003) int displayCode,
  }) = NoConnectionFailure;

  const factory AppFailure.responseDecodingFailure({
    @Default('Failed to decode response') String displayMessage,
    @Default(2006) int displayCode,
  }) = ResponseDecodingFailure;

  const factory AppFailure.vpnConnectedFailure({
    @Default('VPN connection detected') String displayMessage,
    @Default(2007) int displayCode,
  }) = VpnConnectedFailure;

  const factory AppFailure.deviceNotSecuredFailure({
    @Default('Device is not secured') String displayMessage,
    @Default(2010) int displayCode,
  }) = DeviceNotSecuredFailure;

  const factory AppFailure.signNotValidFailure({
    @Default('Request signing failed') String displayMessage,
    @Default(2011) int displayCode,
  }) = SignNotValidFailure;

  const factory AppFailure.unhandledStatusCodeFailure({
    required int? statusCode,
    required String message,
    required Map<String, dynamic>? errorData,
    @Default('Unhandled status code') String displayMessage,
    @Default(3000) int displayCode,
  }) = UnhandledStatusCodeFailure;

  const factory AppFailure.sslPinningFailure({
    required String message,
    @Default('SSL certificate validation failed') String displayMessage,
    @Default(2012) int displayCode,
  }) = SslPinningFailure;

// Updated app_failure.dart (relevant part)
  // lib/new_structure/core/services/network/failures/app_failure/app_failure.dart (relevant part)
  String get displayMessage => when(
    unexpectedFailure: (_, message, __) => message,
    apiDetailedFailure: (_, __, ___, message, ____) => message,
    modelMapFailure: (_, message, __) => message,
    apiFailureService: (type) => type.apiMessage ?? type.message, // Updated to handle nullable
    checkInternetFailure: (message, _) => message,
    connectionTimeoutFailure: (message, _) => message,
    noConnectionFailure: (message, _) => message,
    responseDecodingFailure: (message, _) => message,
    vpnConnectedFailure: (message, _) => message,
    deviceNotSecuredFailure: (message, _) => message,
    signNotValidFailure: (message, _) => message,
    unhandledStatusCodeFailure: (_, __, ___, message, ____) => message,
    sslPinningFailure: (_, message, __) => message,
  );

  int get displayCode => when(
    unexpectedFailure: (_, __, code) => code,
    apiDetailedFailure: (_, __, ___, ____, code) => code,
    modelMapFailure: (_, __, code) => code,
    apiFailureService: (_) => 2008,
    checkInternetFailure: (_, code) => code,
    connectionTimeoutFailure: (_, code) => code,
    noConnectionFailure: (_, code) => code,
    responseDecodingFailure: (_, code) => code,
    vpnConnectedFailure: (_, code) => code,
    deviceNotSecuredFailure: (_, code) => code,
    signNotValidFailure: (_, code) => code,
    unhandledStatusCodeFailure: (_, __, ___, ____, code) => code,
    sslPinningFailure: (_, __, code) => code,
  );
}