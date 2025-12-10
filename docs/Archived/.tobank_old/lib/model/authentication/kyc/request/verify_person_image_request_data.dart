import '../../../../service/core/api_request_model.dart';

class VerifyPersonImageRequestData extends ApiRequestModel {
  VerifyPersonImageRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.nationalIdSerial,
    required this.personImage,
    required this.personVideo,
    required this.deviceId,
  });

  String trackingNumber;
  String nationalCode;
  String nationalIdSerial;
  String personImage;
  String personVideo;
  String deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'nationalIdSerial': nationalIdSerial,
        'personImage': personImage,
        'personVideo': personVideo,
        'deviceId': deviceId,
      };
}
