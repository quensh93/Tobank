import '../../../../service/core/api_request_model.dart';

class IssueCertificateRequestData extends ApiRequestModel {
  IssueCertificateRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.globalFirstName,
    required this.globalLastName,
    required this.occupation,
    required this.email,
    required this.landLineNumber,
    required this.certificateRequestData,
    required this.deviceId,
  });

  String trackingNumber;
  String nationalCode;
  String globalFirstName;
  String globalLastName;
  String? occupation;
  String email;
  String landLineNumber;
  String certificateRequestData;
  String deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'globalFirstName': globalFirstName,
        'globalLastName': globalLastName,
        'occupation': occupation,
        'email': email,
        'landLineNumber': landLineNumber,
        'certificateRequestData': certificateRequestData,
        'deviceId': deviceId,
      };
}
