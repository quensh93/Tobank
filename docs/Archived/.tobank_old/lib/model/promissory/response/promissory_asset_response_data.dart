import 'dart:convert';

import '../../common/error_response_data.dart';

PromissoryAssetResponseData promissoryAssetResponseDataFromJson(String str) =>
    PromissoryAssetResponseData.fromJson(json.decode(str));

String promissoryAssetResponseDataToJson(PromissoryAssetResponseData data) => json.encode(data.toJson());

class PromissoryAssetResponseData {
  PromissoryAssetResponseData({
    this.data,
    this.success,
    this.message,
    this.code,
  });

  Data? data;
  bool? success;
  String? message;
  int? code;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory PromissoryAssetResponseData.fromJson(Map<String, dynamic> json) => PromissoryAssetResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data?.toJson(),
        'success': success,
        'message': message,
        'code': code,
      };
}

class Data {
  Data({
    this.datetime,
    this.signCoordination,
    this.tourismBankDetails,
  });

  SignDatetime? datetime;
  SignCoordination? signCoordination;
  TourismBankDetails? tourismBankDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        datetime: json['datetime'] == null ? null : SignDatetime.fromJson(json['datetime']),
        signCoordination:
            json['sign_coordination'] == null ? null : SignCoordination.fromJson(json['sign_coordination']),
        tourismBankDetails:
            json['tourism_bank_details'] == null ? null : TourismBankDetails.fromJson(json['tourism_bank_details']),
      );

  Map<String, dynamic> toJson() => {
        'datetime': datetime?.toJson(),
        'sign_coordination': signCoordination?.toJson(),
        'tourism_bank_details': tourismBankDetails?.toJson(),
      };
}

class SignDatetime {
  SignDatetime({
    this.solarDatetime,
    this.gregorianDatetime,
    this.timeStamp,
  });

  DateTime? solarDatetime;
  DateTime? gregorianDatetime;
  double? timeStamp;

  factory SignDatetime.fromJson(Map<String, dynamic> json) => SignDatetime(
        solarDatetime: json['solar_datetime'] == null ? null : DateTime.parse(json['solar_datetime']),
        gregorianDatetime: json['gregorian_datetime'] == null ? null : DateTime.parse(json['gregorian_datetime']),
        timeStamp: json['time_stamp']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'solar_datetime': solarDatetime?.toIso8601String(),
        'gregorian_datetime': gregorianDatetime?.toIso8601String(),
        'time_stamp': timeStamp,
      };
}

class SignCoordination {
  SignCoordination({
    this.x,
    this.y,
    this.width,
    this.height,
    this.xIOS,
    this.yIOS,
    this.widthIOS,
    this.heightIOS,
    this.page,
  });

  int? x;
  int? y;
  int? width;
  int? height;
  int? xIOS;
  int? yIOS;
  int? widthIOS;
  int? heightIOS;
  int? page;

  factory SignCoordination.fromJson(Map<String, dynamic> json) => SignCoordination(
        x: json['x'],
        y: json['y'],
        width: json['width'],
        height: json['height'],
        xIOS: json['x_ios'],
        yIOS: json['y_ios'],
        widthIOS: json['width_ios'],
        heightIOS: json['height_ios'],
        page: json['page'],
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'width': width,
        'height': height,
        'x_ios': xIOS,
        'y_ios': yIOS,
        'width_ios': widthIOS,
        'height_ios': heightIOS,
        'page': page,
      };
}

class TourismBankDetails {
  TourismBankDetails({
    this.legalNationalNumber,
    this.legalPhoneNumber,
    this.paymentAddress,
  });

  String? legalNationalNumber;
  String? legalPhoneNumber;
  String? paymentAddress;

  factory TourismBankDetails.fromJson(Map<String, dynamic> json) => TourismBankDetails(
        legalNationalNumber: json['legal_national_number'],
        legalPhoneNumber: json['legal_phone_number'],
        paymentAddress: json['payment_address'],
      );

  Map<String, dynamic> toJson() => {
        'legal_national_number': legalNationalNumber,
        'legal_phone_number': legalPhoneNumber,
        'payment_address': paymentAddress,
      };
}
