import 'dart:convert';

import '../error_response_pichak_data.dart';

ReceiverInquiryResponse receiverInquiryResponseFromJson(String str) =>
    ReceiverInquiryResponse.fromJson(json.decode(str));

String receiverInquiryResponseToJson(ReceiverInquiryResponse data) => json.encode(data.toJson());

class ReceiverInquiryResponse {
  ReceiverInquiryResponse({
    this.fullName,
    this.personType,
    this.nationalId,
    this.shahabId,
  });

  late ErrorResponsePichakData errorResponsePichakData;
  int? statusCode;
  String? fullName;
  int? personType;
  String? nationalId;
  dynamic shahabId;

  factory ReceiverInquiryResponse.fromJson(Map<String, dynamic> json) => ReceiverInquiryResponse(
        fullName: json['fullName'],
        personType: json['personType'],
        nationalId: json['nationalId'],
        shahabId: json['shahabId'],
      );

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'personType': personType,
        'nationalId': nationalId,
        'shahabId': shahabId,
      };
}
