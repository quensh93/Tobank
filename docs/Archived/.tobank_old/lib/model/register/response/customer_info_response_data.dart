import 'dart:convert';

import '../../bpms/response/user_startable_process_response_data.dart';
import '../../common/error_response_data.dart';

CustomerInfoResponse customerInfoResponseFromJson(String str) => CustomerInfoResponse.fromJson(json.decode(str));

String customerInfoResponseToJson(CustomerInfoResponse data) => json.encode(data.toJson());

class CustomerInfoResponse {
  CustomerInfoResponse({
    this.data,
    this.success,
    this.message,
    this.processDefinitions,
    this.hasDeposit,
    this.activeCertificateResponse,
  });

  Data? data;
  String? message;
  bool? success;
  List<ProcessDefinitionData>? processDefinitions;
  bool? hasDeposit;
  ActiveCertificateResponse? activeCertificateResponse;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CustomerInfoResponse.fromJson(Map<String, dynamic> json) => CustomerInfoResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
        processDefinitions: json['processDefinitions'] == null
            ? null
            : List<ProcessDefinitionData>.from(
                json['processDefinitions'].map((x) => ProcessDefinitionData.fromJson(x))),
        hasDeposit: json['hasDeposit'],
        activeCertificateResponse: json['activeCertificateResponse'] == null
            ? null
            : ActiveCertificateResponse.fromJson(json['activeCertificateResponse']),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
        'processDefinitions':
            processDefinitions == null ? null : List<dynamic>.from(processDefinitions!.map((x) => x.toJson())),
        'hasDeposit': hasDeposit,
        'activeCertificateResponse': activeCertificateResponse?.toJson(),
      };
}

class Data {
  Data({
    this.customerNumber,
    this.customerStatus,
    this.digitalBankingCustomer,
    this.firstName,
    this.gender,
    this.lastName,
    this.nationalCode,
    this.registrationDate,
    this.shahabCodeAcquired,
    this.status,
    this.trackingNumber,
    this.transactionId,
    this.loyaltyCode,
    this.message,
    this.ekycProvider,
    this.digitalSignatureProvider,
    this.address,
    this.postalCode,
  });

  String? customerNumber;
  int? customerStatus; // 0 inActive, 1 Active, 2 unConfirmed, 3 Disabled, 4 InComplete Ekyc, 5 InComplete Document
  bool? digitalBankingCustomer;
  String? firstName;
  int? gender;
  String? lastName;
  String? message;
  String? nationalCode;
  int? registrationDate;
  bool? shahabCodeAcquired;
  int? status;
  String? trackingNumber;
  String? transactionId;
  String? loyaltyCode;
  String? address;
  String? postalCode;
  int? ekycProvider; // 0 zoomId, 1 yekta
  int? digitalSignatureProvider; // null any provider, 0 zoomId, 1 yekta

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerNumber: json['customerNumber'],
        customerStatus: json['customerStatus'],
        digitalBankingCustomer: json['digitalBankingCustomer'],
        firstName: json['firstName'],
        gender: json['gender'],
        lastName: json['lastName'],
        nationalCode: json['nationalCode'],
        registrationDate: json['registrationDate'],
        shahabCodeAcquired: json['shahabCodeAcquired'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        message: json['message'],
        loyaltyCode: json['loyaltyCode'],
        ekycProvider: json['ekycProvider'],
        digitalSignatureProvider: json['digitalSignatureProvider'],
        address: json['address'],
        postalCode: json['postalCode'],
      );

  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'customerStatus': customerStatus,
        'digitalBankingCustomer': digitalBankingCustomer,
        'firstName': firstName,
        'gender': gender,
        'lastName': lastName,
        'message': message,
        'nationalCode': nationalCode,
        'registrationDate': registrationDate,
        'shahabCodeAcquired': shahabCodeAcquired,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'loyaltyCode': loyaltyCode,
        'ekycProvider': ekycProvider,
        'digitalSignatureProvider': digitalSignatureProvider,
        'address': address,
        'postalCode': postalCode,
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
