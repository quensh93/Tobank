import 'dart:convert';

import '../../common/error_response_data.dart';
import '../../common/sign_document_data.dart';

GetTaskContractDocumentResponse getTaskContractDocumentResponseFromJson(String str) =>
    GetTaskContractDocumentResponse.fromJson(json.decode(str));

String getTaskContractDocumentResponseToJson(GetTaskContractDocumentResponse data) => json.encode(data.toJson());

class GetTaskContractDocumentResponse {
  GetTaskContractDocumentResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory GetTaskContractDocumentResponse.fromJson(Map<String, dynamic> json) => GetTaskContractDocumentResponse(
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
  Data({
    this.signLocation,
    this.id,
    this.base64Data,
  });

  SignLocation? signLocation;
  String? id;
  String? base64Data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        signLocation: json['sign_location'] == null ? null : SignLocation.fromJson(json['sign_location']),
        id: json['ID'],
        base64Data: json['base64Data'],
      );

  Map<String, dynamic> toJson() => {
        'sign_location': signLocation?.toJson(),
        'ID': id,
        'base64Data': base64Data,
      };
}
