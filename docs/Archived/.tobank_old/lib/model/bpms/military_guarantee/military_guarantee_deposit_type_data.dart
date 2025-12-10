import 'package:equatable/equatable.dart';

class MilitaryGuaranteeDepositTypeData extends Equatable {
  final String title;
  final String description;
  final int id;

  const MilitaryGuaranteeDepositTypeData({
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
