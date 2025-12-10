import 'dart:convert';

UserStartableProcessRequest userStartableProcessRequestFromJson(String str) =>
    UserStartableProcessRequest.fromJson(json.decode(str));

String userStartableProcessRequestToJson(UserStartableProcessRequest data) =>
    json.encode(data.toJson());

class UserStartableProcessRequest {
  UserStartableProcessRequest({
    required this.customerNumber,
    required this.latestVersion,
    required this.trackingNumber,
  });

  String customerNumber;
  bool latestVersion;
  String trackingNumber;

  factory UserStartableProcessRequest.fromJson(Map<String, dynamic> json) => UserStartableProcessRequest(
        customerNumber: json['customerNumber'],
        latestVersion: json['latestVersion'],
        trackingNumber: json['trackingNumber'],
      );

  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'latestVersion': latestVersion,
        'trackingNumber': trackingNumber,
      };
}
