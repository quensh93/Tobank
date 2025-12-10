import 'dart:convert';

EncryptedData encryptedDataFromJson(String str) => EncryptedData.fromJson(json.decode(str));

String encryptedDataToJson(EncryptedData data) => json.encode(data.toJson());

class EncryptedData {
  EncryptedData({
    this.iv,
    this.key,
    this.data,
  });

  String? iv;
  String? key;
  String? data;

  factory EncryptedData.fromJson(Map<String, dynamic> json) => EncryptedData(
        iv: json['iv'],
        key: json['key'],
        data: json['data'],
      );

  Map<String, dynamic> toJson() =>
      {
        'iv': iv,
        'key': key,
        'data': data,
      };
}
