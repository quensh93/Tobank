import 'dart:convert';

import '../../common/error_response_data.dart';

GetJobsListResponse getJobsListResponseFromJson(String str) =>
    GetJobsListResponse.fromJson(json.decode(str));

String getJobsListResponseToJson(GetJobsListResponse data) =>
    json.encode(data.toJson());

class GetJobsListResponse {
  List<JobModel>? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  GetJobsListResponse({
    this.data,
    this.message,
    this.success,
  });

  factory GetJobsListResponse.fromJson(Map<String, dynamic> json) => GetJobsListResponse(
        data: json['data'] == null ? [] : List<JobModel>.from(json['data']!.map((x) => JobModel.fromJson(x))),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'success': success,
      };
}

class JobModel {
  String? faTitle;
  String? jobType;
  bool? needsDescription;

  JobModel({
    this.faTitle,
    this.jobType,
    this.needsDescription,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        faTitle: json['fa_title'],
        jobType: json['job_type'],
        needsDescription: json['needs_description'],
      );

  Map<String, dynamic> toJson() =>
      {
        'fa_title': faTitle,
        'job_type': jobType,
        'needs_description': needsDescription,
      };
}
