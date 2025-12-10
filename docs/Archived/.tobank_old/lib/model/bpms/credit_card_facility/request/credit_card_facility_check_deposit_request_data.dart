import '../../../../service/core/api_request_model.dart';

class CreditCardFacilityCheckDepositRequestData extends ApiRequestModel {
  String? depositNumber;

  CreditCardFacilityCheckDepositRequestData({
    this.depositNumber,
  });

  @override
  Map<String, dynamic> toJson() => {
        'deposit_number': depositNumber,
      };
}
