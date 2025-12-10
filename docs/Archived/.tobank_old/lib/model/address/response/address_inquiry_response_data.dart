import 'dart:convert';

import '../../common/error_response_data.dart';

AddressInquiryResponseData addressInquiryResponseDataFromJson(String str) =>
    AddressInquiryResponseData.fromJson(json.decode(str));

String addressInquiryResponseDataToJson(AddressInquiryResponseData data) => json.encode(data.toJson());

class AddressInquiryResponseData {
  AddressInquiryResponseData({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory AddressInquiryResponseData.fromJson(Map<String, dynamic> json) => AddressInquiryResponseData(
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
    this.responseCode,
    this.trackingId,
    this.fullAddress,
    this.detail,
  });

  String? responseCode;
  String? trackingId;
  String? fullAddress;
  AddressDetail? detail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        responseCode: json['responseCode'],
        trackingId: json['trackingId'],
        fullAddress: json['FullAddress'],
        detail: json['Detail'] == null ? null : AddressDetail.fromJson(json['Detail']),
      );

  Map<String, dynamic> toJson() => {
        'responseCode': responseCode,
        'trackingId': trackingId,
        'FullAddress': fullAddress,
        'Detail': detail?.toJson(),
      };
}

class AddressDetail {
  AddressDetail({
    this.province,
    this.townShip,
    this.zone,
    this.village,
    this.localityType,
    this.localityName,
    this.localityCode,
    this.subLocality,
    this.street,
    this.street2,
    this.houseNumber,
    this.floor,
    this.sideFloor,
    this.buildingName,
    this.description,
  });

  String? province;
  String? townShip;
  String? zone;
  String? village;
  String? localityType;
  String? localityName;
  int? localityCode;
  String? subLocality;
  String? street;
  String? street2;
  int? houseNumber;
  String? floor;
  String? sideFloor;
  String? buildingName;
  String? description;

  factory AddressDetail.fromJson(Map<String, dynamic> json) => AddressDetail(
        province: json['Province'],
        townShip: json['TownShip'],
        zone: json['Zone'],
        village: json['Village'],
        localityType: json['LocalityType'],
        localityName: json['LocalityName'],
        localityCode: json['LocalityCode'],
        subLocality: json['SubLocality'],
        street: json['Street'],
        street2: json['Street2'],
        houseNumber: json['HouseNumber'],
        floor: json['Floor'],
        sideFloor: json['SideFloor'],
        buildingName: json['BuildingName'],
        description: json['Description'],
      );

  Map<String, dynamic> toJson() => {
        'Province': province,
        'TownShip': townShip,
        'Zone': zone,
        'Village': village,
        'LocalityType': localityType,
        'LocalityName': localityName,
        'LocalityCode': localityCode,
        'SubLocality': subLocality,
        'Street': street,
        'Street2': street2,
        'HouseNumber': houseNumber,
        'Floor': floor,
        'SideFloor': sideFloor,
        'BuildingName': buildingName,
        'Description': description,
      };
}
