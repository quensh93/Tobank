import 'enums.dart';

class ChargeAndPackagePaymentPlanParams {
  final int amount;
  final int maximumAmount;
  final int minimumAmount;
  final double taxPercent;
  final String depositNumber;
  final String mobile;
  final ChargeAndPackageType serviceType;
  final ChargeAndPackageTagType productType;
  final String productCode;
  final bool wallet;
  final ChargeAndPackageType chargeAndPackageType;
  final OperatorType operatorType;

  const ChargeAndPackagePaymentPlanParams({
    required this.amount,
    required this.maximumAmount,
    required this.minimumAmount,
    required this.taxPercent,
    required this.depositNumber,
    required this.mobile,
    required this.serviceType,
    required this.productCode,
    required this.productType,
    required this.wallet,
    required this.chargeAndPackageType,
    required this.operatorType,
  });

  factory ChargeAndPackagePaymentPlanParams.fromJson(Map<String, dynamic> json) {
    return ChargeAndPackagePaymentPlanParams(
      amount: json['amount'] as int,
      maximumAmount: json['maximum_amount'] as int,
      minimumAmount: json['minimum_amount'] as int,
      taxPercent: json['tax_percent'] as double,
      depositNumber: json['deposit_number'] as String,
      mobile: json['mobile'] as String,
      serviceType: ChargeAndPackageType.fromJson(json['service_type']),
      productType: ChargeAndPackageTagType.fromJson(json['product_code']),
      productCode: json['product_type'] as String,
      wallet: json['wallet'] as bool,
      chargeAndPackageType: json['charge_and_package_type'] as ChargeAndPackageType,
      operatorType: json['operator_type'] as OperatorType,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'amount': amount,
      'deposit_number': depositNumber.trim(),
      'mobile': mobile.trim(),
      'service_type': serviceType.toJson(),
      'product_code': productCode.trim(),
      'product_type': productType.toJson(),
      'wallet': wallet,
      'tax_percent': taxPercent,
      'operator_type': operatorType.toJson(),
    };

    return data;
  }

  @override
  String toString() {
    return 'ChargeAndPackagePaymentPlanParams(\n'
        'amount: $amount\n'
        'depositNumber: "$depositNumber"\n'
        'mobile: "$mobile"\n'
        'serviceType: "$serviceType"\n'
        'productCode: "$productCode"\n'
        'productType: "$productType"\n'
        'wallet: $wallet\n'
        ')';
  }
}
