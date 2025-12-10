import 'dart:convert';

import '../../common/error_response_data.dart';

AvatarListResponseData avatarListResponseDataFromJson(String str) => AvatarListResponseData.fromJson(json.decode(str));

String avatarListResponseDataToJson(AvatarListResponseData data) => json.encode(data.toJson());

class AvatarListResponseData {
  AvatarListResponseData({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory AvatarListResponseData.fromJson(Map<String, dynamic> json) => AvatarListResponseData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'success': success,
      };
}

class Data {
  Data({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<AvatarData>? results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results:
            json['results'] == null ? null : List<AvatarData>.from(json['results'].map((x) => AvatarData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class AvatarData {
  AvatarData({
    this.avatar,
    this.id,
    this.title,
  });

  String? avatar;
  int? id;
  String? title;

  factory AvatarData.fromJson(Map<String, dynamic> json) => AvatarData(
        avatar: json['avatar'],
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() =>
      {
        'avatar': avatar,
        'id': id,
        'title': title,
      };
}
