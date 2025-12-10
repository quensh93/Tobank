import '../../../service/core/api_request_model.dart';

class TransferStatusRequestData extends ApiRequestModel {
  TransferStatusRequestData({
    this.trackingNumber,
    this.financialTransactionId,
    this.customerNumber,
  });

  String? trackingNumber;
  String? financialTransactionId;
  String? customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'financialTransactionId': financialTransactionId,
        'customerNumber': customerNumber,
      };
}
