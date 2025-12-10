import '../../../../service/core/api_request_model.dart';

class UploadBirthCertificateMainImageRequestData extends ApiRequestModel {
  UploadBirthCertificateMainImageRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.birthCertificateMainImage,
    required this.deviceId,
  });

  String trackingNumber;
  String nationalCode;
  String birthCertificateMainImage;
  String deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'birthCertificateMainImage': birthCertificateMainImage,
        'deviceId': deviceId,
      };
}
