import '../../../service/core/api_request_model.dart';

class RenewCertificateRequestData extends ApiRequestModel {
  String trackingNumber;
  String deviceId;
  String nationalCode;
  String certificateRequestData;

  RenewCertificateRequestData({
    required this.trackingNumber,
    required this.deviceId,
    required this.nationalCode,
    required this.certificateRequestData,
  });

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'deviceId': deviceId,
        'nationalCode': nationalCode,
        'certificateRequestData': certificateRequestData,
      };
}
