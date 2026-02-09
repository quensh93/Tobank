import 'package:stac_core/stac_core.dart';

class StacPromissorySignAction extends StacAction {
  final String? unsignedContract;
  final Map<String, dynamic>? signLocation;
  final String? promissoryTitle;
  final Map<String, dynamic>? onSuccess;
  final Map<String, dynamic>? onFailure;

  const StacPromissorySignAction({
    this.unsignedContract,
    this.signLocation,
    this.promissoryTitle,
    this.onSuccess,
    this.onFailure,
  });

  @override
  String get actionType => 'promissorySign';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'promissorySign',
      if (unsignedContract != null) 'unsignedContract': unsignedContract,
      if (signLocation != null) 'signLocation': signLocation,
      if (promissoryTitle != null) 'promissoryTitle': promissoryTitle,
      if (onSuccess != null)
        'onSuccess': onSuccess is StacAction
            ? (onSuccess as StacAction).toJson()
            : onSuccess,
      if (onFailure != null)
        'onFailure': onFailure is StacAction
            ? (onFailure as StacAction).toJson()
            : onFailure,
    };
  }
}
