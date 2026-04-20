import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';

/// Custom parser to soften tap splash/highlight for bottom navigation items.
class CustomBottomNavigationBarParser
    extends StacParser<StacBottomNavigationBar> {
  const CustomBottomNavigationBarParser();

  @override
  String get type => WidgetType.bottomNavigationBar.name;

  @override
  StacBottomNavigationBar getModel(Map<String, dynamic> json) =>
      StacBottomNavigationBar.fromJson(json);

  @override
  Widget parse(BuildContext context, StacBottomNavigationBar model) {
    return _CustomBottomNavigationBarWidget(model: model);
  }
}

class _CustomBottomNavigationBarWidget extends StatelessWidget {
  const _CustomBottomNavigationBarWidget({required this.model});

  final StacBottomNavigationBar model;

  @override
  Widget build(BuildContext context) {
    final controller = BottomNavigationScope.of(context)?.controller;
    final theme = Theme.of(context);
    final splashColor = _reduceAlpha(theme.splashColor, 0.35);
    final highlightColor = _reduceAlpha(theme.highlightColor, 0.35);

    return Theme(
      data: theme.copyWith(
        splashColor: splashColor,
        highlightColor: highlightColor,
      ),
      child: BottomNavigationBar(
        items: model.items
            .map(
              (item) => BottomNavigationBarItem(
                icon:
                    Stac.fromJson(item.icon.toJson(), context) ??
                    const SizedBox.shrink(),
                activeIcon: item.activeIcon != null
                    ? Stac.fromJson(item.activeIcon!.toJson(), context)
                    : null,
                label: item.label,
                backgroundColor: item.backgroundColor?.toColor(context),
                tooltip: item.tooltip,
              ),
            )
            .toList(),
        onTap: (index) => controller?.index = index,
        currentIndex: controller?.index ?? 0,
        elevation: model.elevation,
        type: _parseBarType(model.barType),
        fixedColor: model.fixedColor?.toColor(context),
        backgroundColor: model.backgroundColor?.toColor(context),
        iconSize: model.iconSize ?? 24.0,
        selectedItemColor: model.selectedItemColor?.toColor(context),
        unselectedItemColor: model.unselectedItemColor?.toColor(context),
        selectedFontSize: model.selectedFontSize ?? 14.0,
        unselectedFontSize: model.unselectedFontSize ?? 12.0,
        showSelectedLabels: model.showSelectedLabels,
        showUnselectedLabels: model.showUnselectedLabels,
        enableFeedback: model.enableFeedback,
        landscapeLayout: _parseLandscapeLayout(model.landscapeLayout),
      ),
    );
  }

  BottomNavigationBarType? _parseBarType(StacBottomNavigationBarType? type) {
    switch (type) {
      case StacBottomNavigationBarType.fixed:
        return BottomNavigationBarType.fixed;
      case StacBottomNavigationBarType.shifting:
        return BottomNavigationBarType.shifting;
      case null:
        return null;
    }
  }

  BottomNavigationBarLandscapeLayout? _parseLandscapeLayout(
    StacBottomNavigationBarLandscapeLayout? layout,
  ) {
    switch (layout) {
      case StacBottomNavigationBarLandscapeLayout.spread:
        return BottomNavigationBarLandscapeLayout.spread;
      case StacBottomNavigationBarLandscapeLayout.centered:
        return BottomNavigationBarLandscapeLayout.centered;
      case StacBottomNavigationBarLandscapeLayout.linear:
        return BottomNavigationBarLandscapeLayout.linear;
      case null:
        return null;
    }
  }

  Color _reduceAlpha(Color color, double factor) {
    final baseAlpha = (color.a * 255).round().clamp(0, 255);
    final scaledAlpha = (baseAlpha * factor).round().clamp(0, 255);
    return color.withAlpha(scaledAlpha);
  }
}
