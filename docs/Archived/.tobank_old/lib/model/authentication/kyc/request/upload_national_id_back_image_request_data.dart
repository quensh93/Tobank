import '../../../../service/core/api_request_model.dart';

class UploadNationalIdBackImageRequestData extends ApiRequestModel {
  UploadNationalIdBackImageRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.nationalIdBackImage,
    required this.deviceId,
  });

  String trackingNumber;
  String nationalCode;
  String nationalIdBackImage;
  String deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'nationalIdBackImage': nationalIdBackImage,
        'deviceId': deviceId,
      };
}
