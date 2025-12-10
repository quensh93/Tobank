import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../registry/custom_component_registry.dart';
import '../../../helpers/logger.dart';

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

  const CloseDialogActionModel({
    this.result,
  });

  factory CloseDialogActionModel.fromJson(Map<String, dynamic> json) {
    return CloseDialogActionModel(
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': 'closeDialog',
      if (result != null) 'result': result,
    };
  }
}

/// StacAction wrapper for CloseDialogActionModel
class StacCloseDialogAction extends StacAction {
  const StacCloseDialogAction({
    this.result,
  });

  final dynamic result;

  @override
  String get actionType => 'closeDialog';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'closeDialog',
      if (result != null) 'result': result,
    };
  }
}

/// Close Dialog Action Parser
///
/// Closes the current dialog by calling Navigator.pop(context)
class CloseDialogActionParser extends StacActionParser<CloseDialogActionModel> {
  const CloseDialogActionParser();

  @override
  String get actionType => 'closeDialog';

  @override
  CloseDialogActionModel getModel(Map<String, dynamic> json) =>
      CloseDialogActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, CloseDialogActionModel model) async {
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
  CustomComponentRegistry.instance.registerAction(const CloseDialogActionParser());
}
