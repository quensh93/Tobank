import 'dart:convert';

List<KeyAliasModel> keyAliasModelFromJson(String str) =>
    List<KeyAliasModel>.from(json.decode(str).map((x) => KeyAliasModel.fromJson(x)));

String keyAliasModelToJson(List<KeyAliasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KeyAliasModel {
  String keyAlias;
  int timestamp;

  KeyAliasModel({
    required this.keyAlias,
    required this.timestamp,
  });

  factory KeyAliasModel.fromJson(Map<String, dynamic> json) => KeyAliasModel(
        keyAlias: json['keyAlias'],
        timestamp: json['timestamp'],
      );

  Map<String, dynamic> toJson() => {
        'keyAlias': keyAlias,
        'timestamp': timestamp,
      };
}
