import '../../../service/core/api_request_model.dart';

class ModernBankingChangePasswordRequest extends ApiRequestModel {
  ModernBankingChangePasswordRequest({
    this.trackingNumber,
    this.customerNumber,
    this.username,
    this.subsystem,
    this.authenticationType,
  });

  String? trackingNumber;
  String? customerNumber;
  String? username;
  int? subsystem;
  int? authenticationType;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'userName': username,
        'subsystem': subsystem,
        'authenticationType': authenticationType,
      };
}
