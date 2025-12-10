import 'dart:convert';

NotificationSetReadResponse notificationSetReadResponseFromJson(String str) =>
    NotificationSetReadResponse.fromJson(json.decode(str));

String notificationSetReadResponseToJson(NotificationSetReadResponse data) => json.encode(data.toJson());

class NotificationSetReadResponse {
  NotificationSetReadResponse({
    this.data,
    this.message,
    this.success,
  });

  List<dynamic>? data;
  String? message;
  bool? success;
  int? statusCode;

  factory NotificationSetReadResponse.fromJson(Map<String, dynamic> json) => NotificationSetReadResponse(
        data: json['data'] == null ? null : List<dynamic>.from(json['data'].map((x) => x)),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? null : List<dynamic>.from(data!.map((x) => x)),
        'message': message,
        'success': success,
      };
}
