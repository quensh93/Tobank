import '../../../../service/core/api_request_model.dart';

class ParsaLoanInquiryCbsRequestData extends ApiRequestModel {
  String? orderId;

  ParsaLoanInquiryCbsRequestData({
    this.orderId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'order_id': orderId,
      };
}
