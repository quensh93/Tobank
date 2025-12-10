import 'dart:convert';

String automaticDynamicPinTransferRequestToJson(AutomaticDynamicPinTransferRequest data) => json.encode(data.toJson());

class AutomaticDynamicPinTransferRequest {
  AutomaticDynamicPinTransferRequest({
    required this.keyId,
    required this.cardNumber,
    required this.amount,
    required this.payeeCard,
    required this.cardAcceptorName,
  });

  String keyId;
  String cardNumber;
  int amount;
  String payeeCard;
  String cardAcceptorName;

  Map<String, dynamic> toJson() =>
      {
        'keyId': keyId,
        'cardNumber': cardNumber,
        'amount': amount,
        'payeeCard': payeeCard,
        'cardAcceptorName': cardAcceptorName,
      };
}
