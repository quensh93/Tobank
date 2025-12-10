import 'dart:convert';

import '../../common/error_response_data.dart';

ListEventPlanData listEventPlanDataFromJson(String str) => ListEventPlanData.fromJson(json.decode(str));

String listEventPlanDataToJson(ListEventPlanData data) => json.encode(data.toJson());

class ListEventPlanData {
  ListEventPlanData({
    this.data,
    this.success,
  });

  List<Event>? data;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory ListEventPlanData.fromJson(Map<String, dynamic> json) => ListEventPlanData(
        data: List<Event>.from(json['data'].map((x) => Event.fromJson(x))),
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'success': success,
      };
}

class Event {
  Event({
    this.id,
    this.plans,
    this.title,
    this.image,
  });

  int? id;
  List<Plan>? plans;
  String? title;
  String? image;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json['id'],
        plans: List<Plan>.from(json['plans'].map((x) => Plan.fromJson(x))),
        title: json['title'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'plans': List<dynamic>.from(plans!.map((x) => x.toJson())),
        'title': title,
        'image': image,
      };
}

class Plan {
  Plan({
    this.active,
    this.createdAt,
    this.event,
    this.id,
    this.image,
    this.title,
    this.eventTitle,
  });

  bool? active;
  DateTime? createdAt;
  int? event;
  int? id;
  String? image;
  String? title;
  String? eventTitle;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        active: json['active'],
        createdAt: DateTime.parse(json['created_at']),
        event: json['event'],
        id: json['id'],
        image: json['image'],
        eventTitle: json['event_title'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() =>
      {
        'active': active,
        'created_at': createdAt!.toIso8601String(),
        'event': event,
        'id': id,
        'image': image,
        'event_title': eventTitle,
        'title': title,
      };
}
