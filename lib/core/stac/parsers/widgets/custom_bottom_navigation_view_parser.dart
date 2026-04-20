import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';

/// Keeps all bottom-nav pages mounted so tab state is preserved across switches.
class CustomBottomNavigationViewParser
    extends StacParser<StacBottomNavigationView> {
  const CustomBottomNavigationViewParser();

  @override
  String get type => WidgetType.bottomNavigationView.name;

  @override
  StacBottomNavigationView getModel(Map<String, dynamic> json) =>
      StacBottomNavigationView.fromJson(json);

  @override
  Widget parse(BuildContext context, StacBottomNavigationView model) {
    return _CustomBottomNavigationViewWidget(model: model);
  }
}

class _CustomBottomNavigationViewWidget extends StatelessWidget {
  const _CustomBottomNavigationViewWidget({required this.model});

  final StacBottomNavigationView model;

  @override
  Widget build(BuildContext context) {
    final controller = BottomNavigationScope.of(context)?.controller;

    if (model.children.isEmpty) return const SizedBox.shrink();

    final index = controller?.index ?? 0;
    final safeIndex = index.clamp(0, model.children.length - 1);

    final children = model.children
        .map(
          (child) => Stac.fromJson(child.toJson(), context) ?? const SizedBox(),
        )
        .toList();

    return IndexedStack(index: safeIndex, children: children);
  }
}
