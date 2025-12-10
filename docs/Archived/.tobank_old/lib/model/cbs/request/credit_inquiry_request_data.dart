import '../../../service/core/api_request_model.dart';
import '../../../util/enums_constants.dart';

class CreditInquiryRequestData extends ApiRequestModel {
  CreditInquiryRequestData({
    required this.verifyCode,
    required this.mobile,
    required this.nationalCode,
    required this.transactionType,
    required this.depositNumber,
  });

  String? verifyCode;
  String mobile;
  String nationalCode;
  PaymentType transactionType;
  String? depositNumber;

  @override
  Map<String, dynamic> toJson() => {
        'verify_otp': verifyCode,
        'mobile': mobile,
        'national_code': nationalCode,
        'transaction_type': transactionType.name,
        'deposit_number': depositNumber,
      };
}
