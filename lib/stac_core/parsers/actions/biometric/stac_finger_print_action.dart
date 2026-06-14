import 'package:stac/stac.dart';

class StacFingerPrintAction extends StacAction {
  final String? title;
  final String? description;
  final String? userId;
  final Map<String, dynamic>? onSuccess;
  final Map<String, dynamic>? onFailure;

  const StacFingerPrintAction({
    this.title,
    this.description,
    this.userId,
    this.onSuccess,
    this.onFailure,
  });

  @override
  String get actionType => 'fingerPrint';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'fingerPrint',
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (userId != null) 'userId': userId,
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
