import 'dart:convert';

import '../../common/error_response_data.dart';

IbanInquiryResponseData ibanInquiryResponseDataFromJson(String str) =>
    IbanInquiryResponseData.fromJson(json.decode(str));

String ibanInquiryResponseDataToJson(IbanInquiryResponseData data) => json.encode(data.toJson());

class IbanInquiryResponseData {
  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  IbanInquiryResponseData({
    this.data,
    this.message,
    this.success,
  });

  factory IbanInquiryResponseData.fromJson(Map<String, dynamic> json) => IbanInquiryResponseData(
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
  dynamic message;
  dynamic errors;
  String? firstName;
  String? lastName;
  String? depositNumber;
  String? iban;
  String? approvalCode;
  List<int>? supportedTransferTypes;
  BankInfo? bankInfo;

  Data({
    this.trackingNumber,
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
    this.firstName,
    this.lastName,
    this.depositNumber,
    this.iban,
    this.approvalCode,
    this.supportedTransferTypes,
    this.bankInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        depositNumber: json['depositNumber'],
        iban: json['iban'],
        approvalCode: json['approvalCode'],
        supportedTransferTypes:
            json['supportedTransferTypes'] == null ? [] : List<int>.from(json['supportedTransferTypes']!.map((x) => x)),
        bankInfo: json['bank_info'] == null ? null : BankInfo.fromJson(json['bank_info']),
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'firstName': firstName,
        'lastName': lastName,
        'depositNumber': depositNumber,
        'iban': iban,
        'approvalCode': approvalCode,
        'supportedTransferTypes':
            supportedTransferTypes == null ? [] : List<dynamic>.from(supportedTransferTypes!.map((x) => x)),
        'bank_info': bankInfo?.toJson(),
      };
}

class BankInfo {
  int? id;
  String? title;
  String? enTitle;
  String? preCode;
  String? startColor;
  String? endColor;
  String? symbol;
  String? logo;
  String? logoPng;
  String? background;
  dynamic faraboomHeader;
  bool? isTransfer;
  bool? inShaparakHub;
  bool? needPassword;
  String? shaparakHubBank;
  bool? showable;
  String? ibanCode;

  BankInfo({
    this.id,
    this.title,
    this.enTitle,
    this.preCode,
    this.startColor,
    this.endColor,
    this.symbol,
    this.logo,
    this.logoPng,
    this.background,
    this.faraboomHeader,
    this.isTransfer,
    this.inShaparakHub,
    this.needPassword,
    this.shaparakHubBank,
    this.showable,
    this.ibanCode,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        id: json['id'],
        title: json['title'],
        enTitle: json['en_title'],
        preCode: json['pre_code'],
        startColor: json['start_color'],
        endColor: json['end_color'],
        symbol: json['symbol'],
        logo: json['logo'],
        logoPng: json['logo_png'],
        background: json['background'],
        faraboomHeader: json['faraboom_header'],
        isTransfer: json['is_transfer'],
        inShaparakHub: json['in_shaparak_hub'],
        needPassword: json['need_password'],
        shaparakHubBank: json['shaparak_hub_bank'],
        showable: json['showable'],
        ibanCode: json['iban_code'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'en_title': enTitle,
        'pre_code': preCode,
        'start_color': startColor,
        'end_color': endColor,
        'symbol': symbol,
        'logo': logo,
        'logo_png': logoPng,
        'background': background,
        'faraboom_header': faraboomHeader,
        'is_transfer': isTransfer,
        'in_shaparak_hub': inShaparakHub,
        'need_password': needPassword,
        'shaparak_hub_bank': shaparakHubBank,
        'showable': showable,
        'iban_code': ibanCode,
      };
}
