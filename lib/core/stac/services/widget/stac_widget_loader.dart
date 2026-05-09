import '../../../../stac/tobank/login/dart/tobank_login.dart' as login_dart;
import '../../../../stac/tobank/login/dart/verify_otp.dart' as verify_otp_dart;
import '../../../../stac/tobank/menu/dart/tobank_menu.dart' as tobank_menu_dart;
import '../../../../stac/tobank/home_page/dart/home_page.dart'
    as home_page_dart;
import '../../../../stac/tobank/home_page/dart/home_page_menu.dart'
    as home_page_menu_dart;
import '../../../../stac/tobank/home_page/dart/tobank_special_services_page.dart'
    as tobank_special_services_page_dart;
import '../../../../stac/tobank/home_page/dart/travel_services_page.dart'
    as travel_services_page_dart;
import '../../../../stac/tobank/home_page/dart/acceptor_services_page.dart'
    as acceptor_services_page_dart;

import '../../../../stac/tobank/onboarding/dart/tobank_onboarding.dart'
    as onboarding_dart;
import '../../../../stac/tobank/flows/login_flow_linear/dart/login_flow_linear_splash.dart'
    as linear_splash_dart;
import '../../../../stac/tobank/flows/login_flow_linear/dart/login_flow_linear_onboarding.dart'
    as linear_onboarding_dart;
import '../../../../stac/tobank/flows/login_flow_linear/dart/login_flow_linear_login.dart'
    as linear_login_dart;
import '../../../../stac/tobank/flows/login_flow_linear/dart/login_flow_linear_verify_otp.dart'
    as linear_verify_otp_dart;
// Promissory Flow imports
import '../../../../stac/tobank/flows/promissory/dart/promissory_intro.dart'
    as promissory_intro_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_rules.dart'
    as promissory_rules_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_issuer.dart'
    as promissory_issuer_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_receiver.dart'
    as promissory_receiver_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_data.dart'
    as promissory_data_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_confirm.dart'
    as promissory_confirm_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_payment.dart'
    as promissory_payment_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_success.dart'
    as promissory_success_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_sign.dart'
    as promissory_sign_dart;
// Promissory Real (API) import
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_intro.dart'
    as promissory_real_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_deposit_select.dart'
    as promissory_deposit_select_dart;
import '../../../../stac/tobank/flows/promissory/dart/request_promissory_deposit_page.dart'
    as request_promissory_deposit_page_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_receiver_screen.dart'
    as promissory_real_receiver_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_data_screen.dart'
    as promissory_real_data_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_confirm_screen.dart'
    as promissory_real_confirm_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_payment_screen.dart'
    as promissory_real_payment_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_payment_deposits_screen.dart'
    as promissory_real_payment_deposits_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_sign_screen.dart'
    as promissory_real_sign_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_success_screen.dart'
    as promissory_real_success_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_issuer_screen.dart'
    as promissory_real_issuer_dart;

import '../../../../stac/tobank/flows/promissory_real/menu/promissory_real_login_screen.dart'
    as promissory_real_login_dart;
import '../../../../stac/tobank/flows/promissory_real/menu/promissory_real_menu.dart'
    as promissory_real_debug_dart;
import '../../../../stac/tobank/flows/verify_identity_real/menu/verify_identity_real_menu.dart'
    as verify_identity_real_menu_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_intro.dart'
    as verify_identity_real_intro_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_preregister.dart'
    as verify_identity_real_preregister_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_verify_otp.dart'
    as verify_identity_real_verify_otp_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_national_card_front.dart'
    as verify_identity_real_national_card_front_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_national_card_back.dart'
    as verify_identity_real_national_card_back_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_old_national_card.dart'
    as verify_identity_real_old_national_card_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_selfie.dart'
    as verify_identity_real_selfie_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_postal_code.dart'
    as verify_identity_real_postal_code_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_rules.dart'
    as verify_identity_real_rules_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_signature.dart'
    as verify_identity_real_signature_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_certificate_generator.dart'
    as verify_identity_real_certificate_generator_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_signature_guide.dart'
    as verify_identity_real_signature_guide_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_signature_visual_guide.dart'
    as verify_identity_real_signature_visual_guide_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_final.dart'
    as verify_identity_real_final_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_registration.dart'
    as verify_identity_real_registration_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/verify_identity_real_job_selector.dart'
    as verify_identity_real_job_selector_dart;
