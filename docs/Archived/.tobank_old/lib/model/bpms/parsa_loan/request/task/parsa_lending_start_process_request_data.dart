import '../../../../../service/core/api_request_model.dart';

class ParsaLendingStartProcessRequestData extends ApiRequestModel {
  int? processId;
  Map<String, dynamic>? extraData;

  ParsaLendingStartProcessRequestData({
    this.processId,
    this.extraData,
  });

  @override
  Map<String, dynamic> toJson() => {
        'process_id': processId,
        'extra_data': extraData,
      };
}
