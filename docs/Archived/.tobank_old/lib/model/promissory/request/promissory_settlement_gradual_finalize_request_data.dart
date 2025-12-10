import '../../../service/core/api_request_model.dart';

class PromissorySettlementGradualFinalizeRequest extends ApiRequestModel {
  PromissorySettlementGradualFinalizeRequest({
    required this.id,
    required this.signedPdf,
  });

  int id;
  String signedPdf;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'signedPdf': signedPdf,
      };
}
