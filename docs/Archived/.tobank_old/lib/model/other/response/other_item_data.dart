import 'dart:convert';

OtherItemData otherItemDataFromJson(String str) => OtherItemData.fromJson(json.decode(str));

String otherItemDataToJson(OtherItemData data) => json.encode(data.toJson());

class OtherItemData {
  OtherItemData({
    this.data,
    this.message,
    this.success,
  });

  OtherItemDataData? data;
  dynamic message;
  bool? success;
  int? statusCode;

  factory OtherItemData.fromJson(Map<String, dynamic> json) => OtherItemData(
        data: OtherItemDataData.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data!.toJson(),
        'message': message,
        'success': success,
      };
}

class OtherItemDataData {
  OtherItemDataData({
    this.data,
    this.success,
  });

  DataData? data;
  bool? success;

  factory OtherItemDataData.fromJson(Map<String, dynamic> json) => OtherItemDataData(
        data: DataData.fromJson(json['data']),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'success': success,
      };
}

class DataData {
  DataData({
    this.content,
    this.created,
    this.id,
    this.slug,
    this.title,
    this.htmlContent,
  });

  String? content;
  DateTime? created;
  int? id;
  String? slug;
  String? title;
  String? htmlContent;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        content: json['content'],
        created: DateTime.parse(json['created']),
        id: json['id'],
        slug: json['slug'],
        title: json['title'],
        htmlContent: json['html_content'],
      );

  Map<String, dynamic> toJson() =>
      {
        'content': content,
        'created': created!.toIso8601String(),
        'id': id,
        'slug': slug,
        'title': title,
        'html_content': htmlContent,
      };
}
