import '../../../stac/tobank/flows/user_credit_validation/dart/user_credit_validation_receipt.dart'
    as user_credit_validation_receipt_dart;
import '../../../stac/tobank/flows/user_credit_validation/dart/user_credit_validation_preview.dart'
    as user_credit_validation_preview_dart;
import '../../../stac/tobank/flows/user_credit_validation/dart/user_credit_validation_report_detail.dart'
    as user_credit_validation_report_detail_dart;
import '../../../stac/tobank/menu/dart/tobank_menu.dart' as tobank_menu_dart;
import '../../../stac/tobank/flows/home_page/dart/home_page.dart'
    as home_page_dart;
import '../../../stac/tobank/flows/home_page/dart/tobank_special_services_page.dart'
    as tobank_special_services_page_dart;
import '../../../stac/tobank/flows/home_page/dart/travel_services_page.dart'
    as travel_services_page_dart;
import '../../../stac/tobank/flows/home_page/dart/acceptor_services_page.dart'
    as acceptor_services_page_dart;


// Promissory Real (API) import
import '../../../stac/tobank/flows/promissory/dart/promissory_intro.dart'
    as promissory_dart;
import '../../../stac/tobank/flows/promissory_guarantee/menu/guarantee_promissory_api_real_menu.dart'
    as guarantee_promissory_api_real_menu_dart;
import '../../../stac/tobank/flows/promissory_guarantee/page/promissory_guarantee_info_page.dart'
    as promissory_guarantee_info_page_dart;
import '../../../stac/tobank/flows/promissory_guarantee/page/promissory_guarantee_confirm_page.dart'
    as promissory_guarantee_confirm_page_dart;
import '../../../stac/tobank/flows/promissory_guarantee/page/promissory_guarantee_sign_page.dart'
    as promissory_guarantee_sign_page_dart;
import '../../../stac/tobank/flows/promissory_guarantee/page/promissory_guarantee_final_page.dart'
    as promissory_guarantee_final_page_dart;
import '../../../stac/tobank/flows/promissory_guarantee/page/promissory_guarantee_preview_page.dart'
    as promissory_guarantee_preview_page_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_receiver.dart'
    as promissory_receiver_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_data.dart'
    as promissory_data_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_confirm.dart'
    as promissory_confirm_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_payment.dart'
    as promissory_payment_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_payment_deposits.dart'
    as promissory_payment_deposits_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_sign.dart'
    as promissory_sign_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_success.dart'
    as promissory_success_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_issuer.dart'
    as promissory_issuer_dart;

import '../../../stac/tobank/flows/login/dart/login.dart'
    as login_screen_dart;
import '../../../stac/tobank/flows/promissory/menu/promissory_menu.dart'
    as promissory_debug_dart;
import '../../../stac/tobank/flows/authentication/menu/authentication_menu.dart'
    as authentication_menu_dart;
import '../../../stac/tobank/flows/user_credit_validation/menu/user_credit_validation_menu.dart'
    as user_credit_validation_menu_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_intro.dart'
    as authentication_intro_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_preregister.dart'
    as authentication_preregister_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_verify_otp.dart'
    as authentication_verify_otp_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_national_card_front.dart'
    as authentication_national_card_front_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_national_card_back.dart'
    as authentication_national_card_back_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_old_national_card.dart'
    as authentication_old_national_card_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_selfie.dart'
    as authentication_selfie_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_postal_code.dart'
    as authentication_postal_code_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_rules.dart'
    as authentication_rules_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_signature.dart'
    as authentication_signature_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_certificate_generator.dart'
    as authentication_certificate_generator_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_signature_guide.dart'
    as authentication_signature_guide_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_signature_visual_guide.dart'
    as authentication_signature_visual_guide_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_final.dart'
    as authentication_final_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_registration.dart'
    as authentication_registration_dart;
import '../../../stac/tobank/flows/authentication/dart/authentication_job_selector.dart'
    as authentication_job_selector_dart;
import '../../../stac/tobank/flows/authentication/dart/test.dart'
    as test_screen_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_rules.dart'
    as promissory_real_rules_dart;
import '../../../stac/tobank/flows/promissory/dart/promissory_preview.dart'
    as promissory_preview_dart;
