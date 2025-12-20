import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../../../stac/tobank/menu/dart/tobank_menu.dart' as tobank_menu;
import '../../../pre_launch/providers/theme_controller_provider.dart';

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

    debugPrint(
      '🎨 TobankStacDartScreen rebuilding with theme: ${themeMode.name}',
    );

    final stacWidget = tobank_menu.tobankMenuDart();
    var json = stacWidget.toJson();

    // Recursively inject itemTemplate into all StacListView widgets
    // This allows flexible layouts (e.g. Columns of ListViews, ScrollViews, etc.)
    void injectItemTemplateRecursively(dynamic node) {
      if (node is Map<String, dynamic>) {
        if (node['type'] == 'listView') {
          // Check if children is populated (static list) or empty (dynamic list)
          // We only want to enable shrinkWrap/physics for the dynamic lists (empty children)
          // The main list has static children and should behave normally
          final children = node['children'];
          final bool hasStaticChildren =
              children != null && children is List && children.isNotEmpty;

          if (!hasStaticChildren) {
            if (node['itemTemplate'] == null) {
              node['itemTemplate'] = _buildMenuItemCard().toJson();
            }
            node['shrinkWrap'] = true;
            node['physics'] = 'never';
          }
        }

        // Use keys.toList() to avoid concurrent modification during iteration
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

  /// Build menu item card template with title and 3 buttons (dart, json, api) in one row
  /// Minimal material design - title on right, space, then buttons on left, with visible border
  /// Uses STAC Dart widgets syntax with theme-aware colors
  StacWidget _buildMenuItemCard() {
    return StacContainer(
      margin: StacEdgeInsets.only(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0),
      decoration: StacBoxDecoration(
        // Use theme-aware surfaceContainer for card background
        color: '{{appColors.current.background.surfaceContainer}}',
        border: StacBorder(
          width: 1.5,
          // Use theme-aware border color
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        borderRadius: StacBorderRadius.all(8.0),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          textDirection: StacTextDirection.rtl,
          children: [
            // Title on right side
            StacExpanded(
              child: StacText(
                data: '{{title}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 15.0,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacSizedBox(width: 8.0),
            // Buttons on left side - use Flexible to prevent overflow
            StacFlexible(
              flex: 0,
              fit: StacFlexFit.loose,
              child: StacRow(
                mainAxisSize: StacMainAxisSize.min,
                children: [
                  // Dart button
                  _buildButtonWidget(
                    label: 'Dart',
                    path: '{{dartPath}}',
                    widgetType: '{{widgetType}}',
                    buttonType: 'dart',
                  ),
                  StacSizedBox(width: 4.0),
                  // JSON button
                  _buildButtonWidget(
                    label: 'JSON',
                    path: '{{jsonPath}}',
                    buttonType: 'json',
                  ),
                  StacSizedBox(width: 4.0),
                  // API button
                  _buildButtonWidget(
                    label: 'API',
                    path: '{{apiPath}}',
                    buttonType: 'api',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build a button widget for navigating to dart/json/api files using STAC Dart syntax
  ///
  /// If path is null or empty, the button will be disabled (no onPressed action)
  StacWidget _buildButtonWidget({
    required String label,
    required String path,
    String? widgetType,
    required String buttonType,
  }) {
    // Determine navigation action based on button type
    // Note: When path is null in API, STAC will resolve {{path}} to empty string or "null"
    StacAction? onPressed;

    // Check if path is valid (not null, not empty, not the string "null")
    final hasValidPath =
        path.isNotEmpty && path != 'null' && path.trim().isNotEmpty;

    if (buttonType == 'dart') {
      // For Dart button: prefer widgetType if available, otherwise use dartPath
      if (widgetType != null && widgetType.isNotEmpty && widgetType != 'null') {
        // Create action with widgetType - CustomNavigateActionParser will handle it
        // We need to create a custom action JSON that includes widgetType
        // Since StacNavigateAction doesn't support widgetType, we'll create it from JSON
        final actionJson = {
          'actionType': 'navigate',
          'widgetType': widgetType,
          'navigationStyle': 'push',
        };
        onPressed = StacAction.fromJson(actionJson);
      } else if (hasValidPath) {
        onPressed = StacNavigateAction(
          assetPath: path,
          navigationStyle: NavigationStyle.push,
        );
      }
    } else if (hasValidPath) {
      // For JSON/API buttons, use assetPath navigation
      onPressed = StacNavigateAction(
        assetPath: path,
        navigationStyle: NavigationStyle.push,
      );
    }
    // If no valid path/widgetType, button will be disabled (no onPressed)

    // Use filledButton for bigger buttons with passive material color
    final isEnabled =
        hasValidPath ||
        (buttonType == 'dart' &&
            widgetType != null &&
            widgetType.isNotEmpty &&
            widgetType != 'null');

    // Use theme-aware colors for buttons
    // Note: For buttons, we'll use theme tokens but need to handle disabled state specially
    // Using secondaryContainer for enabled, surfaceContainerHigh for disabled
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
