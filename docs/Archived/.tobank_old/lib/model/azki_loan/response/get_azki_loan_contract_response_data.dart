import 'dart:convert';

import '../../common/error_response_data.dart';
import '../../common/sign_document_data.dart';

GetAzkiLoanContractResponse getAzkiLoanContractResponseFromJson(String str) =>
    GetAzkiLoanContractResponse.fromJson(json.decode(str));

String getAzkiLoanContractResponseToJson(GetAzkiLoanContractResponse data) => json.encode(data.toJson());

class GetAzkiLoanContractResponse {
  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  GetAzkiLoanContractResponse({
    this.data,
    this.success,
    this.message,
  });

  factory GetAzkiLoanContractResponse.fromJson(Map<String, dynamic> json) => GetAzkiLoanContractResponse(
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
  int? id;
  String? contractAnswer;
  List<SignLocation>? signLocation;

  Data({
    this.id,
    this.contractAnswer,
    this.signLocation,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        contractAnswer: json['contract_answer'],
        signLocation: json['sign_location'] == null
            ? []
            : List<SignLocation>.from(json['sign_location']!.map((x) => SignLocation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'contract_answer': contractAnswer,
        'sign_location': signLocation == null ? [] : List<dynamic>.from(signLocation!.map((x) => x.toJson())),
      };
}
