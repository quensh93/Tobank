import '../../../../service/core/api_request_model.dart';

class RenewCertificateRequestData extends ApiRequestModel {
  RenewCertificateRequestData({
    required this.trackingNumber,
    required this.destinationProvider,
    required this.nationalCode,
    required this.globalFirstName,
    required this.globalLastName,
    required this.occupation,
    required this.email,
    required this.landLineNumber,
    required this.certificateRequestData,
  });

  String trackingNumber;
  String destinationProvider;
  String nationalCode;
  String? globalFirstName;
  String? globalLastName;
  String occupation;
  String? email;
  String landLineNumber;
  String certificateRequestData;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'destinationProvider': destinationProvider,
        'nationalCode': nationalCode,
        'globalFirstName': globalFirstName,
        'globalLastName': globalLastName,
        'occupation': occupation,
        'email': email,
        'landLineNumber': landLineNumber,
        'certificateRequestData': certificateRequestData,
      };
}
