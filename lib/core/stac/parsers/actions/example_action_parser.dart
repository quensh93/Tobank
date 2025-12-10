import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';

/// Example Action Model
///
/// A custom STAC action that shows a snackbar message.
class ExampleActionModel {
  final String message;
  final int? duration;
  final String? backgroundColor;
  final String? textColor;
  final bool? showAction;
  final String? actionText;
  final Map<String, dynamic>? onActionPressed;

  const ExampleActionModel({
    required this.message,
    this.duration,
    this.backgroundColor,
    this.textColor,
    this.showAction,
    this.actionText,
    this.onActionPressed,
  });

  factory ExampleActionModel.fromJson(Map<String, dynamic> json) {
    return ExampleActionModel(
      message: json['message'] as String,
      duration: json['duration'] as int?,
      backgroundColor: json['backgroundColor'] as String?,
      textColor: json['textColor'] as String?,
      showAction: json['showAction'] as bool?,
      actionText: json['actionText'] as String?,
      onActionPressed: json['onActionPressed'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': 'exampleAction',
      'message': message,
      if (duration != null) 'duration': duration,
      if (backgroundColor != null) 'backgroundColor': backgroundColor,
      if (textColor != null) 'textColor': textColor,
      if (showAction != null) 'showAction': showAction,
      if (actionText != null) 'actionText': actionText,
      if (onActionPressed != null) 'onActionPressed': onActionPressed,
    };
  }

  List<Object?> get props => [
        message,
        duration,
        backgroundColor,
        textColor,
        showAction,
        actionText,
        onActionPressed,
      ];
}

/// Example Action Parser
///
/// Parses ExampleActionModel JSON and executes the action.
class ExampleActionParser extends StacActionParser<ExampleActionModel> {
  const ExampleActionParser();

  @override
  String get actionType => 'exampleAction';

  @override
  ExampleActionModel getModel(Map<String, dynamic> json) =>
      ExampleActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, ExampleActionModel model) {
    final bgColor = _parseColor(model.backgroundColor ?? '#4CAF50');
    final textColor = _parseColor(model.textColor ?? '#FFFFFF');

    final snackBar = SnackBar(
      content: Text(
        model.message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: bgColor,
      duration: Duration(seconds: model.duration ?? 2),
      action: (model.showAction ?? false)
          ? SnackBarAction(
              label: model.actionText ?? 'OK',
              textColor: textColor,
              onPressed: () {
                if (model.onActionPressed != null) {
                  Stac.onCallFromJson(
                    model.onActionPressed!,
                    context,
                  );
                }
              },
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return null;
  }

  Color _parseColor(String colorString) {
    final hexColor = colorString.replaceAll('#', '');
    if (hexColor.length == 6) {
      return Color(int.parse('FF$hexColor', radix: 16));
    } else if (hexColor.length == 8) {
      return Color(int.parse(hexColor, radix: 16));
    }
    return Colors.green;
  }
}

void registerExampleActionParser() {
  CustomComponentRegistry.instance.registerAction(const ExampleActionParser());
}
