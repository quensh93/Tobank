import 'dart:convert';

NotificationMessageData notificationMessageDataFromJson(String str) =>
    NotificationMessageData.fromJson(json.decode(str));

String notificationMessageDataToJson(NotificationMessageData data) => json.encode(data.toJson());

class NotificationMessageData {
  String? header;
  String? description;
  String? clickAction;
  String? type;
  String? id;

  NotificationMessageData({
    this.header,
    this.description,
    this.clickAction,
    this.type,
    this.id,
  });

  factory NotificationMessageData.fromJson(Map<String, dynamic> json) => NotificationMessageData(
        header: json['header'],
        description: json['description'],
        clickAction: json['click_action'],
        type: json['type'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'header': header,
        'description': description,
        'click_action': clickAction,
        'type': type,
        'id': id,
      };
}
