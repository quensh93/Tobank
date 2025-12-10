import 'dart:convert';

ChooseBranchResponseData chooseBranchResponseDataFromJson(String str) =>
    ChooseBranchResponseData.fromJson(json.decode(str));

String chooseBranchResponseDataToJson(ChooseBranchResponseData data) => json.encode(data.toJson());

class ChooseBranchResponseData {
  String? message;
  bool? success;

  ChooseBranchResponseData({
    this.message,
    this.success,
  });

  factory ChooseBranchResponseData.fromJson(Map<String, dynamic> json) => ChooseBranchResponseData(
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
      };
}
