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
import '../parsers/widgets/reactive_switch_parser.dart';
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
import '../parsers/actions/custom_network_request_action_parser.dart';
import '../parsers/actions/file_picker_action_parser.dart';
import '../parsers/widgets/custom_text_form_field_parser.dart';
import '../parsers/widgets/promissory_real_loader_parser.dart';
import '../parsers/widgets/verify_identity_real_loader_parser.dart';
import '../../../../stac/tobank/flows/promissory_real/service/promissory_login_action_parser.dart';
import '../parsers/actions/save_file_action_parser.dart';
import '../parsers/actions/share_file_action_parser.dart';
import '../parsers/actions/format_number_action_parser.dart';
import '../parsers/actions/format_date_action_parser.dart';
import '../parsers/actions/amount_to_words_action_parser.dart';
import '../parsers/actions/show_rules_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_guide_options_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_photo_tips_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_job_selector_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_bank_address_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_theme_selector_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_delete_account_confirm_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_logout_confirm_dialog_action_parser.dart';
import '../parsers/actions/show_add_destination_card_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_gift_card_purchase_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_gift_card_payment_accounts_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_gift_card_amount_guide_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_gift_card_message_guide_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_gift_card_location_selector_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_gift_card_select_date_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_gift_card_select_amount_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_gift_card_design_type_bottom_sheet_action_parser.dart';
import '../parsers/actions/show_gift_card_plan_selector_bottom_sheet_action_parser.dart';
import '../parsers/actions/add_gift_card_amount_card_action_parser.dart';
import '../parsers/actions/remove_gift_card_amount_card_action_parser.dart';
import '../parsers/actions/update_gift_card_amount_count_action_parser.dart';
import '../parsers/actions/launch_url_action_parser.dart';
import '../parsers/actions/play_audio_url_action_parser.dart';

import '../parsers/widgets/reactive_list_view_parser.dart';
import '../parsers/widgets/custom_bottom_navigation_bar_parser.dart';
import '../parsers/widgets/custom_bottom_navigation_view_parser.dart';
import '../parsers/widgets/asset_widget_parser.dart';

