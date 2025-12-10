class ShaparakPublicKeyModel {
  ShaparakPublicKeyModel({
    this.publicKey,
  });

  String? publicKey;

  factory ShaparakPublicKeyModel.fromJson(Map<String, dynamic> json) => ShaparakPublicKeyModel(
        publicKey: json['publicKey'],
      );

  Map<String, dynamic> toJson() => {
        'publicKey': publicKey,
      };
}
