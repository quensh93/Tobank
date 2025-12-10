import 'package:stac/stac.dart';
import '../../helpers/logger.dart';

import 'custom_component_registry.dart';
import '../parsers/widgets/example_card_parser.dart';
import '../parsers/widgets/custom_text_form_field_parser.dart';
import '../parsers/actions/example_action_parser.dart';
import '../parsers/actions/custom_navigate_action_parser.dart';
import '../parsers/actions/custom_set_value_action_parser.dart';
import '../parsers/actions/persian_date_picker_action_parser.dart';
import '../parsers/actions/close_dialog_action_parser.dart';

/// Register all custom STAC parsers with the STAC framework.
///
/// This function should be called during app initialization, after Stac.initialize()
/// but before the app starts rendering STAC widgets.
///
/// It performs the following steps:
/// 1. Registers example parsers with CustomComponentRegistry
/// 2. Retrieves all custom parsers from CustomComponentRegistry
/// 3. Registers them with the core STAC framework (StacRegistry)
/// 4. Ensures no conflicts with built-in parsers
///
/// Usage:
/// ```dart
/// void main() async {
///   await Stac.initialize();
///   await registerCustomParsers();
///   await bootstrap();
/// }
/// ```
Future<void> registerCustomParsers() async {
  try {
    AppLogger.i('🔧 Registering custom STAC parsers...');

    // Register example parsers with custom registry first
    _registerExampleParsers();

    final customRegistry = CustomComponentRegistry.instance;
    final stacRegistry = StacRegistry.instance;

    // Get all custom widget parsers
    final widgetTypes = customRegistry.getRegisteredWidgets();
    int widgetCount = 0;
    int widgetSkipped = 0;

    for (final type in widgetTypes) {
      final parser = customRegistry.getWidgetParser(type);
      if (parser != null) {
        // Check if this would conflict with a built-in parser
        final existingParser = stacRegistry.getParser(type);
        if (existingParser != null) {
          AppLogger.w(
            'Skipping custom widget parser "$type" - conflicts with built-in parser',
          );
          widgetSkipped++;
          continue;
        }

        // Register with STAC framework
        final success = stacRegistry.register(parser);
        if (success) {
          widgetCount++;
          AppLogger.d('Registered custom widget parser: $type');
        }
      }
    }

    // Get all custom action parsers
    final actionTypes = customRegistry.getRegisteredActions();
    int actionCount = 0;
    int actionSkipped = 0;

    for (final actionType in actionTypes) {
      final parser = customRegistry.getActionParser(actionType);
      if (parser != null) {
        // Check if this would conflict with a built-in parser
        final existingParser = stacRegistry.getActionParser(actionType);
        if (existingParser != null) {
          AppLogger.w(
            'Skipping custom action parser "$actionType" - conflicts with built-in parser',
          );
          actionSkipped++;
          continue;
        }

        // Register with STAC framework
        final success = stacRegistry.registerAction(parser);
        if (success) {
          actionCount++;
          AppLogger.d('Registered custom action parser: $actionType');
        }
      }
    }

    // Register custom TextFormField parser to override the default one
    // This allows controllers to be registered for external updates (e.g., date picker)
    try {
      const customTextFormFieldParser = CustomTextFormFieldParser();
      final success = stacRegistry.register(customTextFormFieldParser, true); // override: true
      if (success) {
        widgetCount++;
        AppLogger.i('✅ Registered custom TextFormField parser (overriding default)');
      } else {
        AppLogger.w('⚠️ Failed to register custom TextFormField parser');
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to register custom TextFormField parser: $e\n$stackTrace');
    }

    // Register custom navigate action parser to override the default navigate parser
    // This ensures all navigated screens get the transparent border and purple button theme
    // and supports navigation to Dart STAC screens via widgetType
    try {
      const customNavigateParser = CustomNavigateActionParser();
      final success = stacRegistry.registerAction(customNavigateParser, true); // override: true as positional parameter
      if (success) {
        actionCount++;
        AppLogger.i('✅ Registered custom navigate action parser (overriding default)');
      } else {
        AppLogger.w('⚠️ Failed to register custom navigate action parser');
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to register custom navigate action parser: $e\n$stackTrace');
    }

    // Register custom setValue action parser to override the default setValue parser
    // This resolves StacGetFormValue actions before storing values in registry
    try {
      const customSetValueParser = CustomSetValueActionParser();
      final success = stacRegistry.registerAction(customSetValueParser, true); // override: true
      if (success) {
        actionCount++;
        AppLogger.i('✅ Registered custom setValue action parser (overriding default)');
      } else {
        AppLogger.w('⚠️ Failed to register custom setValue action parser');
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to register custom setValue action parser: $e\n$stackTrace');
    }

    // Note: Custom text parser removed to avoid stack overflow recursion
    // Form values should be stored in registry before navigation instead

    // Log summary
    AppLogger.i(
      '✅ Custom parser registration complete: '
      '$widgetCount widgets, $actionCount actions registered',
    );

    if (widgetSkipped > 0 || actionSkipped > 0) {
      AppLogger.w(
        '⚠️ Skipped $widgetSkipped widgets and $actionSkipped actions due to conflicts',
      );
    }

    // Log detailed summary
    final summary = customRegistry.getSummary();
    AppLogger.d('Custom registry summary: $summary');
  } catch (e, stackTrace) {
    AppLogger.e('❌ Failed to register custom parsers: $e\n$stackTrace');
    rethrow;
  }
}

/// Register example parsers with the custom component registry.
///
/// This function registers all example widgets and actions that come with
/// the framework. You can use this as a reference for registering your own
/// custom parsers.
void _registerExampleParsers() {
  // Register example widget parsers
  registerExampleCardParser();

  // Register example action parsers
  registerExampleActionParser();
  
  // Register Persian date picker action parser
  registerPersianDatePickerActionParser();
  
  // Register close dialog action parser
  registerCloseDialogActionParser();
}

/// Unregister all custom parsers from the STAC framework.
///
/// This is useful for testing or hot reload scenarios where you want to
/// reset the parser registry.
Future<void> unregisterCustomParsers() async {
  try {
    AppLogger.i('🔧 Unregistering custom STAC parsers...');

    final customRegistry = CustomComponentRegistry.instance;

    // Note: StacRegistry doesn't provide an unregister method,
    // so we can only clear our custom registry
    customRegistry.clearAll();

    AppLogger.i('✅ Custom parsers cleared from custom registry');
  } catch (e, stackTrace) {
    AppLogger.e('❌ Failed to unregister custom parsers: $e\n$stackTrace');
    rethrow;
  }
}
