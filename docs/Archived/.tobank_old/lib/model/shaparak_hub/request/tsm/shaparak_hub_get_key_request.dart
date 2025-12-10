import 'dart:convert';

String shaparakHubGetKeyRequestToJson(ShaparakHubGetKeyRequest data) => json.encode(data.toJson());

class ShaparakHubGetKeyRequest {
  ShaparakHubGetKeyRequest({
    this.transactionId,
    this.keyId,
  });

  String? transactionId;
  String? keyId;

  Map<String, dynamic> toJson() =>
      {
        'transactionId': transactionId,
        'keyId': keyId,
      };
}
