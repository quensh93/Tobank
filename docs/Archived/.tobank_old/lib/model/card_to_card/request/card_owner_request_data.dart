import '../../../service/core/api_request_model.dart';

class CardOwnerRequestData extends ApiRequestModel {
  CardOwnerRequestData({
    this.srcCard,
    this.dstCard,
    this.amount,
    this.userAgent,
    this.deviceId,
    this.platform,
  });

  String? srcCard;
  String? dstCard;
  int? amount;
  String? userAgent;
  String? deviceId;
  String? platform;

  @override
  Map<String, dynamic> toJson() => {
        'src_card': srcCard,
        'dst_card': dstCard,
        'amount': amount,
        'email': 'test@test.com',
        'user_agent': userAgent,
        'device_id': deviceId,
        'platform': platform,
      };
}
