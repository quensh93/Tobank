import '../../../service/core/api_request_model.dart';

class CreditInquiryRequest extends ApiRequestModel {
  CreditInquiryRequest({
    required this.chequeId,
  });

  String chequeId;

  @override
  Map<String, dynamic> toJson() => {
        'chequeId': chequeId,
      };
}
