import 'dart:convert';

OccupationListResponseData occupationListResponseDataFromJson(String str) =>
    OccupationListResponseData.fromJson(json.decode(str));

String occupationListResponseDataToJson(OccupationListResponseData data) => json.encode(data.toJson());

class OccupationListResponseData {
  String? message;
  bool? success;
  List<OccupationData>? data;

  OccupationListResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory OccupationListResponseData.fromJson(Map<String, dynamic> json) => OccupationListResponseData(
        message: json['message'],
        success: json['success'],
        data:
            json['data'] == null ? [] : List<OccupationData>.from(json['data']!.map((x) => OccupationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OccupationData {
  String? faTitle;
  String? jobType;
  bool? needsDescription;

  OccupationData({
    this.faTitle,
    this.jobType,
    this.needsDescription,
  });

  factory OccupationData.fromJson(Map<String, dynamic> json) => OccupationData(
        faTitle: json['fa_title'],
        jobType: json['job_type'],
        needsDescription: json['needs_description'],
      );

  Map<String, dynamic> toJson() => {
        'fa_title': faTitle,
        'job_type': jobType,
        'needs_description': needsDescription,
      };
}
