import '../../../../service/core/api_request_model.dart';

class GetActiveCertificateRequestData extends ApiRequestModel {
  GetActiveCertificateRequestData({
    required this.trackingNumber,
    required this.personType,
  });

  String trackingNumber;
  int personType;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'personType': personType,
      };
}
