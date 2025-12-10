import '../../../service/core/api_request_model.dart';

class CustomerInfoRequest extends ApiRequestModel {
  CustomerInfoRequest({
    required this.trackingNumber,
    required this.nationalCode,
    required this.forceCacheUpdate,
    required this.forceInquireAddressInfo,
    required this.getCustomerStartableProcesses,
    required this.getCustomerDeposits,
    required this.getCustomerActiveCertificate,
  });

  String trackingNumber;
  String nationalCode;
  bool forceCacheUpdate;
  bool forceInquireAddressInfo;
  bool getCustomerStartableProcesses;
  bool getCustomerDeposits;
  bool getCustomerActiveCertificate;

  factory CustomerInfoRequest.fromJson(Map<String, dynamic> json) => CustomerInfoRequest(
        trackingNumber: json['trackingNumber'],
        nationalCode: json['nationalCode'],
        forceCacheUpdate: json['forceCacheUpdate'],
        forceInquireAddressInfo: json['forceInquireAddressInfo'],
        getCustomerStartableProcesses: json['getCustomerStartableProcesses'],
        getCustomerDeposits: json['getCustomerDeposits'],
        getCustomerActiveCertificate: json['getCustomerActiveCertificate'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'forceCacheUpdate': forceCacheUpdate,
        'forceInquireAddressInfo': forceInquireAddressInfo,
        'getCustomerStartableProcesses': getCustomerStartableProcesses,
        'getCustomerDeposits': getCustomerDeposits,
        'getCustomerActiveCertificate': getCustomerActiveCertificate,
      };
}
