import '../../../service/core/api_request_model.dart';

class DeleteAccountRequestData extends ApiRequestModel {
  DeleteAccountRequestData({
    this.code,
  });

  int? code;

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
      };
}
