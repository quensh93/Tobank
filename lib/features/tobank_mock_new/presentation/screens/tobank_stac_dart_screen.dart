import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../../../stac/tobank/menu/dart/tobank_menu.dart' as tobank_menu;

/// Renders the Tobank STAC menu screen directly from the Dart StacWidget.
class TobankStacDartScreen extends StatelessWidget {
  const TobankStacDartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stacWidget = tobank_menu.tobankMenuDart();
    var json = stacWidget.toJson();
    
    // Manually add itemTemplate to the template JSON since StacListView doesn't support it in Dart
    // Each menu item is displayed as a card with 3 buttons: dart, json, api
    // Using STAC Dart widgets syntax, then converting to JSON
    if (json['body'] != null && 
        json['body']['template'] != null && 
        json['body']['template']['type'] == 'listView') {
      final itemTemplateWidget = _buildMenuItemCard();
      json['body']['template']['itemTemplate'] = itemTemplateWidget.toJson();
    }
    
    final rendered =
        Stac.fromJson(json, context) ?? const SizedBox.shrink();

    return rendered;
  }
  
  /// Build menu item card template with title and 3 buttons (dart, json, api) in one row
  /// Minimal material design - title on right, space, then buttons on left, with visible border
  /// Uses STAC Dart widgets syntax
  StacWidget _buildMenuItemCard() {
    return StacContainer(
      margin: StacEdgeInsets.only(
        left: 8.0,
        top: 4.0,
        right: 8.0,
        bottom: 4.0,
      ),
      decoration: StacBoxDecoration(
        color: StacColors.white,
        border: StacBorder(
          width: 1.5,
          color: '#E0E0E0', // Light gray border
        ),
        borderRadius: StacBorderRadius.all(8.0),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 10.0,
        ),
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
    final hasValidPath = path.isNotEmpty && 
                        path != 'null' && 
                        path.trim().isNotEmpty;
    
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
    final isEnabled = hasValidPath || (buttonType == 'dart' && widgetType != null && widgetType.isNotEmpty && widgetType != 'null');
    
    // Use passive material colors - light blue-gray for enabled, gray for disabled
    final buttonColor = '#E3F2FD'; // Light blue-gray passive color
    final textColor = '#1976D2'; // Dark blue for text
    final disabledButtonColor = '#F5F5F5'; // Light gray for disabled
    final disabledTextColor = '#9E9E9E'; // Medium gray for disabled text
    
    return StacFilledButton(
      onPressed: onPressed,
      style: StacButtonStyle(
        padding: StacEdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 6.0,
        ),
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
