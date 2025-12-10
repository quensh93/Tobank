import 'dart:convert';

import '../../../common/error_response_data.dart';

GetAddressInfoResponseData getAddressInfoResponseDataFromJson(String str) =>
    GetAddressInfoResponseData.fromJson(json.decode(str));

String getAddressInfoResponseDataToJson(GetAddressInfoResponseData data) => json.encode(data.toJson());

class GetAddressInfoResponseData {
  GetAddressInfoResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory GetAddressInfoResponseData.fromJson(Map<String, dynamic> json) => GetAddressInfoResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
        'message': message,
      };
}

class Data {
  Data({
    this.trackingNumber,
    this.registrationDate,
    this.status,
    this.address,
    this.latitude,
    this.longitude,
  });

  String? trackingNumber;
  int? registrationDate;
  int? status;
  String? address;
  String? latitude;
  String? longitude;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        address: json['address'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'registrationDate': registrationDate,
        'status': status,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      };
}
