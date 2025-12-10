import '../../../service/core/api_request_model.dart';
import '../../../util/enums_constants.dart';

class PromissoryPublishPaymentRequestData extends ApiRequestModel {
  PromissoryPublishPaymentRequestData({
    required this.transactionType,
    required this.depositNumber,
    required this.id,
    required this.gssToYekta,
  });

  PaymentType transactionType;
  String? depositNumber;
  int id;
  bool gssToYekta;

  @override
  Map<String, dynamic> toJson() => {
        'transaction_type': transactionType.name,
        'deposit_number': depositNumber,
        'id': id,
        'gss_to_yekta': gssToYekta,
      };
}
