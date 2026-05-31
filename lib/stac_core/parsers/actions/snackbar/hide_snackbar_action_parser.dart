import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/bootstrap/app_root.dart';

class HideSnackBarActionModel {
  const HideSnackBarActionModel();

  factory HideSnackBarActionModel.fromJson(Map<String, dynamic> json) {
    return const HideSnackBarActionModel();
  }
}

/// Hides currently visible snackbar.
class HideSnackBarActionParser
    extends StacActionParser<HideSnackBarActionModel> {
  const HideSnackBarActionParser();

  @override
  String get actionType => 'hideSnackBar';

  @override
  HideSnackBarActionModel getModel(Map<String, dynamic> json) {
    return HideSnackBarActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(BuildContext context, HideSnackBarActionModel model) {
    // Use app-root navigator context first; gesture context can be deactivated
    // when snackbar child is being removed.
    final rootContext = AppRoot.mainAppNavigatorKey.currentContext;
    final messenger = rootContext != null
        ? ScaffoldMessenger.maybeOf(rootContext)
        : (context.mounted ? ScaffoldMessenger.maybeOf(context) : null);
    messenger?.hideCurrentSnackBar();
    return null;
  }
}
