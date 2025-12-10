import 'dart:convert';

ResponseData responseDataFromJson(String str) => ResponseData.fromJson(json.decode(str));

String responseDataToJson(ResponseData data) => json.encode(data.toJson());

class ResponseData {
  ResponseData({
    this.data,
  });

  String? data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        data: json['data'],
      );

  Map<String, dynamic> toJson() => {
        'data': data,
      };
}
