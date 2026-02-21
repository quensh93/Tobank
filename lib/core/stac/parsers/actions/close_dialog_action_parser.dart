import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../registry/custom_component_registry.dart';
import '../../../helpers/logger.dart';
import '../../builders/close_dialog_action.dart';

/// Close Dialog Action Model
///
/// A custom STAC action that closes the current dialog.
///
/// Example JSON:
/// ```json
/// {
///   "actionType": "closeDialog"
/// }
/// ```
class CloseDialogActionModel {
  /// Optional result to return when closing the dialog
  final dynamic result;

  const CloseDialogActionModel({this.result});

  factory CloseDialogActionModel.fromJson(Map<String, dynamic> json) {
    return CloseDialogActionModel(result: json['result']);
  }

  Map<String, dynamic> toJson() {
    return {'actionType': 'closeDialog', if (result != null) 'result': result};
  }
}

/// Close Dialog Action Parser
///
/// Closes the current dialog by calling Navigator.pop(context)
class CloseDialogActionParser extends StacActionParser<StacCloseDialogAction> {
  const CloseDialogActionParser();

  @override
  String get actionType => 'closeDialog';

  @override
  StacCloseDialogAction getModel(Map<String, dynamic> json) =>
      StacCloseDialogAction(result: json['result']);

  @override
  FutureOr onCall(BuildContext context, StacCloseDialogAction model) async {
    try {
      AppLogger.d('Closing dialog...');
      Navigator.of(context).pop(model.result);
      AppLogger.d('✅ Dialog closed');
    } catch (e, stackTrace) {
      AppLogger.e('Error closing dialog: $e', e, stackTrace);
    }
  }
}

/// Register the close dialog action parser
void registerCloseDialogActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const CloseDialogActionParser(),
  );
}
