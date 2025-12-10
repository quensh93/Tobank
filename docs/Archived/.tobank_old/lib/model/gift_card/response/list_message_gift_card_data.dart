import 'dart:convert';

import '../../common/error_response_data.dart';

ListMessageGiftCardData listMessageGiftCardDataFromJson(String str) =>
    ListMessageGiftCardData.fromJson(json.decode(str));

String listMessageGiftCardDataToJson(ListMessageGiftCardData data) => json.encode(data.toJson());

class ListMessageGiftCardData {
  ListMessageGiftCardData({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<MessageData>? results;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ListMessageGiftCardData.fromJson(Map<String, dynamic> json) => ListMessageGiftCardData(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: List<MessageData>.from(json['results'].map((x) => MessageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class MessageData {
  MessageData({
    this.description,
    this.event,
    this.id,
  });

  String? description;
  MessageEventData? event;
  int? id;

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        description: json['description'],
        event: MessageEventData.fromJson(json['event']),
        id: json['id'],
      );

  Map<String, dynamic> toJson() =>
      {
        'description': description,
        'event': event!.toJson(),
        'id': id,
      };
}

class MessageEventData {
  MessageEventData({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory MessageEventData.fromJson(Map<String, dynamic> json) => MessageEventData(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
