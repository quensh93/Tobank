class EncryptionKeyPair {
  final String publicKey;
  final String privateKey;

  EncryptionKeyPair({required this.publicKey, required this.privateKey});

  factory EncryptionKeyPair.fromJson(Map<String, dynamic> json) {
    return EncryptionKeyPair(
      publicKey: json['publicKey'] as String,
      privateKey: json['privateKey'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'publicKey': publicKey, 'privateKey': privateKey};
  }
}
