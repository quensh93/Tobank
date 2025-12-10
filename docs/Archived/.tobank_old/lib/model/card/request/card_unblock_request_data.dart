import 'dart:convert';

CardUnBlockRequestData cardUnBlockRequestDataFromJson(String str) =>
    CardUnBlockRequestData.fromJson(json.decode(str));

String cardUnBlockRequestDataToJson(CardUnBlockRequestData data) =>
    json.encode(data.toJson());

class CardUnBlockRequestData {
  CardUnBlockRequestData({
    this.trackingNumber,
    this.customerNumber,
    this.pan,
  });

  String? trackingNumber;
  String? customerNumber;
  String? pan;

  factory CardUnBlockRequestData.fromJson(Map<String, dynamic> json) => CardUnBlockRequestData(
        trackingNumber: json['trackingNumber'],
        customerNumber: json['customerNumber'],
        pan: json['pan'],
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'pan': pan,
      };
}
