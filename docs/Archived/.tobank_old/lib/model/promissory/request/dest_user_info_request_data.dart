import '../../../service/core/api_request_model.dart';

class DestUserInfoRequestData extends ApiRequestModel {
  DestUserInfoRequestData({
    required this.birthDate,
    required this.nationalCode,
    required this.mobile,
  });

  String birthDate;
  String nationalCode;
  String mobile;

  @override
  Map<String, dynamic> toJson() => {
        'birth_date': birthDate,
        'national_code': nationalCode,
        'mobile': mobile,
      };
}
