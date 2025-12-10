import '../../../service/core/api_request_model.dart';

class OpenDepositRequest extends ApiRequestModel {
  OpenDepositRequest({
    required this.trackingNumber,
    required this.depositTypeCode,
    required this.customerNumber,
    this.branchCode,
  });

  String trackingNumber;
  String depositTypeCode;
  String customerNumber;
  String? branchCode;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'depositTypeCode': depositTypeCode,
        'customerNumber': customerNumber,
        'branchCode': branchCode,
      };
}
