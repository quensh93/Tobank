import '../../../../service/core/api_request_model.dart';

class InquiryCbsRequestData extends ApiRequestModel {
  String? orderId;
  int? transactionId;

  InquiryCbsRequestData({
    this.orderId,
    this.transactionId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'transaction_id': transactionId,
      };
}
