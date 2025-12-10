import '../../../service/core/api_request_model.dart';

class IbanInquiryRequestData extends ApiRequestModel {
  IbanInquiryRequestData({
    this.trackingNumber,
    this.destinationDepositNumber,
    this.destinationIban,
    this.amount,
    this.referenceNumber,
    this.customerNumber,
  });

  String? trackingNumber;
  String? destinationDepositNumber;
  String? destinationIban;
  int? amount;
  String? referenceNumber;
  String? customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'destinationDepositNumber': destinationDepositNumber,
        'destinationIban': destinationIban,
        'amount': amount,
        'referenceNumber': referenceNumber,
        'customerNumber': customerNumber,
      };
}
