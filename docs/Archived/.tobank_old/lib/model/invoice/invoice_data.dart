import '../../service/core/api_request_model.dart';

class InvoiceData extends ApiRequestModel {
  int? amount;
  String? billId;
  String? payId;
  String? title;
  String? barcode;
  late bool isWallet;
  int? discount;
  String? token;

  @override
  Map<String, dynamic> toJson() => {
        'bill_id': billId,
        'pay_id': payId,
        'wallet': isWallet ? 1 : 0,
        'discount': discount,
        'token': token,
      };
}
