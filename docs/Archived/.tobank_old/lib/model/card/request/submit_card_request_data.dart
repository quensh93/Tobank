import '../../../service/core/api_request_model.dart';

class SubmitCardRequest extends ApiRequestModel {
  SubmitCardRequest({
    required this.title,
    required this.cardNumber,
    required this.cardExpMonth,
    required this.cardExpYear,
    required this.isMine,
  });

  String title;
  String cardNumber;
  String? cardExpMonth;
  String? cardExpYear;
  bool isMine;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> tempMap = {'title': title, 'card_number': cardNumber, 'is_mine': isMine};
    
    if (cardExpMonth != null) {
      tempMap['card_exp_month'] = cardExpMonth;
    }
    if (cardExpYear != null) {
      tempMap['card_exp_year'] = cardExpYear;
    }
    return tempMap;
  }
}
