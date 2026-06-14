import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../stac/tobank/menu/dart/tobank_menu.dart' as tobank_menu;
import 'package:tobank_sdui/stac_core/services/theme/theme_controller_provider.dart';
import '../../core/helpers/logger.dart';
import '../../stac_core/builders/stac_common_builders.dart';
import '../../stac_core/navigation/nav_modes.dart';

/// Renders the Tobank STAC menu screen directly from the Dart StacWidget.
///
/// Uses ConsumerWidget to watch theme changes and rebuild the entire
/// STAC widget tree when theme is toggled, ensuring all colors update.
class TobankStacDartScreen extends ConsumerWidget {
  const TobankStacDartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme controller - this triggers rebuild when theme changes
    // This is critical for updating all STAC colors when theme toggles
    final themeState = ref.watch(themeControllerProvider);

    // Get current theme mode for logging/debugging
    final themeMode = themeState.maybeWhen(
      data: (mode) => mode,
      orElse: () => ThemeMode.system,
    );

    AppLogger.dc(
      LogCategory.theme,
      'TobankStacDartScreen rebuilding with theme: ${themeMode.name}',
    );

    final stacWidget = tobank_menu.tobankMenuDart();
    var json = stacWidget.toJson();

    // Recursively inject itemTemplate into all StacListView widgets
    // This allows flexible layouts (e.g. Columns of ListViews, ScrollViews, etc.)
    void injectItemTemplateRecursively(dynamic node) {
      if (node is Map<String, dynamic>) {
        if (node['type'] == 'listView') {
          final children = node['children'];
          final bool hasStaticChildren =
              children != null && children is List && children.isNotEmpty;

          if (!hasStaticChildren) {
            if (node['itemTemplate'] == null) {
              if (node['restorationId'] == 'singleButtonList') {
                node['itemTemplate'] = _buildSingleButtonMenuItemCard().toJson();
              } else {
                node['itemTemplate'] = _buildMenuItemCard().toJson();
              }
            }
            node['shrinkWrap'] = true;
            node['physics'] = 'never';
          }
        }

        final keys = node.keys.toList();
        for (final key in keys) {
          final value = node[key];
          if (value is Map<String, dynamic> || value is List) {
            injectItemTemplateRecursively(value);
          }
        }
      } else if (node is List) {
        for (var item in node) {
          injectItemTemplateRecursively(item);
        }
      }
    }

    injectItemTemplateRecursively(json);

    final rendered = Stac.fromJson(json, context) ?? const SizedBox.shrink();

    return rendered;
  }

  StacWidget _buildSingleButtonMenuItemCard() {
    return StacContainer(
      margin: StacEdgeInsets.only(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        border: StacBorder(
          width: 1.5,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        borderRadius: StacBorderRadius.all(8.0),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.start,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: StacText(
                data: '{{title}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                maxLines: 1,
                overflow: StacTextOverflow.ellipsis,
                style: StacCustomTextStyle(
                  fontSize: 15.0,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacSizedBox(width: 8.0),
            _buildButtonWidget(
              label: 'Run',
              path: '',
              widgetType: '{{widgetType}}',
              buttonType: 'dart',
            ),
          ],
        ),
      ),
    );
  }

  StacWidget _buildMenuItemCard() {
    return StacContainer(
      margin: StacEdgeInsets.only(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        border: StacBorder(
          width: 1.5,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        borderRadius: StacBorderRadius.all(8.0),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.start,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: StacText(
                data: '{{title}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                maxLines: 1,
                overflow: StacTextOverflow.ellipsis,
                style: StacCustomTextStyle(
                  fontSize: 15.0,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacSizedBox(width: 8.0),
            StacRow(
              mainAxisSize: StacMainAxisSize.min,
              children: [
                _buildButtonWidget(
                  label: 'Dart',
                  path: '{{dartPath}}',
                  widgetType: '{{widgetType}}',
                  buttonType: 'dart',
                ),
                StacSizedBox(width: 4.0),
                _buildButtonWidget(
                  label: 'JSON',
                  path: '{{jsonPath}}',
                  buttonType: 'json',
                ),
                StacSizedBox(width: 4.0),
                _buildButtonWidget(
                  label: 'API',
                  path: '{{apiPath}}',
                  buttonType: 'api',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  StacWidget _buildButtonWidget({
    required String label,
    required String path,
    String? widgetType,
    required String buttonType,
  }) {
    StacAction? onPressed;

    final hasValidPath =
        path.isNotEmpty && path != 'null' && path.trim().isNotEmpty;

    if (buttonType == 'dart') {
      if (widgetType != null && widgetType.isNotEmpty && widgetType != 'null') {
        onPressed = NavigationAction(
          fileName: widgetType,
          navMode: NavModes.dart,
          navigationStyle: NavigationStyle.push,
        );
      } else if (hasValidPath) {
        onPressed = NavigationAction(
          navMode: NavModes.localJson,
          pathOverride: path,
          navigationStyle: NavigationStyle.push,
        );
      }
    } else if (hasValidPath) {
      onPressed = NavigationAction(
        navMode: NavModes.localJson,
        pathOverride: path,
        navigationStyle: NavigationStyle.push,
      );
    }

    final isEnabled =
        hasValidPath ||
        (buttonType == 'dart' &&
            widgetType != null &&
            widgetType.isNotEmpty &&
            widgetType != 'null');

    final buttonColor = '{{appColors.current.secondary.secondaryContainer}}';
    final textColor = '{{appColors.current.secondary.color}}';
    final disabledButtonColor =
        '{{appColors.current.background.surfaceContainerHigh}}';
    final disabledTextColor = '{{appColors.current.text.hint}}';

    return StacFilledButton(
      onPressed: onPressed,
      style: StacButtonStyle(
        padding: StacEdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        minimumSize: const StacSize(0.0, 0.0),
        backgroundColor: isEnabled ? buttonColor : disabledButtonColor,
        foregroundColor: isEnabled ? textColor : disabledTextColor,
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(6.0),
        ),
        tapTargetSize: StacMaterialTapTargetSize.shrinkWrap,
      ),
      child: StacText(
        data: label,
        style: StacCustomTextStyle(
          fontSize: 11.0,
          fontWeight: StacFontWeight.w600,
          color: isEnabled ? textColor : disabledTextColor,
        ),
      ),
    );
  }
}
