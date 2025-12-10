import '../../../service/core/api_request_model.dart';

class SubmitSafeBoxRequestData extends ApiRequestModel {
  SubmitSafeBoxRequestData({
    this.wallet,
    this.fundId,
    this.referTimeId,
  });

  int? wallet;
  int? fundId;
  int? referTimeId;

  @override
  Map<String, dynamic> toJson() => {
        'wallet': wallet,
        'fund_id': fundId,
        'refer_time_id': referTimeId,
      };
}