import '../../../stac/tobank/flows/login/dart/login_onboarding.dart'
    as login_onboarding_dart;
import '../../../stac/tobank/flows/login/dart/login_splash.dart'
    as login_splash_dart;
import '../../../stac/tobank/flows/profile/menu/profile_menu.dart'
    as profile_menu_dart;
import '../../../stac/tobank/flows/profile/dart/profile_intro.dart'
    as profile_intro_dart;
import '../../../stac/tobank/flows/profile/dart/profile_bank_info.dart'
    as profile_bank_info_dart;
import '../../../stac/tobank/flows/profile/dart/profile_invite_friends.dart'
    as profile_invite_friends_dart;
import '../../../stac/tobank/flows/profile/dart/profile_destinations.dart'
    as profile_destinations_dart;
import '../../../stac/tobank/flows/profile/dart/profile_settings.dart'
    as profile_settings_dart;
import '../../../stac/tobank/flows/profile/dart/profile_change_password.dart'
    as profile_change_password_dart;
import '../../../stac/tobank/flows/profile/dart/profile_rules.dart'
    as profile_rules_dart;
import '../../../stac/tobank/flows/profile/dart/profile_about.dart'
    as profile_about_dart;
import '../../../stac/tobank/flows/profile/dart/profile_contact.dart'
    as profile_contact_dart;
import '../../../stac/tobank/flows/cartable/menu/cartable_menu.dart'
    as cartable_menu_dart;
import '../../../stac/tobank/flows/cartable/dart/cartable_intro.dart'
    as cartable_intro_dart;
import '../../../stac/tobank/flows/cartable/dart/cartable_detail.dart'
    as cartable_detail_dart;
import '../../../stac/tobank/flows/transaction/menu/transaction_menu.dart'
    as transaction_menu_dart;
import '../../../stac/tobank/flows/installment_payment/menu/installment_payment_api_real_menu.dart'
    as installment_payment_api_real_menu_dart;
import '../../../stac/tobank/flows/child_loan/menu/child_loan_menu.dart'
    as child_loan_menu_dart;
import '../../../stac/tobank/flows/child_loan/dart/child_loan_rules.dart'
    as child_loan_rules_dart;
import '../../../stac/tobank/flows/child_loan/dart/child_loan_customer_check.dart'
    as child_loan_customer_check_dart;
import '../../../stac/tobank/flows/child_loan/dart/child_loan_task_list.dart'
    as child_loan_task_list_dart;
import '../../../stac/tobank/flows/child_loan/dart/child_loan_customer_document.dart'
    as child_loan_customer_document_dart;
import '../../../stac/tobank/flows/child_loan/dart/child_loan_guarantee_address.dart'
    as child_loan_guarantee_address_dart;
import '../../../stac/tobank/flows/child_loan/dart/child_loan_child_check.dart'
    as child_loan_child_check_dart;
import '../../../stac/tobank/flows/installment_payment/dart/installment_payment_list_main.dart'
    as installment_payment_list_main_dart;
import '../../../stac/tobank/flows/installment_payment/dart/installment_payment_detail_main.dart'
    as installment_payment_detail_main_dart;
import '../../../stac/tobank/flows/transaction/dart/transaction_intro.dart'
    as transaction_intro_dart;
import '../../../stac/tobank/flows/transaction/dart/transaction_filter.dart'
    as transaction_filter_dart;
import '../../../stac/tobank/flows/notification/menu/notification_menu.dart'
    as notification_menu_dart;
import '../../../stac/tobank/flows/notification/dart/notification_intro.dart'
    as notification_intro_dart;
import '../../../stac/tobank/flows/deposit_turnover/menu/deposit_turnover_menu.dart'
    as deposit_turnover_menu_dart;
import '../../../stac/tobank/flows/deposit_turnover/dart/deposit_turnover_intro.dart'
    as deposit_turnover_intro_dart;
import '../../../stac/tobank/flows/deposit_turnover/dart/deposit_turnover_transactions.dart'
    as deposit_turnover_transactions_dart;
import '../../../stac/tobank/flows/deposit_more_options/menu/deposit_more_options_menu.dart'
    as deposit_more_options_menu_dart;
import '../../../stac/tobank/flows/deposit_more_options/dart/deposit_more_options_intro.dart'
    as deposit_more_options_intro_dart;
