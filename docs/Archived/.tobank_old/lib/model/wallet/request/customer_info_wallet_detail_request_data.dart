import '../../../service/core/api_request_model.dart';

class CustomerInfoWalletDetailRequestData extends ApiRequestModel {
  String category;
  String type;
  String trackingNumber;
  String nationalCode;
  bool forceCacheUpdate;
  bool forceInquireAddressInfo;
  bool getCustomerStartableProcesses;
  bool getCustomerDeposits;
  bool getCustomerActiveCertificate;

  CustomerInfoWalletDetailRequestData({
    required this.category,
    required this.type,
    required this.trackingNumber,
    required this.nationalCode,
    required this.forceCacheUpdate,
    required this.forceInquireAddressInfo,
    required this.getCustomerStartableProcesses,
    required this.getCustomerDeposits,
    required this.getCustomerActiveCertificate,
  });

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'forceInquireAddressInfo': forceInquireAddressInfo,
        'category': category,
        'type': type,
        'forceCacheUpdate': forceCacheUpdate,
        'getCustomerStartableProcesses': getCustomerStartableProcesses,
        'getCustomerDeposits': getCustomerDeposits,
        'getCustomerActiveCertificate': getCustomerActiveCertificate,
      };
}
