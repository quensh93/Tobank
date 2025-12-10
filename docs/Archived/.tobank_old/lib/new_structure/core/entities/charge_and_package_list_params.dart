import 'enums.dart';

class ChargeAndPackageListParams {
  final String mobile;
  final ChargeAndPackageType serviceType;
  final SimType? simcardType;
  final OperatorType? operator;

  // final ChargeAndPackageType serviceType;

  const ChargeAndPackageListParams({
    required this.mobile,
    required this.serviceType,
    this.simcardType,
    this.operator,
  });

  factory ChargeAndPackageListParams.fromJson(Map<String, dynamic> json) {
    return ChargeAndPackageListParams(
      mobile: json['mobile'] as String,
      serviceType: ChargeAndPackageType.fromJson(json['service_type']),
      simcardType: SimType.fromJson(json['simcard_type']),
      operator: OperatorType.fromJson(json['operator'])
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'mobile': mobile,
      'service_type': serviceType.toJson(),
      'simcard_type' : simcardType?.toJson(),
      'operator' : operator?.toJson(),
    };

    return data;
  }
}