import '../../../service/core/api_request_model.dart';

class CharityPaymentRequestData extends ApiRequestModel {
  int amount;
  int discount;
  int wallet;
  String refId;
  int charityId;

  CharityPaymentRequestData({
    required this.amount,
    required this.discount,
    required this.wallet,
    required this.refId,
    required this.charityId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'wallet': wallet.toString(),
        'callback': '',
        'client_ref': refId.toString(),
        'discount': discount,
      };
}
