import '../../../service/core/api_request_model.dart';

class MicroLendingSubmitDepositRequest extends ApiRequestModel {
  String depositNumber;

  MicroLendingSubmitDepositRequest({
    required this.depositNumber,
  });

  @override
  Map<String, dynamic> toJson() => {
        'deposit_number': depositNumber,
      };
}
