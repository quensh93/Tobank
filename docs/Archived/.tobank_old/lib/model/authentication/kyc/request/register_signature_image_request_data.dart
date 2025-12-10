import '../../../../service/core/api_request_model.dart';

class RegisterSignatureImageRequestData extends ApiRequestModel {
  RegisterSignatureImageRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.personSignatureImage,
    required this.deviceId,
  });

  String trackingNumber;
  String nationalCode;
  String personSignatureImage;
  String deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'personSignatureImage': personSignatureImage,
        'deviceId': deviceId,
      };
}
