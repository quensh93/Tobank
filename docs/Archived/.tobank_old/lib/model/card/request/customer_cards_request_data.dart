import 'dart:convert';

CustomerCardsRequest customerDepositsRequestFromJson(String str) =>
    CustomerCardsRequest.fromJson(json.decode(str));

String customerDepositsRequestToJson(CustomerCardsRequest data) =>
    json.encode(data.toJson());

class CustomerCardsRequest {
  CustomerCardsRequest({
    required this.trackingNumber,
    required this.customerNumber,
  });

  String trackingNumber;
  String customerNumber;

  factory CustomerCardsRequest.fromJson(Map<String, dynamic> json) => CustomerCardsRequest(
        trackingNumber: json['trackingNumber'],
        customerNumber: json['customerNumber'],
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
      };
}
