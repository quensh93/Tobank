import 'dart:convert';

import '../../common/error_response_data.dart';

ListNotificationData listNotificationDataFromJson(String str) => ListNotificationData.fromJson(json.decode(str));

String listNotificationDataToJson(ListNotificationData data) => json.encode(data.toJson());

class ListNotificationData {
  ListNotificationData({
    this.data,
    this.success,
  });

  List<NotificationData>? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ListNotificationData.fromJson(Map<String, dynamic> json) => ListNotificationData(
        data: List<NotificationData>.from(json['data'].map((x) => NotificationData.fromJson(x))),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'success': success,
      };
}

class NotificationData {
  NotificationData({
    this.category,
    this.date,
    this.description,
    this.id,
    this.isRead,
    this.message,
    this.title,
    this.type,
  });

  String? category;
  String? date;
  String? description;
  int? id;
  bool? isRead;
  String? message;
  String? title;
  String? type;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        category: json['category'],
        date: json['date'],
        description: json['description'],
        id: json['id'],
        isRead: json['is_read'],
        message: json['message'],
        title: json['title'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'category': category,
        'date': date,
        'description': description,
        'id': id,
        'is_read': isRead,
        'message': message,
        'title': title,
        'type': type,
      };
}
