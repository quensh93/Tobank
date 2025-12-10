import '../../../service/core/api_request_model.dart';

class PromissoryGuaranteeFinalizeRequestData extends ApiRequestModel {
  PromissoryGuaranteeFinalizeRequestData({
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
