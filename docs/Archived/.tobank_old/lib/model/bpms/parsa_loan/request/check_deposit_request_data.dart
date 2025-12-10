import '../../../../service/core/api_request_model.dart';

class CheckDepositRequestData extends ApiRequestModel {
  String? depositNumber;

  CheckDepositRequestData({
    this.depositNumber,
  });

  @override
  Map<String, dynamic> toJson() => {
        'deposit_number': depositNumber,
      };
}
