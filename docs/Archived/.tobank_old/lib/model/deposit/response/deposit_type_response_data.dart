import 'dart:convert';

import '../../common/error_response_data.dart';

DepositTypeResponseData depositTypeResponseDataFromJson(String str) =>
    DepositTypeResponseData.fromJson(json.decode(str));

String depositTypeResponseDataToJson(DepositTypeResponseData data) => json.encode(data.toJson());

class DepositTypeResponseData {
  DepositTypeResponseData({
    this.data,
    this.message,
    this.success,
    this.branchCode,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  int? branchCode;
  late ErrorResponseData errorResponseModel;

  factory DepositTypeResponseData.fromJson(Map<String, dynamic> json) => DepositTypeResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
        branchCode: json['branchCode'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
        'branchCode': branchCode,
      };
}

class Data {
  Data({
    this.depositTypes,
    this.message,
    this.registrationDate,
    this.status,
    this.trackingNumber,
    this.transactionId,
  });

  List<DepositType>? depositTypes;
  String? message;
  int? registrationDate;
  int? status;
  String? trackingNumber;
  String? transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        depositTypes: json['depositTypes'] == null
            ? null
            : List<DepositType>.from(json['depositTypes'].map((x) => DepositType.fromJson(x))),
        message: json['message'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
      );

  Map<String, dynamic> toJson() => {
        'depositTypes': depositTypes == null ? null : List<dynamic>.from(depositTypes!.map((x) => x.toJson())),
        'message': message,
        'registrationDate': registrationDate,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
      };
}

class DepositType {
  DepositType({
    this.calculateMaxPerBranch,
    this.generalType,
    this.globalName,
    this.localName,
    this.maxPerCustomer,
    this.remainingInstances,
    this.status,
    this.typeCode,
  });

  bool? calculateMaxPerBranch;
  int? generalType; // 0 Current, 1 Gharzolhasane, 2 Short_term, 3 Long_term
  String? globalName;
  String? localName;
  int? maxPerCustomer;
  int? remainingInstances;
  int? status;
  String? typeCode;

  factory DepositType.fromJson(Map<String, dynamic> json) => DepositType(
        calculateMaxPerBranch: json['calculateMaxPerBranch'],
        generalType: json['generalType'],
        globalName: json['globalName'],
        localName: json['localName'],
        maxPerCustomer: json['maxPerCustomer'],
        remainingInstances: json['remainingInstances'],
        status: json['status'],
        typeCode: json['typeCode'],
      );

  Map<String, dynamic> toJson() => {
        'calculateMaxPerBranch': calculateMaxPerBranch,
        'generalType': generalType,
        'globalName': globalName,
        'localName': localName,
        'maxPerCustomer': maxPerCustomer,
        'remainingInstances': remainingInstances,
        'status': status,
        'typeCode': typeCode,
      };
}
