import '../../../../service/core/api_request_model.dart';

class GetOtpRequestData extends ApiRequestModel {
  GetOtpRequestData({
    required this.trackingNumber,
    required this.cellphoneNumber,
    required this.nationalCode,
    required this.birthDate,
    required this.deviceId,
  });

  String trackingNumber;
  String cellphoneNumber;
  String nationalCode;
  String birthDate;
  String deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'cellphoneNumber': cellphoneNumber,
        'nationalCode': nationalCode,
        'birthDate': birthDate,
        'deviceId': deviceId,
      };
}
