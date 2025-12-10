import '../../../service/core/api_request_model.dart';

class UpdateAvatarByIdRequest extends ApiRequestModel {
  UpdateAvatarByIdRequest({
    required this.avatarId,
  });

  int avatarId;

  @override
  Map<String, dynamic> toJson() => {
        'avatar_id': avatarId,
      };
}
