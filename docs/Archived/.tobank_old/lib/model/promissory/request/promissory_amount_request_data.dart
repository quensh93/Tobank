import '../../../service/core/api_request_model.dart';

class PromissoryAmountRequestData extends ApiRequestModel {
  PromissoryAmountRequestData({
    required this.amount,
    required this.gssToYekta,
  });

  int amount;
  bool gssToYekta;

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'gss_to_yekta': gssToYekta,
      };
}
