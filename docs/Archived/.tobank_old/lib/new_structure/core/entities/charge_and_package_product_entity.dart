// charge_and_package_product_entity.dart
import 'charge_and_package_amount_entity.dart';
import 'enums.dart';

class ChargeAndPackageProductEntity {
  final OperatorType operator;
  final ChargeAndPackageType serviceType;
  final String name;
  final String code;
  final String type;
  final bool active;
  final SimType simType;
  final List<String> tags;
  final List<ChargeAndPackageAmountEntity> amounts;

  ChargeAndPackageProductEntity({
    required this.operator,
    required this.serviceType,
    required this.name,
    required this.code,
    required this.type,
    required this.active,
    required this.simType,
    required this.tags,
    required this.amounts,
  });

  factory ChargeAndPackageProductEntity.fromJson(Map<String, dynamic> json) {
    return ChargeAndPackageProductEntity(
      operator: OperatorType.fromJson(json['operator']),
      serviceType: ChargeAndPackageType.fromJson(json['serviceType']),
      name: json['name'] as String,
      code: json['code'] as String,
      type: json['type'] as String,
      active: json['active'] as bool,
      simType: SimType.fromJson(json['simType']),
      tags: (json['tags'] as List<dynamic>).cast<String>(),
      amounts: List<ChargeAndPackageAmountEntity>.from(json['amounts'].map((model)=> ChargeAndPackageAmountEntity.fromJson(model))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'operator': operator.toJson(),
      'serviceType': serviceType.toJson(),
      'name': name,
      'code': code,
      'type': type,
      'active': active,
      'simType': simType.toJson(),
      'tags': List<dynamic>.from(tags.map((x) => x.toString())),
      'amounts': List<dynamic>.from(amounts.map((x) => x.toJson())),
    };
  }
}