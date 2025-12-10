import '../../../service/core/api_request_model.dart';

class SignUpData extends ApiRequestModel {
  SignUpData({
    this.mobile,
    this.password,
    this.nationalCode,
    this.birthDate,
    this.type,
  });

  String? mobile;
  String? password;
  String? nationalCode;
  String? birthDate;
  String? type;

  @override
  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'password': password,
        'national_code': nationalCode,
        'birth_date': birthDate,
        'type': type,
      };
}
