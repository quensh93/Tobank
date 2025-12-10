import '../../../service/core/api_request_model.dart';

class CardToCardRequestData extends ApiRequestModel {
  String? sourceCardNumber;
  String? cardExpMonth;
  String? cardExpYear;
  String? sourceBankName;
  String? sourceBankIcon;
  String? destinationCardNumber;
  String? destinationBankName;
  String? destinationBankIcon;
  int? amount;
  String? srcDescription;
  String? desDescription;
  String? password;
  String? cvv2;
  String? saveDestinationCard;
  String? saveDestinationName;
  late bool isSelectedDestination;
  String? transactionId;
  String? userAgent;
  String? platform;
  String? deviceId;
  int? refNumber;
  String category = 'gpay';

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'cvv2': cvv2,
        'password': password,
        'src_card': sourceCardNumber,
        'expire_month': cardExpMonth,
        'expire_year': cardExpYear,
        'dst_card': destinationCardNumber,
        'src_comment': srcDescription,
        'dst_comment': '',
        'save_dst_card': saveDestinationCard,
        'dst_card_name': saveDestinationName,
        'transaction_id': transactionId,
        'email': 'test@test.com',
        'user_agent': userAgent,
        'device_id': deviceId,
        'platform': platform,
        'ref_number': refNumber.toString(),
        'category': category.toString(),
      };
}
