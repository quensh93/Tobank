import '../../../service/core/api_request_model.dart';

class UpdateGoftinoIdRequest extends ApiRequestModel {
  UpdateGoftinoIdRequest({
    required this.goftinoId,
  });

  String goftinoId;

  @override
  Map<String, dynamic> toJson() => {
        'goftino_id': goftinoId,
      };
}
