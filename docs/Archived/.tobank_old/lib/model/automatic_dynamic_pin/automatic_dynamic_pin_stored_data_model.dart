import 'dart:convert';

AutomaticDynamicPinStoredData automaticDynamicPinStoredDataFromJson(String str) =>
    AutomaticDynamicPinStoredData.fromJson(json.decode(str));

String automaticDynamicPinStoredDataToJson(AutomaticDynamicPinStoredData data) => json.encode(data.toJson());

class AutomaticDynamicPinStoredData {
  String publicKey;
  String privateKey;
  String keyId;

  AutomaticDynamicPinStoredData({
    required this.publicKey,
    required this.privateKey,
    required this.keyId,
  });

  factory AutomaticDynamicPinStoredData.fromJson(Map<String, dynamic> json) => AutomaticDynamicPinStoredData(
        publicKey: json['public_key'],
        privateKey: json['private_key'],
        keyId: json['key_id'],
      );

  Map<String, dynamic> toJson() => {
        'public_key': publicKey,
        'private_key': privateKey,
        'key_id': keyId,
      };
}
