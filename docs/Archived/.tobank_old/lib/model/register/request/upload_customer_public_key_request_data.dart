import '../../../service/core/api_request_model.dart';

class UploadCustomerPublicKeyRequest extends ApiRequestModel {
  UploadCustomerPublicKeyRequest({
    required this.trackingNumber,
    required this.customerNumber,
    required this.customerPublicKey,
  });

  String trackingNumber;
  String customerNumber;
  String customerPublicKey;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'customerPublicKey': customerPublicKey,
      };
}
