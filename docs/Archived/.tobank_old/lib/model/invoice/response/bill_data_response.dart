import 'dart:convert';

import '../../common/error_response_data.dart';

BillDataResponse billDataResponseFromJson(String str) => BillDataResponse.fromJson(json.decode(str));

String billDataResponseToJson(BillDataResponse data) => json.encode(data.toJson());

class BillDataResponse {
  BillDataResponse({
    this.data,
    this.message,
    this.success,
  });

  BillData? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory BillDataResponse.fromJson(Map<String, dynamic> json) => BillDataResponse(
        data: BillData.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'message': message,
        'success': success,
      };
}

class BillData {
  BillData({
    this.barcode,
    this.billIdentifier,
    this.id,
    this.identifier,
    this.mobile,
    this.phone,
    this.title,
    this.type,
    this.typeId,
    this.user,
    this.plateNumber,
    this.midterm,
  });

  String? barcode;
  String? billIdentifier;
  int? id;
  String? identifier;
  String? mobile;
  String? phone;
  String? title;
  String? type;
  int? typeId;
  String? user;
  String? plateNumber;
  bool? midterm;

  factory BillData.fromJson(Map<String, dynamic> json) => BillData(
        barcode: json['barcode'],
        billIdentifier: json['bill_identifier'],
        id: json['id'],
        identifier: json['identifier'],
        mobile: json['mobile'],
        phone: json['phone'],
        title: json['title'],
        type: json['type'],
        typeId: json['type_id'],
        user: json['user'],
        plateNumber: json['plate_number'],
        midterm: json['midterm'],
      );

  Map<String, dynamic> toJson() =>
      {
        'barcode': barcode,
        'bill_identifier': billIdentifier,
        'id': id,
        'identifier': identifier,
        'mobile': mobile,
        'phone': phone,
        'title': title,
        'type': type,
        'type_id': typeId,
        'user': user,
        'plate_number': plateNumber,
        'midterm': midterm,
      };
}
