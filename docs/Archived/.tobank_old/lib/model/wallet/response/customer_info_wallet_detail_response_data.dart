import 'dart:convert';

import '../../common/error_response_data.dart';
import 'wallet_detail_data.dart';

CustomerInfoWalletDetailResponseData customerInfoWalletDetailResponseDataFromJson(String str) =>
    CustomerInfoWalletDetailResponseData.fromJson(json.decode(str));

String customerInfoWalletDetailResponseDataToJson(CustomerInfoWalletDetailResponseData data) =>
    json.encode(data.toJson());

class CustomerInfoWalletDetailResponseData {
  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  CustomerInfoWalletDetailResponseData({
    this.data,
    this.message,
    this.success,
  });

  factory CustomerInfoWalletDetailResponseData.fromJson(Map<String, dynamic> json) =>
      CustomerInfoWalletDetailResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  String? nationalCode;
  String? firstName;
  String? lastName;
  int? gender;
  String? customerNumber;
  bool? shahabCodeAcquired;
  bool? digitalBankingCustomer;
  bool? azkiMenu;
  String? loyaltyCode;
  String? address;
  String? postalCode;
  int? customerStatus;
  int? ekycProvider; // 0 zoomId, 1 yekta
  int? digitalSignatureProvider; // null any provider, 0 zoomId, 1 yekta
  bool? hasDeposit;
  ActiveCertificateResponse? activeCertificateResponse;
  WalletInfo? walletInfo;

  Data({
    this.trackingNumber,
    this.transactionId,
    this.registrationDate,
    this.status,
    this.nationalCode,
    this.firstName,
    this.lastName,
    this.gender,
    this.customerNumber,
    this.shahabCodeAcquired,
    this.digitalBankingCustomer,
    this.azkiMenu,
    this.loyaltyCode,
    this.address,
    this.postalCode,
    this.customerStatus,
    this.ekycProvider,
    this.digitalSignatureProvider,
    this.hasDeposit,
    this.activeCertificateResponse,
    this.walletInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        nationalCode: json['nationalCode'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        customerNumber: json['customerNumber'],
        shahabCodeAcquired: json['shahabCodeAcquired'],
        digitalBankingCustomer: json['digitalBankingCustomer'],
        azkiMenu: json['azki_menu'],
        loyaltyCode: json['loyaltyCode'],
        address: json['address'],
        postalCode: json['postalCode'],
        customerStatus: json['customerStatus'],
        ekycProvider: json['ekycProvider'],
        digitalSignatureProvider: json['digitalSignatureProvider'],
        hasDeposit: json['hasDeposit'],
        activeCertificateResponse: json['activeCertificateResponse'] == null
            ? null
            : ActiveCertificateResponse.fromJson(json['activeCertificateResponse']),
        walletInfo: json['wallet_info'] == null ? null : WalletInfo.fromJson(json['wallet_info']),
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'nationalCode': nationalCode,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'customerNumber': customerNumber,
        'shahabCodeAcquired': shahabCodeAcquired,
        'digitalBankingCustomer': digitalBankingCustomer,
        'azki_menu': azkiMenu,
        'loyaltyCode': loyaltyCode,
        'address': address,
        'postalCode': postalCode,
        'customerStatus': customerStatus,
        'ekycProvider': ekycProvider,
        'digitalSignatureProvider': digitalSignatureProvider,
        'hasDeposit': hasDeposit,
        'activeCertificateResponse': activeCertificateResponse,
        'wallet_info': walletInfo?.toJson(),
      };
}

class ActiveCertificateResponse {
  ActiveCertificateResponse({
    this.trackingNumber,
    this.registrationDate,
    this.status,
    this.token,
    this.provider,
  });

  String? trackingNumber;
  int? registrationDate;
  int? status;
  String? token;
  int? provider;

  factory ActiveCertificateResponse.fromJson(Map<String, dynamic> json) => ActiveCertificateResponse(
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        token: json['token'],
        provider: json['provider'],
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'status': status,
        'token': token,
        'provider': provider,
      };
}
