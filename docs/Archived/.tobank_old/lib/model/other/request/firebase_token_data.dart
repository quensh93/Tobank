import '../../../service/core/api_request_model.dart';

class FirebaseTokenData extends ApiRequestModel {

  String? registrationId;
  String? type;
  String? deviceId;
  String? name;

  @override
  Map<String, dynamic> toJson() => {
        'registration_id': registrationId,
        'type': type,
        'device_id': deviceId,
        'name': name,
      };
}
