import '../../../../stac/tobank/login/dart/tobank_login.dart' as login_dart;
import '../../../../stac/tobank/login/dart/verify_otp.dart' as verify_otp_dart;
import '../../../../stac/tobank/menu/dart/tobank_menu.dart' as tobank_menu_dart;
import '../../../../stac/tobank/flows/home_page/dart/home_page.dart'
    as home_page_dart;
import '../../../../stac/tobank/flows/home_page/dart/home_page_menu.dart'
    as home_page_menu_dart;
import '../../../../stac/tobank/flows/home_page/dart/tobank_special_services_page.dart'
    as tobank_special_services_page_dart;
import '../../../../stac/tobank/flows/home_page/dart/travel_services_page.dart'
    as travel_services_page_dart;
import '../../../../stac/tobank/flows/home_page/dart/acceptor_services_page.dart'
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
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_intro.dart'
    as promissory_old_intro_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_rules.dart'
    as promissory_old_rules_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_issuer.dart'
    as promissory_old_issuer_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_receiver.dart'
    as promissory_old_receiver_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_data.dart'
    as promissory_old_data_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_confirm.dart'
    as promissory_old_confirm_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_payment.dart'
    as promissory_old_payment_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_success.dart'
    as promissory_old_success_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_sign.dart'
    as promissory_old_sign_dart;
// Promissory Real (API) import
import '../../../../stac/tobank/flows/promissory/dart/promissory_intro.dart'
    as promissory_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/promissory_deposit_select.dart'
    as promissory_old_deposit_select_dart;
import '../../../../stac/tobank/flows/promissory_old/dart/request_promissory_deposit_page.dart'
    as request_promissory_old_deposit_page_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_receiver_screen.dart'
    as promissory_receiver_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_data_screen.dart'
    as promissory_data_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_confirm_screen.dart'
    as promissory_confirm_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_payment_screen.dart'
    as promissory_payment_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_payment_deposits_screen.dart'
    as promissory_payment_deposits_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_sign_screen.dart'
    as promissory_sign_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_success_screen.dart'
    as promissory_success_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_issuer_screen.dart'
    as promissory_issuer_dart;

import '../../../../stac/tobank/flows/login/dart/login_screen.dart'
    as login_screen_dart;
import '../../../../stac/tobank/flows/promissory/menu/promissory_menu.dart'
    as promissory_debug_dart;
import '../../../../stac/tobank/flows/verify_identity/menu/verify_identity_menu.dart'
    as verify_identity_menu_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_intro.dart'
    as verify_identity_intro_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_preregister.dart'
    as verify_identity_preregister_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_verify_otp.dart'
    as verify_identity_verify_otp_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_national_card_front.dart'
    as verify_identity_national_card_front_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_national_card_back.dart'
    as verify_identity_national_card_back_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_old_national_card.dart'
    as verify_identity_old_national_card_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_selfie.dart'
    as verify_identity_selfie_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_postal_code.dart'
    as verify_identity_postal_code_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_rules.dart'
    as verify_identity_rules_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_signature.dart'
    as verify_identity_signature_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_certificate_generator.dart'
    as verify_identity_certificate_generator_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_signature_guide.dart'
    as verify_identity_signature_guide_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_signature_visual_guide.dart'
    as verify_identity_signature_visual_guide_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_final.dart'
    as verify_identity_final_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_registration.dart'
    as verify_identity_registration_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/verify_identity_job_selector.dart'
    as verify_identity_job_selector_dart;
import '../../../../stac/tobank/flows/verify_identity/dart/test_screen.dart'
    as test_screen_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_rules.dart'
    as promissory_real_rules_dart;
import '../../../../stac/tobank/flows/promissory/dart/promissory_preview_screen.dart'
    as promissory_preview_dart;
import '../../../../stac/tobank/flows/login/dart/login_onboarding.dart'
    as login_onboarding_dart;
import '../../../../stac/tobank/flows/login/dart/login_splash.dart'
    as login_splash_dart;
