import 'dart:convert';

String automaticDynamicPinPreRegisterRequestToJson(AutomaticDynamicPinPreRegisterRequest data) =>
    json.encode(data.toJson());

class AutomaticDynamicPinPreRegisterRequest {
  AutomaticDynamicPinPreRegisterRequest({
    required this.mobile,
  });

  String mobile;

  Map<String, dynamic> toJson() => {'mobile': mobile};
}