import '../parsers/widgets/custom_visibility_parser.dart';
import '../parsers/actions/show_snackbar_action_parser.dart';
import '../parsers/actions/finger_print_action_parser.dart';
import '../parsers/actions/auth_persist_action_parser.dart';
import '../parsers/actions/promissory_sign_action_parser.dart';
import '../parsers/widgets/pdf_preview_parser.dart';
import '../parsers/widgets/otp_countdown_button_parser.dart';
import '../parsers/widgets/signature_pad_parser.dart';
import '../parsers/widgets/tobank_banner_carousel_parser.dart';
import '../parsers/widgets/tobank_cards_carousel_parser.dart';
import '../parsers/widgets/tobank_cards_stack_scroller_parser.dart';

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
          // Allow overriding specific parsers explicitly
          if (type == 'image' ||
              type == 'visibility' ||
              type == 'stateful' ||
              type == 'stateFull' ||
              type == 'bottomNavigationView' ||
              type == 'bottomNavigationBar') {
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
        final success =
            (type == 'image' ||
                type == 'visibility' ||
                type == 'stateful' ||
                type == 'stateFull' ||
                type == 'bottomNavigationView' ||
                type == 'bottomNavigationBar')
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

    // Register custom networkRequest action parser to override the default networkRequest parser
    // This stores response data in registry so {{data.data.*}} variables can be resolved
    try {
      const customNetworkRequestParser = CustomNetworkRequestActionParser();
      final success = stacRegistry.registerAction(
        customNetworkRequestParser,
        true,
      ); // override: true
      if (success) {
        actionCount++;
        AppLogger.ic(
          LogCategory.registry,
          '✅ Registered custom networkRequest action parser (overriding default)',
        );
      } else {
        AppLogger.wc(
          LogCategory.registry,
          '⚠️ Failed to register custom networkRequest action parser',
        );
      }
    } catch (e, stackTrace) {
      AppLogger.ec(
        LogCategory.registry,
        '❌ Failed to register custom networkRequest action parser: $e\n$stackTrace',
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

  // Register custom visibility parser to handle dynamic 'visible' property
  CustomComponentRegistry.instance.registerWidget(
    const CustomVisibilityParser(),
    true,
  );

  // Register Timed Splash widget parser for auto-navigation splash screens
  CustomComponentRegistry.instance.registerWidget(TimedSplashParser());

  // Register OnMountAction widget parser for executing actions on widget mount
  // This allows backend-controlled auto-actions (navigation, data fetching, etc.)
  CustomComponentRegistry.instance.registerWidget(OnMountActionParser());

  // Register StatefulWidget parser for full widget lifecycle management
  // This enables Flutter-like lifecycle methods in STAC widgets
  CustomComponentRegistry.instance.registerWidget(StatefulWidgetParser(), true);

  // Register alias with preferred casing
  CustomComponentRegistry.instance.registerWidget(
    const StateFullWidgetParser(),
    true,
  );

  // Register reactive elevated button parser for registry-driven enable/disable
  CustomComponentRegistry.instance.registerWidget(
    const ReactiveElevatedButtonParser(),
  );

  // Register reactive switch parser for registry-driven switch toggle
  CustomComponentRegistry.instance.registerWidget(const ReactiveSwitchParser());

  // Register OTP countdown button parser for verify code screens
  CustomComponentRegistry.instance.registerWidget(
    const OtpCountdownButtonParser(),
  );

  // Register home-page banner carousel parser (auto-scroll + indicators)
  registerTobankBannerCarouselParser();
  registerTobankCardsCarouselParser();
  registerTobankCardsStackScrollerParser();

  // Register signature pad parser for hand-drawn signature capture
  CustomComponentRegistry.instance.registerWidget(const SignaturePadParser());

  // Register Promissory Real Loader parser
  CustomComponentRegistry.instance.registerWidget(
    const PromissoryRealLoaderParser(),
  );

  // Register Verify Identity Real Loader parser
  CustomComponentRegistry.instance.registerWidget(
    const VerifyIdentityRealLoaderParser(),
  );

  // Register generic ReactiveListView parser for reactive data lists
  CustomComponentRegistry.instance.registerWidget(
    const ReactiveListViewParser(),
  );

  // Override default bottomNavigationBar parser to soften item splash/highlight
  CustomComponentRegistry.instance.registerWidget(
    const CustomBottomNavigationBarParser(),
    true,
  );

  // Override bottomNavigationView parser to keep all tab pages mounted
  CustomComponentRegistry.instance.registerWidget(
    const CustomBottomNavigationViewParser(),
    true,
  );

  // Register assetWidget parser for loading tab/page content from external JSON
  CustomComponentRegistry.instance.registerWidget(const AssetWidgetParser());

  // Note: PromissoryRealPaymentDepositsParser removed as it uses the same list component

  // Register Promissory Login Action parser
  CustomComponentRegistry.instance.registerAction(
    const PromissoryLoginActionParser(),
  );

  // Register file picker action parser for file selection
  registerFilePickerActionParser();

  // Register showSnackBar action parser for notifications
  CustomComponentRegistry.instance.registerAction(
    const ShowSnackBarActionParser(),
  );

  // Register fingerPrint action parser
  CustomComponentRegistry.instance.registerAction(
    const FingerPrintActionParser(),
  );

  // Register authPersist action parser
  CustomComponentRegistry.instance.registerAction(
    const AuthPersistActionParser(),
  );

  // Register promissorySign action parser
  CustomComponentRegistry.instance.registerAction(
    const PromissorySignActionParser(),
  );

  // Register saveFile action parser
  CustomComponentRegistry.instance.registerAction(const SaveFileActionParser());

  // Register shareFile action parser for sharing files via share_plus
  CustomComponentRegistry.instance.registerAction(
    const ShareFileActionParser(),
  );

  // Register pdfPreview widget parser for rendering base64 PDFs
  CustomComponentRegistry.instance.registerWidget(const PdfPreviewParser());

  // Register formatNumber action parser for client side text formatting
  CustomComponentRegistry.instance.registerAction(
    const FormatNumberActionParser(),
  );

  // Register format date action parser
  CustomComponentRegistry.instance.registerAction(
    const FormatDateActionParser(),
  );

  // Register amount to words action parser for live verbal amount preview
  CustomComponentRegistry.instance.registerAction(
    const AmountToWordsActionParser(),
  );

  // Register rules bottom sheet action parser for showing long-form rules inline
  registerShowRulesBottomSheetActionParser();

  // Register guide options bottom sheet action parser
  registerShowGuideOptionsBottomSheetActionParser();

  // Register photo tips bottom sheet action parser
  registerShowPhotoTipsBottomSheetActionParser();

  // Register job selector bottom sheet action parser
  registerShowJobSelectorBottomSheetActionParser();

  // Register bank address bottom sheet action parser
  registerShowBankAddressBottomSheetActionParser();

  // Register theme selector bottom sheet action parser
  registerShowThemeSelectorBottomSheetActionParser();

  // Register delete-account confirmation bottom sheet action parser
  registerShowDeleteAccountConfirmBottomSheetActionParser();

  // Register logout confirmation dialog action parser
  registerShowLogoutConfirmDialogActionParser();

  // Register add destination card bottom sheet action parser
  registerShowAddDestinationCardBottomSheetActionParser();

  // Register gift-card purchase bottom sheet action parser
  registerShowGiftCardPurchaseBottomSheetActionParser();

  // Register gift-card payment accounts bottom sheet action parser
  registerShowGiftCardPaymentAccountsBottomSheetActionParser();

  // Register gift-card amount guide bottom sheet action parser
  registerShowGiftCardAmountGuideBottomSheetActionParser();

  // Register gift-card message guide bottom sheet action parser
  registerShowGiftCardMessageGuideBottomSheetActionParser();

  // Register gift-card location selector bottom sheet action parser
  registerShowGiftCardLocationSelectorBottomSheetActionParser();

  // Register gift-card date/time selector bottom sheet action parser
  registerShowGiftCardSelectDateBottomSheetActionParser();

  // Register gift-card select amount bottom sheet action parser
  registerShowGiftCardSelectAmountBottomSheetActionParser();

  // Register gift-card design type bottom sheet action parser
  registerShowGiftCardDesignTypeBottomSheetActionParser();

  // Register gift-card plan selector bottom sheet action parser
  registerShowGiftCardPlanSelectorBottomSheetActionParser();

  // Register add-gift-card amount card action parser (max 3 cards)
  registerAddGiftCardAmountCardActionParser();

  // Register remove-gift-card amount card action parser
  registerRemoveGiftCardAmountCardActionParser();

  // Register update gift-card amount count action parser (1..5)
  registerUpdateGiftCardAmountCountActionParser();

  // Register launchUrl action parser for opening external links/media
  CustomComponentRegistry.instance.registerAction(
    const LaunchUrlActionParser(),
  );

  // Register playAudioUrl action parser for in-page audio playback
  CustomComponentRegistry.instance.registerAction(
    const PlayAudioUrlActionParser(),
  );

  // Register stopAudioUrl action parser for stopping in-page audio playback
  CustomComponentRegistry.instance.registerAction(
    const StopAudioUrlActionParser(),
  );
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
