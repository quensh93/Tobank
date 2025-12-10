import '../../../service/core/api_request_model.dart';

class DeleteDepositRequest extends ApiRequestModel {
  DeleteDepositRequest({
    this.id,
  });

  int? id;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
