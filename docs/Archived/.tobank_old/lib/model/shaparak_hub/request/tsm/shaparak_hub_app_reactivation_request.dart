import '../../../../service/core/api_request_model.dart';

class ShaparakHubAppReactivationRequest extends ApiRequestModel {
  ShaparakHubAppReactivationRequest({
    this.appUrlPattern,
    this.trackingNumber,
  });

  String? appUrlPattern;
  String? trackingNumber;

  @override
  Map<String, dynamic> toJson() => {
        'appUrlPattern': appUrlPattern,
        'trackingNumber': trackingNumber,
      };
}
