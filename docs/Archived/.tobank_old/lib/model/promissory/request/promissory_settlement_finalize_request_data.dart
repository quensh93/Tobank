import '../../../service/core/api_request_model.dart';

class PromissorySettlementFinalizeRequest extends ApiRequestModel {
  PromissorySettlementFinalizeRequest({
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
