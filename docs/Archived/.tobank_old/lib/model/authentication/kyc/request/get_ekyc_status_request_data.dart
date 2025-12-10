import '../../../../service/core/api_request_model.dart';

class GetEkycStatusRequestData extends ApiRequestModel {
  GetEkycStatusRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.deviceId,
    required this.returnHasNationalId,
  });

  String trackingNumber;
  String nationalCode;
  String deviceId;
  bool returnHasNationalId;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'deviceId': deviceId,
        'returnHasNationalId': returnHasNationalId,
      };
}
