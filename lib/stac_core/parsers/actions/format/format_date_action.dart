import 'package:stac/stac.dart';

class StacFormatDateAction extends StacAction {
  final String sourceKey;
  final String destinationKey;

  const StacFormatDateAction({
    required this.sourceKey,
    required this.destinationKey,
  });

  @override
  String get actionType => 'formatDate';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': 'formatDate',
    'sourceKey': sourceKey,
    'destinationKey': destinationKey,
  };

  factory StacFormatDateAction.fromJson(Map<String, dynamic> json) {
    return StacFormatDateAction(
      sourceKey: json['sourceKey'] as String,
      destinationKey: json['destinationKey'] as String,
    );
  }
}
