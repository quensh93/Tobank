class SignerInfo {
  final String customerNumber;
  final String portion;
  final String customerRelationWithDepositPersian;
  final String customerRelationWithDepositEnglish;
  final String fullName;

  SignerInfo({
    required this.customerNumber,
    required this.portion,
    required this.customerRelationWithDepositPersian,
    required this.customerRelationWithDepositEnglish,
    required this.fullName,
  });

  factory SignerInfo.fromJson(Map<String, dynamic> json) {
    return SignerInfo(
      customerNumber: json['CustomerNumber'] as String,
      portion: json['Portion'] as String,
      customerRelationWithDepositPersian: json['CustomerRelationWithDepositPersian'] as String,
      customerRelationWithDepositEnglish: json['CustomerRelationWithDepositEnglish'] as String,
      fullName: json['FullName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CustomerNumber': customerNumber,
      'Portion': portion,
      'CustomerRelationWithDepositPersian': customerRelationWithDepositPersian,
      'CustomerRelationWithDepositEnglish': customerRelationWithDepositEnglish,
      'FullName': fullName,
    };
  }

  @override
  String toString() {
    return 'SignerInfo(\n'
        '  customerNumber: $customerNumber\n'
        '  portion: $portion\n'
        '  customerRelationWithDepositPersian: $customerRelationWithDepositPersian\n'
        '  customerRelationWithDepositEnglish: $customerRelationWithDepositEnglish\n'
        '  fullName: $fullName\n'
        ')';
  }
}