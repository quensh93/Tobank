import 'package:stac/stac.dart';

class StacFormatNumberAction extends StacAction {
  final String sourceKey;
  final String destinationKey;

  const StacFormatNumberAction({
    required this.sourceKey,
    required this.destinationKey,
  });

  @override
  String get actionType => 'formatNumber';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': 'formatNumber',
    'sourceKey': sourceKey,
    'destinationKey': destinationKey,
  };

  factory StacFormatNumberAction.fromJson(Map<String, dynamic> json) {
    return StacFormatNumberAction(
      sourceKey: json['sourceKey'] as String,
      destinationKey: json['destinationKey'] as String,
    );
  }
}
