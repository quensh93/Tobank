import 'package:stac_core/stac_core.dart';

class StacAmountToWordsAction extends StacAction {
  final String sourceKey;
  final String destinationKey;
  final int divideBy;
  final int minDigits;
  final String suffix;

  const StacAmountToWordsAction({
    required this.sourceKey,
    required this.destinationKey,
    this.divideBy = 10,
    this.minDigits = 2,
    this.suffix = 'تومان',
  });

  @override
  String get actionType => 'amountToWords';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'sourceKey': sourceKey,
    'destinationKey': destinationKey,
    'divideBy': divideBy,
    'minDigits': minDigits,
    'suffix': suffix,
  };

  factory StacAmountToWordsAction.fromJson(Map<String, dynamic> json) {
    return StacAmountToWordsAction(
      sourceKey: json['sourceKey'] as String,
      destinationKey: json['destinationKey'] as String,
      divideBy: (json['divideBy'] as num?)?.toInt() ?? 10,
      minDigits: (json['minDigits'] as num?)?.toInt() ?? 2,
      suffix: json['suffix'] as String? ?? 'تومان',
    );
  }
}
