import '../../../service/core/api_request_model.dart';

class AuthorizedApiTokenRequest extends ApiRequestModel {
  AuthorizedApiTokenRequest({
    this.trackingNumber,
    this.nationalCode,
    this.birthDate,
  });

  String? trackingNumber;
  String? nationalCode;
  String? birthDate;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'birthDate': birthDate,
      };
}
