import '../../../service/core/api_request_model.dart';

class CardToCardDynamicPasswordRequestData extends ApiRequestModel {
  String sourcePAN;
  String destinationPAN;
  int amount;

  CardToCardDynamicPasswordRequestData({
    required this.sourcePAN,
    required this.destinationPAN,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {'sourcePAN': sourcePAN, 'destinationPAN': destinationPAN, 'amount': amount};
}
