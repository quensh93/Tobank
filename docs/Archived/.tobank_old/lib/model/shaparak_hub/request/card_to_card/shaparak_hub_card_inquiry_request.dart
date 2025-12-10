import '../../../../service/core/api_request_model.dart';

class ShaparakHubCardInquiryRequest extends ApiRequestModel {
  ShaparakHubCardInquiryRequest({
    this.sourcePan,
    this.destinationPan,
    this.amount,
    this.bankName,
  });

  String? sourcePan;
  String? destinationPan;
  int? amount;
  String? bankName;

  @override
  Map<String, dynamic> toJson() => {
        'sourcePan': sourcePan,
        'destinationPAN': destinationPan,
        'amount': amount,
        'bankName': bankName,
      };
}
