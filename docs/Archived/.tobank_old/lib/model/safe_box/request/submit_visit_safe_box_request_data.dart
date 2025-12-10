
import '../../../service/core/api_request_model.dart';

class SubmitVisitSafeBoxRequestData extends ApiRequestModel {
  SubmitVisitSafeBoxRequestData({
    this.visitTimeId,
    this.userFundId,
  });

  int? visitTimeId;
  int? userFundId;

  @override
  Map<String, dynamic> toJson() => {
        'visit_time_id': visitTimeId,
        'user_fund_id': userFundId,
      };
}
