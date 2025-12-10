import '../../../../service/core/api_request_model.dart';

class ShaparakHubGetCardInfoRequest extends ApiRequestModel {
  ShaparakHubGetCardInfoRequest({
    this.sourceCard,
    this.transactionId,
  });

  String? sourceCard;
  String? transactionId;

  @override
  Map<String, dynamic> toJson() => {
        'src_card': sourceCard,
        'transactionId': transactionId,
      };
}
