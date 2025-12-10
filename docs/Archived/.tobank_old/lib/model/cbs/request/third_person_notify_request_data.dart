import '../../../service/core/api_request_model.dart';

class ThirdPersonNotifyRequestData extends ApiRequestModel {
  ThirdPersonNotifyRequestData({
    required this.mobile,
  });

  String mobile;

  @override
  Map<String, dynamic> toJson() => {
        'mobile': mobile,
      };
}
