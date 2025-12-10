import '../../service/core/api_request_model.dart';

class MainPichakRequest extends ApiRequestModel {
  MainPichakRequest({
    required this.manaId,
    required this.trackingNumber,
    required this.cardId,
    required this.expiryDate,
    required this.authenticationMethod,
    required this.requestSecureEnvelope,
  });

  String? manaId;
  String trackingNumber;
  String cardId;
  String expiryDate;
  int authenticationMethod;
  RequestSecureEnvelope requestSecureEnvelope;

  @override
  Map<String, dynamic> toJson() => {
        'manaId': manaId,
        'trackingNumber': trackingNumber,
        'cardId': cardId,
        'expiryDate': expiryDate,
        'authenticationMethod': authenticationMethod,
        'requestSecureEnvelope': requestSecureEnvelope.toJson(),
      };
}

class RequestSecureEnvelope {
  RequestSecureEnvelope({
    required this.iv,
    required this.encryptedData,
    required this.encryptedKey,
    required this.keyEncryptionCipherSet,
  });

  String iv;
  String encryptedData;
  String encryptedKey;
  int keyEncryptionCipherSet;

  Map<String, dynamic> toJson() => {
        'iv': iv,
        'encryptedData': encryptedData,
        'encryptedKey': encryptedKey,
        'keyEncryptionCipherSet': keyEncryptionCipherSet,
      };
}