import '../../../stac/tobank/flows/deposit_more_options/dart/deposit_card_issue_address.dart'
    as deposit_card_issue_address_dart;
import '../../../stac/tobank/flows/deposit_more_options/dart/deposit_card_issue_template.dart'
    as deposit_card_issue_template_dart;
import '../../../stac/tobank/flows/deposit_more_options/dart/deposit_card_issue_result.dart'
    as deposit_card_issue_result_dart;
import '../../../stac/tobank/flows/deposit_more_options/dart/deposit_close_confirm.dart'
    as deposit_close_confirm_dart;
import '../../../stac/tobank/flows/deposit_more_options/dart/deposit_close_selector.dart'
    as deposit_close_selector_dart;
import '../../../stac/tobank/flows/deposit_more_options/dart/deposit_close_result.dart'
    as deposit_close_result_dart;
import '../../../stac/tobank/flows/dashboard/menu/dashboard_menu.dart'
    as dashboard_menu_dart;
import '../../../stac/tobank/flows/biometric_test/menu/biometric_test_menu.dart'
    as biometric_test_menu_dart;
import '../../../stac/tobank/flows/dashboard/dart/dashboard_shell.dart'
    as dashboard_shell_dart;
import '../../../stac/tobank/flows/dashboard/dart/cards_management.dart'
    as cards_management_screen_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/widgets/card_edit.dart'
    as card_edit_screen_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/wallet/wallet_transfer_receipt.dart'
    as wallet_transfer_receipt_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/pin/primary_pin_get.dart'
    as primary_pin_get_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/pin/primary_pin_change.dart'
    as primary_pin_change_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/pin/primary_pin_result.dart'
    as primary_pin_result_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/pin/secondary_pin_get.dart'
    as secondary_pin_get_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/pin/secondary_pin_change.dart'
    as secondary_pin_change_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/pin/secondary_pin_receipt.dart'
    as secondary_pin_receipt_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/reissue/reissue_request.dart'
    as reissue_request_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/reissue/reissue_select_card_color.dart'
    as reissue_select_card_color_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/reissue/reissue_receipt.dart'
    as reissue_receipt_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/balance/card_balance.dart'
    as card_balance_screen_dart;
import '../../../stac/tobank/flows/dashboard/dart/card_management/add_card/add_new_card.dart'
    as add_new_card_screen_dart;
import '../../../stac/tobank/flows/gift_card/menu/gift_card_menu.dart'
    as gift_card_menu_dart;
import '../../../stac/tobank/flows/transfer/menu/transfer_menu.dart'
    as transfer_menu_dart;
import '../../../stac/tobank/flows/transfer/dart/transfer_amount.dart'
    as transfer_amount_dart;
import '../../../stac/tobank/flows/transfer/dart/transfer_details.dart'
    as transfer_details_dart;
import '../../../stac/tobank/flows/transfer/dart/transfer_confirm.dart'
    as transfer_confirm_dart;
import '../../../stac/tobank/flows/transfer/dart/transfer_result.dart'
    as transfer_result_dart;
import '../../../stac/tobank/flows/transfer/dart/transfer_card_result.dart'
    as transfer_card_result_dart;
import '../../../stac/tobank/flows/transfer/dart/transfer_in_bank_details.dart'
    as transfer_in_bank_details_dart;
import '../../../stac/tobank/flows/transfer/dart/transfer_in_bank_confirm.dart'
    as transfer_in_bank_confirm_dart;
import '../../../stac/tobank/flows/transfer/dart/transfer_in_bank_result.dart'
    as transfer_in_bank_result_dart;
import '../../../stac/tobank/flows/transfer/dart/transfer_card_details.dart'
    as transfer_card_details_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_intro.dart'
    as gift_card_intro_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_select_amount.dart'
    as gift_card_select_amount_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_design_selector.dart'
    as gift_card_design_selector_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_custom_design_selector.dart'
    as gift_card_custom_design_selector_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_image_selector.dart'
    as gift_card_image_selector_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_custom_select_design.dart'
    as gift_card_custom_select_design_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_custom_message.dart'
    as gift_card_custom_message_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_select_design.dart'
    as gift_card_select_design_dart;
