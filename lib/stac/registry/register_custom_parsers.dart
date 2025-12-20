import 'package:stac/stac.dart';
import '../../core/stac/parsers/widgets/tobank_onboarding_slider_parser.dart';
import 'custom_component_registry.dart';

// Custom widgets and actions will be imported here when created
// import '../widgets/example_card/example_card_parser.dart';
// import '../actions/example_action/example_action_parser.dart';

/// Register all custom STAC parsers with the STAC framework.
///
/// This function should be called during app initialization, after Stac.initialize()
/// but before the app starts rendering STAC widgets.
///
/// It performs the following steps:
/// 1. Retrieves all custom parsers from CustomComponentRegistry
/// 2. Registers them with the core STAC framework (StacRegistry)
/// 3. Ensures no conflicts with built-in parsers
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
    print('🔧 Registering custom STAC parsers...');

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
          print(
            'Skipping custom widget parser "$type" - conflicts with built-in parser',
          );
          widgetSkipped++;
          continue;
        }

        // Register with STAC framework
        final success = stacRegistry.register(parser);
        if (success) {
          widgetCount++;
          print('Registered custom widget parser: $type');
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
          print(
            'Skipping custom action parser "$actionType" - conflicts with built-in parser',
          );
          actionSkipped++;
          continue;
        }

        // Register with STAC framework
        final success = stacRegistry.registerAction(parser);
        if (success) {
          actionCount++;
          print('Registered custom action parser: $actionType');
        }
      }
    }

    // Log summary
    print(
      '✅ Custom parser registration complete: '
      '$widgetCount widgets, $actionCount actions registered',
    );

    if (widgetSkipped > 0 || actionSkipped > 0) {
      print(
        '⚠️ Skipped $widgetSkipped widgets and $actionSkipped actions due to conflicts',
      );
    }

    // Log detailed summary
    final summary = customRegistry.getSummary();
    print('Custom registry summary: $summary');
  } catch (e, stackTrace) {
    print('❌ Failed to register custom parsers: $e');
    print('Stack trace:\n$stackTrace');
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
  // registerExampleCardParser(); // Uncomment when widgets are created
  CustomComponentRegistry.instance.registerWidget(
    const TobankOnboardingSliderParser(),
  );

  // Register example action parsers
  // registerExampleActionParser(); // Uncomment when actions are created
}

/// Unregister all custom parsers from the STAC framework.
///
/// This is useful for testing or hot reload scenarios where you want to
/// reset the parser registry.
Future<void> unregisterCustomParsers() async {
  try {
    print('🔧 Unregistering custom STAC parsers...');

    final customRegistry = CustomComponentRegistry.instance;

    // Note: StacRegistry doesn't provide an unregister method,
    // so we can only clear our custom registry
    customRegistry.clearAll();

    print('✅ Custom parsers cleared from custom registry');
  } catch (e, stackTrace) {
    print('❌ Failed to unregister custom parsers: $e');
    print('Stack trace:\n$stackTrace');
    rethrow;
  }
}
