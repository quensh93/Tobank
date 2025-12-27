import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

class SequenceActionModel {
  final List<Map<String, dynamic>> actions;

  SequenceActionModel({required this.actions});

  factory SequenceActionModel.fromJson(Map<String, dynamic> json) {
    final rawActions = json['actions'];
    final actions = <Map<String, dynamic>>[];

    if (rawActions is List) {
      for (final item in rawActions) {
        if (item is Map<String, dynamic>) {
          actions.add(item);
        } else if (item is Map) {
          actions.add(Map<String, dynamic>.from(item));
        }
      }
    }

    return SequenceActionModel(actions: actions);
  }
}

class SequenceActionParser extends StacActionParser<SequenceActionModel> {
  const SequenceActionParser();

  @override
  String get actionType => 'sequence';

  @override
  SequenceActionModel getModel(Map<String, dynamic> json) =>
      SequenceActionModel.fromJson(json);

  @override
  Future<void> onCall(BuildContext context, SequenceActionModel model) async {
    for (final action in model.actions) {
      final result = Stac.onCallFromJson(action, context);
      if (result is Future) {
        await result;
      }
    }
  }
}
