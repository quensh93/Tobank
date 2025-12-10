import '../../../service/core/api_request_model.dart';

class GetBillDetailByPayIdBillIdRequest extends ApiRequestModel {
  GetBillDetailByPayIdBillIdRequest({
    this.billId,
    this.payId,
  });

  String? billId;
  String? payId;

  @override
  Map<String, dynamic> toJson() => {
        'bill_id': billId,
        'pay_id': payId,
      };
}
