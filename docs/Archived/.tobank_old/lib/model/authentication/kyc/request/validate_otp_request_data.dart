import '../../../../service/core/api_request_model.dart';

class ValidateOtpRequestData extends ApiRequestModel {
  ValidateOtpRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.otp,
    required this.deviceId,
  });

  String trackingNumber;
  String nationalCode;
  String otp;
  String deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'otp': otp,
        'deviceId': deviceId,
      };
}
