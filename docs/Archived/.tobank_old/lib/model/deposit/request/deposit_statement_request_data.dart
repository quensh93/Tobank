import '../../../service/core/api_request_model.dart';

class DepositStatementRequestData extends ApiRequestModel {
  DepositStatementRequestData({
    this.trackingNumber,
    this.depositNumber,
    this.fromDate,
    this.toDate,
    this.pageNumber,
    this.pageSize,
    this.customerNumber,
  });

  String? trackingNumber;
  String? depositNumber;
  String? customerNumber;
  String? fromDate;
  String? toDate;
  int? pageNumber;
  int? pageSize;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'depositNumber': depositNumber,
        'customerNumber': customerNumber,
        'fromDate': fromDate,
        'toDate': toDate,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
}