import '../../../../stac/tobank/flows/profile/menu/profile_menu.dart'
    as profile_menu_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_intro.dart'
    as profile_intro_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_bank_info.dart'
    as profile_bank_info_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_invite_friends.dart'
    as profile_invite_friends_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_destinations.dart'
    as profile_destinations_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_settings.dart'
    as profile_settings_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_change_password.dart'
    as profile_change_password_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_rules.dart'
    as profile_rules_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_about.dart'
    as profile_about_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_contact.dart'
    as profile_contact_dart;
import '../../../../stac/tobank/flows/cartable/menu/cartable_menu.dart'
    as cartable_menu_dart;
import '../../../../stac/tobank/flows/cartable/dart/cartable_intro.dart'
    as cartable_intro_dart;
import '../../../../stac/tobank/flows/cartable/dart/cartable_detail.dart'
    as cartable_detail_dart;
import '../../../../stac/tobank/flows/transaction/menu/transaction_menu.dart'
    as transaction_menu_dart;
import '../../../../stac/tobank/flows/transaction/dart/transaction_intro.dart'
    as transaction_intro_dart;
import '../../../../stac/tobank/flows/transaction/dart/transaction_filter.dart'
    as transaction_filter_dart;
import '../../../../stac/tobank/flows/dashboard/menu/dashboard_menu.dart'
    as dashboard_menu_dart;
import '../../../../stac/tobank/flows/biometric_test/menu/biometric_test_menu.dart'
    as biometric_test_menu_dart;
import '../../../../stac/tobank/flows/dashboard/dart/dashboard_shell.dart'
    as dashboard_shell_dart;
import '../../../../stac/tobank/flows/dashboard/dart/cards_management_screen.dart'
    as cards_management_screen_dart;
import '../../../../stac/tobank/flows/gift_card/menu/gift_card_menu.dart'
    as gift_card_menu_dart;
import '../../../../stac/tobank/flows/transfer/menu/transfer_menu.dart'
    as transfer_menu_dart;
import '../../../../stac/tobank/flows/transfer/dart/transfer_amount.dart'
    as transfer_amount_dart;
import '../../../../stac/tobank/flows/transfer/dart/transfer_details.dart'
    as transfer_details_dart;
import '../../../../stac/tobank/flows/transfer/dart/transfer_confirm.dart'
    as transfer_confirm_dart;
import '../../../../stac/tobank/flows/transfer/dart/transfer_result.dart'
    as transfer_result_dart;
import '../../../../stac/tobank/flows/transfer/dart/transfer_card_result.dart'
    as transfer_card_result_dart;
import '../../../../stac/tobank/flows/transfer/dart/transfer_in_bank_details.dart'
    as transfer_in_bank_details_dart;
import '../../../../stac/tobank/flows/transfer/dart/transfer_in_bank_confirm.dart'
    as transfer_in_bank_confirm_dart;
import '../../../../stac/tobank/flows/transfer/dart/transfer_in_bank_result.dart'
    as transfer_in_bank_result_dart;
import '../../../../stac/tobank/flows/transfer/dart/transfer_card_details.dart'
    as transfer_card_details_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_intro.dart'
    as gift_card_intro_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_select_amount.dart'
    as gift_card_select_amount_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_design_selector.dart'
    as gift_card_design_selector_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_custom_design_selector.dart'
    as gift_card_custom_design_selector_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_image_selector.dart'
    as gift_card_image_selector_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_custom_select_design.dart'
    as gift_card_custom_select_design_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_custom_message.dart'
    as gift_card_custom_message_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_select_design.dart'
    as gift_card_select_design_dart;
import '../../../../stac/tobank/flows/charge/menu/charge_menu.dart'
    as charge_menu_dart;
import '../../../../stac/tobank/flows/charge/dart/charge_intro.dart'
    as charge_intro_dart;
import '../../../../stac/tobank/flows/charge/dart/charge_add_sim.dart'
    as charge_add_sim_dart;
import '../../../../stac/tobank/flows/charge/dart/charge_package_list.dart'
    as charge_package_list_dart;
import '../../../../stac/tobank/flows/charge/dart/charge_payment.dart'
    as charge_payment_dart;
import '../../../../stac/tobank/flows/charge/dart/charge_payment_success.dart'
    as charge_payment_success_dart;
