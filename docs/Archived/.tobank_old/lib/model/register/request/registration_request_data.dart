import 'dart:convert';

import '../../../service/core/api_request_model.dart';

String registrationRequestDataToJson(RegistrationRequest data) => json.encode(data.toJson());

class RegistrationRequest extends ApiRequestModel {
  RegistrationRequest({
    required this.trackingNumber,
    required this.transactionId,
    required this.nationalCode,
    required this.customerPublicKey,
    this.referrerLoyaltyCode,
    this.jobs,
  });

  String trackingNumber;
  String transactionId;
  String nationalCode;
  String? referrerLoyaltyCode;
  String customerPublicKey;
  List<Job>? jobs;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'nationalCode': nationalCode,
        'referrerLoyaltyCode': referrerLoyaltyCode,
        'customerPublicKey': customerPublicKey,
        'jobs': jobs == null ? [] : List<dynamic>.from(jobs!.map((x) => x.toJson())),
      };
}

class Job {
  int? jobType;
  dynamic description;

  Job({
    this.jobType,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'jobType': jobType,
        'description': description,
      };
}
