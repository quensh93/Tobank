class EncryptionKeyPair {
  String publicKey;
  String privateKey;

  EncryptionKeyPair({required this.publicKey, required this.privateKey});

  factory EncryptionKeyPair.fromJson(Map<String, dynamic> json) => EncryptionKeyPair(
        publicKey: json['public_key'],
        privateKey: json['private_key'],
      );

  Map<String, dynamic> toJson() => {
        'public_key': publicKey,
        'private_key': privateKey,
      };
}
