// installment_list_data_entity.dart

class ChargeAndPackageAmountEntity {
  final int amount;
  final int amountWithTax;

  ChargeAndPackageAmountEntity({
    required this.amount,
    required this.amountWithTax
  });

  factory ChargeAndPackageAmountEntity.fromJson(Map<String, dynamic> json) {
    return ChargeAndPackageAmountEntity(
      amount: json['loan'] as int,
      amountWithTax: json['amountWithTax'] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'amountWithTax': amountWithTax
    };
  }
}