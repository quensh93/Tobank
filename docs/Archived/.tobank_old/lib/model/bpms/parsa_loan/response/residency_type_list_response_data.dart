import 'dart:convert';

ResidencyTypeListResponseData residencyTypeListResponseDataFromJson(String str) =>
    ResidencyTypeListResponseData.fromJson(json.decode(str));

String residencyTypeListResponseDataToJson(ResidencyTypeListResponseData data) => json.encode(data.toJson());

class ResidencyTypeListResponseData {
  String? message;
  bool? success;
  List<ResidencyType>? data;

  ResidencyTypeListResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory ResidencyTypeListResponseData.fromJson(Map<String, dynamic> json) => ResidencyTypeListResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? [] : List<ResidencyType>.from(json['data']!.map((x) => ResidencyType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ResidencyType {
  String? faTitle;
  String? type;
  bool? needsDescription;

  ResidencyType({
    this.faTitle,
    this.type,
    this.needsDescription,
  });

  factory ResidencyType.fromJson(Map<String, dynamic> json) => ResidencyType(
        faTitle: json['fa_title'],
        type: json['type'],
        needsDescription: json['needs_description'],
      );

  Map<String, dynamic> toJson() => {
        'fa_title': faTitle,
        'type': type,
        'needs_description': needsDescription,
      };
}
