import 'dart:convert';

ChooseResidencyTypeResponseData chooseResidencyTypeResponseDataFromJson(String str) =>
    ChooseResidencyTypeResponseData.fromJson(json.decode(str));

String chooseResidencyTypeResponseDataToJson(ChooseResidencyTypeResponseData data) => json.encode(data.toJson());

class ChooseResidencyTypeResponseData {
  String? message;
  bool? success;

  ChooseResidencyTypeResponseData({
    this.message,
    this.success,
  });

  factory ChooseResidencyTypeResponseData.fromJson(Map<String, dynamic> json) => ChooseResidencyTypeResponseData(
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
      };
}
