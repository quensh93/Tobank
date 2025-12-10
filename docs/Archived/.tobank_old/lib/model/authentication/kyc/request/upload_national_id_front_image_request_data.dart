import '../../../../service/core/api_request_model.dart';

class UploadNationalIdFrontImageRequestData extends ApiRequestModel {
  UploadNationalIdFrontImageRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.nationalIdFrontImage,
    required this.deviceId,
  });

  String trackingNumber;
  String nationalCode;
  String nationalIdFrontImage;
  String deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'nationalIdFrontImage': nationalIdFrontImage,
        'deviceId': deviceId,
      };
}
