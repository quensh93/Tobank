import 'dart:convert';

MainPichakResponse mainPichakResponseFromJson(String str) => MainPichakResponse.fromJson(json.decode(str));

String mainPichakResponseToJson(MainPichakResponse data) => json.encode(data.toJson());

class MainPichakResponse {
  MainPichakResponse({
    this.data,
    this.success,
    this.message,
  });

  int? statusCode;
  Data? data;
  bool? success;
  String? message;

  factory MainPichakResponse.fromJson(Map<String, dynamic> json) => MainPichakResponse(
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
    this.requestId,
    this.status,
    this.registrationDate,
    this.responseSecureEnvelope,
  });

  String? trackingNumber;
  String? requestId;
  int? status;
  int? registrationDate;
  ResponseSecureEnvelope? responseSecureEnvelope;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        requestId: json['requestId'],
        status: json['status'],
        registrationDate: json['registrationDate'],
        responseSecureEnvelope: json['responseSecureEnvelope'] == null
            ? null
            : ResponseSecureEnvelope.fromJson(json['responseSecureEnvelope']),
      );

  Map<String, dynamic> toJson() =>
      {
        'trackingNumber': trackingNumber,
        'requestId': requestId,
        'status': status,
        'registrationDate': registrationDate,
        'responseSecureEnvelope': responseSecureEnvelope?.toJson(),
      };
}

class ResponseSecureEnvelope {
  ResponseSecureEnvelope({
    this.iv,
    this.encryptedData,
  });

  String? iv;
  String? encryptedData;

  factory ResponseSecureEnvelope.fromJson(Map<String, dynamic> json) => ResponseSecureEnvelope(
        iv: json['iv'],
        encryptedData: json['encryptedData'],
      );

  Map<String, dynamic> toJson() => {
        'iv': iv,
        'encryptedData': encryptedData,
      };
}
