import '../../../service/core/api_request_model.dart';

class UpdateAvatarWithFileRequest extends ApiRequestModel {
  UpdateAvatarWithFileRequest({
    required this.file,
  });

  String file;

  @override
  Map<String, dynamic> toJson() => {
        'file': file,
      };
}
