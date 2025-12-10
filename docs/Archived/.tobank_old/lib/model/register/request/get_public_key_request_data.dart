import '../../../service/core/api_request_model.dart';

class GetPublicKeyRequestData extends ApiRequestModel {
  GetPublicKeyRequestData({
    this.trackingNumber,
    this.customerNumber,
  });

  String? trackingNumber;
  String? customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
      };
}
