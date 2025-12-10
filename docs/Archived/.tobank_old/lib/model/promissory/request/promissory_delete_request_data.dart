import '../../../service/core/api_request_model.dart';

class PromissoryDeleteRequestData extends ApiRequestModel {
  PromissoryDeleteRequestData({
    required this.id,
    required this.docType,
  });

  int id;
  String docType;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'docType': docType,
      };
}
