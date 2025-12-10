import '../../../service/core/api_request_model.dart';

class TransferHistoryRequestData extends ApiRequestModel {
  TransferHistoryRequestData({
    this.trackingNumber,
    this.fromDate,
    this.toDate,
    this.financialTransactionStatuses,
    this.transferTypes,
    this.pageSize,
    this.offset,
    this.customerNumber,
  });

  String? trackingNumber;
  int? fromDate;
  int? toDate;
  List<int>? financialTransactionStatuses;
  List<int>? transferTypes;
  int? pageSize;
  int? offset;
  String? customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'fromDate': fromDate,
        'toDate': toDate,
        'financialTransactionStatuses': financialTransactionStatuses == null
            ? null
            : List<dynamic>.from(financialTransactionStatuses!.map((x) => x)),
        'transferTypes': transferTypes == null ? null : List<dynamic>.from(transferTypes!.map((x) => x)),
        'pageSize': pageSize,
        'offset': offset,
        'customerNumber': customerNumber,
      };
}