import '../../../../stac/tobank/flows/verify_identity_real/dart/test_screen.dart'
    as test_screen_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_rules.dart'
    as promissory_real_rules_dart;
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_preview_screen.dart'
    as promissory_real_preview_dart;
import '../../../../stac/tobank/flows/promissory_real/onboarding/promissory_real_onboarding.dart'
    as promissory_real_onboarding_dart;
import '../../../../stac/tobank/flows/promissory_real/splash/promissory_real_splash.dart'
    as promissory_real_splash_dart;
import '../../../../stac/tobank/flows/profile_real/menu/profile_real_menu.dart'
    as profile_real_menu_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_intro.dart'
    as profile_real_intro_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_bank_info.dart'
    as profile_real_bank_info_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_invite_friends.dart'
    as profile_real_invite_friends_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_destinations.dart'
    as profile_real_destinations_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_settings.dart'
    as profile_real_settings_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_change_password.dart'
    as profile_real_change_password_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_rules.dart'
    as profile_real_rules_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_about.dart'
    as profile_real_about_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_contact.dart'
    as profile_real_contact_dart;
import '../../../../stac/tobank/flows/cartable_real/menu/cartable_real_menu.dart'
    as cartable_real_menu_dart;
import '../../../../stac/tobank/flows/cartable_real/dart/cartable_real_intro.dart'
    as cartable_real_intro_dart;
import '../../../../stac/tobank/flows/cartable_real/dart/cartable_real_detail.dart'
    as cartable_real_detail_dart;
import '../../../../stac/tobank/flows/transaction_real/menu/transaction_real_menu.dart'
    as transaction_real_menu_dart;
import '../../../../stac/tobank/flows/transaction_real/dart/transaction_real_intro.dart'
    as transaction_real_intro_dart;
import '../../../../stac/tobank/flows/transaction_real/dart/transaction_real_filter.dart'
    as transaction_real_filter_dart;
import '../../../../stac/tobank/flows/dashboard_real/menu/dashboard_real_menu.dart'
    as dashboard_real_menu_dart;
import '../../../../stac/tobank/flows/biometric_test/menu/biometric_test_menu.dart'
    as biometric_test_menu_dart;
import '../../../../stac/tobank/flows/dashboard_real/dart/dashboard_real_shell.dart'
    as dashboard_real_shell_dart;
import '../../../../stac/tobank/flows/dashboard_real/dart/cards_management_screen.dart'
    as cards_management_screen_dart;
import '../../../../stac/tobank/flows/gift_card_real/menu/gift_card_real_menu.dart'
    as gift_card_real_menu_dart;
import '../../../../stac/tobank/flows/transfer_real/menu/transfer_real_menu.dart'
    as transfer_real_menu_dart;
import '../../../../stac/tobank/flows/transfer_real/dart/transfer_real_amount.dart'
    as transfer_real_amount_dart;
import '../../../../stac/tobank/flows/transfer_real/dart/transfer_real_details.dart'
    as transfer_real_details_dart;
import '../../../../stac/tobank/flows/transfer_real/dart/transfer_real_confirm.dart'
    as transfer_real_confirm_dart;
import '../../../../stac/tobank/flows/transfer_real/dart/transfer_real_result.dart'
    as transfer_real_result_dart;
import '../../../../stac/tobank/flows/transfer_real/dart/transfer_real_card_result.dart'
    as transfer_real_card_result_dart;
import '../../../../stac/tobank/flows/transfer_real/dart/transfer_real_in_bank_details.dart'
    as transfer_real_in_bank_details_dart;
import '../../../../stac/tobank/flows/transfer_real/dart/transfer_real_in_bank_confirm.dart'
    as transfer_real_in_bank_confirm_dart;
import '../../../../stac/tobank/flows/transfer_real/dart/transfer_real_in_bank_result.dart'
    as transfer_real_in_bank_result_dart;
