import 'package:stac/stac.dart';
import '../../helpers/logger.dart';
import 'custom_component_registry.dart';
import '../parsers/widgets/example_card_parser.dart';
import '../parsers/widgets/tobank_onboarding_slider_parser.dart';
import '../parsers/widgets/custom_image_parser.dart';
import '../parsers/widgets/timed_splash_parser.dart';
import '../parsers/widgets/on_mount_action_parser.dart';
import '../parsers/widgets/stateful_widget_parser.dart';
import '../parsers/widgets/reactive_elevated_button_parser.dart';
import '../parsers/widgets/registry_reactive_widget_parser.dart';
import '../parsers/actions/example_action_parser.dart';
import '../parsers/actions/persian_date_picker_action_parser.dart';
import '../parsers/actions/close_dialog_action_parser.dart';
import '../parsers/actions/calculate_sum_action_parser.dart';
import '../parsers/actions/log_action_parser.dart';
import '../parsers/actions/sequence_action_parser.dart';
import '../parsers/actions/flow_next_action_parser.dart';
import '../parsers/actions/validate_fields_action_parser.dart';
import '../parsers/actions/custom_set_value_action_parser.dart';
import '../parsers/actions/custom_navigate_action_parser.dart';
import '../parsers/actions/file_picker_action_parser.dart';
import '../parsers/widgets/custom_text_form_field_parser.dart';

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

    // Register the registry reactive widget parser
    final customRegistry = CustomComponentRegistry.instance;
    customRegistry.registerWidget(const RegistryReactiveWidgetParser());

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
          // Allow overriding 'image' parser explicitly
          if (type == 'image') {
            AppLogger.i('Overriding built-in parser for "$type"');
          } else {
            AppLogger.w(
              'Skipping custom widget parser "$type" - conflicts with built-in parser',
            );
            widgetSkipped++;
            continue;
          }
        }

        // Register with STAC framework
        // NOTE: For some core widgets (e.g. 'image') we intentionally override.
        final success = type == 'image'
            ? stacRegistry.register(parser, true)
            : stacRegistry.register(parser);
        if (success) {
          widgetCount++;
          AppLogger.dc(
            LogCategory.registry,
            'Registered custom widget parser: $type',
          );
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
          AppLogger.dc(
            LogCategory.registry,
            'Registered custom action parser: $actionType',
          );
        }
      }
    }

    // Register custom TextFormField parser to override the default one
    // This allows controllers to be registered for external updates (e.g., date picker)
    try {
      const customTextFormFieldParser = CustomTextFormFieldParser();
      final success = stacRegistry.register(
        customTextFormFieldParser,
        true,
      ); // override: true
      if (success) {
        widgetCount++;
        AppLogger.ic(
          LogCategory.registry,
          '✅ Registered custom TextFormField parser (overriding default)',
        );
      } else {
        AppLogger.wc(
          LogCategory.registry,
          '⚠️ Failed to register custom TextFormField parser',
        );
      }
    } catch (e, stackTrace) {
      AppLogger.ec(
        LogCategory.registry,
        '❌ Failed to register custom TextFormField parser: $e\n$stackTrace',
      );
    }

    // Register custom navigate action parser to override the default navigate parser
    // This ensures all navigated screens get the transparent border and purple button theme
    // and supports navigation to Dart STAC screens via widgetType
    try {
      const customNavigateParser = CustomNavigateActionParser();
      final success = stacRegistry.registerAction(
        customNavigateParser,
        true,
      ); // override: true as positional parameter
      if (success) {
        actionCount++;
        AppLogger.ic(
          LogCategory.registry,
          '✅ Registered custom navigate action parser (overriding default)',
        );
      } else {
        AppLogger.wc(
          LogCategory.registry,
          '⚠️ Failed to register custom navigate action parser',
        );
      }
    } catch (e, stackTrace) {
      AppLogger.ec(
        LogCategory.registry,
        '❌ Failed to register custom navigate action parser: $e\n$stackTrace',
      );
    }

    // Register custom setValue action parser to override the default setValue parser
    // This resolves StacGetFormValue actions before storing values in registry
    try {
      const customSetValueParser = CustomSetValueActionParser();
      final success = stacRegistry.registerAction(
        customSetValueParser,
        true,
      ); // override: true
      if (success) {
        actionCount++;
        AppLogger.ic(
          LogCategory.registry,
          '✅ Registered custom setValue action parser (overriding default)',
        );
      } else {
        AppLogger.wc(
          LogCategory.registry,
          '⚠️ Failed to register custom setValue action parser',
        );
      }
    } catch (e, stackTrace) {
      AppLogger.ec(
        LogCategory.registry,
        '❌ Failed to register custom setValue action parser: $e\n$stackTrace',
      );
    }

    // Note: Custom text parser removed to avoid stack overflow recursion
    // Form values should be stored in registry before navigation instead

    // Log summary
    AppLogger.ic(
      LogCategory.registry,
      '✅ Custom parser registration complete: '
      '$widgetCount widgets, $actionCount actions registered',
    );

    if (widgetSkipped > 0 || actionSkipped > 0) {
      AppLogger.wc(
        LogCategory.registry,
        '⚠️ Skipped $widgetSkipped widgets and $actionSkipped actions due to conflicts',
      );
    }

    // Log detailed summary
    final summary = customRegistry.getSummary();
    AppLogger.dc(LogCategory.registry, 'Custom registry summary: $summary');
  } catch (e, stackTrace) {
    AppLogger.ec(
      LogCategory.registry,
      '❌ Failed to register custom parsers: $e\n$stackTrace',
    );
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

  // Register theme toggle action parser
  // TODO: Fix registerThemeToggleActionParser function
  // registerThemeToggleActionParser();

  // Register calculate sum action parser
  registerCalculateSumActionParser();

  // Register log action parser
  CustomComponentRegistry.instance.registerAction(const LogActionParser());

  // Register sequence action parser
  CustomComponentRegistry.instance.registerAction(const SequenceActionParser());

  // Register flow next action parser
  CustomComponentRegistry.instance.registerAction(const FlowNextActionParser());

  // Register validate fields action parser
  CustomComponentRegistry.instance.registerAction(
    const ValidateFieldsActionParser(),
  );

  // Register Tobank onboarding slider widget parser
  CustomComponentRegistry.instance.registerWidget(
    const TobankOnboardingSliderParser(),
  );
  CustomComponentRegistry.instance.registerWidget(
    const CustomImageParser(),
    true,
  );

  // Register Timed Splash widget parser for auto-navigation splash screens
  CustomComponentRegistry.instance.registerWidget(TimedSplashParser());

  // Register OnMountAction widget parser for executing actions on widget mount
  // This allows backend-controlled auto-actions (navigation, data fetching, etc.)
  CustomComponentRegistry.instance.registerWidget(OnMountActionParser());

  // Register StatefulWidget parser for full widget lifecycle management
  // This enables Flutter-like lifecycle methods in STAC widgets
  CustomComponentRegistry.instance.registerWidget(StatefulWidgetParser());

  // Register alias with preferred casing
  CustomComponentRegistry.instance.registerWidget(
    const StateFullWidgetParser(),
  );

  // Register reactive elevated button parser for registry-driven enable/disable
  CustomComponentRegistry.instance.registerWidget(
    const ReactiveElevatedButtonParser(),
  );

  // Register file picker action parser for file selection
  registerFilePickerActionParser();
}

/// Unregister all custom parsers from the STAC framework.
///
/// This is useful for testing or hot reload scenarios where you want to
/// reset the parser registry.
Future<void> unregisterCustomParsers() async {
  try {
    AppLogger.ic(
      LogCategory.registry,
      '🔧 Unregistering custom STAC parsers...',
    );

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
