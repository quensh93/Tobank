import '../../../../service/core/api_request_model.dart';

class ShaparakHubRenewCardIdRequest extends ApiRequestModel {
  ShaparakHubRenewCardIdRequest({
    this.sourceCard,
    this.cardId,
    this.referenceExpiryDate,
  });

  String? sourceCard;
  String? cardId;
  String? referenceExpiryDate;

  @override
  Map<String, dynamic> toJson() => {
        'src_card': sourceCard,
        'cardId': cardId,
        'referenceExpiryDate': referenceExpiryDate,
      };
}