import '../../../../stac/tobank/flows/transfer_real/dart/transfer_real_card_details.dart'
    as transfer_real_card_details_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_intro.dart'
    as gift_card_real_intro_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_select_amount.dart'
    as gift_card_real_select_amount_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_design_selector.dart'
    as gift_card_real_design_selector_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_custom_design_selector.dart'
    as gift_card_real_custom_design_selector_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_image_selector.dart'
    as gift_card_real_image_selector_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_custom_select_design.dart'
    as gift_card_real_custom_select_design_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_custom_message.dart'
    as gift_card_real_custom_message_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_select_design.dart'
    as gift_card_real_select_design_dart;
import '../../../../stac/tobank/flows/charge_real/menu/charge_real_menu.dart'
    as charge_real_menu_dart;
import '../../../../stac/tobank/flows/charge_real/dart/charge_real_intro.dart'
    as charge_real_intro_dart;
import '../../../../stac/tobank/flows/charge_real/dart/charge_real_add_sim.dart'
    as charge_real_add_sim_dart;
import '../../../../stac/tobank/flows/charge_real/dart/charge_real_package_list.dart'
    as charge_real_package_list_dart;
import '../../../../stac/tobank/flows/charge_real/dart/charge_real_payment.dart'
    as charge_real_payment_dart;
import '../../../../stac/tobank/flows/charge_real/dart/charge_real_payment_success.dart'
    as charge_real_payment_success_dart;
import '../../../../stac/tobank/flows/package_real/menu/package_real_menu.dart'
    as package_real_menu_dart;
import '../../../../stac/tobank/flows/package_real/dart/package_real_intro.dart'
    as package_real_intro_dart;
import '../../../../stac/tobank/flows/package_real/dart/package_real_add_sim.dart'
    as package_real_add_sim_dart;
import '../../../../stac/tobank/flows/package_real/dart/package_real_package_list.dart'
    as package_real_package_list_dart;
import '../../../../stac/tobank/flows/package_real/dart/package_real_payment.dart'
    as package_real_payment_dart;
import '../../../../stac/tobank/flows/package_real/dart/package_real_payment_success.dart'
    as package_real_payment_success_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_message.dart'
    as gift_card_real_message_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_receiver_info.dart'
    as gift_card_real_receiver_info_dart;
import '../../../../stac/tobank/flows/gift_card_real/dart/gift_card_real_confirm.dart'
    as gift_card_real_confirm_dart;
import '../../../../stac/tobank/flows/profile_real/dart/profile_real_customer_referrals.dart'
    as profile_real_customer_referrals_dart;
import 'package:tobank_sdui/core/helpers/logger.dart';

/// Service for loading STAC widgets from Dart files.
///
/// Follows Single Responsibility Principle - only responsible for loading
/// widget JSON from Dart widget definitions.
/// Follows Open/Closed Principle - new widget types can be registered
/// without modifying this class.
class StacWidgetLoader {
  StacWidgetLoader._();