import '../../../stac/tobank/flows/charge/menu/charge_menu.dart'
    as charge_menu_dart;
import '../../../stac/tobank/flows/charge/dart/charge_intro.dart'
    as charge_intro_dart;
import '../../../stac/tobank/flows/charge/dart/charge_add_sim.dart'
    as charge_add_sim_dart;
import '../../../stac/tobank/flows/charge/dart/charge_package_list.dart'
    as charge_package_list_dart;
import '../../../stac/tobank/flows/charge/dart/charge_payment.dart'
    as charge_payment_dart;
import '../../../stac/tobank/flows/charge/dart/charge_payment_success.dart'
    as charge_payment_success_dart;
import '../../../stac/tobank/flows/internet_pakage/menu/internet_pakage_menu.dart'
    as internet_pakage_menu_dart;
import '../../../stac/tobank/flows/internet_pakage/dart/internet_pakage_intro.dart'
    as internet_pakage_intro_dart;
import '../../../stac/tobank/flows/internet_pakage/dart/internet_pakage_add_sim.dart'
    as internet_pakage_add_sim_dart;
import '../../../stac/tobank/flows/internet_pakage/dart/internet_pakage_list.dart'
    as internet_pakage_list_dart;
import '../../../stac/tobank/flows/internet_pakage/dart/internet_pakage_payment.dart'
    as internet_pakage_payment_dart;
import '../../../stac/tobank/flows/internet_pakage/dart/internet_pakage_payment_success.dart'
    as internet_pakage_payment_success_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_message.dart'
    as gift_card_message_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_receiver_info.dart'
    as gift_card_receiver_info_dart;
import '../../../stac/tobank/flows/gift_card/dart/gift_card_confirm.dart'
    as gift_card_confirm_dart;
