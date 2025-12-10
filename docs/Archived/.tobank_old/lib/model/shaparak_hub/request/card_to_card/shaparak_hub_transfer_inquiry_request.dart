import '../../../../service/core/api_request_model.dart';

class ShaparakHubTransferInquiryRequest extends ApiRequestModel {
  ShaparakHubTransferInquiryRequest({
    this.transactionId,
    this.registrationDate,
    this.amount,
  });

  String? transactionId;
  int? registrationDate;
  int? amount;

  @override
  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'amount': amount,
      };
}
