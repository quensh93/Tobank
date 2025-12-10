import '../../../service/core/api_request_model.dart';

class ApplicantTaskListRequest extends ApiRequestModel {
  ApplicantTaskListRequest({
    required this.customerNumber,
    required this.nationalId,
    required this.personalityType,
    required this.processInstanceId,
    required this.trackingNumber,
  });

  String customerNumber;
  String nationalId;
  int personalityType;
  String? processInstanceId;
  String trackingNumber;

  @override
  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'nationalId': nationalId,
        'personalityType': personalityType,
        'processInstanceId': processInstanceId,
        'trackingNumber': trackingNumber,
      };
}
