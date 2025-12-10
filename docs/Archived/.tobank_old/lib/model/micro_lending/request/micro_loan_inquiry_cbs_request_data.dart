import '../../../../service/core/api_request_model.dart';

class MicroLoanInquiryCbsRequestData extends ApiRequestModel {
  String? orderId;

  MicroLoanInquiryCbsRequestData({
    this.orderId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'order_id': orderId,
      };
}
