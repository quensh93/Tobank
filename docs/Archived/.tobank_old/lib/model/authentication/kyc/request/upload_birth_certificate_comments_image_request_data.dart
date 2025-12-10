import '../../../../service/core/api_request_model.dart';

class UploadBirthCertificateCommentsImageRequestData extends ApiRequestModel {
  UploadBirthCertificateCommentsImageRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.birthCertificateCommentsImage,
    required this.deviceId,
  });

  String trackingNumber;
  String nationalCode;
  String birthCertificateCommentsImage;
  String deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'birthCertificateCommentsImage': birthCertificateCommentsImage,
        'deviceId': deviceId,
      };
}
