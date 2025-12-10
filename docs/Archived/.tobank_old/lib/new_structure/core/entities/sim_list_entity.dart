import 'enums.dart';

class SimListEntity {
  final String title;
  final String simcard;
  final OperatorType simcardOperator;

  const SimListEntity({
    required this.title,
    required this.simcard,
    required this.simcardOperator,
  });

  factory SimListEntity.fromJson(Map<String, dynamic> json) {
    return SimListEntity(
      title: json['title'] as String,
      simcard: json['simcard'] as String,
      // simcardOperator: OperatorType.MCI,
      simcardOperator: OperatorType.fromJson(json['simcard_operator']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'title': title.trim(),
      'simcard': simcard.trim(),
      'simcard_operator': simcardOperator.toJson(),
    };

    return data;
  }

  @override
  String toString() {
    return 'SimListEntity(\n'
        'title: "$title"\n'
        'simcard: "$simcard"\n'
        'simcardOperator: "$simcardOperator"\n'
        ')';
  }
}