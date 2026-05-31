import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../../registry/custom_component_registry.dart';
import '../../../../core/helpers/logger.dart';
import './close_dialog_action.dart';

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
