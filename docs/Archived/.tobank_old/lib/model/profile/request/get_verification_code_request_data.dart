import '../../../service/core/api_request_model.dart';

class GetVerificationCodeRequestData extends ApiRequestModel {
  GetVerificationCodeRequestData({
    required this.phoneNumber,
  });

  String phoneNumber;

  factory GetVerificationCodeRequestData.fromJson(Map<String, dynamic> json) => GetVerificationCodeRequestData(
        phoneNumber: json['mobile'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'mobile': phoneNumber,
      };
}
