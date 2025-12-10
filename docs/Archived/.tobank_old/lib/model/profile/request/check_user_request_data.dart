import '../../../service/core/api_request_model.dart';

class CheckUserRequestData extends ApiRequestModel {
  CheckUserRequestData({
    this.nationalCode,
    this.birthDate,
  });

  String? nationalCode;
  String? birthDate;

  @override
  Map<String, dynamic> toJson() => {
        'national_code': nationalCode,
        'birth_date': birthDate,
      };
}
