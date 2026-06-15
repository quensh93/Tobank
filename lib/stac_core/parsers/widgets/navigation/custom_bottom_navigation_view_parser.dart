import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

/// Keeps all bottom-nav pages mounted so tab state is preserved across switches.
class CustomBottomNavigationViewParser
    extends StacParser<StacNavigationView> {
  const CustomBottomNavigationViewParser();

  @override
  String get type => WidgetType.bottomNavigationView.name;

  @override
  StacNavigationView getModel(Map<String, dynamic> json) =>
      StacNavigationView.fromJson(json);

  @override
  Widget parse(BuildContext context, StacNavigationView model) {
    return _CustomBottomNavigationViewWidget(model: model);
  }
}

class _CustomBottomNavigationViewWidget extends StatelessWidget {
  const _CustomBottomNavigationViewWidget({required this.model});

  final StacNavigationView model;

  @override
  Widget build(BuildContext context) {
    final controller = NavigationScope.of(context)?.controller;

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
