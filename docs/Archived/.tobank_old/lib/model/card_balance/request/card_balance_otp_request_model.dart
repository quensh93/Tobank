import '../../../service/core/api_request_model.dart';

class CardBalanceOTPRequestModel extends ApiRequestModel {
  CardBalanceOTPRequestModel({
    this.cardNumber,
  });

  String? cardNumber;

  @override
  Map<String, dynamic> toJson() => {
        'cardNumber': cardNumber,
      };
}
