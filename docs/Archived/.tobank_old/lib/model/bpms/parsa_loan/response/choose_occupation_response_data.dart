import 'dart:convert';

ChooseOccupationResponseData chooseOccupationResponseDataFromJson(String str) =>
    ChooseOccupationResponseData.fromJson(json.decode(str));

String chooseOccupationResponseDataToJson(ChooseOccupationResponseData data) => json.encode(data.toJson());

class ChooseOccupationResponseData {
  String? message;
  bool? success;

  ChooseOccupationResponseData({
    this.message,
    this.success,
  });

  factory ChooseOccupationResponseData.fromJson(Map<String, dynamic> json) => ChooseOccupationResponseData(
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
      };
}
