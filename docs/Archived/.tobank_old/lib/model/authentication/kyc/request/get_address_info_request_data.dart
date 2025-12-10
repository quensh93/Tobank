import '../../../../service/core/api_request_model.dart';

class GetAddressInfoRequestData extends ApiRequestModel {
  GetAddressInfoRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.postalCode,
    required this.declaredAddress,
    required this.deviceId,
  });

  String trackingNumber;
  String nationalCode;
  String? postalCode;
  String? declaredAddress;
  String? deviceId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'postalCode': postalCode,
        'declaredAddress': declaredAddress,
        'deviceId': deviceId,
      };
}
