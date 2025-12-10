import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';

/// Example Card Model
///
/// A custom STAC widget that displays a card with a title, subtitle, and optional icon.
class ExampleCardModel {
  final String title;
  final String? subtitle;
  final Map<String, dynamic>? icon;
  final String? backgroundColor;
  final double? elevation;
  final double? borderRadius;
  final double? padding;
  final Map<String, dynamic>? onTap;

  const ExampleCardModel({
    required this.title,
    this.subtitle,
    this.icon,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.onTap,
  });

  factory ExampleCardModel.fromJson(Map<String, dynamic> json) {
    return ExampleCardModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      icon: json['icon'] as Map<String, dynamic>?,
      backgroundColor: json['backgroundColor'] as String?,
      elevation: (json['elevation'] as num?)?.toDouble(),
      borderRadius: (json['borderRadius'] as num?)?.toDouble(),
      padding: (json['padding'] as num?)?.toDouble(),
      onTap: json['onTap'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': 'exampleCard',
      'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (icon != null) 'icon': icon,
      if (backgroundColor != null) 'backgroundColor': backgroundColor,
      if (elevation != null) 'elevation': elevation,
      if (borderRadius != null) 'borderRadius': borderRadius,
      if (padding != null) 'padding': padding,
      if (onTap != null) 'onTap': onTap,
    };
  }

  List<Object?> get props => [
        title,
        subtitle,
        icon,
        backgroundColor,
        elevation,
        borderRadius,
        padding,
        onTap,
      ];
}

/// Example Card Parser
///
/// Parses ExampleCardModel JSON into a Flutter Card widget.
class ExampleCardParser extends StacParser<ExampleCardModel> {
  const ExampleCardParser();

  @override
  String get type => 'exampleCard';

  @override
  ExampleCardModel getModel(Map<String, dynamic> json) =>
      ExampleCardModel.fromJson(json);

  @override
  Widget parse(BuildContext context, ExampleCardModel model) {
    Widget? iconWidget;
    if (model.icon != null) {
      iconWidget = Stac.fromJson(model.icon!, context);
    }

    Color? bgColor;
    if (model.backgroundColor != null) {
      bgColor = _parseColor(model.backgroundColor!, context);
    }

    final content = Padding(
      padding: EdgeInsets.all(model.padding ?? 16.0),
      child: Row(
        children: [
          if (iconWidget != null) ...[
            iconWidget,
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (model.subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    model.subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    final card = Card(
      color: bgColor,
      elevation: model.elevation ?? 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(model.borderRadius ?? 8.0),
      ),
      child: content,
    );

    if (model.onTap != null) {
      return InkWell(
        onTap: () => Stac.onCallFromJson(model.onTap!, context),
        borderRadius: BorderRadius.circular(model.borderRadius ?? 8.0),
        child: card,
      );
    }

    return card;
  }

  Color _parseColor(String colorString, BuildContext context) {
    if (colorString.startsWith('#')) {
      final hexColor = colorString.replaceAll('#', '');
      if (hexColor.length == 6) {
        return Color(int.parse('FF$hexColor', radix: 16));
      } else if (hexColor.length == 8) {
        return Color(int.parse(hexColor, radix: 16));
      }
    }
    return Theme.of(context).cardColor;
  }
}

void registerExampleCardParser() {
  CustomComponentRegistry.instance.registerWidget(const ExampleCardParser());
}