  /// Registry of widget type to loader function mappings.
  /// Extensible - new widget types can be registered without modifying this class.
  static final Map<String, Map<String, dynamic> Function()> _widgetLoaders = {
    'tobank_login_dart': () => login_dart.tobankLoginDart().toJson(),
    'tobank_verify_otp_dart': () =>
        verify_otp_dart.tobankVerifyOtpDart().toJson(),
    'tobank_menu_dart': () => tobank_menu_dart.tobankMenuDart().toJson(),
    'tobank_home_page_menu': () =>
        home_page_menu_dart.tobankHomePageMenu().toJson(),
    'tobank_home_page_dart': () => home_page_dart.tobankHomePageDart().toJson(),
    'tobank_special_services_page': () =>
        tobank_special_services_page_dart.tobankSpecialServicesPage().toJson(),
    'tobank_travel_services_page': () =>
        travel_services_page_dart.tobankTravelServicesPage().toJson(),
    'tobank_acceptor_services_page': () =>
        acceptor_services_page_dart.tobankAcceptorServicesPage().toJson(),
    'tobank_onboarding': () => onboarding_dart.tobankOnboarding().toJson(),

    // Flow widgets - all use FlowManager via loginFlowOverview
    'tobank_login_flow_dart': () => {
      'type': 'loginFlowOverview',
      'configPath':
          'lib/stac/tobank/flows/login_flow/dart/login_flow_config_dart.json',
      'useApiPath': false,
    },
    // Config-driven flow screens - uses LoginFlowOverview widget
    'login_flow_config': () => {
      '_flowWidgetType': 'login_flow_config',
      'configPath':
          'lib/stac/tobank/flows/login_flow/json/login_flow_config.json',
    },
    'login_flow_config_api': () => {
      '_flowWidgetType': 'login_flow_config_api',
      'configPath':
          'lib/stac/tobank/flows/login_flow/api/GET_login_flow_config.json',
    },
    // Linear flow widgets - each page handles navigation internally
    // Splash: Uses onMountAction to auto-navigate after 2 seconds (handled in Dart file)
    'tobank_login_flow_linear_splash': () =>
        linear_splash_dart.tobankLoginFlowLinearSplash().toJson(),
    'tobank_login_flow_linear_onboarding': () =>
        linear_onboarding_dart.tobankLoginFlowLinearOnboarding().toJson(),
    'tobank_login_flow_linear_login': () =>
        linear_login_dart.tobankLoginFlowLinearLogin().toJson(),
    'tobank_login_flow_linear_verify_otp': () =>
        linear_verify_otp_dart.tobankLoginFlowLinearVerifyOtp().toJson(),

    // Promissory Flow - Linear flow screens
    'promissory_intro': () => promissory_intro_dart.promissoryIntro().toJson(),
    'promissory_rules': () => promissory_rules_dart.promissoryRules().toJson(),
    'promissory_issuer': () =>
        promissory_issuer_dart.promissoryIssuer().toJson(),
    'promissory_receiver': () =>
        promissory_receiver_dart.promissoryReceiver().toJson(),
    'promissory_data': () => promissory_data_dart.promissoryData().toJson(),
    'promissory_confirm': () =>
        promissory_confirm_dart.promissoryConfirm().toJson(),
    'promissory_payment': () =>
        promissory_payment_dart.promissoryPayment().toJson(),
    'promissory_success': () =>
        promissory_success_dart.promissorySuccess().toJson(),
    'promissory_sign': () => promissory_sign_dart.promissorySign().toJson(),
    // Promissory Real (Real API) - fetches SDUI from real backend
    'promissory_real_menu': () =>
        promissory_real_debug_dart.promissoryRealDebugMenu().toJson(),
    'verify_identity_real_menu': () =>
        verify_identity_real_menu_dart.verifyIdentityRealMenu().toJson(),
    'profile_real_menu': () =>
        profile_real_menu_dart.profileRealMenu().toJson(),
    'profile_real_intro': () =>
        profile_real_intro_dart.profileRealIntro().toJson(),
    'profile_real_bank_info': () =>
        profile_real_bank_info_dart.profileRealBankInfo().toJson(),
    'profile_real_invite_friends': () =>
        profile_real_invite_friends_dart.profileRealInviteFriends().toJson(),
    'profile_real_destinations': () =>
        profile_real_destinations_dart.profileRealDestinations().toJson(),
    'profile_real_settings': () =>
        profile_real_settings_dart.profileRealSettings().toJson(),
    'profile_real_change_password': () =>
        profile_real_change_password_dart.profileRealChangePassword().toJson(),
    'profile_real_rules': () =>
        profile_real_rules_dart.profileRealRules().toJson(),
    'profile_real_about': () =>
        profile_real_about_dart.profileRealAbout().toJson(),
    'profile_real_contact': () =>
        profile_real_contact_dart.profileRealContact().toJson(),
    'profile_real_customer_referrals': () =>
        profile_real_customer_referrals_dart
            .profileRealCustomerReferrals()
            .toJson(),
    'cartable_real_menu': () =>
        cartable_real_menu_dart.cartableRealMenu().toJson(),
    'cartable_real_intro': () =>
        cartable_real_intro_dart.cartableRealIntro().toJson(),
    'cartable_real_detail': () =>
        cartable_real_detail_dart.cartableRealDetail().toJson(),
    'transaction_real_menu': () =>
        transaction_real_menu_dart.transactionRealMenu().toJson(),
    'transaction_real_intro': () =>
        transaction_real_intro_dart.transactionRealIntro().toJson(),
    'transaction_real_filter': () =>
        transaction_real_filter_dart.transactionRealFilter().toJson(),
    'dashboard_real_menu': () =>
        dashboard_real_menu_dart.dashboardRealMenu().toJson(),
    'biometric_test_menu': () =>
        biometric_test_menu_dart.biometricTestMenu().toJson(),
    'dashboard_real_shell': () =>
        dashboard_real_shell_dart.dashboardRealShell().toJson(),
    'dashboard_real_cards_management': () =>
        cards_management_screen_dart.dashboardRealCardsManagement().toJson(),
    'gift_card_real_menu': () =>
        gift_card_real_menu_dart.giftCardRealMenu().toJson(),
    'transfer_real_menu': () =>
        transfer_real_menu_dart.transferRealMenu().toJson(),
    'transfer_real_amount': () =>
        transfer_real_amount_dart.transferRealAmount().toJson(),
    'transfer_real_details': () =>
        transfer_real_details_dart.transferRealDetails().toJson(),
    'transfer_real_confirm': () =>
        transfer_real_confirm_dart.transferRealConfirm().toJson(),
    'transfer_real_result': () =>
        transfer_real_result_dart.transferRealResult().toJson(),
    'transfer_real_card_result': () =>
        transfer_real_card_result_dart.transferRealCardResult().toJson(),
    'transfer_real_in_bank_details': () =>
        transfer_real_in_bank_details_dart.transferRealInBankDetails().toJson(),
    'transfer_real_in_bank_confirm': () =>
        transfer_real_in_bank_confirm_dart.transferRealInBankConfirm().toJson(),
    'transfer_real_in_bank_result': () =>
        transfer_real_in_bank_result_dart.transferRealInBankResult().toJson(),
    'transfer_real_card_details': () =>
        transfer_real_card_details_dart.transferRealCardDetails().toJson(),
    'gift_card_real_intro': () =>
        gift_card_real_intro_dart.giftCardRealIntro().toJson(),
    'gift_card_real_select_amount': () =>
        gift_card_real_select_amount_dart.giftCardRealSelectAmount().toJson(),
    'gift_card_real_design_selector': () => gift_card_real_design_selector_dart
        .giftCardRealDesignSelector()
        .toJson(),
    'gift_card_real_custom_design_selector': () =>
        gift_card_real_custom_design_selector_dart
            .giftCardRealCustomDesignSelector()
            .toJson(),
    'gift_card_real_image_selector': () =>
        gift_card_real_image_selector_dart.giftCardRealImageSelector().toJson(),
    'gift_card_real_custom_select_design': () =>
        gift_card_real_custom_select_design_dart
            .giftCardRealCustomSelectDesign()
            .toJson(),
    'gift_card_real_custom_message': () =>
        gift_card_real_custom_message_dart.giftCardRealCustomMessage().toJson(),
    'gift_card_real_select_design': () =>
        gift_card_real_select_design_dart.giftCardRealSelectDesign().toJson(),
    'charge_real_menu': () => charge_real_menu_dart.chargeRealMenu().toJson(),
    'charge_real_intro': () =>
        charge_real_intro_dart.chargeRealIntro().toJson(),
    'charge_real_add_sim': () =>
        charge_real_add_sim_dart.chargeRealAddSim().toJson(),
    'charge_real_package_list': () =>
        charge_real_package_list_dart.chargeRealPackageList().toJson(),
    'charge_real_payment': () =>
        charge_real_payment_dart.chargeRealPayment().toJson(),
    'charge_real_payment_success': () =>
        charge_real_payment_success_dart.chargeRealPaymentSuccess().toJson(),
    'charge_real_simcards': () =>
        charge_real_intro_dart.chargeRealSimCards().toJson(),
    'charge_real_simcards_duplicate': () =>
        charge_real_intro_dart.chargeRealSimCardsDuplicate().toJson(),
    'charge_real_simcards_selected': () =>
        charge_real_intro_dart.chargeRealSimCardsSelected().toJson(),
    'charge_real_add_sim_empty': () =>
        charge_real_add_sim_dart.chargeRealAddSimEmpty().toJson(),
    'charge_real_add_sim_filled': () =>
        charge_real_add_sim_dart.chargeRealAddSimFilled().toJson(),
    'charge_real_add_sim_invalid': () =>
        charge_real_add_sim_dart.chargeRealAddSimInvalid().toJson(),
    'charge_real_add_sim_unsupported': () =>
        charge_real_add_sim_dart.chargeRealAddSimUnsupported().toJson(),
    'package_real_menu': () =>
        package_real_menu_dart.packageRealMenu().toJson(),
    'package_real_intro': () =>
        package_real_intro_dart.packageRealIntro().toJson(),
    'package_real_add_sim': () =>
        package_real_add_sim_dart.packageRealAddSim().toJson(),
    'package_real_package_list': () =>
        package_real_package_list_dart.packageRealPackageList().toJson(),
    'package_real_payment': () =>
        package_real_payment_dart.packageRealPayment().toJson(),
    'package_real_payment_success': () =>
        package_real_payment_success_dart.packageRealPaymentSuccess().toJson(),
    'package_real_simcards': () =>
        package_real_intro_dart.packageRealSimCards().toJson(),
    'package_real_simcards_duplicate': () =>
        package_real_intro_dart.packageRealSimCardsDuplicate().toJson(),
    'package_real_simcards_selected': () =>
        package_real_intro_dart.packageRealSimCardsSelected().toJson(),
    'package_real_add_sim_empty': () =>
        package_real_add_sim_dart.packageRealAddSimEmpty().toJson(),
    'package_real_add_sim_filled': () =>
        package_real_add_sim_dart.packageRealAddSimFilled().toJson(),
    'package_real_add_sim_invalid': () =>
        package_real_add_sim_dart.packageRealAddSimInvalid().toJson(),
    'package_real_add_sim_unsupported': () =>
        package_real_add_sim_dart.packageRealAddSimUnsupported().toJson(),
    'gift_card_real_message': () =>
        gift_card_real_message_dart.giftCardRealMessage().toJson(),
    'gift_card_real_receiver_info': () =>
        gift_card_real_receiver_info_dart.giftCardRealReceiverInfo().toJson(),
    'gift_card_real_confirm': () =>
        gift_card_real_confirm_dart.giftCardRealConfirm().toJson(),
    'verify_identity_real_intro': () =>
        verify_identity_real_intro_dart.verifyIdentityRealIntro().toJson(),
    'verify_identity_real_preregister': () =>
        verify_identity_real_preregister_dart
            .verifyIdentityRealPreRegister()
            .toJson(),
    'verify_identity_real_verify_otp': () =>
        verify_identity_real_verify_otp_dart
            .verifyIdentityRealVerifyOtp()
            .toJson(),
    'verify_identity_real_national_card_front': () =>
        verify_identity_real_national_card_front_dart
            .verifyIdentityRealNationalCardFront()
            .toJson(),
    'verify_identity_real_national_card_back': () =>
        verify_identity_real_national_card_back_dart
            .verifyIdentityRealNationalCardBack()
            .toJson(),
    'verify_identity_real_old_national_card': () =>
        verify_identity_real_old_national_card_dart
            .verifyIdentityRealOldNationalCard()
            .toJson(),
    'verify_identity_real_selfie': () =>
        verify_identity_real_selfie_dart.verifyIdentityRealSelfie().toJson(),
    'verify_identity_real_postal_code': () =>
        verify_identity_real_postal_code_dart
            .verifyIdentityRealPostalCode()
            .toJson(),
    'verify_identity_real_rules': () =>
        verify_identity_real_rules_dart.verifyIdentityRealRules().toJson(),
    'verify_identity_real_signature': () => verify_identity_real_signature_dart
        .verifyIdentityRealSignature()
        .toJson(),
    'verify_identity_real_certificate_generator': () =>
        verify_identity_real_certificate_generator_dart
            .verifyIdentityRealCertificateGenerator()
            .toJson(),
    'verify_identity_real_signature_guide': () =>
        verify_identity_real_signature_guide_dart
            .verifyIdentityRealSignatureGuide()
            .toJson(),
    'verify_identity_real_signature_visual_guide': () =>
        verify_identity_real_signature_visual_guide_dart
            .verifyIdentityRealSignatureVisualGuide()
            .toJson(),
    'verify_identity_real_final': () =>
        verify_identity_real_final_dart.verifyIdentityRealFinal().toJson(),
    'verify_identity_real_registration': () =>
        verify_identity_real_registration_dart
            .verifyIdentityRealRegistration()
            .toJson(),
    'verify_identity_real_job_selector': () =>
        verify_identity_real_job_selector_dart
            .verifyIdentityRealJobSelector()
            .toJson(),
    'test_screen': () => test_screen_dart.testScreen().toJson(),
    'promissory_real_loader': () => {'type': 'promissory_real_loader'},
    'verify_identity_real_loader': () => {
      'type': 'verify_identity_real_loader',
    },
    'promissory_deposit_select': () =>
        promissory_deposit_select_dart.promissoryDepositSelectPage().toJson(),
    'request_promissory_deposit': () => request_promissory_deposit_page_dart
        .requestPromissoryDepositPage()
        .toJson(),
    'promissory_real_intro': () =>
        promissory_real_dart.promissoryRealIntro().toJson(),
    'promissory_real_login_form_dart': () =>
        promissory_real_login_dart.promissoryRealLoginForm().toJson(),
    'promissory_real_rules': () =>
        promissory_real_rules_dart.promissoryRealRules().toJson(),
    'promissory_real_issuer': () =>
        promissory_real_issuer_dart.promissoryRealIssuer().toJson(),
    'promissory_real_receiver': () =>
        promissory_real_receiver_dart.promissoryRealReceiver().toJson(),
    'promissory_real_data': () =>
        promissory_real_data_dart.promissoryRealData().toJson(),
    'promissory_real_confirm': () =>
        promissory_real_confirm_dart.promissoryRealConfirm().toJson(),
    'promissory_real_payment': () =>
        promissory_real_payment_dart.promissoryRealPayment().toJson(),
    'promissory_real_payment_deposits': () =>
        promissory_real_payment_deposits_dart
            .promissoryRealPaymentDeposits()
            .toJson(),
    'promissory_real_sign': () =>
        promissory_real_sign_dart.promissoryRealSign().toJson(),
    'promissory_real_success': () =>
        promissory_real_success_dart.promissoryRealSuccess().toJson(),
    'promissory_real_preview': () =>
        promissory_real_preview_dart.promissoryRealPreview().toJson(),
    'promissory_real_onboarding': () =>
        promissory_real_onboarding_dart.promissoryRealOnboarding().toJson(),
    'promissory_real_splash': () =>
        promissory_real_splash_dart.promissoryRealSplash().toJson(),
  };