import '../../../stac/tobank/flows/profile/dart/profile_customer_referrals.dart'
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
    'user_credit_validation_receipt': () =>
        user_credit_validation_receipt_dart.userCreditValidationReceipt().toJson(),
    'user_credit_validation_preview': () =>
        user_credit_validation_preview_dart.userCreditValidationPreview().toJson(),
    'user_credit_validation_report_detail': () => user_credit_validation_report_detail_dart
        .userCreditValidationReportDetail()
        .toJson(),
    'tobank_user_credit_validation': () =>
        user_credit_validation_menu_dart.userCreditValidationMenu().toJson(),
    'tobank_menu_dart': () => tobank_menu_dart.tobankMenuDart().toJson(),
    'tobank_home_page_dart': () => home_page_dart.tobankHomePageDart().toJson(),
    'tobank_special_services_page': () =>
        tobank_special_services_page_dart.tobankSpecialServicesPage().toJson(),
    'tobank_travel_services_page': () =>
        travel_services_page_dart.tobankTravelServicesPage().toJson(),
    'tobank_acceptor_services_page': () =>
        acceptor_services_page_dart.tobankAcceptorServicesPage().toJson(),
    'tobank_onboarding': () => login_onboarding_dart.loginOnboarding().toJson(),



    // Promissory Real (Real API) - fetches SDUI from real backend
    'promissory_menu': () =>
        promissory_debug_dart.promissoryRealDebugMenu().toJson(),
    'guarantee_promissory_api_real_menu': () =>
        guarantee_promissory_api_real_menu_dart
            .guaranteePromissoryApiRealMenu()
            .toJson(),
    'promissory_guarantee_info_page': () => promissory_guarantee_info_page_dart
        .promissoryGuaranteeInfoPage()
        .toJson(),
    'promissory_guarantee_confirm_page': () =>
        promissory_guarantee_confirm_page_dart
            .promissoryGuaranteeConfirmPage()
            .toJson(),
    'promissory_guarantee_sign_page': () => promissory_guarantee_sign_page_dart
        .promissoryGuaranteeSignPage()
        .toJson(),
    'promissory_guarantee_final_page': () =>
        promissory_guarantee_final_page_dart
            .promissoryGuaranteeFinalPage()
            .toJson(),
    'promissory_guarantee_preview_page': () =>
        promissory_guarantee_preview_page_dart
            .promissoryGuaranteePreviewPage()
            .toJson(),
    'authentication_menu': () =>
        authentication_menu_dart.authenticationRealMenu().toJson(),
    'profile_menu': () => profile_menu_dart.profileRealMenu().toJson(),
    'profile_intro': () => profile_intro_dart.profileRealIntro().toJson(),
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
    'profile_rules': () => profile_rules_dart.profileRealRules().toJson(),
    'profile_about': () => profile_about_dart.profileRealAbout().toJson(),
    'profile_contact': () => profile_contact_dart.profileRealContact().toJson(),
    'profile_customer_referrals': () =>
        profile_customer_referrals_dart.profileRealCustomerReferrals().toJson(),
    'cartable_menu': () => cartable_menu_dart.cartableRealMenu().toJson(),
    'cartable_intro': () => cartable_intro_dart.cartableRealIntro().toJson(),
    'cartable_detail': () => cartable_detail_dart.cartableRealDetail().toJson(),
    'transaction_menu': () =>
        transaction_menu_dart.transactionRealMenu().toJson(),
    'installment_payment_api_real_menu': () =>
        installment_payment_api_real_menu_dart
            .installmentPaymentApiRealMenu()
            .toJson(),
    'child_loan_api_real_menu': () =>
        child_loan_menu_dart.childLoanApiRealMenu().toJson(),
    'child_loan_rules': () =>
        child_loan_rules_dart.childLoanRulesScreen().toJson(),
    'child_loan_customer_check': () =>
        child_loan_customer_check_dart.childLoanCustomerCheckScreen().toJson(),
    'child_loan_task_list': () =>
        child_loan_task_list_dart.childLoanTaskListScreen().toJson(),
    'child_loan_customer_document': () => child_loan_customer_document_dart
        .childLoanCustomerDocumentScreen()
        .toJson(),
    'child_loan_guarantee_address': () => child_loan_guarantee_address_dart
        .childLoanGuaranteeAddressScreen()
        .toJson(),
    'child_loan_child_check': () =>
        child_loan_child_check_dart.childLoanChildCheckScreen().toJson(),
    'installment_payment_list_main': () => installment_payment_list_main_dart
        .installmentPaymentListMain()
        .toJson(),
    'installment_payment_detail_main': () =>
        installment_payment_detail_main_dart
            .installmentPaymentDetailMain()
            .toJson(),
    'transaction_intro': () =>
        transaction_intro_dart.transactionRealIntro().toJson(),
    'transaction_filter': () =>
        transaction_filter_dart.transactionRealFilter().toJson(),
    'notification_menu': () =>
        notification_menu_dart.notificationRealMenu().toJson(),
    'notification_intro': () =>
        notification_intro_dart.notificationRealIntro().toJson(),
    'deposit_turnover_menu': () =>
        deposit_turnover_menu_dart.depositTurnoverRealMenu().toJson(),
    'deposit_turnover_intro': () =>
        deposit_turnover_intro_dart.depositTurnoverIntro().toJson(),
    'deposit_turnover_transactions': () => deposit_turnover_transactions_dart
        .depositTurnoverTransactions()
        .toJson(),
    'deposit_more_options_menu': () =>
        deposit_more_options_menu_dart.depositMoreOptionsMenu().toJson(),
    'deposit_more_options_intro': () =>
        deposit_more_options_intro_dart.depositMoreOptionsIntro().toJson(),
    'deposit_card_issue_address': () =>
        deposit_card_issue_address_dart.depositCardIssueAddress().toJson(),
    'deposit_card_issue_template': () =>
        deposit_card_issue_template_dart.depositCardIssueTemplate().toJson(),
    'deposit_card_issue_result': () =>
        deposit_card_issue_result_dart.depositCardIssueResult().toJson(),
    'deposit_close_confirm': () =>
        deposit_close_confirm_dart.depositCloseConfirm().toJson(),
    'deposit_close_selector': () =>
        deposit_close_selector_dart.depositCloseSelector().toJson(),
    'deposit_close_result': () =>
        deposit_close_result_dart.depositCloseResult().toJson(),
    'dashboard_menu': () => dashboard_menu_dart.dashboardRealMenu().toJson(),
    'biometric_test_menu': () =>
        biometric_test_menu_dart.biometricTestMenu().toJson(),
    'dashboard_shell': () => dashboard_shell_dart.dashboardShell().toJson(),
    'dashboard_cards_management': () =>
        cards_management_screen_dart.dashboardCardsManagement().toJson(),
    'dashboard_card_edit': () =>
        card_edit_screen_dart.dashboardCardEdit().toJson(),
    'dashboard_wallet_transfer_receipt': () =>
        wallet_transfer_receipt_dart.dashboardWalletTransferReceipt().toJson(),
    'dashboard_primary_pin_get': () =>
        primary_pin_get_dart.dashboardPrimaryPinGet().toJson(),
    'dashboard_primary_pin_change': () =>
        primary_pin_change_dart.dashboardPrimaryPinChange().toJson(),
    'dashboard_primary_pin_result': () =>
        primary_pin_result_dart.dashboardPrimaryPinResult().toJson(),
    'dashboard_secondary_pin_get': () =>
        secondary_pin_get_dart.dashboardSecondaryPinGet().toJson(),
    'dashboard_secondary_pin_change': () =>
        secondary_pin_change_dart.dashboardSecondaryPinChange().toJson(),
    'dashboard_secondary_pin_result': () =>
        secondary_pin_receipt_dart.dashboardSecondaryPinResult().toJson(),
    'dashboard_card_reissue_request': () =>
        reissue_request_dart.dashboardCardReissueRequest().toJson(),
    'dashboard_card_reissue_select_card_color': () =>
        reissue_select_card_color_dart
            .dashboardCardReissueSelectCardColor()
            .toJson(),
    'dashboard_card_reissue_receipt': () =>
        reissue_receipt_dart.dashboardCardReissueReceipt().toJson(),
    'dashboard_card_balance': () =>
        card_balance_screen_dart.dashboardCardBalance().toJson(),
    'dashboard_add_new_card': () =>
        add_new_card_screen_dart.dashboardAddNewCard().toJson(),
    'gift_card_menu': () => gift_card_menu_dart.giftCardRealMenu().toJson(),
    'transfer_menu': () => transfer_menu_dart.transferRealMenu().toJson(),
    'transfer_amount': () => transfer_amount_dart.transferRealAmount().toJson(),
    'transfer_details': () =>
        transfer_details_dart.transferRealDetails().toJson(),
    'transfer_confirm': () =>
        transfer_confirm_dart.transferRealConfirm().toJson(),
    'transfer_result': () => transfer_result_dart.transferRealResult().toJson(),
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
    'gift_card_intro': () => gift_card_intro_dart.giftCardRealIntro().toJson(),
    'gift_card_select_amount': () =>
        gift_card_select_amount_dart.giftCardRealSelectAmount().toJson(),
    'gift_card_design_selector': () =>
        gift_card_design_selector_dart.giftCardRealDesignSelector().toJson(),
    'gift_card_custom_design_selector': () =>
        gift_card_custom_design_selector_dart
            .giftCardRealCustomDesignSelector()
            .toJson(),
    'gift_card_image_selector': () =>
        gift_card_image_selector_dart.giftCardRealImageSelector().toJson(),
    'gift_card_custom_select_design': () => gift_card_custom_select_design_dart
        .giftCardRealCustomSelectDesign()
        .toJson(),
    'gift_card_custom_message': () =>
        gift_card_custom_message_dart.giftCardRealCustomMessage().toJson(),
    'gift_card_select_design': () =>
        gift_card_select_design_dart.giftCardRealSelectDesign().toJson(),
    'charge_menu': () => charge_menu_dart.chargeRealMenu().toJson(),
    'charge_intro': () => charge_intro_dart.chargeRealIntro().toJson(),
    'charge_add_sim': () => charge_add_sim_dart.chargeRealAddSim().toJson(),
    'charge_internet_pakage_list': () =>
        charge_package_list_dart.chargeRealPackageList().toJson(),
    'charge_payment': () => charge_payment_dart.chargeRealPayment().toJson(),
    'charge_payment_success': () =>
        charge_payment_success_dart.chargeRealPaymentSuccess().toJson(),
    'internet_pakage_menu': () => internet_pakage_menu_dart.packageRealMenu().toJson(),
    'internet_pakage_intro': () => internet_pakage_intro_dart.packageRealIntro().toJson(),
    'internet_pakage_add_sim': () => internet_pakage_add_sim_dart.packageRealAddSim().toJson(),
    'internet_pakage_list': () => internet_pakage_list_dart.packageRealInternetPakageList().toJson(),
    'internet_pakage_payment': () => internet_pakage_payment_dart.packageRealPayment().toJson(),
    'internet_pakage_payment_success': () =>
        internet_pakage_payment_success_dart.packageRealPaymentSuccess().toJson(),
    'gift_card_message': () =>
        gift_card_message_dart.giftCardRealMessage().toJson(),
    'gift_card_receiver_info': () =>
        gift_card_receiver_info_dart.giftCardRealReceiverInfo().toJson(),
    'gift_card_confirm': () =>
        gift_card_confirm_dart.giftCardRealConfirm().toJson(),
    'authentication_intro': () =>
        authentication_intro_dart.authenticationRealIntro().toJson(),
    'authentication_preregister': () => authentication_preregister_dart
        .authenticationRealPreRegister()
        .toJson(),
    'authentication_verify_otp': () =>
        authentication_verify_otp_dart.authenticationRealVerifyOtp().toJson(),
    'authentication_national_card_front': () =>
        authentication_national_card_front_dart
            .authenticationRealNationalCardFront()
            .toJson(),
    'authentication_national_card_back': () =>
        authentication_national_card_back_dart
            .authenticationRealNationalCardBack()
            .toJson(),
    'authentication_old_national_card': () =>
        authentication_old_national_card_dart
            .authenticationRealOldNationalCard()
            .toJson(),
    'authentication_selfie': () =>
        authentication_selfie_dart.authenticationRealSelfie().toJson(),
    'authentication_postal_code': () => authentication_postal_code_dart
        .authenticationRealPostalCode()
        .toJson(),
    'authentication_rules': () =>
        authentication_rules_dart.authenticationRealRules().toJson(),
    'authentication_signature': () =>
        authentication_signature_dart.authenticationRealSignature().toJson(),
    'authentication_certificate_generator': () =>
        authentication_certificate_generator_dart
            .authenticationRealCertificateGenerator()
            .toJson(),
    'authentication_signature_guide': () =>
        authentication_signature_guide_dart
            .authenticationRealSignatureGuide()
            .toJson(),
    'authentication_signature_visual_guide': () =>
        authentication_signature_visual_guide_dart
            .authenticationRealSignatureVisualGuide()
            .toJson(),
    'authentication_final': () =>
        authentication_final_dart.authenticationRealFinal().toJson(),
    'authentication_registration': () => authentication_registration_dart
        .authenticationRealRegistration()
        .toJson(),
    'authentication_job_selector': () => authentication_job_selector_dart
        .authenticationRealJobSelector()
        .toJson(),
    'test': () => test_screen_dart.testScreen().toJson(),
    'promissory_loader': () => {'type': 'promissory_loader'},
    'authentication_loader': () => {'type': 'authentication_loader'},
    'promissory_intro': () => promissory_dart.promissoryRealIntro().toJson(),
    'login_form_dart': () => login_screen_dart.loginForm().toJson(),
    'promissory_rules': () =>
        promissory_real_rules_dart.promissoryRealRules().toJson(),
    'promissory_issuer': () =>
        promissory_issuer_dart.promissoryRealIssuer().toJson(),
    'promissory_receiver': () =>
        promissory_receiver_dart.promissoryRealReceiver().toJson(),
    'promissory_data': () => promissory_data_dart.promissoryRealData().toJson(),
    'promissory_confirm': () =>
        promissory_confirm_dart.promissoryRealConfirm().toJson(),
    'promissory_payment': () =>
        promissory_payment_dart.promissoryRealPayment().toJson(),
    'promissory_payment_deposits': () => promissory_payment_deposits_dart
        .promissoryRealPaymentDeposits()
        .toJson(),
    'promissory_sign': () => promissory_sign_dart.promissoryRealSign().toJson(),
    'promissory_success': () =>
        promissory_success_dart.promissoryRealSuccess().toJson(),
    'promissory_preview': () =>
        promissory_preview_dart.promissoryRealPreview().toJson(),
    'login_onboarding': () => login_onboarding_dart.loginOnboarding().toJson(),
    'login_splash': () => login_splash_dart.loginSplash().toJson(),
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
