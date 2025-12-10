import 'dart:convert';

import '../../common/error_response_data.dart';

InviteLinkResponse inviteLinkResponseFromJson(String str) => InviteLinkResponse.fromJson(json.decode(str));

String inviteLinkResponseToJson(InviteLinkResponse data) => json.encode(data.toJson());

class InviteLinkResponse {
  InviteLinkResponse({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory InviteLinkResponse.fromJson(Map<String, dynamic> json) => InviteLinkResponse(
        data: Data.fromJson(json['data']),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'success': success,
      };
}

class Data {
  Data({
    this.amount,
    this.link,
  });

  int? amount;
  String? link;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        amount: json['amount'],
        link: json['link'],
      );

  Map<String, dynamic> toJson() =>
      {
        'amount': amount,
        'link': link,
      };
}