import '../../../../stac/tobank/flows/package/menu/package_menu.dart'
    as package_menu_dart;
import '../../../../stac/tobank/flows/package/dart/package_intro.dart'
    as package_intro_dart;
import '../../../../stac/tobank/flows/package/dart/package_add_sim.dart'
    as package_add_sim_dart;
import '../../../../stac/tobank/flows/package/dart/package_package_list.dart'
    as package_package_list_dart;
import '../../../../stac/tobank/flows/package/dart/package_payment.dart'
    as package_payment_dart;
import '../../../../stac/tobank/flows/package/dart/package_payment_success.dart'
    as package_payment_success_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_message.dart'
    as gift_card_message_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_receiver_info.dart'
    as gift_card_receiver_info_dart;
import '../../../../stac/tobank/flows/gift_card/dart/gift_card_confirm.dart'
    as gift_card_confirm_dart;
import '../../../../stac/tobank/flows/profile/dart/profile_customer_referrals.dart'
    as profile_customer_referrals_dart;
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

    // Legacy promissory flow screens
    'promissory_old_intro': () =>
        promissory_old_intro_dart.promissoryIntro().toJson(),
    'promissory_old_rules': () =>
        promissory_old_rules_dart.promissoryRules().toJson(),
    'promissory_old_issuer': () =>
        promissory_old_issuer_dart.promissoryIssuer().toJson(),
    'promissory_old_receiver': () =>
        promissory_old_receiver_dart.promissoryReceiver().toJson(),
    'promissory_old_data': () =>
        promissory_old_data_dart.promissoryData().toJson(),
    'promissory_old_confirm': () =>
        promissory_old_confirm_dart.promissoryConfirm().toJson(),
    'promissory_old_payment': () =>
        promissory_old_payment_dart.promissoryPayment().toJson(),
    'promissory_old_success': () =>
        promissory_old_success_dart.promissorySuccess().toJson(),
    'promissory_old_sign': () =>
        promissory_old_sign_dart.promissorySign().toJson(),
    // Promissory Real (Real API) - fetches SDUI from real backend
    'promissory_menu': () =>
        promissory_debug_dart.promissoryRealDebugMenu().toJson(),
    'verify_identity_menu': () =>
        verify_identity_menu_dart.verifyIdentityRealMenu().toJson(),
    'profile_menu': () =>
        profile_menu_dart.profileRealMenu().toJson(),
    'profile_intro': () =>
        profile_intro_dart.profileRealIntro().toJson(),
    'profile_bank_info': () =>
        profile_bank_info_dart.profileRealBankInfo().toJson(),
    'profile_invite_friends': () =>
        profile_invite_friends_dart.profileRealInviteFriends().toJson(),
    'profile_destinations': () =>
        profile_destinations_dart.profileRealDestinations().toJson(),
    'profile_settings': () =>
        profile_settings_dart.profileRealSettings().toJson(),
    'profile_change_password': () =>
        profile_change_password_dart.profileRealChangePassword().toJson(),
    'profile_rules': () =>
        profile_rules_dart.profileRealRules().toJson(),
    'profile_about': () =>
        profile_about_dart.profileRealAbout().toJson(),
    'profile_contact': () =>
        profile_contact_dart.profileRealContact().toJson(),
    'profile_customer_referrals': () =>
        profile_customer_referrals_dart
            .profileRealCustomerReferrals()
            .toJson(),
    'cartable_menu': () =>
        cartable_menu_dart.cartableRealMenu().toJson(),
    'cartable_intro': () =>
        cartable_intro_dart.cartableRealIntro().toJson(),
    'cartable_detail': () =>
        cartable_detail_dart.cartableRealDetail().toJson(),
    'transaction_menu': () =>
        transaction_menu_dart.transactionRealMenu().toJson(),
    'transaction_intro': () =>
        transaction_intro_dart.transactionRealIntro().toJson(),
    'transaction_filter': () =>
        transaction_filter_dart.transactionRealFilter().toJson(),
    'dashboard_menu': () =>
        dashboard_menu_dart.dashboardRealMenu().toJson(),
    'biometric_test_menu': () =>
        biometric_test_menu_dart.biometricTestMenu().toJson(),
    'dashboard_shell': () =>
        dashboard_shell_dart.dashboardRealShell().toJson(),
    'dashboard_cards_management': () =>
        cards_management_screen_dart.dashboardRealCardsManagement().toJson(),
    'gift_card_menu': () =>
        gift_card_menu_dart.giftCardRealMenu().toJson(),
    'transfer_menu': () =>
        transfer_menu_dart.transferRealMenu().toJson(),
    'transfer_amount': () =>
        transfer_amount_dart.transferRealAmount().toJson(),
    'transfer_details': () =>
        transfer_details_dart.transferRealDetails().toJson(),
    'transfer_confirm': () =>
        transfer_confirm_dart.transferRealConfirm().toJson(),
    'transfer_result': () =>
        transfer_result_dart.transferRealResult().toJson(),
    'transfer_card_result': () =>
        transfer_card_result_dart.transferRealCardResult().toJson(),
    'transfer_in_bank_details': () =>
        transfer_in_bank_details_dart.transferRealInBankDetails().toJson(),
    'transfer_in_bank_confirm': () =>
        transfer_in_bank_confirm_dart.transferRealInBankConfirm().toJson(),
    'transfer_in_bank_result': () =>
        transfer_in_bank_result_dart.transferRealInBankResult().toJson(),
    'transfer_card_details': () =>
        transfer_card_details_dart.transferRealCardDetails().toJson(),
    'gift_card_intro': () =>
        gift_card_intro_dart.giftCardRealIntro().toJson(),
    'gift_card_select_amount': () =>
        gift_card_select_amount_dart.giftCardRealSelectAmount().toJson(),
    'gift_card_design_selector': () => gift_card_design_selector_dart
        .giftCardRealDesignSelector()
        .toJson(),
    'gift_card_custom_design_selector': () =>
        gift_card_custom_design_selector_dart
            .giftCardRealCustomDesignSelector()
            .toJson(),
    'gift_card_image_selector': () =>
        gift_card_image_selector_dart.giftCardRealImageSelector().toJson(),
    'gift_card_custom_select_design': () =>
        gift_card_custom_select_design_dart
            .giftCardRealCustomSelectDesign()
            .toJson(),
    'gift_card_custom_message': () =>
        gift_card_custom_message_dart.giftCardRealCustomMessage().toJson(),
    'gift_card_select_design': () =>
        gift_card_select_design_dart.giftCardRealSelectDesign().toJson(),
    'charge_menu': () => charge_menu_dart.chargeRealMenu().toJson(),
    'charge_intro': () =>
        charge_intro_dart.chargeRealIntro().toJson(),
    'charge_add_sim': () =>
        charge_add_sim_dart.chargeRealAddSim().toJson(),
    'charge_package_list': () =>
        charge_package_list_dart.chargeRealPackageList().toJson(),
    'charge_payment': () =>
        charge_payment_dart.chargeRealPayment().toJson(),
    'charge_payment_success': () =>
        charge_payment_success_dart.chargeRealPaymentSuccess().toJson(),
    'package_menu': () =>
        package_menu_dart.packageRealMenu().toJson(),
    'package_intro': () =>
        package_intro_dart.packageRealIntro().toJson(),
    'package_add_sim': () =>
        package_add_sim_dart.packageRealAddSim().toJson(),
    'package_package_list': () =>
        package_package_list_dart.packageRealPackageList().toJson(),
    'package_payment': () =>
        package_payment_dart.packageRealPayment().toJson(),
    'package_payment_success': () =>
        package_payment_success_dart.packageRealPaymentSuccess().toJson(),
    'gift_card_message': () =>
        gift_card_message_dart.giftCardRealMessage().toJson(),
    'gift_card_receiver_info': () =>
        gift_card_receiver_info_dart.giftCardRealReceiverInfo().toJson(),
    'gift_card_confirm': () =>
        gift_card_confirm_dart.giftCardRealConfirm().toJson(),
    'verify_identity_intro': () =>
        verify_identity_intro_dart.verifyIdentityRealIntro().toJson(),
    'verify_identity_preregister': () =>
        verify_identity_preregister_dart
            .verifyIdentityRealPreRegister()
            .toJson(),
    'verify_identity_verify_otp': () =>
        verify_identity_verify_otp_dart
            .verifyIdentityRealVerifyOtp()
            .toJson(),
    'verify_identity_national_card_front': () =>
        verify_identity_national_card_front_dart
            .verifyIdentityRealNationalCardFront()
            .toJson(),
    'verify_identity_national_card_back': () =>
        verify_identity_national_card_back_dart
            .verifyIdentityRealNationalCardBack()
            .toJson(),
    'verify_identity_old_national_card': () =>
        verify_identity_old_national_card_dart
            .verifyIdentityRealOldNationalCard()
            .toJson(),
    'verify_identity_selfie': () =>
        verify_identity_selfie_dart.verifyIdentityRealSelfie().toJson(),
    'verify_identity_postal_code': () =>
        verify_identity_postal_code_dart
            .verifyIdentityRealPostalCode()
            .toJson(),
    'verify_identity_rules': () =>
        verify_identity_rules_dart.verifyIdentityRealRules().toJson(),
    'verify_identity_signature': () => verify_identity_signature_dart
        .verifyIdentityRealSignature()
        .toJson(),
    'verify_identity_certificate_generator': () =>
        verify_identity_certificate_generator_dart
            .verifyIdentityRealCertificateGenerator()
            .toJson(),
    'verify_identity_signature_guide': () =>
        verify_identity_signature_guide_dart
            .verifyIdentityRealSignatureGuide()
            .toJson(),
    'verify_identity_signature_visual_guide': () =>
        verify_identity_signature_visual_guide_dart
            .verifyIdentityRealSignatureVisualGuide()
            .toJson(),
    'verify_identity_final': () =>
        verify_identity_final_dart.verifyIdentityRealFinal().toJson(),
    'verify_identity_registration': () =>
        verify_identity_registration_dart
            .verifyIdentityRealRegistration()
            .toJson(),
    'verify_identity_job_selector': () =>
        verify_identity_job_selector_dart
            .verifyIdentityRealJobSelector()
            .toJson(),
    'test_screen': () => test_screen_dart.testScreen().toJson(),
    'promissory_loader': () => {'type': 'promissory_loader'},
    'verify_identity_loader': () => {
      'type': 'verify_identity_loader',
    },
    'promissory_old_deposit_select': () =>
        promissory_old_deposit_select_dart
            .promissoryDepositSelectPage()
            .toJson(),
    'request_promissory_old_deposit': () =>
        request_promissory_old_deposit_page_dart
        .requestPromissoryDepositPage()
        .toJson(),
    'promissory_intro': () =>
        promissory_dart.promissoryRealIntro().toJson(),
    'login_form_dart': () =>
        login_screen_dart.loginForm().toJson(),
    'promissory_rules': () =>
        promissory_real_rules_dart.promissoryRealRules().toJson(),
    'promissory_issuer': () =>
        promissory_issuer_dart.promissoryRealIssuer().toJson(),
    'promissory_receiver': () =>
        promissory_receiver_dart.promissoryRealReceiver().toJson(),
    'promissory_data': () =>
        promissory_data_dart.promissoryRealData().toJson(),
    'promissory_confirm': () =>
        promissory_confirm_dart.promissoryRealConfirm().toJson(),
    'promissory_payment': () =>
        promissory_payment_dart.promissoryRealPayment().toJson(),
    'promissory_payment_deposits': () =>
        promissory_payment_deposits_dart
            .promissoryRealPaymentDeposits()
            .toJson(),
    'promissory_sign': () =>
        promissory_sign_dart.promissoryRealSign().toJson(),
    'promissory_success': () =>
        promissory_success_dart.promissoryRealSuccess().toJson(),
    'promissory_preview': () =>
        promissory_preview_dart.promissoryRealPreview().toJson(),
    'login_onboarding': () =>
        login_onboarding_dart.loginOnboarding().toJson(),
    'login_splash': () =>
        login_splash_dart.loginSplash().toJson(),
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
