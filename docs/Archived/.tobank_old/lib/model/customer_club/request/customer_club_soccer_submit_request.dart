import '../../../service/core/api_request_model.dart';

class CustomerClubSoccerSubmitRequest extends ApiRequestModel {
  CustomerClubSoccerSubmitRequest({
    this.matchId,
    this.matchPrediction,
  });

  String? matchId;
  String? matchPrediction;

  @override
  Map<String, dynamic> toJson() => {
        'match_id': matchId,
        'match_prediction': matchPrediction,
      };
}