  /// Registers a widget loader for a specific widget type.
  /// Allows extension without modification (Open/Closed Principle).
  static void registerWidgetLoader(
    String widgetType,
    Map<String, dynamic> Function() loader,
  ) {
    _widgetLoaders[widgetType] = loader;
  }

  /// Loads widget JSON from Dart file based on widgetType.
  /// Returns null if widgetType is not registered or loading fails.
  static Map<String, dynamic>? loadWidgetJson(String? widgetType) {
    if (widgetType == null || widgetType.isEmpty) {
      AppLogger.w('StacWidgetLoader: widgetType is null or empty');
      return null;
    }

    final loader = _widgetLoaders[widgetType];
    if (loader == null) {
      AppLogger.w(
        'StacWidgetLoader: No loader found for widgetType: $widgetType',
      );
      AppLogger.d('Available widgetTypes: ${_widgetLoaders.keys.toList()}');
      return null;
    }

    try {
      AppLogger.d('StacWidgetLoader: Loading widget JSON for: $widgetType');
      final json = loader();
      AppLogger.d(
        'StacWidgetLoader: Successfully loaded JSON for: $widgetType',
      );
      AppLogger.d('JSON keys: ${json.keys.toList()}');
      return json;
    } catch (e, stackTrace) {
      // Log error but don't throw - allows fallback to other navigation methods
      AppLogger.e(
        'StacWidgetLoader: Error loading widget JSON for $widgetType',
        e,
        stackTrace,
      );
      return null;
    }
  }
}
