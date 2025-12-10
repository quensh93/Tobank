import 'dart:convert';

ParsaLoanSubmitPromissoryResponseData parsaLoanSubmitPromissoryResponseDataFromJson(String str) =>
    ParsaLoanSubmitPromissoryResponseData.fromJson(json.decode(str));

String parsaLoanSubmitPromissoryResponseDataToJson(ParsaLoanSubmitPromissoryResponseData data) =>
    json.encode(data.toJson());

class ParsaLoanSubmitPromissoryResponseData {
  List<dynamic>? data;
  bool? success;
  String? message;

  ParsaLoanSubmitPromissoryResponseData({
    this.data,
    this.success,
    this.message,
  });

  factory ParsaLoanSubmitPromissoryResponseData.fromJson(Map<String, dynamic> json) =>
      ParsaLoanSubmitPromissoryResponseData(
        data: json['data'] == null ? [] : List<dynamic>.from(json['data']!.map((x) => x)),
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        'success': success,
        'message': message,
      };
}
