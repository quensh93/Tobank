import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('fa')];

  /// No description provided for @customer_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره مشتری'**
  String get customer_number;

  /// No description provided for @setting_manage_destinations.
  ///
  /// In fa, this message translates to:
  /// **'مدیریت مقصدها'**
  String get setting_manage_destinations;

  /// No description provided for @invite_friends.
  ///
  /// In fa, this message translates to:
  /// **'دعوت از دوستان'**
  String get invite_friends;

  /// No description provided for @bank_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات بانکی'**
  String get bank_information;

  /// No description provided for @setting.
  ///
  /// In fa, this message translates to:
  /// **'تنظیمات'**
  String get setting;

  /// No description provided for @rules_and_regulations.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات'**
  String get rules_and_regulations;

  /// No description provided for @about_us.
  ///
  /// In fa, this message translates to:
  /// **'درباره ما'**
  String get about_us;

  /// No description provided for @contact_us.
  ///
  /// In fa, this message translates to:
  /// **'تماس با ما'**
  String get contact_us;

  /// No description provided for @app_version.
  ///
  /// In fa, this message translates to:
  /// **'نسخه برنامه: {version}'**
  String app_version(String version);

  /// No description provided for @address_registered_in_the_bank.
  ///
  /// In fa, this message translates to:
  /// **'آدرس ثبت‌شده در بانک'**
  String get address_registered_in_the_bank;

  /// No description provided for @edit_address_registered_in_the_bank.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش آدرس ثبت‌شده در بانک'**
  String get edit_address_registered_in_the_bank;

  /// No description provided for @edit_address.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش آدرس'**
  String get edit_address;

  /// No description provided for @address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس'**
  String get address;

  /// No description provided for @postal_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی'**
  String get postal_code;

  /// No description provided for @edit.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش'**
  String get edit;

  /// No description provided for @copy_invitation_code_or_share_with_friends.
  ///
  /// In fa, this message translates to:
  /// **'کد دعوت را کپی کنید و یا با دوستانتان به اشتراک بگذارید '**
  String get copy_invitation_code_or_share_with_friends;

  /// No description provided for @postal_code_and_address.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کد پستی و آدرس را وارد کنید'**
  String get postal_code_and_address;

  /// No description provided for @sharing_invitation_code.
  ///
  /// In fa, this message translates to:
  /// **'اشتراک‌گذاری کد دعوت'**
  String get sharing_invitation_code;

  /// No description provided for @invited_list.
  ///
  /// In fa, this message translates to:
  /// **'لیست دعوت‌شدگان'**
  String get invited_list;

  /// No description provided for @no_items_found.
  ///
  /// In fa, this message translates to:
  /// **'موردی یافت نشد'**
  String get no_items_found;

  /// No description provided for @card.
  ///
  /// In fa, this message translates to:
  /// **'کارت'**
  String get card;

  /// No description provided for @deposit.
  ///
  /// In fa, this message translates to:
  /// **'سپرده'**
  String get deposit;

  /// No description provided for @shaba.
  ///
  /// In fa, this message translates to:
  /// **'شبا'**
  String get shaba;

  /// No description provided for @shaba_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره شبا'**
  String get shaba_number;

  /// No description provided for @add_destination_card.
  ///
  /// In fa, this message translates to:
  /// **'افزودن کارت مقصد'**
  String get add_destination_card;

  /// No description provided for @edit_card.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش کارت'**
  String get edit_card;

  /// No description provided for @delete_card.
  ///
  /// In fa, this message translates to:
  /// **'حذف کارت'**
  String get delete_card;

  /// No description provided for @support.
  ///
  /// In fa, this message translates to:
  /// **'پشتیبانی'**
  String get support;

  /// No description provided for @enter_your_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی محل سکونت را وارد کنید'**
  String get enter_your_postal_code;

  /// No description provided for @inquiry.
  ///
  /// In fa, this message translates to:
  /// **'استعلام'**
  String get inquiry;

  /// No description provided for @fingerprint_activation.
  ///
  /// In fa, this message translates to:
  /// **'فعال‌سازی اثر انگشت'**
  String get fingerprint_activation;

  /// No description provided for @face_id_activate.
  ///
  /// In fa, this message translates to:
  /// **'فعال سازی تشخیص چهره'**
  String get face_id_activate;

  /// No description provided for @app_appearance.
  ///
  /// In fa, this message translates to:
  /// **'ظاهر برنامه'**
  String get app_appearance;

  /// No description provided for @select_app_appearance.
  ///
  /// In fa, this message translates to:
  /// **'ظاهر برنامه را انتخاب کنید'**
  String get select_app_appearance;

  /// No description provided for @night_mode.
  ///
  /// In fa, this message translates to:
  /// **'حالت شب'**
  String get night_mode;

  /// No description provided for @day_mode.
  ///
  /// In fa, this message translates to:
  /// **'حالت روز'**
  String get day_mode;

  /// No description provided for @system_default_mode.
  ///
  /// In fa, this message translates to:
  /// **'پیش‌فرض سیستم‌عامل'**
  String get system_default_mode;

  /// No description provided for @change_password.
  ///
  /// In fa, this message translates to:
  /// **'تغییر رمز عبور'**
  String get change_password;

  /// No description provided for @current_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور فعلی'**
  String get current_password;

  /// No description provided for @new_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور جدید'**
  String get new_password;

  /// No description provided for @repeat_new_password.
  ///
  /// In fa, this message translates to:
  /// **'تکرار رمز عبور جدید'**
  String get repeat_new_password;

  /// No description provided for @enter_current_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور فعلی را وارد کنید'**
  String get enter_current_password;

  /// No description provided for @enter_new_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور جدید را وارد کنید'**
  String get enter_new_password;

  /// No description provided for @re_enter_new_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور جدید را دوباره وارد کنید'**
  String get re_enter_new_password;

  /// No description provided for @incorrect_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور صحیح نیست'**
  String get incorrect_password;

  /// No description provided for @password_length_5char.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور حداقل 5 کاراکتر می‌باشد'**
  String get password_length_5char;

  /// No description provided for @password_not_match.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور مطابقت ندارد'**
  String get password_not_match;

  /// No description provided for @confirm_and_save.
  ///
  /// In fa, this message translates to:
  /// **'تایید و ذخیره'**
  String get confirm_and_save;

  /// No description provided for @delete_account_information.
  ///
  /// In fa, this message translates to:
  /// **'حذف اطلاعات حساب کاربری'**
  String get delete_account_information;

  /// No description provided for @virtual_branch_with_you.
  ///
  /// In fa, this message translates to:
  /// **'یک شعبه مجازی همراه شماست!'**
  String get virtual_branch_with_you;

  /// No description provided for @gardesh_pay.
  ///
  /// In fa, this message translates to:
  /// **'گردش‌پی'**
  String get gardesh_pay;

  /// No description provided for @close.
  ///
  /// In fa, this message translates to:
  /// **'بستن'**
  String get close;

  /// No description provided for @save.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In fa, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @sms_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پیامک شده'**
  String get sms_code;

  /// No description provided for @receive_verification_code_again.
  ///
  /// In fa, this message translates to:
  /// **'دریافت مجدد کد تایید'**
  String get receive_verification_code_again;

  /// No description provided for @automatic_dynamic_password_activation.
  ///
  /// In fa, this message translates to:
  /// **'فعالسازی رمز پویا خودکار'**
  String get automatic_dynamic_password_activation;

  /// No description provided for @mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره موبایل'**
  String get mobile_number;

  /// No description provided for @enter_your_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره همراه خود را وارد نمایید'**
  String get enter_your_mobile_number;

  /// No description provided for @enter_valid_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'یک شماره همراه معتبر وارد نمایید'**
  String get enter_valid_mobile_number;

  /// No description provided for @receive_verification_code.
  ///
  /// In fa, this message translates to:
  /// **'دریافت کد تایید'**
  String get receive_verification_code;

  /// No description provided for @enter_correct_postal_code_value.
  ///
  /// In fa, this message translates to:
  /// **'مقدار صحیح کد پستی را وارد کنید'**
  String get enter_correct_postal_code_value;

  /// No description provided for @enter_postal_code_value.
  ///
  /// In fa, this message translates to:
  /// **'مقدار کد پستی را وارد کنید'**
  String get enter_postal_code_value;

  /// No description provided for @enter_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی را وارد کنید'**
  String get enter_postal_code;

  /// No description provided for @central_branch_1.
  ///
  /// In fa, this message translates to:
  /// **'شعبه مرکزی ۱ (۱۲۳۲۲)'**
  String get central_branch_1;

  /// No description provided for @sharing.
  ///
  /// In fa, this message translates to:
  /// **'اشتراک‌گذاری'**
  String get sharing;

  /// No description provided for @landline_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن ثابت'**
  String get landline_number;

  /// No description provided for @enter_landline_number_with_city_code.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن ثابت خود با کد شهر را وارد کنید'**
  String get enter_landline_number_with_city_code;

  /// No description provided for @routing.
  ///
  /// In fa, this message translates to:
  /// **'مسیریابی'**
  String get routing;

  /// No description provided for @branch.
  ///
  /// In fa, this message translates to:
  /// **'شعبه'**
  String get branch;

  /// No description provided for @bank_branches.
  ///
  /// In fa, this message translates to:
  /// **'شعبه‌های بانک'**
  String get bank_branches;

  /// No description provided for @search_by_name_and_branch_code.
  ///
  /// In fa, this message translates to:
  /// **'جستجو بر اساس نام، کد شعبه'**
  String get search_by_name_and_branch_code;

  /// No description provided for @covered_origin_banks_to_banks_in_country.
  ///
  /// In fa, this message translates to:
  /// **'بانک‌های مبدا تحت پوشش به مقصد کلیه بانک‌های کشور'**
  String get covered_origin_banks_to_banks_in_country;

  /// No description provided for @enter_your_card_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره کارت خود را وارد نمایید'**
  String get enter_your_card_number;

  /// No description provided for @enter_card_number.
  ///
  /// In fa, this message translates to:
  /// **'یک شماره کارت معتبر وارد نمایید'**
  String get enter_card_number;

  /// No description provided for @card_expiration_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ انقضا کارت'**
  String get card_expiration_date;

  /// No description provided for @expiration_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ انقضا'**
  String get expiration_date;

  /// No description provided for @invalid_value.
  ///
  /// In fa, this message translates to:
  /// **'مقدار نامعتبر'**
  String get invalid_value;

  /// No description provided for @cvv2_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز CVV2 را وارد کنید'**
  String get cvv2_password;

  /// No description provided for @verify_card_be_card_info.
  ///
  /// In fa, this message translates to:
  /// **'تایید اطلاعات کارت به کارت'**
  String get verify_card_be_card_info;

  /// No description provided for @enter_cvv2_password.
  ///
  /// In fa, this message translates to:
  /// **'مقدار cvv2 را وارد نمایید'**
  String get enter_cvv2_password;

  /// No description provided for @enter_cvv2.
  ///
  /// In fa, this message translates to:
  /// **'CVV2 را وارد نمایید'**
  String get enter_cvv2;

  /// No description provided for @dynamic_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز پویا'**
  String get dynamic_password;

  /// No description provided for @enter_validate_password.
  ///
  /// In fa, this message translates to:
  /// **'یک رمز معتبر وارد نمایید'**
  String get enter_validate_password;

  /// No description provided for @enter_dynamic_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز پویا را وارد نمایید'**
  String get enter_dynamic_password;

  /// No description provided for @scan_card.
  ///
  /// In fa, this message translates to:
  /// **'اسکن کارت'**
  String get scan_card;

  /// No description provided for @save_card.
  ///
  /// In fa, this message translates to:
  /// **'ثبت کارت'**
  String get save_card;

  /// No description provided for @cancel_laghv.
  ///
  /// In fa, this message translates to:
  /// **'لغو'**
  String get cancel_laghv;

  /// No description provided for @sure_settlement_promissory.
  ///
  /// In fa, this message translates to:
  /// **'از تسویه سفته مطمئن هستید؟'**
  String get sure_settlement_promissory;

  /// No description provided for @confirmation.
  ///
  /// In fa, this message translates to:
  /// **'تایید'**
  String get confirmation;

  /// No description provided for @card_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره کارت'**
  String get card_number;

  /// No description provided for @enter_name.
  ///
  /// In fa, this message translates to:
  /// **'نام را وارد کنید'**
  String get enter_name;

  /// No description provided for @transaction_receipt.
  ///
  /// In fa, this message translates to:
  /// **'رسید تراکنش'**
  String get transaction_receipt;

  /// No description provided for @transaction_receipt_file_name.
  ///
  /// In fa, this message translates to:
  /// **'رسید_تراکنش'**
  String get transaction_receipt_file_name;

  /// No description provided for @transaction_info_not_found.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات تراکنش یافت نشد'**
  String get transaction_info_not_found;

  /// No description provided for @payment_gateway_address_not_found.
  ///
  /// In fa, this message translates to:
  /// **'آدرس درگاه پرداخت یافت نشد'**
  String get payment_gateway_address_not_found;

  /// No description provided for @destination_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت مقصد'**
  String get destination_card;

  /// No description provided for @month.
  ///
  /// In fa, this message translates to:
  /// **'ماه'**
  String get month;

  /// No description provided for @do_copy.
  ///
  /// In fa, this message translates to:
  /// **'کپی کردن'**
  String get do_copy;

  /// No description provided for @year.
  ///
  /// In fa, this message translates to:
  /// **'سال'**
  String get year;

  /// No description provided for @payment_error.
  ///
  /// In fa, this message translates to:
  /// **'خطا در پرداخت'**
  String get payment_error;

  /// No description provided for @try_again2.
  ///
  /// In fa, this message translates to:
  /// **'مجدد تلاش کنید'**
  String get try_again2;

  /// No description provided for @cvv2.
  ///
  /// In fa, this message translates to:
  /// **'CVV2'**
  String get cvv2;

  /// No description provided for @deposit_number_for_deposit.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده جهت واریز'**
  String get deposit_number_for_deposit;

  /// No description provided for @card_title.
  ///
  /// In fa, this message translates to:
  /// **'عنوان کارت'**
  String get card_title;

  /// No description provided for @enter_card_title.
  ///
  /// In fa, this message translates to:
  /// **'عنوان کارت را وارد کنید'**
  String get enter_card_title;

  /// No description provided for @save_changes.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره تغییرات'**
  String get save_changes;

  /// No description provided for @add_new_card.
  ///
  /// In fa, this message translates to:
  /// **'افزودن کارت جدید'**
  String get add_new_card;

  /// No description provided for @amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ'**
  String get amount;

  /// No description provided for @fee.
  ///
  /// In fa, this message translates to:
  /// **'۱۴۴۰ ریال'**
  String get fee;

  /// No description provided for @fee_deducted_from_account.
  ///
  /// In fa, this message translates to:
  /// **' بابت کارمزد از حساب شما کسر خواهد شد'**
  String get fee_deducted_from_account;

  /// No description provided for @receive_inventory.
  ///
  /// In fa, this message translates to:
  /// **'دریافت موجودی'**
  String get receive_inventory;

  /// No description provided for @deposit_inventory.
  ///
  /// In fa, this message translates to:
  /// **'موجودی سپرده'**
  String get deposit_inventory;

  /// No description provided for @deposit_account_message.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده مقصد خود را برای واریز وجه جهت واریز اصل و سود انتخاب نمایید'**
  String get deposit_account_message;

  /// No description provided for @regard_or_about_or_paid_for.
  ///
  /// In fa, this message translates to:
  /// **'بابت'**
  String get regard_or_about_or_paid_for;

  /// No description provided for @operation_done_successful.
  ///
  /// In fa, this message translates to:
  /// **'عملیات با موفقیت انجام شد'**
  String get operation_done_successful;

  /// No description provided for @balance_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ موجودی'**
  String get balance_amount;

  /// No description provided for @final_confirmation_and_transfer.
  ///
  /// In fa, this message translates to:
  /// **'تایید نهایی و انتقال وجه'**
  String get final_confirmation_and_transfer;

  /// No description provided for @rial.
  ///
  /// In fa, this message translates to:
  /// **'ریال'**
  String get rial;

  /// No description provided for @transaction_time.
  ///
  /// In fa, this message translates to:
  /// **'زمان تراکنش'**
  String get transaction_time;

  /// No description provided for @inventory_sharing.
  ///
  /// In fa, this message translates to:
  /// **'اشتراک‌گذاری موجودی'**
  String get inventory_sharing;

  /// No description provided for @mandatory_to_comply.
  ///
  /// In fa, this message translates to:
  /// **'رعایت این موارد الزامیست...'**
  String get mandatory_to_comply;

  /// No description provided for @card_password_4digit.
  ///
  /// In fa, this message translates to:
  /// **'رمز اول کارت باید ۴ رقم باشد'**
  String get card_password_4digit;

  /// No description provided for @dont_use_1111_1234_password.
  ///
  /// In fa, this message translates to:
  /// **'از انتخاب رمز ساده نظیر ۱۱۱۱ یا ۱۲۳۴ خودداری کنید'**
  String get dont_use_1111_1234_password;

  /// No description provided for @enter_valid_value_for_current_password.
  ///
  /// In fa, this message translates to:
  /// **'مقدار معتبری برای رمز فعلی وارد کنید'**
  String get enter_valid_value_for_current_password;

  /// No description provided for @new_pass_word.
  ///
  /// In fa, this message translates to:
  /// **'رمز جدید'**
  String get new_pass_word;

  /// No description provided for @card_first_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز اول کارت'**
  String get card_first_password;

  /// No description provided for @enter_new_pass_word.
  ///
  /// In fa, this message translates to:
  /// **'رمز جدید را وارد کنید'**
  String get enter_new_pass_word;

  /// No description provided for @enter_valid_value_for_new_pass_word.
  ///
  /// In fa, this message translates to:
  /// **'مقدار معتبری برای رمز جدید وارد کنید'**
  String get enter_valid_value_for_new_pass_word;

  /// No description provided for @enter_valid_value_for_repeated_new_pass_word.
  ///
  /// In fa, this message translates to:
  /// **'مقدار معتبری برای تکرار رمز وارد کنید'**
  String get enter_valid_value_for_repeated_new_pass_word;

  /// No description provided for @do_repeat_new_pass_word.
  ///
  /// In fa, this message translates to:
  /// **'رمز جدید را تکرار کنید'**
  String get do_repeat_new_pass_word;

  /// No description provided for @repeat_new_pass_word.
  ///
  /// In fa, this message translates to:
  /// **'تکرار رمز جدید'**
  String get repeat_new_pass_word;

  /// No description provided for @change_first_pass_word.
  ///
  /// In fa, this message translates to:
  /// **'تغییر رمز اول'**
  String get change_first_pass_word;

  /// No description provided for @change_second_pass_word.
  ///
  /// In fa, this message translates to:
  /// **'تغییر رمز دوم'**
  String get change_second_pass_word;

  /// No description provided for @second_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز دوم'**
  String get second_password;

  /// No description provided for @first_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز اول'**
  String get first_password;

  /// No description provided for @successful_request.
  ///
  /// In fa, this message translates to:
  /// **'درخواست موفق'**
  String get successful_request;

  /// No description provided for @card_first_password_changed_successfully.
  ///
  /// In fa, this message translates to:
  /// **'رمز اول کارت با موفقیت تغییر یافت'**
  String get card_first_password_changed_successfully;

  /// No description provided for @card_first_password_issued_successfully.
  ///
  /// In fa, this message translates to:
  /// **'رمز اول کارت با موفقیت صادر گردید!'**
  String get card_first_password_issued_successfully;

  /// No description provided for @card_request_submitted.
  ///
  /// In fa, this message translates to:
  /// **'درخواست صدور کارت شما ثبت شد!'**
  String get card_request_submitted;

  /// No description provided for @return_to_deposit_services.
  ///
  /// In fa, this message translates to:
  /// **'بازگشت به خدمات سپرده'**
  String get return_to_deposit_services;

  /// No description provided for @return_to_services.
  ///
  /// In fa, this message translates to:
  /// **'بازگشت به خدمات'**
  String get return_to_services;

  /// No description provided for @card_second_password_changed.
  ///
  /// In fa, this message translates to:
  /// **'رمز دوم کارت تغییر یافت'**
  String get card_second_password_changed;

  /// No description provided for @first_selected_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز اول انتخابی'**
  String get first_selected_password;

  /// No description provided for @return_to_card_services_list.
  ///
  /// In fa, this message translates to:
  /// **'بازگشت به لیست خدمات کارت'**
  String get return_to_card_services_list;

  /// No description provided for @confirm_receive_first_password.
  ///
  /// In fa, this message translates to:
  /// **'تایید و دریافت رمز اول'**
  String get confirm_receive_first_password;

  /// No description provided for @applicant_address_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات آدرس متقاضی'**
  String get applicant_address_information;

  /// No description provided for @location_information.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا اطلاعات محل سکونت خود را وارد نمایید.'**
  String get location_information;

  /// No description provided for @applicant_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی محل سکونت متقاضی'**
  String get applicant_postal_code;

  /// No description provided for @inquire_about_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کدپستی خود را استعلام نمایید'**
  String get inquire_about_postal_code;

  /// No description provided for @county.
  ///
  /// In fa, this message translates to:
  /// **'شهرستان'**
  String get county;

  /// No description provided for @card_request_registered.
  ///
  /// In fa, this message translates to:
  /// **'درخواست صدور کارت ثبت شد!'**
  String get card_request_registered;

  /// No description provided for @card_request.
  ///
  /// In fa, this message translates to:
  /// **'درخواست صدور کارت'**
  String get card_request;

  /// No description provided for @enter_postal_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کدپستی را وارد نمایید'**
  String get enter_postal_code_hint;

  /// No description provided for @enter_applicant_main_street.
  ///
  /// In fa, this message translates to:
  /// **'خیابان اصلی متقاضی را وارد نمایید'**
  String get enter_applicant_main_street;

  /// No description provided for @please_enter_county_value.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار شهرستان را وارد نمایید'**
  String get please_enter_county_value;

  /// No description provided for @enter_county.
  ///
  /// In fa, this message translates to:
  /// **'شهرستان خود را وارد نمایید'**
  String get enter_county;

  /// No description provided for @enter_county_value.
  ///
  /// In fa, this message translates to:
  /// **'مقدار شهرستان را وارد نمایید'**
  String get enter_county_value;

  /// No description provided for @main_street_label.
  ///
  /// In fa, this message translates to:
  /// **'خیابان اصلی'**
  String get main_street_label;

  /// No description provided for @main_street_hint.
  ///
  /// In fa, this message translates to:
  /// **'خیابان اصلی خود را وارد نمایید'**
  String get main_street_hint;

  /// No description provided for @account_opened_successfully.
  ///
  /// In fa, this message translates to:
  /// **'با موفقیت افتتاح شد'**
  String get account_opened_successfully;

  /// No description provided for @main_street_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار خیابان اصلی را وارد نمایید'**
  String get main_street_error;

  /// No description provided for @enter_guarantor_secondary_street.
  ///
  /// In fa, this message translates to:
  /// **'خیابان فرعی ضامن را وارد کنید'**
  String get enter_guarantor_secondary_street;

  /// No description provided for @secondary_street_label.
  ///
  /// In fa, this message translates to:
  /// **'خیابان فرعی'**
  String get secondary_street_label;

  /// No description provided for @secondary_street_hint.
  ///
  /// In fa, this message translates to:
  /// **'خیابان فرعی خود را وارد نمایید'**
  String get secondary_street_hint;

  /// No description provided for @secondary_street_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار خیابان فرعی را وارد نمایید'**
  String get secondary_street_error;

  /// No description provided for @plaque_label.
  ///
  /// In fa, this message translates to:
  /// **'پلاک'**
  String get plaque_label;

  /// No description provided for @first_password_reception.
  ///
  /// In fa, this message translates to:
  /// **'دریافت رمز اول'**
  String get first_password_reception;

  /// No description provided for @first_password_change.
  ///
  /// In fa, this message translates to:
  /// **'تغییر رمز اول'**
  String get first_password_change;

  /// No description provided for @second_password_reception.
  ///
  /// In fa, this message translates to:
  /// **'دریافت رمز دوم'**
  String get second_password_reception;

  /// No description provided for @second_password_change.
  ///
  /// In fa, this message translates to:
  /// **'تغییر رمز دوم'**
  String get second_password_change;

  /// No description provided for @confirm_deletion.
  ///
  /// In fa, this message translates to:
  /// **'آیا از حذف این شماره number مطمئن هستید؟'**
  String confirm_deletion(String number);

  /// No description provided for @deleted_successfully_message.
  ///
  /// In fa, this message translates to:
  /// **'شماره numbers با موفقیت حذف شد'**
  String deleted_successfully_message(String numbers);

  /// No description provided for @edited_successfully_message.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات number_ با موفقیت ویرایش شد'**
  String edited_successfully_message(String number_);

  /// No description provided for @enter_sub_street_of_beneficiary.
  ///
  /// In fa, this message translates to:
  /// **'خیابان فرعی مشمول را وارد نمایید'**
  String get enter_sub_street_of_beneficiary;

  /// No description provided for @plaque_hint.
  ///
  /// In fa, this message translates to:
  /// **'پلاک خود را وارد نمایید'**
  String get plaque_hint;

  /// No description provided for @enter_applicant_side_street.
  ///
  /// In fa, this message translates to:
  /// **'خیابان فرعی متقاضی را وارد کنید'**
  String get enter_applicant_side_street;

  /// No description provided for @plaque_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار پلاک را وارد نمایید'**
  String get plaque_error;

  /// No description provided for @enter_applicant_unit.
  ///
  /// In fa, this message translates to:
  /// **'واحد متقاضی را وارد کنید'**
  String get enter_applicant_unit;

  /// No description provided for @enter_guarantor_plate.
  ///
  /// In fa, this message translates to:
  /// **'پلاک ضامن را وارد نمایید'**
  String get enter_guarantor_plate;

  /// No description provided for @unit_label.
  ///
  /// In fa, this message translates to:
  /// **'واحد'**
  String get unit_label;

  /// No description provided for @unit_hint.
  ///
  /// In fa, this message translates to:
  /// **'واحد خود را وارد نمایید'**
  String get unit_hint;

  /// No description provided for @enter_side_street_value.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار خیابان فرعی را وارد کنید'**
  String get enter_side_street_value;

  /// No description provided for @enter_applicant_plaque.
  ///
  /// In fa, this message translates to:
  /// **'پلاک متقاضی را وارد نمایید'**
  String get enter_applicant_plaque;

  /// No description provided for @unit_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار واحد را وارد نمایید'**
  String get unit_error;

  /// No description provided for @select_location.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب آدرس روی نقشه (اختیاری)'**
  String get select_location;

  /// No description provided for @latitude_longitude.
  ///
  /// In fa, this message translates to:
  /// **'عرض و طول جغرافیایی'**
  String get latitude_longitude;

  /// No description provided for @remove_location_icon.
  ///
  /// In fa, this message translates to:
  /// **'حذف آدرس از نقشه'**
  String get remove_location_icon;

  /// No description provided for @location_error.
  ///
  /// In fa, this message translates to:
  /// **'آدرس را از نقشه انتخاب نمایید'**
  String get location_error;

  /// No description provided for @enter_unit_of_beneficiary.
  ///
  /// In fa, this message translates to:
  /// **'واحد مشمول را وارد نمایید'**
  String get enter_unit_of_beneficiary;

  /// No description provided for @applicant_residential_address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس محل سکونت متقاضی'**
  String get applicant_residential_address;

  /// No description provided for @enter_plaque_of_beneficiary.
  ///
  /// In fa, this message translates to:
  /// **'پلاک مشمول را وارد نمایید'**
  String get enter_plaque_of_beneficiary;

  /// No description provided for @submit_button.
  ///
  /// In fa, this message translates to:
  /// **'ثبت'**
  String get submit_button;

  /// No description provided for @issuing_duplicate_card.
  ///
  /// In fa, this message translates to:
  /// **'صدور کارت المثنی'**
  String get issuing_duplicate_card;

  /// No description provided for @duplicate_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت المثنی'**
  String get duplicate_card;

  /// No description provided for @address_hint_text.
  ///
  /// In fa, this message translates to:
  /// **'محله، خیابان، کوچه، شماره پلاک'**
  String get address_hint_text;

  /// No description provided for @employee_workplace_address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس محل کار کارمند'**
  String get employee_workplace_address;

  /// No description provided for @postal_address_error_text.
  ///
  /// In fa, this message translates to:
  /// **'مقدار صحیح آدرس پستی را به فارسی وارد نمایید'**
  String get postal_address_error_text;

  /// No description provided for @dear_user_message_living_place_Lease.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا اطلاعات محل سکونت خود را وارد و تصویر اصل سند یا اجاره نامه محل سکونت خود را بارگذاری نمایید.'**
  String get dear_user_message_living_place_Lease;

  /// No description provided for @province.
  ///
  /// In fa, this message translates to:
  /// **'استان'**
  String get province;

  /// No description provided for @select_province.
  ///
  /// In fa, this message translates to:
  /// **'استان را انتخاب کنید'**
  String get select_province;

  /// No description provided for @error_select_province.
  ///
  /// In fa, this message translates to:
  /// **'لطفا استان را انتخاب کنید'**
  String get error_select_province;

  /// No description provided for @city.
  ///
  /// In fa, this message translates to:
  /// **'شهر'**
  String get city;

  /// No description provided for @reciver_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی گیرنده'**
  String get reciver_postal_code;

  /// No description provided for @residence_address_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات پستی محل سکونت'**
  String get residence_address_information;

  /// No description provided for @choose_city.
  ///
  /// In fa, this message translates to:
  /// **'لطفا شهر را انتخاب کنید'**
  String get choose_city;

  /// No description provided for @select_city.
  ///
  /// In fa, this message translates to:
  /// **'شهر را انتخاب کنید'**
  String get select_city;

  /// No description provided for @current_pass_word.
  ///
  /// In fa, this message translates to:
  /// **'رمز فعلی'**
  String get current_pass_word;

  /// No description provided for @default_card_message.
  ///
  /// In fa, this message translates to:
  /// **'کارت پیش‌فرض برای سپرده شما صادر خواهد شد'**
  String get default_card_message;

  /// No description provided for @select_card_color.
  ///
  /// In fa, this message translates to:
  /// **'رنگ کارت خود را انتخاب کنید'**
  String get select_card_color;

  /// No description provided for @confirm_continue.
  ///
  /// In fa, this message translates to:
  /// **'تایید و ادامه'**
  String get confirm_continue;

  /// No description provided for @request_success_message.
  ///
  /// In fa, this message translates to:
  /// **'درخواست شما با موفقیت ثبت شد!'**
  String get request_success_message;

  /// No description provided for @tracking_number_label.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری'**
  String get tracking_number_label;

  /// No description provided for @sms_notification_message.
  ///
  /// In fa, this message translates to:
  /// **'مراتب از طریق پیامک به شما اطلاع داده خواهد شد.'**
  String get sms_notification_message;

  /// No description provided for @second_card_password_lenght_5_12.
  ///
  /// In fa, this message translates to:
  /// **'رمز دوم کارت باید حداقل ۵ و حداکثر ۱۲ رقم باشد'**
  String get second_card_password_lenght_5_12;

  /// No description provided for @dont_use_11111_123456.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب رمزهای ساده نظیر ۱۱۱۱۱ یا ۱۲۳۴۵۶ امکان پذیر نیست'**
  String get dont_use_11111_123456;

  /// No description provided for @submit_and_recieve_second_password.
  ///
  /// In fa, this message translates to:
  /// **'تایید و دریافت رمز دوم'**
  String get submit_and_recieve_second_password;

  /// No description provided for @second_card_code_issued.
  ///
  /// In fa, this message translates to:
  /// **'رمز دوم کارت صادر گردید!'**
  String get second_card_code_issued;

  /// No description provided for @second_card_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز دوم کارت'**
  String get second_card_password;

  /// No description provided for @wallet.
  ///
  /// In fa, this message translates to:
  /// **'کیف پول'**
  String get wallet;

  /// No description provided for @charge_wallet.
  ///
  /// In fa, this message translates to:
  /// **'شارژ کیف پول'**
  String get charge_wallet;

  /// No description provided for @block_card_title.
  ///
  /// In fa, this message translates to:
  /// **'مسدودسازی کارت'**
  String get block_card_title;

  /// No description provided for @block.
  ///
  /// In fa, this message translates to:
  /// **'مسدودسازی'**
  String get block;

  /// No description provided for @block_card_warning_message.
  ///
  /// In fa, this message translates to:
  /// **'در صورت ارسال درخواست مسدودی، تمامی امکانات کارت شما غیرفعال می‌شود و برای استفاده مجدد از کارت باید باید به صورت حضوری به شعبه بانک مراجعه نمایید.'**
  String get block_card_warning_message;

  /// No description provided for @select_block_reason.
  ///
  /// In fa, this message translates to:
  /// **'دلیل مسدودی را انتخاب نمایید'**
  String get select_block_reason;

  /// No description provided for @detail.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات'**
  String get detail;

  /// No description provided for @cant_withdraw_wallet_just_use_in_tobank.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ کیف پول شما قابل برداشت نیست و فقط در بخش خدمات توبانک قابل استفاده میباشد'**
  String get cant_withdraw_wallet_just_use_in_tobank;

  /// No description provided for @select_default_card.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب به عنوان پیش‌فرض'**
  String get select_default_card;

  /// No description provided for @reissue_request_title.
  ///
  /// In fa, this message translates to:
  /// **'در صورت درخواست صدور کارت المثنی'**
  String get reissue_request_title;

  /// No description provided for @card_info_change_message.
  ///
  /// In fa, this message translates to:
  /// **'شماره کارت، تاریخ انقضاء و CVV2 کارت بانکی تغییر خواهد کرد'**
  String get card_info_change_message;

  /// No description provided for @reissue_fee_message.
  ///
  /// In fa, this message translates to:
  /// **'کارمزد صدور کارت المثنی از سپرده متعلق به کارت بانکی مذکور کسر خواهد شد'**
  String get reissue_fee_message;

  /// No description provided for @reissue_fee_amount_message.
  ///
  /// In fa, this message translates to:
  /// **'کارمزد صدور کارت المثنی ({money}) ریال می‌باشد.'**
  String reissue_fee_amount_message(String money);

  /// No description provided for @banned.
  ///
  /// In fa, this message translates to:
  /// **'مسدود شده'**
  String get banned;

  /// No description provided for @destination_wallet.
  ///
  /// In fa, this message translates to:
  /// **'کیف پول مقصد'**
  String get destination_wallet;

  /// No description provided for @transfers.
  ///
  /// In fa, this message translates to:
  /// **'انتقالات'**
  String get transfers;

  /// No description provided for @description.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات'**
  String get description;

  /// No description provided for @payment_button.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت'**
  String get payment_button;

  /// No description provided for @select_service_you_want.
  ///
  /// In fa, this message translates to:
  /// **'خدمات مورد نظر خود را انتخاب نمایید'**
  String get select_service_you_want;

  /// No description provided for @continue_label.
  ///
  /// In fa, this message translates to:
  /// **'ادامه'**
  String get continue_label;

  /// No description provided for @deposit_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده'**
  String get deposit_number;

  /// No description provided for @min_wallet_charge.
  ///
  /// In fa, this message translates to:
  /// **'حداقل مبلغ شارژ کیف پول '**
  String get min_wallet_charge;

  /// No description provided for @min_amount_of_charge.
  ///
  /// In fa, this message translates to:
  /// **'حداقل مبلغ شارژ '**
  String get min_amount_of_charge;

  /// No description provided for @credit_card_loan_terms.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات درخواست تسهیلات کارت اعتباری'**
  String get credit_card_loan_terms;

  /// No description provided for @accept_credit_card_loan_terms.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات تسهیلات کارت اعتباری را قبول دارم'**
  String get accept_credit_card_loan_terms;

  /// No description provided for @wallet_balance_limit.
  ///
  /// In fa, this message translates to:
  /// **' ریال و سقف موجودی کیف پول '**
  String get wallet_balance_limit;

  /// No description provided for @balance_limit.
  ///
  /// In fa, this message translates to:
  /// **' ریال و سقف موجودی '**
  String get balance_limit;

  /// No description provided for @is_rial.
  ///
  /// In fa, this message translates to:
  /// **' ریال است'**
  String get is_rial;

  /// No description provided for @enter.
  ///
  /// In fa, this message translates to:
  /// **'را وارد کنید'**
  String get enter;

  /// No description provided for @digit.
  ///
  /// In fa, this message translates to:
  /// **'عدد'**
  String get digit;

  /// No description provided for @enter_valid.
  ///
  /// In fa, this message translates to:
  /// **'معتبر وارد نمایید'**
  String get enter_valid;

  /// No description provided for @number.
  ///
  /// In fa, this message translates to:
  /// **'شماره'**
  String get number;

  /// No description provided for @a_number.
  ///
  /// In fa, this message translates to:
  /// **'یک شماره'**
  String get a_number;

  /// No description provided for @charge_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ شارژ'**
  String get charge_amount;

  /// No description provided for @enter_a_valid.
  ///
  /// In fa, this message translates to:
  /// **'معتبر وارد نمایید'**
  String get enter_a_valid;

  /// No description provided for @enter_charge_amount_hint.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ شارژ را به ریال وارد کنید'**
  String get enter_charge_amount_hint;

  /// No description provided for @increase_wallet_balance.
  ///
  /// In fa, this message translates to:
  /// **'افزایش موجودی کیف پول'**
  String get increase_wallet_balance;

  /// No description provided for @increase_balance.
  ///
  /// In fa, this message translates to:
  /// **'افزایش موجودی'**
  String get increase_balance;

  /// No description provided for @payable_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ قابل پرداخت'**
  String get payable_amount;

  /// No description provided for @pay_location.
  ///
  /// In fa, this message translates to:
  /// **'محل پرداخت'**
  String get pay_location;

  /// No description provided for @choose_card_design.
  ///
  /// In fa, this message translates to:
  /// **'طرح کارت را انتخاب کنید'**
  String get choose_card_design;

  /// No description provided for @payment_method.
  ///
  /// In fa, this message translates to:
  /// **'روش پرداخت'**
  String get payment_method;

  /// No description provided for @wallet_transfer.
  ///
  /// In fa, this message translates to:
  /// **'انتقال وجه کیف پول'**
  String get wallet_transfer;

  /// No description provided for @ready_design.
  ///
  /// In fa, this message translates to:
  /// **'طرح‌های آماده'**
  String get ready_design;

  /// No description provided for @enter_des_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره همراه مقصد را وارد کنید'**
  String get enter_des_mobile_number;

  /// No description provided for @valid_mobile_number_error.
  ///
  /// In fa, this message translates to:
  /// **'یک شماره معتبر وارد نمایید'**
  String get valid_mobile_number_error;

  /// No description provided for @enter_transfer_amount_rial.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ را به ریال وارد کنید'**
  String get enter_transfer_amount_rial;

  /// No description provided for @valid_amount_error.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ معتبر وارد نمایید'**
  String get valid_amount_error;

  /// No description provided for @description_optional.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات(اختیاری)'**
  String get description_optional;

  /// No description provided for @enter_transfer_description.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات انتقال وجه را وارد کنید'**
  String get enter_transfer_description;

  /// No description provided for @manage_cards.
  ///
  /// In fa, this message translates to:
  /// **'مدیریت کارت‌ها'**
  String get manage_cards;

  /// No description provided for @enter_expiration_card.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ انقصای کارت را وارد کنید'**
  String get enter_expiration_card;

  /// No description provided for @to_destination.
  ///
  /// In fa, this message translates to:
  /// **'به مقصد'**
  String get to_destination;

  /// No description provided for @cards.
  ///
  /// In fa, this message translates to:
  /// **'کارت‌ها'**
  String get cards;

  /// No description provided for @select_expiration_date_value.
  ///
  /// In fa, this message translates to:
  /// **'مقدار تاریخ انقضا را انتخاب نمایید'**
  String get select_expiration_date_value;

  /// No description provided for @deposit_detail.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات سپرده'**
  String get deposit_detail;

  /// No description provided for @from_origin.
  ///
  /// In fa, this message translates to:
  /// **'از مبدا'**
  String get from_origin;

  /// No description provided for @origin.
  ///
  /// In fa, this message translates to:
  /// **'مبدا'**
  String get origin;

  /// No description provided for @error.
  ///
  /// In fa, this message translates to:
  /// **'خطا'**
  String get error;

  /// No description provided for @select_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ را انتخاب نمایید'**
  String get select_amount;

  /// No description provided for @enter_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ را وارد نمایید'**
  String get enter_amount;

  /// No description provided for @enter_description.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات را وارد نمایید'**
  String get enter_description;

  /// No description provided for @show_error.
  ///
  /// In fa, this message translates to:
  /// **'خطا - {apiException}'**
  String show_error(int apiException);

  /// No description provided for @crop_picture.
  ///
  /// In fa, this message translates to:
  /// **'برش عکس'**
  String get crop_picture;

  /// No description provided for @safe_box_title.
  ///
  /// In fa, this message translates to:
  /// **'صندوق امانات'**
  String get safe_box_title;

  /// No description provided for @save_destination_card.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره کارت مقصد'**
  String get save_destination_card;

  /// No description provided for @in_amount_of.
  ///
  /// In fa, this message translates to:
  /// **'به مبلغ'**
  String get in_amount_of;

  /// No description provided for @transfer.
  ///
  /// In fa, this message translates to:
  /// **'انتقال'**
  String get transfer;

  /// No description provided for @issue.
  ///
  /// In fa, this message translates to:
  /// **'صدور'**
  String get issue;

  /// No description provided for @guarante.
  ///
  /// In fa, this message translates to:
  /// **'ضمانت'**
  String get guarante;

  /// No description provided for @receive.
  ///
  /// In fa, this message translates to:
  /// **'دریافت'**
  String get receive;

  /// No description provided for @million.
  ///
  /// In fa, this message translates to:
  /// **'میلیون'**
  String get million;

  /// No description provided for @select_one_of_deposit.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از سپرده‌ها را انتخاب کنید'**
  String get select_one_of_deposit;

  /// No description provided for @origin_card_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره کارت مبدا'**
  String get origin_card_number;

  /// No description provided for @select_origin_card_hint.
  ///
  /// In fa, this message translates to:
  /// **'شماره کارت مبدا را انتخاب کنید'**
  String get select_origin_card_hint;

  /// No description provided for @deposit_balance_not_eligible_to_receive_the_facility.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، با توجه به میانگین موجودی سپرده شما، متاسفانه واجد شرایط دریافت تسهیلات نمی‌باشید.'**
  String get deposit_balance_not_eligible_to_receive_the_facility;

  /// No description provided for @valid_origin_card_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا شماره کارت مبدا را انتخاب نمایید'**
  String get valid_origin_card_error;

  /// No description provided for @destination_card_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره کارت مقصد'**
  String get destination_card_number;

  /// No description provided for @enter_or_select_destination_card.
  ///
  /// In fa, this message translates to:
  /// **'شماره کارت مقصد را وارد یا انتخاب نمایید'**
  String get enter_or_select_destination_card;

  /// No description provided for @increase_card_to_card_limit.
  ///
  /// In fa, this message translates to:
  /// **'افزایش سقف کارت به کارت'**
  String get increase_card_to_card_limit;

  /// No description provided for @card_to_card_limit_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، انتقال وجه کارت به کارت تا سقف ۱۰۰ میلیون ریال از مبدا بانک گردشگری فراهم شده است. برای مبالغ بیشتر، از انتقال وجه بخش سپرده‌ها اقدام نمایید'**
  String get card_to_card_limit_message;

  /// No description provided for @understood_button.
  ///
  /// In fa, this message translates to:
  /// **'متوجه شدم'**
  String get understood_button;

  /// No description provided for @card_to_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت به کارت'**
  String get card_to_card;

  /// No description provided for @select_charity_plan.
  ///
  /// In fa, this message translates to:
  /// **'طرح خیریه مورد نظر خود را انتخاب کنید'**
  String get select_charity_plan;

  /// No description provided for @drag_bar_accessibility.
  ///
  /// In fa, this message translates to:
  /// **'برای جابجا کردن، نوار را بکشید'**
  String get drag_bar_accessibility;

  /// No description provided for @collected_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ جمع‌آوری شده'**
  String get collected_amount;

  /// No description provided for @required_budget.
  ///
  /// In fa, this message translates to:
  /// **'بودجه لازم'**
  String get required_budget;

  /// No description provided for @enter_donation_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ کمک را وارد نمایید'**
  String get enter_donation_amount;

  /// No description provided for @donation_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ نیکوکاری'**
  String get donation_amount;

  /// No description provided for @invalid_amount_error.
  ///
  /// In fa, this message translates to:
  /// **'مقدار معتبری وارد نمایید'**
  String get invalid_amount_error;

  /// No description provided for @confirm_donation_button.
  ///
  /// In fa, this message translates to:
  /// **'تایید مبلغ کمک'**
  String get confirm_donation_button;

  /// No description provided for @niko_kari.
  ///
  /// In fa, this message translates to:
  /// **'نیکوکاری'**
  String get niko_kari;

  /// No description provided for @feedback_prompt.
  ///
  /// In fa, this message translates to:
  /// **'لطفا در صورت تمایل نظر خود را در مورد برنامه توبانک ثبت کنید'**
  String get feedback_prompt;

  /// No description provided for @later_button.
  ///
  /// In fa, this message translates to:
  /// **'بعدا'**
  String get later_button;

  /// No description provided for @submit_feedback_button.
  ///
  /// In fa, this message translates to:
  /// **'ثبت نظر'**
  String get submit_feedback_button;

  /// No description provided for @select_exprire_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ انقضای کارت را انتخاب نمایید'**
  String get select_exprire_date;

  /// No description provided for @shaparak_register.
  ///
  /// In fa, this message translates to:
  /// **'ثبت در شاپرک'**
  String get shaparak_register;

  /// No description provided for @tobank_wallet.
  ///
  /// In fa, this message translates to:
  /// **'کیف پول توبانک'**
  String get tobank_wallet;

  /// No description provided for @try_again.
  ///
  /// In fa, this message translates to:
  /// **'تلاش مجدد'**
  String get try_again;

  /// No description provided for @credit_card_amount_label.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ کارت اعتباری'**
  String get credit_card_amount_label;

  /// No description provided for @to_use_service_must_register_at_least_one_bank_card.
  ///
  /// In fa, this message translates to:
  /// **'برای استفاده از این سرویس باید حداقل یک کارت بانکی خود را در بخش مدیریت کارت‌ها ثبت کنید'**
  String get to_use_service_must_register_at_least_one_bank_card;

  /// No description provided for @credit_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت اعتباری'**
  String get credit_card;

  /// No description provided for @enter_credit_card_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ کارت اعتباری را انتخاب کنید'**
  String get enter_credit_card_amount;

  /// No description provided for @select_payment_term.
  ///
  /// In fa, this message translates to:
  /// **'دوره بازپرداخت را انتخاب کنید'**
  String get select_payment_term;

  /// No description provided for @payment_term.
  ///
  /// In fa, this message translates to:
  /// **'دوره بازپرداخت'**
  String get payment_term;

  /// No description provided for @select_payment_term_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از دوره‌های بازپرداخت را انتخاب کنید'**
  String get select_payment_term_error;

  /// No description provided for @select_amount_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از مبالغ را انتخاب کنید'**
  String get select_amount_error;

  /// No description provided for @credit_card_amount_unavailable.
  ///
  /// In fa, this message translates to:
  /// **'غیرقابل دریافت'**
  String get credit_card_amount_unavailable;

  /// No description provided for @enter_pay_id_optional.
  ///
  /// In fa, this message translates to:
  /// **'شناسه پرداخت را وارد نمایید(اختیاری)'**
  String get enter_pay_id_optional;

  /// No description provided for @card_to_card_not_available_.
  ///
  /// In fa, this message translates to:
  /// **'امکان کارت به کارت برای کارت انتخاب شده وجود ندارد'**
  String get card_to_card_not_available_;

  /// No description provided for @credit_card_amount_range.
  ///
  /// In fa, this message translates to:
  /// **'از ۱۰ میلیون تومان تا {amount} تومان'**
  String credit_card_amount_range(String amount);

  /// No description provided for @return_.
  ///
  /// In fa, this message translates to:
  /// **'بازگشت'**
  String get return_;

  /// No description provided for @send_sms.
  ///
  /// In fa, this message translates to:
  /// **'ارسال پیامک'**
  String get send_sms;

  /// No description provided for @receive_dynamic_password_sms.
  ///
  /// In fa, this message translates to:
  /// **'دریافت رمز پویا از طریق پیامک'**
  String get receive_dynamic_password_sms;

  /// No description provided for @new_.
  ///
  /// In fa, this message translates to:
  /// **'(جدید)'**
  String get new_;

  /// No description provided for @dynamic_pin_description.
  ///
  /// In fa, this message translates to:
  /// **'دریافت رمز پویا به صورت خودکار در توبانک'**
  String get dynamic_pin_description;

  /// No description provided for @position_selection.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب موقعیت'**
  String get position_selection;

  /// No description provided for @pay_with_browser_or_bank_portal.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت را در مرورگر و توسط درگاه بانکی تحت وب ادامه دهید'**
  String get pay_with_browser_or_bank_portal;

  /// No description provided for @check_payment.
  ///
  /// In fa, this message translates to:
  /// **'بررسی پرداخت'**
  String get check_payment;

  /// No description provided for @bank_portal.
  ///
  /// In fa, this message translates to:
  /// **'درگاه بانکی'**
  String get bank_portal;

  /// No description provided for @select_deposit_for_payment.
  ///
  /// In fa, this message translates to:
  /// **'سپرده جهت پرداخت را انتخاب کنید'**
  String get select_deposit_for_payment;

  /// No description provided for @change_app_theme.
  ///
  /// In fa, this message translates to:
  /// **'تغییر تم برنامه'**
  String get change_app_theme;

  /// No description provided for @payment_successful.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت موفق'**
  String get payment_successful;

  /// No description provided for @payment_unsuccessful.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت ناموفق'**
  String get payment_unsuccessful;

  /// No description provided for @payment_unknown.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت نامشخص'**
  String get payment_unknown;

  /// No description provided for @transaction_report.
  ///
  /// In fa, this message translates to:
  /// **' گزارش تراکنش'**
  String get transaction_report;

  /// No description provided for @paid_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ پرداختی'**
  String get paid_amount;

  /// No description provided for @charge.
  ///
  /// In fa, this message translates to:
  /// **'شارژ'**
  String get charge;

  /// No description provided for @transaction_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع تراکنش'**
  String get transaction_type;

  /// No description provided for @request_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع درخواست: '**
  String get request_type;

  /// No description provided for @paid_via.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت از طریق'**
  String get paid_via;

  /// No description provided for @discounted_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ پس از تخفیف'**
  String get discounted_amount;

  /// No description provided for @tracking_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره پیگیری'**
  String get tracking_number;

  /// No description provided for @receipt_image.
  ///
  /// In fa, this message translates to:
  /// **'تصویر رسید'**
  String get receipt_image;

  /// No description provided for @receipt_text.
  ///
  /// In fa, this message translates to:
  /// **'متن رسید'**
  String get receipt_text;

  /// No description provided for @check_again_.
  ///
  /// In fa, this message translates to:
  /// **'بررسی مجدد'**
  String get check_again_;

  /// No description provided for @re_inquiry_transfer.
  ///
  /// In fa, this message translates to:
  /// **'استعلام مجدد'**
  String get re_inquiry_transfer;

  /// No description provided for @virtual_branch.
  ///
  /// In fa, this message translates to:
  /// **'شعبه مجازی همراه شما'**
  String get virtual_branch;

  /// No description provided for @website.
  ///
  /// In fa, this message translates to:
  /// **'www.tobank.ir'**
  String get website;

  /// No description provided for @success_ENG.
  ///
  /// In fa, this message translates to:
  /// **'success'**
  String get success_ENG;

  /// No description provided for @error_ENG.
  ///
  /// In fa, this message translates to:
  /// **'error'**
  String get error_ENG;

  /// No description provided for @tobank_contacts.
  ///
  /// In fa, this message translates to:
  /// **'مخاطبین توبانک'**
  String get tobank_contacts;

  /// No description provided for @search_with_phone_number.
  ///
  /// In fa, this message translates to:
  /// **'جستجو نام یا تلفن‌همراه'**
  String get search_with_phone_number;

  /// No description provided for @contact.
  ///
  /// In fa, this message translates to:
  /// **'مخاطبین'**
  String get contact;

  /// No description provided for @address_farhang.
  ///
  /// In fa, this message translates to:
  /// **'تهران، سعادت‌آباد، بلوار فرهنگ، نبش کوچه نور، پلاک ۶'**
  String get address_farhang;

  /// No description provided for @branch_support.
  ///
  /// In fa, this message translates to:
  /// **'پشتیبانی شعبه'**
  String get branch_support;

  /// No description provided for @tourism_bank_instagram.
  ///
  /// In fa, this message translates to:
  /// **'اینستاگرام بانک گردشگری'**
  String get tourism_bank_instagram;

  /// No description provided for @contact_tobank.
  ///
  /// In fa, this message translates to:
  /// **'ارتباط با توبانک'**
  String get contact_tobank;

  /// No description provided for @phone_number_dakheli3.
  ///
  /// In fa, this message translates to:
  /// **'02123950 - داخلی 3'**
  String get phone_number_dakheli3;

  /// No description provided for @instagram_handle.
  ///
  /// In fa, this message translates to:
  /// **'@tourism.bank'**
  String get instagram_handle;

  /// No description provided for @tobank_phone.
  ///
  /// In fa, this message translates to:
  /// **'tel://02123950'**
  String get tobank_phone;

  /// No description provided for @tobank_email.
  ///
  /// In fa, this message translates to:
  /// **'mailto:info@tobank.ir'**
  String get tobank_email;

  /// No description provided for @tobank_website.
  ///
  /// In fa, this message translates to:
  /// **'https://tobank.ir'**
  String get tobank_website;

  /// No description provided for @tobank_instagram.
  ///
  /// In fa, this message translates to:
  /// **'https://instagram.com/tobank.ir'**
  String get tobank_instagram;

  /// No description provided for @tobank_linkedin.
  ///
  /// In fa, this message translates to:
  /// **'https://www.linkedin.com/company/tobank'**
  String get tobank_linkedin;

  /// No description provided for @tobank_aparat.
  ///
  /// In fa, this message translates to:
  /// **'https://www.aparat.com/GardeshPay'**
  String get tobank_aparat;

  /// No description provided for @dear_user_not_member_tobank_customer_club.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، شما عضو باشگاه مشتریان توبانک نیستید'**
  String get dear_user_not_member_tobank_customer_club;

  /// No description provided for @tobank_customer_club.
  ///
  /// In fa, this message translates to:
  /// **'باشگاه مشتریان توبانک'**
  String get tobank_customer_club;

  /// No description provided for @customer_club.
  ///
  /// In fa, this message translates to:
  /// **'باشگاه مشتریان'**
  String get customer_club;

  /// No description provided for @credit_card_reception.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات کارت اعتباری'**
  String get credit_card_reception;

  /// No description provided for @marriage_loan_gharz_hassane.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات قرض الحسنه ازدواج'**
  String get marriage_loan_gharz_hassane;

  /// No description provided for @internet_banking_account_creation_request.
  ///
  /// In fa, this message translates to:
  /// **'خدمات اینترنت بانک'**
  String get internet_banking_account_creation_request;

  /// No description provided for @mobile_banking_account_creation_request.
  ///
  /// In fa, this message translates to:
  /// **'خدمات موبایل بانک'**
  String get mobile_banking_account_creation_request;

  /// No description provided for @card_issuance_request.
  ///
  /// In fa, this message translates to:
  /// **'صدور کارت فیزیکی'**
  String get card_issuance_request;

  /// No description provided for @card_reissuance_request.
  ///
  /// In fa, this message translates to:
  /// **'صدور کارت المثنی'**
  String get card_reissuance_request;

  /// No description provided for @rayan_card_request.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات رایان کارت'**
  String get rayan_card_request;

  /// No description provided for @children_loan.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات فرزندآوری'**
  String get children_loan;

  /// No description provided for @documents_completion.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش مدارک هویتی'**
  String get documents_completion;

  /// No description provided for @documents_edit.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش مدارک'**
  String get documents_edit;

  /// No description provided for @military_lg.
  ///
  /// In fa, this message translates to:
  /// **'ضمانت‌نامه نظام وظیفه'**
  String get military_lg;

  /// No description provided for @retail_loan.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات خرد'**
  String get retail_loan;

  /// No description provided for @micro_lending_loan.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات کوچک'**
  String get micro_lending_loan;

  /// No description provided for @sure_about_paying_inquiry_fee.
  ///
  /// In fa, this message translates to:
  /// **'از پرداخت هزینه استعلام مطمئن هستید؟'**
  String get sure_about_paying_inquiry_fee;

  /// No description provided for @default_unknown.
  ///
  /// In fa, this message translates to:
  /// **'نامشخص'**
  String get default_unknown;

  /// No description provided for @next_step.
  ///
  /// In fa, this message translates to:
  /// **'مرحله بعد'**
  String get next_step;

  /// No description provided for @registration_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ ثبت'**
  String get registration_date;

  /// No description provided for @request_checking_message.
  ///
  /// In fa, this message translates to:
  /// **'در حال حاضر درخواست جدید ندارید یا درخواست مورد نظر شما در حال بررسی می‌باشد. شما می‌توانید وضعیت درخواست‌های خود را در منو تاریخچه فعالییت‌ها مشاهده فرمایید.'**
  String get request_checking_message;

  /// No description provided for @continue_process.
  ///
  /// In fa, this message translates to:
  /// **'ادامه فرآیند'**
  String get continue_process;

  /// No description provided for @no_new_requests_message.
  ///
  /// In fa, this message translates to:
  /// **'در حال حاضر درخواست جدید ندارید یا درخواست مورد نظر شما در حال بررسی می‌باشد. شما می‌توانید وضعیت درخواست‌های خود را در منو فرآیند مشاهده فرمایید.'**
  String get no_new_requests_message;

  /// No description provided for @user_account.
  ///
  /// In fa, this message translates to:
  /// **'حساب کاربری'**
  String get user_account;

  /// No description provided for @no_transaction_recorded.
  ///
  /// In fa, this message translates to:
  /// **'تراکنشی ثبت نشده است.'**
  String get no_transaction_recorded;

  /// No description provided for @deposit_money.
  ///
  /// In fa, this message translates to:
  /// **'واریز وجه'**
  String get deposit_money;

  /// No description provided for @deposit_turn_over.
  ///
  /// In fa, this message translates to:
  /// **'گردش سپرده'**
  String get deposit_turn_over;

  /// No description provided for @transfer_money.
  ///
  /// In fa, this message translates to:
  /// **'انتقال وجه'**
  String get transfer_money;

  /// No description provided for @terms_and_conditions_title_warranty.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات صدور ضمانت‌نامه'**
  String get terms_and_conditions_title_warranty;

  /// No description provided for @terms_and_conditions_check_title.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات به شرح فوق را رویت و مورد تایید و قبول اینجانب می‌باشد'**
  String get terms_and_conditions_check_title;

  /// No description provided for @more.
  ///
  /// In fa, this message translates to:
  /// **'بیشتر'**
  String get more;

  /// No description provided for @tobank_special_services.
  ///
  /// In fa, this message translates to:
  /// **'خدمات ویژه توبانک'**
  String get tobank_special_services;

  /// No description provided for @loan_types.
  ///
  /// In fa, this message translates to:
  /// **'انواع تسهیلات'**
  String get loan_types;

  /// No description provided for @loan_types_description.
  ///
  /// In fa, this message translates to:
  /// **'ازدواج، کارت اعتباری ...'**
  String get loan_types_description;

  /// No description provided for @other_services.
  ///
  /// In fa, this message translates to:
  /// **'سایر خدمات'**
  String get other_services;

  /// No description provided for @other_services_description.
  ///
  /// In fa, this message translates to:
  /// **'سفته الکترونیک ...'**
  String get other_services_description;

  /// No description provided for @tourism_bank_investment_funds.
  ///
  /// In fa, this message translates to:
  /// **'صندوق‌های سرمایه‌گذاری در بانک گردشگری'**
  String get tourism_bank_investment_funds;

  /// No description provided for @tax_exempt.
  ///
  /// In fa, this message translates to:
  /// **'معاف از مالیات'**
  String get tax_exempt;

  /// No description provided for @regulated_by_stock_organization.
  ///
  /// In fa, this message translates to:
  /// **'تحت مجوز و نظارت سازمان بورس'**
  String get regulated_by_stock_organization;

  /// No description provided for @start_investing.
  ///
  /// In fa, this message translates to:
  /// **'شروع سرمایه‌گذاری'**
  String get start_investing;

  /// No description provided for @cartable.
  ///
  /// In fa, this message translates to:
  /// **'کارتابل'**
  String get cartable;

  /// No description provided for @activity_history.
  ///
  /// In fa, this message translates to:
  /// **'تاریخچه فعالیت‌ها'**
  String get activity_history;

  /// No description provided for @filters.
  ///
  /// In fa, this message translates to:
  /// **'فیلترها'**
  String get filters;

  /// No description provided for @all.
  ///
  /// In fa, this message translates to:
  /// **'همه'**
  String get all;

  /// No description provided for @wallet_transactions.
  ///
  /// In fa, this message translates to:
  /// **'تراکنش‌های کیف پول'**
  String get wallet_transactions;

  /// No description provided for @tobank.
  ///
  /// In fa, this message translates to:
  /// **'توبانک'**
  String get tobank;

  /// No description provided for @deposits.
  ///
  /// In fa, this message translates to:
  /// **'سپرده‌ها'**
  String get deposits;

  /// No description provided for @open_requests.
  ///
  /// In fa, this message translates to:
  /// **'درخواست‌های باز'**
  String get open_requests;

  /// No description provided for @closed_requests.
  ///
  /// In fa, this message translates to:
  /// **'درخواست‌های بسته'**
  String get closed_requests;

  /// No description provided for @active.
  ///
  /// In fa, this message translates to:
  /// **'باز'**
  String get active;

  /// No description provided for @suspended.
  ///
  /// In fa, this message translates to:
  /// **'معلق'**
  String get suspended;

  /// No description provided for @completed_or_terminated.
  ///
  /// In fa, this message translates to:
  /// **'بسته'**
  String get completed_or_terminated;

  /// No description provided for @package.
  ///
  /// In fa, this message translates to:
  /// **'بسته'**
  String get package;

  /// No description provided for @status_request.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت درخواست'**
  String get status_request;

  /// No description provided for @registration_date_request.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ ثبت درخواست'**
  String get registration_date_request;

  /// No description provided for @select_average_period.
  ///
  /// In fa, this message translates to:
  /// **'دوره میانگین گیری را انتخاب کنید'**
  String get select_average_period;

  /// No description provided for @base_on.
  ///
  /// In fa, this message translates to:
  /// **'بر اساس'**
  String get base_on;

  /// No description provided for @deposit_services.
  ///
  /// In fa, this message translates to:
  /// **'خدمات سپرده'**
  String get deposit_services;

  /// No description provided for @identity_verification.
  ///
  /// In fa, this message translates to:
  /// **'احراز هویت آنلاین'**
  String get identity_verification;

  /// No description provided for @account_opening.
  ///
  /// In fa, this message translates to:
  /// **'افتتاح آنلاین و رایگان انواع سپرده'**
  String get account_opening;

  /// No description provided for @free_card_delivery.
  ///
  /// In fa, this message translates to:
  /// **'ارسال رایگان انواع کارت بانکی به سراسر کشور'**
  String get free_card_delivery;

  /// No description provided for @online_loans.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت آنلاین انواع تسهیلات'**
  String get online_loans;

  /// No description provided for @bank_services_message.
  ///
  /// In fa, this message translates to:
  /// **'برای استفاده از تمامی خدمات بانک گردشگری بعد از احراز هویت اقدام به افتتاح سپرده نمایید'**
  String get bank_services_message;

  /// No description provided for @security_message.
  ///
  /// In fa, this message translates to:
  /// **'به جهت حفظ امنیت دوباره وارد شوید'**
  String get security_message;

  /// No description provided for @password_label.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور'**
  String get password_label;

  /// No description provided for @password_hint.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور خود را وارد نمایید'**
  String get password_hint;

  /// No description provided for @password_error_farsi_5char.
  ///
  /// In fa, this message translates to:
  /// **'حداقل طول رمزعبور باید ۵ کاراکتر باشد و شامل حروف فارسی نباشد'**
  String get password_error_farsi_5char;

  /// No description provided for @login_again.
  ///
  /// In fa, this message translates to:
  /// **'ورود مجدد'**
  String get login_again;

  /// No description provided for @bank_deposit_opening.
  ///
  /// In fa, this message translates to:
  /// **'افتتاح سپرده بانک گردشگری'**
  String get bank_deposit_opening;

  /// No description provided for @deposit_description.
  ///
  /// In fa, this message translates to:
  /// **'کوتاه مدت، قرض‌الحسنه پس‌انداز، بلندمدت و ...'**
  String get deposit_description;

  /// No description provided for @deposit_button_opening.
  ///
  /// In fa, this message translates to:
  /// **'افتتاح سپرده'**
  String get deposit_button_opening;

  /// No description provided for @time_range.
  ///
  /// In fa, this message translates to:
  /// **'بازه زمانی'**
  String get time_range;

  /// No description provided for @last_10_transactions.
  ///
  /// In fa, this message translates to:
  /// **'۱۰ گردش آخر'**
  String get last_10_transactions;

  /// No description provided for @from_date.
  ///
  /// In fa, this message translates to:
  /// **'از تاریخ'**
  String get from_date;

  /// No description provided for @to_date.
  ///
  /// In fa, this message translates to:
  /// **'تا تاریخ'**
  String get to_date;

  /// No description provided for @select_hint.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب کنید'**
  String get select_hint;

  /// No description provided for @investment_title.
  ///
  /// In fa, this message translates to:
  /// **'سرمایه‌گذاری'**
  String get investment_title;

  /// No description provided for @services_title.
  ///
  /// In fa, this message translates to:
  /// **'خدمات'**
  String get services_title;

  /// No description provided for @deposit_limit_message.
  ///
  /// In fa, this message translates to:
  /// **'محدودیت تعداد سپرده'**
  String get deposit_limit_message;

  /// No description provided for @select_deposit_message.
  ///
  /// In fa, this message translates to:
  /// **'سپرده مورد نظر خود را انتخاب نمایید'**
  String get select_deposit_message;

  /// No description provided for @select_profile_image.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب تصویر پروفایل'**
  String get select_profile_image;

  /// No description provided for @default_images.
  ///
  /// In fa, this message translates to:
  /// **'تصاویر پیش‌فرض'**
  String get default_images;

  /// No description provided for @select_from_gallery.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب از گالری'**
  String get select_from_gallery;

  /// No description provided for @error_in_receive_customer_info.
  ///
  /// In fa, this message translates to:
  /// **'مشکلی در دریافت اطلاعات مشتری پیش آمده است.'**
  String get error_in_receive_customer_info;

  /// No description provided for @cancel.
  ///
  /// In fa, this message translates to:
  /// **'انصراف'**
  String get cancel;

  /// No description provided for @to_use_service_national_code_mobile_number_need_match.
  ///
  /// In fa, this message translates to:
  /// **'برای استفاده از این سرویس، نیاز است که کد ملی و شماره موبایل مطابقت داده شود'**
  String get to_use_service_national_code_mobile_number_need_match;

  /// No description provided for @select_transaction_reason.
  ///
  /// In fa, this message translates to:
  /// **'دلیل تراکنش را انتخاب نمایید'**
  String get select_transaction_reason;

  /// No description provided for @select_reason_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از دلیل‌ها را انتخاب نمایید'**
  String get select_reason_error;

  /// No description provided for @from_description.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات مبدا'**
  String get from_description;

  /// No description provided for @from_description_hint.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات مبدا را وارد نمایید'**
  String get from_description_hint;

  /// No description provided for @transaction_description_hint.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات تراکنش را وارد نمایید'**
  String get transaction_description_hint;

  /// No description provided for @transfer_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع انتقال'**
  String get transfer_type;

  /// No description provided for @transfer_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ انتقال'**
  String get transfer_amount;

  /// No description provided for @enter_rial_transfer_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ انتقال را به ریال وارد کنید'**
  String get enter_rial_transfer_amount;

  /// No description provided for @transfer_time.
  ///
  /// In fa, this message translates to:
  /// **'زمان انتقال وجه'**
  String get transfer_time;

  /// No description provided for @source_deposit_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده مبدا'**
  String get source_deposit_number;

  /// No description provided for @destination_deposit_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده مقصد'**
  String get destination_deposit_number;

  /// No description provided for @destination_account_owner.
  ///
  /// In fa, this message translates to:
  /// **'صاحب سپرده مقصد'**
  String get destination_account_owner;

  /// No description provided for @bank_tracking_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره پیگیری بانکی'**
  String get bank_tracking_number;

  /// No description provided for @system_tracking_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره پیگیری سیستم'**
  String get system_tracking_number;

  /// No description provided for @source_description.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات مبدا'**
  String get source_description;

  /// No description provided for @transaction_description.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات تراکنش'**
  String get transaction_description;

  /// No description provided for @save_to_gallery.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره در گالری'**
  String get save_to_gallery;

  /// No description provided for @destination_shaba.
  ///
  /// In fa, this message translates to:
  /// **'شماره شبا مقصد'**
  String get destination_shaba;

  /// No description provided for @deposit_destination_tourism_bank_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده بانک گردشگری مقصد'**
  String get deposit_destination_tourism_bank_number;

  /// No description provided for @enter_destination_deposit_tourism_banknumber.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده بانک گردشگری مقصد را وارد کنید'**
  String get enter_destination_deposit_tourism_banknumber;

  /// No description provided for @destination_number_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفاً شماره سپرده مقصد بانک گردشگری را وارد کنید'**
  String get destination_number_error;

  /// No description provided for @empty_list_message.
  ///
  /// In fa, this message translates to:
  /// **'هیچ شماره‌ای ذخیره نشده است'**
  String get empty_list_message;

  /// No description provided for @no_number_saved.
  ///
  /// In fa, this message translates to:
  /// **'شماره‌ای ذخیره نشده است'**
  String get no_number_saved;

  /// No description provided for @transfer_for.
  ///
  /// In fa, this message translates to:
  /// **'انتقال بابت:'**
  String get transfer_for;

  /// No description provided for @cant_use_this_transfer_method.
  ///
  /// In fa, this message translates to:
  /// **'امکان استفاده از این روش انتقال وجود ندارد'**
  String get cant_use_this_transfer_method;

  /// No description provided for @withdrawal.
  ///
  /// In fa, this message translates to:
  /// **'برداشت وجه'**
  String get withdrawal;

  /// No description provided for @select_destination_card.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب کارت مقصد'**
  String get select_destination_card;

  /// No description provided for @transfer_detail.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات انتقال وجه'**
  String get transfer_detail;

  /// No description provided for @select_transfer_method.
  ///
  /// In fa, this message translates to:
  /// **'روش انتقال را انتخاب کنید'**
  String get select_transfer_method;

  /// No description provided for @amount_to_transfer.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ جهت انتقال'**
  String get amount_to_transfer;

  /// No description provided for @enter_shaba.
  ///
  /// In fa, this message translates to:
  /// **'شماره شبا را وارد کنید'**
  String get enter_shaba;

  /// No description provided for @transfer_success.
  ///
  /// In fa, this message translates to:
  /// **'انتقال وجه با موفقیت انجام شد!'**
  String get transfer_success;

  /// No description provided for @transaction_failed.
  ///
  /// In fa, this message translates to:
  /// **'عملیات ناموفق بود'**
  String get transaction_failed;

  /// No description provided for @check_again.
  ///
  /// In fa, this message translates to:
  /// **'برای مشاهده وضعیت تراکنش، دکمه بررسی مجدد را کلیک کنید'**
  String get check_again;

  /// No description provided for @interbank.
  ///
  /// In fa, this message translates to:
  /// **'بین بانکی'**
  String get interbank;

  /// No description provided for @inbank.
  ///
  /// In fa, this message translates to:
  /// **'درون بانکی'**
  String get inbank;

  /// No description provided for @title.
  ///
  /// In fa, this message translates to:
  /// **'عنوان'**
  String get title;

  /// No description provided for @search_destination_card.
  ///
  /// In fa, this message translates to:
  /// **'جستجو کارت مقصد'**
  String get search_destination_card;

  /// No description provided for @check_transaction_status_click_recheck_button.
  ///
  /// In fa, this message translates to:
  /// **'برای مشخص شدن وضعیت تراکنش، دکمه بررسی مجدد را کلیک کنید'**
  String get check_transaction_status_click_recheck_button;

  /// No description provided for @hint_card_number.
  ///
  /// In fa, this message translates to:
  /// **'عنوان یا شماره کارت'**
  String get hint_card_number;

  /// No description provided for @invalid_card_number.
  ///
  /// In fa, this message translates to:
  /// **'مقدار معتبری برای شماره کارت وارد نمایید'**
  String get invalid_card_number;

  /// No description provided for @no_card_registered.
  ///
  /// In fa, this message translates to:
  /// **'شما کارتی ثبت نکرده‌اید'**
  String get no_card_registered;

  /// No description provided for @add_card_instructions.
  ///
  /// In fa, this message translates to:
  /// **'برای افزودن کارت، دکمه افزودن کارت جدید را کلیک کنید'**
  String get add_card_instructions;

  /// No description provided for @facilities.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات'**
  String get facilities;

  /// No description provided for @gift_card_image_not_found.
  ///
  /// In fa, this message translates to:
  /// **'تصویر کارت هدیه یافت نشد'**
  String get gift_card_image_not_found;

  /// No description provided for @place_photo_in_frame.
  ///
  /// In fa, this message translates to:
  /// **'بخش مورد نظر عکس خود را در کادر بدون رنگ قرار دهید'**
  String get place_photo_in_frame;

  /// No description provided for @select_photo_from_gallery.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب عکس از گالری'**
  String get select_photo_from_gallery;

  /// No description provided for @gift_card_text.
  ///
  /// In fa, this message translates to:
  /// **'متن کارت هدیه'**
  String get gift_card_text;

  /// No description provided for @gift_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت هدیه'**
  String get gift_card;

  /// No description provided for @write_custom_text_40char.
  ///
  /// In fa, this message translates to:
  /// **'متن دلخواهتان را بنویسید (تا ۴۰ کاراکتر)'**
  String get write_custom_text_40char;

  /// No description provided for @text_length_error_40char.
  ///
  /// In fa, this message translates to:
  /// **'متن باید بین ۳ تا ۴۰ کاراکتر باشد'**
  String get text_length_error_40char;

  /// No description provided for @choose_gift_card_design.
  ///
  /// In fa, this message translates to:
  /// **'لطفا طرح کارت هدیه را انتخاب کنید'**
  String get choose_gift_card_design;

  /// No description provided for @select_text_for_card_message.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از متن‌های پیشفرض را انتخاب کنید تا در صورت عدم موافقت بانک با متن دلخواه شما، متن پیشفرض جایگزین آن شود'**
  String get select_text_for_card_message;

  /// No description provided for @select_image_for_card_message.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از طرح‌های پیشفرض را انتخاب کنید تا در صورت عدم موافقت بانک با عکس دلخواه شما، طرح پیش‌فرض جایگزین آن شود'**
  String get select_image_for_card_message;

  /// No description provided for @default_replacement_text.
  ///
  /// In fa, this message translates to:
  /// **'متن پیش‌فرض جایگزین'**
  String get default_replacement_text;

  /// No description provided for @required_field_star.
  ///
  /// In fa, this message translates to:
  /// **'*'**
  String get required_field_star;

  /// No description provided for @select_gift_card_category.
  ///
  /// In fa, this message translates to:
  /// **'دسته‌بندی کارت هدیه را انتخاب کنید'**
  String get select_gift_card_category;

  /// No description provided for @total_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ کل'**
  String get total_amount;

  /// No description provided for @each_card_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ هر کارت'**
  String get each_card_amount;

  /// No description provided for @cards_count.
  ///
  /// In fa, this message translates to:
  /// **'تعداد کارت‌ها'**
  String get cards_count;

  /// No description provided for @card_count.
  ///
  /// In fa, this message translates to:
  /// **'تعداد کارت‌'**
  String get card_count;

  /// No description provided for @card_issuance_fee.
  ///
  /// In fa, this message translates to:
  /// **'هزینه صدور هر کارت'**
  String get card_issuance_fee;

  /// No description provided for @delivery_cost.
  ///
  /// In fa, this message translates to:
  /// **'هزینه ارسال'**
  String get delivery_cost;

  /// No description provided for @gift_card_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع کارت هدیه'**
  String get gift_card_type;

  /// No description provided for @recipient_name.
  ///
  /// In fa, this message translates to:
  /// **'نام تحویل گیرنده'**
  String get recipient_name;

  /// No description provided for @recipient_mobile.
  ///
  /// In fa, this message translates to:
  /// **'موبایل تحویل گیرنده'**
  String get recipient_mobile;

  /// No description provided for @delivery_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تحویل'**
  String get delivery_date;

  /// No description provided for @delivery_time.
  ///
  /// In fa, this message translates to:
  /// **'ساعت تحویل'**
  String get delivery_time;

  /// No description provided for @recipient_address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس تحویل گیرنده'**
  String get recipient_address;

  /// No description provided for @preview_card.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده پیش‌نمایش کارت'**
  String get preview_card;

  /// No description provided for @no_purchased_card.
  ///
  /// In fa, this message translates to:
  /// **'شما کارتی خریداری نکرده‌اید'**
  String get no_purchased_card;

  /// No description provided for @buy_gift_card.
  ///
  /// In fa, this message translates to:
  /// **'خرید کارت هدیه'**
  String get buy_gift_card;

  /// No description provided for @buy_gift_card_message.
  ///
  /// In fa, this message translates to:
  /// **'به مبالغ، {chargeAmount} ریال بابت کارمزد و {deliveryCost} ریال بابت ارسال کارت هدیه به تحویل گیرنده اضافه می‌گردد'**
  String buy_gift_card_message(String deliveryCost, String chargeAmount);

  /// No description provided for @accept_terms.
  ///
  /// In fa, this message translates to:
  /// **'توبانک را خوانده و قبول دارم'**
  String get accept_terms;

  /// No description provided for @validate_terms_warning.
  ///
  /// In fa, this message translates to:
  /// **'لطفا قوانین و مقررات را تایید کنید'**
  String get validate_terms_warning;

  /// No description provided for @gift_card_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ کارت(های) هدیه'**
  String get gift_card_amount;

  /// No description provided for @card_issuance_cost.
  ///
  /// In fa, this message translates to:
  /// **'هزینه صدور هر کارت'**
  String get card_issuance_cost;

  /// No description provided for @recipient_city.
  ///
  /// In fa, this message translates to:
  /// **'شهر تحویل گیرنده'**
  String get recipient_city;

  /// No description provided for @select_text_and_image.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب متن و تصویر'**
  String get select_text_and_image;

  /// No description provided for @review_and_confirm_selected_text_and_image.
  ///
  /// In fa, this message translates to:
  /// **'متن و تصویر انتخابی خود را بررسی و تایید نمایید'**
  String get review_and_confirm_selected_text_and_image;

  /// No description provided for @choose_desired_text_and_image.
  ///
  /// In fa, this message translates to:
  /// **'متن و تصویر مورد نظر خود را انتخاب کنید'**
  String get choose_desired_text_and_image;

  /// No description provided for @your_desired_image.
  ///
  /// In fa, this message translates to:
  /// **'تصویر مورد نظر شما'**
  String get your_desired_image;

  /// No description provided for @i_am_reciever.
  ///
  /// In fa, this message translates to:
  /// **'گیرنده خودم هستم'**
  String get i_am_reciever;

  /// No description provided for @name_and_last_name.
  ///
  /// In fa, this message translates to:
  /// **'نام و نام‌خانوادگی'**
  String get name_and_last_name;

  /// No description provided for @enter_name_and_last_name.
  ///
  /// In fa, this message translates to:
  /// **'نام و نام‌خانوادگی را وارد کنید'**
  String get enter_name_and_last_name;

  /// No description provided for @enter_the_value_of_name_and_last_name.
  ///
  /// In fa, this message translates to:
  /// **'مقدار نام و نام‌خانوادگی را وارد نمایید'**
  String get enter_the_value_of_name_and_last_name;

  /// No description provided for @reciver_mobile.
  ///
  /// In fa, this message translates to:
  /// **'شماره همراه گیرنده'**
  String get reciver_mobile;

  /// No description provided for @enter_reciver_mobile.
  ///
  /// In fa, this message translates to:
  /// **'تلفن همراه تحویل گیرنده را وارد کنید'**
  String get enter_reciver_mobile;

  /// No description provided for @enter_value_mobile.
  ///
  /// In fa, this message translates to:
  /// **'مقدار تلفن همراه را وارد کنید'**
  String get enter_value_mobile;

  /// No description provided for @reciver_postal_address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس پستی گیرنده'**
  String get reciver_postal_address;

  /// No description provided for @enter_postal_address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس پستی را وارد کنید'**
  String get enter_postal_address;

  /// No description provided for @enter_postal_address_value.
  ///
  /// In fa, this message translates to:
  /// **'مقدار آدرس پستی را وارد کنید'**
  String get enter_postal_address_value;

  /// No description provided for @select_gift_card_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ کارت هدیه را وارد یا انتخاب نمایید'**
  String get select_gift_card_amount;

  /// No description provided for @add_card_with_new_amount.
  ///
  /// In fa, this message translates to:
  /// **'افزودن کارت با مبلغ جدید'**
  String get add_card_with_new_amount;

  /// No description provided for @gift_card_amount_to_rial.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ کارت هدیه را به ریال وارد نمایید'**
  String get gift_card_amount_to_rial;

  /// No description provided for @select_gift_delivery_date.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ و بازه‌زمانی تحویل هدیه را انتخاب کنید'**
  String get select_gift_delivery_date;

  /// No description provided for @delivery_time_range.
  ///
  /// In fa, this message translates to:
  /// **'محدوده ساعتی تحویل'**
  String get delivery_time_range;

  /// No description provided for @no_date_selected.
  ///
  /// In fa, this message translates to:
  /// **'تاریخی انتخاب نشده است'**
  String get no_date_selected;

  /// No description provided for @no_time_available_for_date.
  ///
  /// In fa, this message translates to:
  /// **'برای این تاریخ زمانی در دسترس نیست'**
  String get no_time_available_for_date;

  /// No description provided for @custom_design.
  ///
  /// In fa, this message translates to:
  /// **'طرح سفارشی'**
  String get custom_design;

  /// No description provided for @honar_ticket.
  ///
  /// In fa, this message translates to:
  /// **'هنر تیکت'**
  String get honar_ticket;

  /// No description provided for @no_packages_found_with_selected_filter.
  ///
  /// In fa, this message translates to:
  /// **'با فیلتر انتخاب شده، بسته‌ای یافت نشد'**
  String get no_packages_found_with_selected_filter;

  /// No description provided for @cell_phone_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن همراه'**
  String get cell_phone_number;

  /// No description provided for @enter_valid_cell_phone.
  ///
  /// In fa, this message translates to:
  /// **'یک شماره تلفن معتبر وارد نمایید'**
  String get enter_valid_cell_phone;

  /// No description provided for @save_sim_card_number.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره شماره سیم‌کارت'**
  String get save_sim_card_number;

  /// No description provided for @amount_including_tax.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ با احتساب مالیات'**
  String get amount_including_tax;

  /// No description provided for @total_points.
  ///
  /// In fa, this message translates to:
  /// **'امتیاز کل شما'**
  String get total_points;

  /// No description provided for @point.
  ///
  /// In fa, this message translates to:
  /// **'امتیاز'**
  String get point;

  /// No description provided for @points_spent.
  ///
  /// In fa, this message translates to:
  /// **'امتیاز مصرفی'**
  String get points_spent;

  /// No description provided for @discount_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تخفیف'**
  String get discount_amount;

  /// No description provided for @use_club_discount.
  ///
  /// In fa, this message translates to:
  /// **'استفاده از تخفیف باشگاه'**
  String get use_club_discount;

  /// No description provided for @select_operator.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب اپراتور'**
  String get select_operator;

  /// No description provided for @porting_operator_instruction.
  ///
  /// In fa, this message translates to:
  /// **'در صورت ترابرد سیم‌کارت، اپراتور خود را انتخاب نمایید'**
  String get porting_operator_instruction;

  /// No description provided for @sim_card_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع سیم‌کارت'**
  String get sim_card_type;

  /// No description provided for @internet_package.
  ///
  /// In fa, this message translates to:
  /// **'بسته اینترنتی'**
  String get internet_package;

  /// No description provided for @internet_package_name.
  ///
  /// In fa, this message translates to:
  /// **'بسته اینترنت'**
  String get internet_package_name;

  /// No description provided for @intro_1_title_manage_card.
  ///
  /// In fa, this message translates to:
  /// **'صدور و مدیریت انواع کارت'**
  String get intro_1_title_manage_card;

  /// No description provided for @intro_1_description_manage_card.
  ///
  /// In fa, this message translates to:
  /// **'بدون نیاز به حضور شما و ضامن در شعب، تسهیلات، کارت هدیه و کارت اعتباری مورد نظر خود را دریافت کنید.'**
  String get intro_1_description_manage_card;

  /// No description provided for @intro_2_title_open_deposit.
  ///
  /// In fa, this message translates to:
  /// **'افتتاح انواع سپرده آنلاین'**
  String get intro_2_title_open_deposit;

  /// No description provided for @intro_2_description_open_deposit.
  ///
  /// In fa, this message translates to:
  /// **'در منزل یا محل کار، فقط با بارگذاری مدارک شناسایی خود در دو مرحله، احراز هویت و افتتاح سپرده دلخواه خود را انجام دهید.'**
  String get intro_2_description_open_deposit;

  /// No description provided for @intro_3_title_internet_bank.
  ///
  /// In fa, this message translates to:
  /// **'مدیریت همراه بانک و اینترنت بانک'**
  String get intro_3_title_internet_bank;

  /// No description provided for @intro_3_description_internet_bank.
  ///
  /// In fa, this message translates to:
  /// **'برای دریافت نام کاربری و رمز عبور همراه بانک و اینترنت بانک، نیازی به مراجعه حضوری ندارید.'**
  String get intro_3_description_internet_bank;

  /// No description provided for @intro_4_title_virtual_branch.
  ///
  /// In fa, this message translates to:
  /// **'شعبه مجازی بانک گردشگری'**
  String get intro_4_title_virtual_branch;

  /// No description provided for @intro_4_description_virtual_branch.
  ///
  /// In fa, this message translates to:
  /// **'توبانک، شعبه مجازی بانک گردشگری است. کلیه امور بانکی خود را در هر مکان و زمان به صورت آنلاین انجام دهید.'**
  String get intro_4_description_virtual_branch;

  /// No description provided for @start_button_text.
  ///
  /// In fa, this message translates to:
  /// **'شروع'**
  String get start_button_text;

  /// No description provided for @bill.
  ///
  /// In fa, this message translates to:
  /// **'قبض'**
  String get bill;

  /// No description provided for @you_have_not_registered_receipt.
  ///
  /// In fa, this message translates to:
  /// **'شما هنوز قبضی ثبت نکرده‌اید'**
  String get you_have_not_registered_receipt;

  /// No description provided for @add_new_bill.
  ///
  /// In fa, this message translates to:
  /// **'افزودن قبض جدید'**
  String get add_new_bill;

  /// No description provided for @bill_payment_title_water_electric.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت قبض آب یا برق'**
  String get bill_payment_title_water_electric;

  /// No description provided for @bill_id_label.
  ///
  /// In fa, this message translates to:
  /// **'شناسه قبض'**
  String get bill_id_label;

  /// No description provided for @bill_id_hint.
  ///
  /// In fa, this message translates to:
  /// **'شناسه قبض را وارد کنید'**
  String get bill_id_hint;

  /// No description provided for @bill_name_label.
  ///
  /// In fa, this message translates to:
  /// **'نام قبض'**
  String get bill_name_label;

  /// No description provided for @bill_name_hint.
  ///
  /// In fa, this message translates to:
  /// **'نام قبض خود را وارد کنید'**
  String get bill_name_hint;

  /// No description provided for @bill_name_error.
  ///
  /// In fa, this message translates to:
  /// **'نامی برای قبض خود انتخاب کنید'**
  String get bill_name_error;

  /// No description provided for @save_bill_text.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره قبض'**
  String get save_bill_text;

  /// No description provided for @midterm.
  ///
  /// In fa, this message translates to:
  /// **'میان‌دوره'**
  String get midterm;

  /// No description provided for @endterm.
  ///
  /// In fa, this message translates to:
  /// **'پایان‌دوره'**
  String get endterm;

  /// No description provided for @bill_operations_tooltip.
  ///
  /// In fa, this message translates to:
  /// **'عملیات قبض'**
  String get bill_operations_tooltip;

  /// No description provided for @bill_edit_option.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش قبض'**
  String get bill_edit_option;

  /// No description provided for @bill_delete_option.
  ///
  /// In fa, this message translates to:
  /// **'حذف قبض'**
  String get bill_delete_option;

  /// No description provided for @gas_bill_title.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت قبض گاز'**
  String get gas_bill_title;

  /// No description provided for @subscription_number_label.
  ///
  /// In fa, this message translates to:
  /// **'شماره اشتراک'**
  String get subscription_number_label;

  /// No description provided for @subscription_number_hint.
  ///
  /// In fa, this message translates to:
  /// **'شماره اشتراک را وارد کنید'**
  String get subscription_number_hint;

  /// No description provided for @subscription_number_error.
  ///
  /// In fa, this message translates to:
  /// **'شماره اشتراک معتبر وارد نمایید'**
  String get subscription_number_error;

  /// No description provided for @title_bill.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات قبض'**
  String get title_bill;

  /// No description provided for @bill_title_label.
  ///
  /// In fa, this message translates to:
  /// **'عنوان قبض'**
  String get bill_title_label;

  /// No description provided for @enter_bill_title_hint.
  ///
  /// In fa, this message translates to:
  /// **'عنوان قبض را وارد کنید'**
  String get enter_bill_title_hint;

  /// No description provided for @edit_bill.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش قبض'**
  String get edit_bill;

  /// No description provided for @pay_id.
  ///
  /// In fa, this message translates to:
  /// **'شناسه پرداخت'**
  String get pay_id;

  /// No description provided for @pay_bill_with_pay_id.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت قبض با شناسه پرداخت'**
  String get pay_bill_with_pay_id;

  /// No description provided for @loading.
  ///
  /// In fa, this message translates to:
  /// **'در حال بارگذاری'**
  String get loading;

  /// No description provided for @pay_id_label.
  ///
  /// In fa, this message translates to:
  /// **'شناسه پرداخت'**
  String get pay_id_label;

  /// No description provided for @pay_id_hint.
  ///
  /// In fa, this message translates to:
  /// **'شناسه پرداخت را وارد کنید'**
  String get pay_id_hint;

  /// No description provided for @scan_barcode_bill.
  ///
  /// In fa, this message translates to:
  /// **'اسکن بارکد قبض'**
  String get scan_barcode_bill;

  /// No description provided for @inquiry_bill.
  ///
  /// In fa, this message translates to:
  /// **'استعلام قبض'**
  String get inquiry_bill;

  /// No description provided for @invalid_pay_id.
  ///
  /// In fa, this message translates to:
  /// **'شناسه پرداخت معتبر وارد نمایید'**
  String get invalid_pay_id;

  /// No description provided for @button_title.
  ///
  /// In fa, this message translates to:
  /// **'اسکن بارکد قبض'**
  String get button_title;

  /// No description provided for @invalid_bill_id.
  ///
  /// In fa, this message translates to:
  /// **'شناسه قبض معتبر وارد نمایید'**
  String get invalid_bill_id;

  /// No description provided for @mobile_and_landline_payment.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت موبایل و تلفن ثابت'**
  String get mobile_and_landline_payment;

  /// No description provided for @phone_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن'**
  String get phone_number;

  /// No description provided for @phone_number_hint.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن را وارد کنید'**
  String get phone_number_hint;

  /// No description provided for @phone_number_error.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن معتبر وارد نمایید'**
  String get phone_number_error;

  /// No description provided for @bill_name.
  ///
  /// In fa, this message translates to:
  /// **'نام قبض'**
  String get bill_name;

  /// No description provided for @bill_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع قبض'**
  String get bill_type;

  /// No description provided for @bill_inquiry_payment_title.
  ///
  /// In fa, this message translates to:
  /// **'استعلام و پرداخت انواع قبض'**
  String get bill_inquiry_payment_title;

  /// No description provided for @bill_selection_instruction.
  ///
  /// In fa, this message translates to:
  /// **'نوع قبض را انتخاب کنید یا از طریق شناسه پرداخت اقدام نمایید'**
  String get bill_selection_instruction;

  /// No description provided for @pay_bill_.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت قبض'**
  String get pay_bill_;

  /// No description provided for @iran_tic.
  ///
  /// In fa, this message translates to:
  /// **'ایران تیک'**
  String get iran_tic;

  /// No description provided for @iran_concert.
  ///
  /// In fa, this message translates to:
  /// **'ایران کنسرت'**
  String get iran_concert;

  /// No description provided for @forgot_password.
  ///
  /// In fa, this message translates to:
  /// **'فراموشی رمز عبور'**
  String get forgot_password;

  /// No description provided for @login_to_tobank.
  ///
  /// In fa, this message translates to:
  /// **'ورود به توبانک'**
  String get login_to_tobank;

  /// No description provided for @new_version_available.
  ///
  /// In fa, this message translates to:
  /// **'نسخه جدید اپلیکیشن توبانک در دسترس است'**
  String get new_version_available;

  /// No description provided for @force_update_message.
  ///
  /// In fa, this message translates to:
  /// **'برای استفاده از برنامه حتما باید به‌روزرسانی انجام شود. لطفا دریافت نسخه جدید را کلیک کنید'**
  String get force_update_message;

  /// No description provided for @travel_services.
  ///
  /// In fa, this message translates to:
  /// **'خدمات سفر'**
  String get travel_services;

  /// No description provided for @no_notifications.
  ///
  /// In fa, this message translates to:
  /// **'در حال حاضر اعلانی در این بخش برای شما وجود ندارد'**
  String get no_notifications;

  /// No description provided for @notifications_title.
  ///
  /// In fa, this message translates to:
  /// **'اعلان‌ها'**
  String get notifications_title;

  /// No description provided for @public_notifications.
  ///
  /// In fa, this message translates to:
  /// **'اعلان‌های عمومی'**
  String get public_notifications;

  /// No description provided for @updates.
  ///
  /// In fa, this message translates to:
  /// **'به‌روزرسانی‌ها'**
  String get updates;

  /// No description provided for @saayad_id_title.
  ///
  /// In fa, this message translates to:
  /// **'شناسه صیاد'**
  String get saayad_id_title;

  /// No description provided for @saayad_cheque_id_hint.
  ///
  /// In fa, this message translates to:
  /// **'شناسه صیاد چک را وارد کنید'**
  String get saayad_cheque_id_hint;

  /// No description provided for @saayad_id_error.
  ///
  /// In fa, this message translates to:
  /// **'شناسه صیاد معتبر وارد نمایید'**
  String get saayad_id_error;

  /// No description provided for @enter_saayad_id.
  ///
  /// In fa, this message translates to:
  /// **'شناسه صیاد چک را وارد نمایید'**
  String get enter_saayad_id;

  /// No description provided for @more_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات بیشتر'**
  String get more_information;

  /// No description provided for @inquiry_details.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات استعلام'**
  String get inquiry_details;

  /// No description provided for @bank_code_title.
  ///
  /// In fa, this message translates to:
  /// **'کد بانک'**
  String get bank_code_title;

  /// No description provided for @bank_name_title.
  ///
  /// In fa, this message translates to:
  /// **'نام بانک'**
  String get bank_name_title;

  /// No description provided for @branch_code_title.
  ///
  /// In fa, this message translates to:
  /// **'کد شعبه'**
  String get branch_code_title;

  /// No description provided for @cheque_owner_title.
  ///
  /// In fa, this message translates to:
  /// **'صاحب(صاحبان) چک'**
  String get cheque_owner_title;

  /// No description provided for @check_status_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنما رنگ وضعیت‌ها'**
  String get check_status_guide;

  /// No description provided for @status_white.
  ///
  /// In fa, this message translates to:
  /// **'سفید'**
  String get status_white;

  /// No description provided for @status_yellow.
  ///
  /// In fa, this message translates to:
  /// **'زرد'**
  String get status_yellow;

  /// No description provided for @status_orange.
  ///
  /// In fa, this message translates to:
  /// **'نارنجی'**
  String get status_orange;

  /// No description provided for @status_brown.
  ///
  /// In fa, this message translates to:
  /// **'قهوه‌ای'**
  String get status_brown;

  /// No description provided for @status_red.
  ///
  /// In fa, this message translates to:
  /// **'قرمز'**
  String get status_red;

  /// No description provided for @returned_cheques_count_label.
  ///
  /// In fa, this message translates to:
  /// **'تعداد چک‌های برگشتی'**
  String get returned_cheques_count_label;

  /// No description provided for @last_update_label.
  ///
  /// In fa, this message translates to:
  /// **'آخرین به‌روزرسانی'**
  String get last_update_label;

  /// No description provided for @cheque_issuer_credit_inquiry.
  ///
  /// In fa, this message translates to:
  /// **'استعلام اعتبار صادرکننده چک'**
  String get cheque_issuer_credit_inquiry;

  /// No description provided for @status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get status;

  /// No description provided for @cheque_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت چک'**
  String get cheque_status;

  /// No description provided for @guarantee_status.
  ///
  /// In fa, this message translates to:
  /// **'ضمانت چک'**
  String get guarantee_status;

  /// No description provided for @block_status.
  ///
  /// In fa, this message translates to:
  /// **'مسدودی چک'**
  String get block_status;

  /// No description provided for @iban_attached_to_cheque.
  ///
  /// In fa, this message translates to:
  /// **'شبا متصل به چک'**
  String get iban_attached_to_cheque;

  /// No description provided for @bank_and_branch_code.
  ///
  /// In fa, this message translates to:
  /// **'بانک و کد شعبه'**
  String get bank_and_branch_code;

  /// No description provided for @due_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ سررسید'**
  String get due_date;

  /// No description provided for @image_of_retirement.
  ///
  /// In fa, this message translates to:
  /// **'تصویر حکم بازنشستگی'**
  String get image_of_retirement;

  /// No description provided for @cheque_description.
  ///
  /// In fa, this message translates to:
  /// **'شرح چک'**
  String get cheque_description;

  /// No description provided for @please_select_reason.
  ///
  /// In fa, this message translates to:
  /// **'لطفا حداقل یک دلیل انتخاب کنید'**
  String get please_select_reason;

  /// No description provided for @cheque_receiver.
  ///
  /// In fa, this message translates to:
  /// **'گیرنده(گیرندگان) چک'**
  String get cheque_receiver;

  /// No description provided for @reasons_should_not_transferred_message.
  ///
  /// In fa, this message translates to:
  /// **'یک یا چند دلیل برای عدم انتقال چک به شخص ثالث را انتخاب نمایید. این دلایل برای آن شخص ارسال خواهد شد'**
  String get reasons_should_not_transferred_message;

  /// No description provided for @reject_cheque.
  ///
  /// In fa, this message translates to:
  /// **'رد چک'**
  String get reject_cheque;

  /// No description provided for @confirm_cheque_receive.
  ///
  /// In fa, this message translates to:
  /// **'تایید دریافت چک'**
  String get confirm_cheque_receive;

  /// No description provided for @cheque_confirmation_success.
  ///
  /// In fa, this message translates to:
  /// **'چک با موفقیت تایید شد'**
  String get cheque_confirmation_success;

  /// No description provided for @cheque_confirmation_failed.
  ///
  /// In fa, this message translates to:
  /// **'چک با موفقیت رد شد'**
  String get cheque_confirmation_failed;

  /// No description provided for @tracking_id.
  ///
  /// In fa, this message translates to:
  /// **'شناسه پیگیری'**
  String get tracking_id;

  /// No description provided for @request_registration_time.
  ///
  /// In fa, this message translates to:
  /// **'زمان ثبت درخواست'**
  String get request_registration_time;

  /// No description provided for @request_registration_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت ثبت درخواست'**
  String get request_registration_status;

  /// No description provided for @request_status_success.
  ///
  /// In fa, this message translates to:
  /// **'موفق'**
  String get request_status_success;

  /// No description provided for @request_status_failed.
  ///
  /// In fa, this message translates to:
  /// **'ناموفق'**
  String get request_status_failed;

  /// No description provided for @request_id.
  ///
  /// In fa, this message translates to:
  /// **'شناسه درخواست'**
  String get request_id;

  /// No description provided for @zero.
  ///
  /// In fa, this message translates to:
  /// **'صفر'**
  String get zero;

  /// No description provided for @sure_to_exite.
  ///
  /// In fa, this message translates to:
  /// **'آیا مطمئن به خروج از برنامه هستید؟'**
  String get sure_to_exite;

  /// No description provided for @register_card_in_shapark_title.
  ///
  /// In fa, this message translates to:
  /// **'ثبت کارت در شاپرک'**
  String get register_card_in_shapark_title;

  /// No description provided for @shaparak_attention_text.
  ///
  /// In fa, this message translates to:
  /// **'با توجه به قانون جدید بانک مرکزی، به منظور حفظ امنیت بیشتر اطلاعات کارت شما، لازم است ابتدا کارت خود را در سامانه شاپرک ثبت کنید.\nبعد از ثبت می‌توانید به برنامه برگردید و تراکنش را ادامه دهید.'**
  String get shaparak_attention_text;

  /// No description provided for @bank_card_label.
  ///
  /// In fa, this message translates to:
  /// **'کارت بانکی'**
  String get bank_card_label;

  /// No description provided for @less_then_16_digit.
  ///
  /// In fa, this message translates to:
  /// **'طول عدد باید کمتر از 16 رقم باشد.'**
  String get less_then_16_digit;

  /// No description provided for @card_placeholder.
  ///
  /// In fa, this message translates to:
  /// **'**** - **** - ***** - ****'**
  String get card_placeholder;

  /// No description provided for @invalid_card_number_error.
  ///
  /// In fa, this message translates to:
  /// **'یک کارت بانکی انتخاب نمایید'**
  String get invalid_card_number_error;

  /// No description provided for @attention.
  ///
  /// In fa, this message translates to:
  /// **'توجه'**
  String get attention;

  /// No description provided for @turn_off_vpn.
  ///
  /// In fa, this message translates to:
  /// **'جهت استفاده از امکانات برنامه VPN خود را خاموش کنید'**
  String get turn_off_vpn;

  /// No description provided for @select_card.
  ///
  /// In fa, this message translates to:
  /// **'یک کارت انتخاب کنید'**
  String get select_card;

  /// No description provided for @pay_continue.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت و ادامه'**
  String get pay_continue;

  /// No description provided for @inventory_transaction.
  ///
  /// In fa, this message translates to:
  /// **'تراکنش موجودی'**
  String get inventory_transaction;

  /// No description provided for @cheque_inquiry_details.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات استعلام چک'**
  String get cheque_inquiry_details;

  /// No description provided for @cheque_series.
  ///
  /// In fa, this message translates to:
  /// **'سری چک'**
  String get cheque_series;

  /// No description provided for @cheque_serial.
  ///
  /// In fa, this message translates to:
  /// **'سریال چک'**
  String get cheque_serial;

  /// No description provided for @wrong_entry_format.
  ///
  /// In fa, this message translates to:
  /// **'فرمت ورودی اشتباه است.'**
  String get wrong_entry_format;

  /// No description provided for @currency_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع ارز'**
  String get currency_type;

  /// No description provided for @cheque_owners.
  ///
  /// In fa, this message translates to:
  /// **'صاحبان چک'**
  String get cheque_owners;

  /// No description provided for @cheque_endorsers.
  ///
  /// In fa, this message translates to:
  /// **'امضاداران چک'**
  String get cheque_endorsers;

  /// No description provided for @physical_cheque_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع فیزیک چک'**
  String get physical_cheque_type;

  /// No description provided for @paper_cheque.
  ///
  /// In fa, this message translates to:
  /// **'کاغذی'**
  String get paper_cheque;

  /// No description provided for @cheque_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع چک'**
  String get cheque_type;

  /// No description provided for @cheque_type_selection_instruction.
  ///
  /// In fa, this message translates to:
  /// **'نوع چک را از لیست انتخاب کنید'**
  String get cheque_type_selection_instruction;

  /// No description provided for @cheque_inquiry.
  ///
  /// In fa, this message translates to:
  /// **'استعلام چک'**
  String get cheque_inquiry;

  /// No description provided for @cheque_and_recivers_details.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات چک و گیرندگان'**
  String get cheque_and_recivers_details;

  /// No description provided for @cheque_recivers.
  ///
  /// In fa, this message translates to:
  /// **'گیرندگان چک'**
  String get cheque_recivers;

  /// No description provided for @final_cheque_registration.
  ///
  /// In fa, this message translates to:
  /// **'ثبت نهایی چک'**
  String get final_cheque_registration;

  /// No description provided for @cheque_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ چک'**
  String get cheque_amount;

  /// No description provided for @enter_cheque_amount_in_rials.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ چک را به ریال وارد کنید'**
  String get enter_cheque_amount_in_rials;

  /// No description provided for @cheque_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ چک'**
  String get cheque_date;

  /// No description provided for @trillion_and.
  ///
  /// In fa, this message translates to:
  /// **'تریلیون و '**
  String get trillion_and;

  /// No description provided for @trillion.
  ///
  /// In fa, this message translates to:
  /// **'تریلیون'**
  String get trillion;

  /// No description provided for @billion_and.
  ///
  /// In fa, this message translates to:
  /// **'میلیارد و '**
  String get billion_and;

  /// No description provided for @million_and.
  ///
  /// In fa, this message translates to:
  /// **'میلیون و '**
  String get million_and;

  /// No description provided for @thousand_and.
  ///
  /// In fa, this message translates to:
  /// **'هزار و '**
  String get thousand_and;

  /// No description provided for @select_cheque_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ چک را انتخاب کنید'**
  String get select_cheque_date;

  /// No description provided for @valid_cheque_date_error.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ معتبر انتخاب کنید'**
  String get valid_cheque_date_error;

  /// No description provided for @select_reason_type.
  ///
  /// In fa, this message translates to:
  /// **'بابت را انتخاب کنید'**
  String get select_reason_type;

  /// No description provided for @enter_cheque_description.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات چک را وارد کنید'**
  String get enter_cheque_description;

  /// No description provided for @cheque_description_error.
  ///
  /// In fa, this message translates to:
  /// **'شرح چک را وارد کنید'**
  String get cheque_description_error;

  /// No description provided for @add_cheque_receiver.
  ///
  /// In fa, this message translates to:
  /// **'افزودن گیرنده چک'**
  String get add_cheque_receiver;

  /// No description provided for @reason_type_note.
  ///
  /// In fa, this message translates to:
  /// **'بابت (اجباری برای مبالغ بالای یک میلیارد ریال)'**
  String get reason_type_note;

  /// No description provided for @cheque_success.
  ///
  /// In fa, this message translates to:
  /// **'چک با موفقیت ثبت شد'**
  String get cheque_success;

  /// No description provided for @register_successfully.
  ///
  /// In fa, this message translates to:
  /// **'با موفقیت ثبت شد.'**
  String get register_successfully;

  /// No description provided for @cheque_failure.
  ///
  /// In fa, this message translates to:
  /// **'چک ثبت نشد'**
  String get cheque_failure;

  /// No description provided for @identity_verification_title.
  ///
  /// In fa, this message translates to:
  /// **'تایید اطلاعات هویتی'**
  String get identity_verification_title;

  /// No description provided for @identity_verification_description.
  ///
  /// In fa, this message translates to:
  /// **'طبق دستور بانک مرکزی، جهت تایید اطلاعات هویتی می‌بایست از طریق یکی از کارت‌های بانکی خود، تراکنش‎ موجودی به مبلغ کارمزد ۱۴۴۰ ریال انجام دهید.\r\nبعد از این تراکنش ۳۰ دقیقه فرصت دارید تا اقدام به ثبت، انتقال و دریافت چک‌ها کنید. بعد از این زمان دوباره به این صفحه برای انجام تراکنش مجدد هدایت خواهید شد.'**
  String get identity_verification_description;

  /// No description provided for @add_reciver.
  ///
  /// In fa, this message translates to:
  /// **'افزودن گیرنده'**
  String get add_reciver;

  /// No description provided for @valued_copied.
  ///
  /// In fa, this message translates to:
  /// **'مقدار کپی شد'**
  String get valued_copied;

  /// No description provided for @recipient_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع گیرنده'**
  String get recipient_type;

  /// No description provided for @floor_label.
  ///
  /// In fa, this message translates to:
  /// **'طبقه'**
  String get floor_label;

  /// No description provided for @floor_hint.
  ///
  /// In fa, this message translates to:
  /// **'طبقه خود را وارد کنید'**
  String get floor_hint;

  /// No description provided for @floor_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار طبقه را وارد کنید'**
  String get floor_error;

  /// No description provided for @recipient_national_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی گیرنده را وارد کنید'**
  String get recipient_national_code_hint;

  /// No description provided for @national_code_title.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی'**
  String get national_code_title;

  /// No description provided for @recipient_national_id_hint.
  ///
  /// In fa, this message translates to:
  /// **'شناسه ملی گیرنده را وارد کنید'**
  String get recipient_national_id_hint;

  /// No description provided for @recipient_national_id_title.
  ///
  /// In fa, this message translates to:
  /// **'شناسه ملی'**
  String get recipient_national_id_title;

  /// No description provided for @recipient_foreigner_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد فراگیر گیرنده را وارد کنید'**
  String get recipient_foreigner_code_hint;

  /// No description provided for @recipient_foreigner_code_title.
  ///
  /// In fa, this message translates to:
  /// **'کد فراگیر'**
  String get recipient_foreigner_code_title;

  /// No description provided for @register_cheque.
  ///
  /// In fa, this message translates to:
  /// **'ثبت چک'**
  String get register_cheque;

  /// No description provided for @cheque_owner_name.
  ///
  /// In fa, this message translates to:
  /// **'نام صاحب فعلی چک'**
  String get cheque_owner_name;

  /// No description provided for @saayadi_cheque.
  ///
  /// In fa, this message translates to:
  /// **'چک صیادی'**
  String get saayadi_cheque;

  /// No description provided for @cheque_owner_national_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره ملی صاحب فعلی چک'**
  String get cheque_owner_national_number;

  /// No description provided for @return_to_saayadi_system.
  ///
  /// In fa, this message translates to:
  /// **'بازگشت به سامانه چک صیادی'**
  String get return_to_saayadi_system;

  /// No description provided for @issued_cheques_inquiry.
  ///
  /// In fa, this message translates to:
  /// **'استعلام چک‌های صادر شده'**
  String get issued_cheques_inquiry;

  /// No description provided for @final_cheque_transfer.
  ///
  /// In fa, this message translates to:
  /// **'انتقال نهایی چک'**
  String get final_cheque_transfer;

  /// No description provided for @cheque_type_normal.
  ///
  /// In fa, this message translates to:
  /// **'عادی'**
  String get cheque_type_normal;

  /// No description provided for @cheque_type_bank.
  ///
  /// In fa, this message translates to:
  /// **'بانکی'**
  String get cheque_type_bank;

  /// No description provided for @cheque_type_secure.
  ///
  /// In fa, this message translates to:
  /// **'رمزدار'**
  String get cheque_type_secure;

  /// No description provided for @cheque_media_physical.
  ///
  /// In fa, this message translates to:
  /// **'کاغذی'**
  String get cheque_media_physical;

  /// No description provided for @cheque_media_digital.
  ///
  /// In fa, this message translates to:
  /// **'دیجیتال'**
  String get cheque_media_digital;

  /// No description provided for @current_cheque_owners.
  ///
  /// In fa, this message translates to:
  /// **'صاحب(صاحبین) فعلی چک'**
  String get current_cheque_owners;

  /// No description provided for @new_cheque_recipients.
  ///
  /// In fa, this message translates to:
  /// **'دریافت‌کنندگان جدید چک'**
  String get new_cheque_recipients;

  /// No description provided for @physical_type_of_cheque.
  ///
  /// In fa, this message translates to:
  /// **'نوع فیزیکی چک'**
  String get physical_type_of_cheque;

  /// No description provided for @add_new_cheque_recipient.
  ///
  /// In fa, this message translates to:
  /// **'افزودن گیرنده جدید چک'**
  String get add_new_cheque_recipient;

  /// No description provided for @cheque_successfully_transferred.
  ///
  /// In fa, this message translates to:
  /// **'چک با موفقیت منتقل شد'**
  String get cheque_successfully_transferred;

  /// No description provided for @cheque_successfully_transferred_reversal.
  ///
  /// In fa, this message translates to:
  /// **'چک با موفقیت عودت داده شد'**
  String get cheque_successfully_transferred_reversal;

  /// No description provided for @request_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت ثبت درخواست'**
  String get request_status;

  /// No description provided for @request_submit.
  ///
  /// In fa, this message translates to:
  /// **'ثبت درخواست'**
  String get request_submit;

  /// No description provided for @unsuccessful.
  ///
  /// In fa, this message translates to:
  /// **'ناموفق'**
  String get unsuccessful;

  /// No description provided for @cheque_transfer.
  ///
  /// In fa, this message translates to:
  /// **'انتقال چک'**
  String get cheque_transfer;

  /// No description provided for @cheque_transfer_reversal.
  ///
  /// In fa, this message translates to:
  /// **'عودت چک'**
  String get cheque_transfer_reversal;

  /// No description provided for @cheque_holders.
  ///
  /// In fa, this message translates to:
  /// **'دارندگان چک'**
  String get cheque_holders;

  /// No description provided for @transfer_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت انتقال'**
  String get transfer_status;

  /// No description provided for @last_change_status.
  ///
  /// In fa, this message translates to:
  /// **'آخرین تغییر وضعیت'**
  String get last_change_status;

  /// No description provided for @cheque_status_inquiry_title.
  ///
  /// In fa, this message translates to:
  /// **'استعلام وضعیت انتقال چک'**
  String get cheque_status_inquiry_title;

  /// No description provided for @guide_register_code_title.
  ///
  /// In fa, this message translates to:
  /// **'راهنما ثبت شناسه'**
  String get guide_register_code_title;

  /// No description provided for @guide_scan_barcode_title.
  ///
  /// In fa, this message translates to:
  /// **'راهنما اسکن بارکد'**
  String get guide_scan_barcode_title;

  /// No description provided for @central_bank_notice_title.
  ///
  /// In fa, this message translates to:
  /// **'ابلاغیه بانک مرکزی'**
  String get central_bank_notice_title;

  /// No description provided for @beneficiary_residence_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات محل سکونت مشمول'**
  String get beneficiary_residence_info;

  /// No description provided for @beneficiary_inductee_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی محل سکونت مشمول'**
  String get beneficiary_inductee_postal_code;

  /// No description provided for @central_bank_notice_content.
  ///
  /// In fa, this message translates to:
  /// **'از تاریخ ۲۱ آذر ۱۳۹۹ بانک‌ها طبق ابلاغ بانک مرکزی مکلفند چک‌هایی راکه از تاریخ یادشده به مشتری تخصیص می‌دهند، پس از استعلام از سامانه چک صیادی و اطمینان از ثبت و عدم مغایرت مشخصات فیزیک چک با اطلاعات ثبت شده در سامانه یادشده، کارسازی کنند. بدیهی است در ثبت اطلاعات خود دقت کافی را به عمل بیاورید'**
  String get central_bank_notice_content;

  /// No description provided for @services_of_issuer_title.
  ///
  /// In fa, this message translates to:
  /// **'خدمات صادرکننده چک'**
  String get services_of_issuer_title;

  /// No description provided for @services_of_receiver_title.
  ///
  /// In fa, this message translates to:
  /// **'خدمات دریافت‌کننده چک'**
  String get services_of_receiver_title;

  /// No description provided for @system_pichak.
  ///
  /// In fa, this message translates to:
  /// **'سامانه پیچک'**
  String get system_pichak;

  /// No description provided for @pichak.
  ///
  /// In fa, this message translates to:
  /// **'پیچک'**
  String get pichak;

  /// No description provided for @scan_barcode.
  ///
  /// In fa, this message translates to:
  /// **'قسمت بارکد را اسکن کنید'**
  String get scan_barcode;

  /// No description provided for @test_sign_plugin.
  ///
  /// In fa, this message translates to:
  /// **'تست پلاگین ساین'**
  String get test_sign_plugin;

  /// No description provided for @generate_key.
  ///
  /// In fa, this message translates to:
  /// **'تولید کلید'**
  String get generate_key;

  /// No description provided for @check_key_existence.
  ///
  /// In fa, this message translates to:
  /// **'تست موجود بودن کلید'**
  String get check_key_existence;

  /// No description provided for @sign_text.
  ///
  /// In fa, this message translates to:
  /// **'ساین کردن'**
  String get sign_text;

  /// No description provided for @verify_signature.
  ///
  /// In fa, this message translates to:
  /// **'وریفای کردن ساین'**
  String get verify_signature;

  /// No description provided for @sign_bytes.
  ///
  /// In fa, this message translates to:
  /// **'ساین بایت'**
  String get sign_bytes;

  /// No description provided for @verify_signature_bytes.
  ///
  /// In fa, this message translates to:
  /// **'وریفای کردن ساین بایت'**
  String get verify_signature_bytes;

  /// No description provided for @remove_key.
  ///
  /// In fa, this message translates to:
  /// **'حذف کلید'**
  String get remove_key;

  /// No description provided for @sign_pdf.
  ///
  /// In fa, this message translates to:
  /// **'ساین پی دی اف'**
  String get sign_pdf;

  /// No description provided for @get_key.
  ///
  /// In fa, this message translates to:
  /// **'دریافت کلید'**
  String get get_key;

  /// No description provided for @user_message_delete_account.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، در صورت انتقال سیم‌کارت یا تمایل به حذف اطلاعات حساب خود می‌توانید اطلاعاتی نظیر تراکنش‌ها، کارت‌های ذخیره شده و ... را از حساب‌کاربری خود حذف کنید.'**
  String get user_message_delete_account;

  /// No description provided for @alert_message_1_move_wallet_credit.
  ///
  /// In fa, this message translates to:
  /// **'حتما قبل از حذف اطلاعات، موجودی کیف پول خود را به شماره جدید خود انتقال دهید'**
  String get alert_message_1_move_wallet_credit;

  /// No description provided for @alert_message_2_forbidden_24hrs.
  ///
  /// In fa, this message translates to:
  /// **'تا ۲۴ ساعت بعد از حذف حساب‌کاربری امکان ثبت‌نام مجدد نخواهید داشت'**
  String get alert_message_2_forbidden_24hrs;

  /// No description provided for @confirmation_text_to_delete_account.
  ///
  /// In fa, this message translates to:
  /// **'میخواهم اطلاعات حساب کاربری خود را حذف کنم.'**
  String get confirmation_text_to_delete_account;

  /// No description provided for @delete_account_title.
  ///
  /// In fa, this message translates to:
  /// **'حذف اطلاعات حساب‌کاربری'**
  String get delete_account_title;

  /// No description provided for @verification_code_label.
  ///
  /// In fa, this message translates to:
  /// **'کد تایید'**
  String get verification_code_label;

  /// No description provided for @otp_error_message.
  ///
  /// In fa, this message translates to:
  /// **'مقدار پیامک شده را وارد کنید'**
  String get otp_error_message;

  /// No description provided for @confirm_and_delete_button.
  ///
  /// In fa, this message translates to:
  /// **'تایید و حذف حساب‌کاربری'**
  String get confirm_and_delete_button;

  /// No description provided for @national_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی خود را بدون خط تیره وارد نمایید'**
  String get national_code_hint;

  /// No description provided for @national_code_error_message.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کد ملی معتبر وارد نمایید'**
  String get national_code_error_message;

  /// No description provided for @birthdate_label.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد'**
  String get birthdate_label;

  /// No description provided for @birthdate_hint.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد خود را انتخاب نمایید'**
  String get birthdate_hint;

  /// No description provided for @birthdate_error_message.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ تولد را انتخاب نمایید'**
  String get birthdate_error_message;

  /// No description provided for @confirm_information_button.
  ///
  /// In fa, this message translates to:
  /// **'بررسی تطابق اطلاعات'**
  String get confirm_information_button;

  /// No description provided for @match_information.
  ///
  /// In fa, this message translates to:
  /// **'بررسی تطابق اطلاعات'**
  String get match_information;

  /// No description provided for @match_information_.
  ///
  /// In fa, this message translates to:
  /// **'تطابق اطلاعات'**
  String get match_information_;

  /// No description provided for @validation_title.
  ///
  /// In fa, this message translates to:
  /// **'اعتبار سنجی'**
  String get validation_title;

  /// No description provided for @validation_instructions.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی؛ پیرو دستورالعمل بانک مرکزی در راستای اعتبارسنجی کاربران، شماره همراه، کد ملی و تاریخ تولد خود را بصورت صحیح وارد نمایید. لطفا شماره همراهی را وارد نمایید که مالک سیم‌کارت آن هستید.'**
  String get validation_instructions;

  /// No description provided for @mobile_number_label.
  ///
  /// In fa, this message translates to:
  /// **'شماره همراه'**
  String get mobile_number_label;

  /// No description provided for @mobile_number_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا شماره همراه معتبر وارد کنید'**
  String get mobile_number_error;

  /// No description provided for @enter_national_code_error.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی معتبر وارد نمایید'**
  String get enter_national_code_error;

  /// No description provided for @enter_applicant_national_code.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی متقاضی را وارد نمایید'**
  String get enter_applicant_national_code;

  /// No description provided for @birthdate_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ تولد خود را انتخاب نمایید'**
  String get birthdate_error;

  /// No description provided for @agree_with_rules_message.
  ///
  /// In fa, this message translates to:
  /// **'با ورود به توبانک با '**
  String get agree_with_rules_message;

  /// No description provided for @reciver_birthday_hint_text.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد دریافت‌کننده را انتخاب کنید'**
  String get reciver_birthday_hint_text;

  /// No description provided for @reciver_birthday_error_text.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ تولد دریافت‌کننده را انتخاب نمایید'**
  String get reciver_birthday_error_text;

  /// No description provided for @enter_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور را وارد نمایید'**
  String get enter_password;

  /// No description provided for @agree_suffix.
  ///
  /// In fa, this message translates to:
  /// **' آن موافق هستم'**
  String get agree_suffix;

  /// No description provided for @password_entry.
  ///
  /// In fa, this message translates to:
  /// **'ورود رمز'**
  String get password_entry;

  /// No description provided for @repeat_password_label.
  ///
  /// In fa, this message translates to:
  /// **'تکرار رمز عبور'**
  String get repeat_password_label;

  /// No description provided for @invalid_promissory_id_error.
  ///
  /// In fa, this message translates to:
  /// **'مقدار شناسه معتبری وارد نمایید'**
  String get invalid_promissory_id_error;

  /// No description provided for @repeat_password_hint.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور جدید را دوباره وارد نمایید'**
  String get repeat_password_hint;

  /// No description provided for @fingerprint_activation_message.
  ///
  /// In fa, this message translates to:
  /// **'جهت سهولت و افزایش امنیت در ورود به برنامه'**
  String get fingerprint_activation_message;

  /// No description provided for @biometric_authentication_label_ios.
  ///
  /// In fa, this message translates to:
  /// **'فعالسازی Face ID'**
  String get biometric_authentication_label_ios;

  /// No description provided for @biometric_authentication_label_android.
  ///
  /// In fa, this message translates to:
  /// **'فعالسازی اثر انگشت'**
  String get biometric_authentication_label_android;

  /// No description provided for @issuer_national_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی صادرکننده را وارد کنید'**
  String get issuer_national_code_hint;

  /// No description provided for @issuer_national_code.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی صادر‌کننده'**
  String get issuer_national_code;

  /// No description provided for @verify_code_sent_to_phone_number.
  ///
  /// In fa, this message translates to:
  /// **'کد تایید به شماره {phoneNumber} پیامک شد.'**
  String verify_code_sent_to_phone_number(String phoneNumber);

  /// No description provided for @wrong_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره را اشتباه وارد کرده‌اید؟'**
  String get wrong_number;

  /// No description provided for @send_again.
  ///
  /// In fa, this message translates to:
  /// **'ارسال مجدد'**
  String get send_again;

  /// No description provided for @like_09123456789.
  ///
  /// In fa, this message translates to:
  /// **'مانند ۰۹۱۲۳۴۵۶۷۸۹'**
  String get like_09123456789;

  /// No description provided for @select_charge_type_and_amount.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب نوع و مبلغ شارژ'**
  String get select_charge_type_and_amount;

  /// No description provided for @choose_charge_type_and_amount.
  ///
  /// In fa, this message translates to:
  /// **'نوع و مبلغ شارژ را انتخاب نمایید'**
  String get choose_charge_type_and_amount;

  /// No description provided for @select_charge_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ شارژ را انتخاب نمایید'**
  String get select_charge_amount;

  /// No description provided for @sim_card_recharge.
  ///
  /// In fa, this message translates to:
  /// **'شارژ سیم‌کارت'**
  String get sim_card_recharge;

  /// No description provided for @register_selected_card.
  ///
  /// In fa, this message translates to:
  /// **'مایل به ثبت کارت انتخاب شده در شاپرک هستید؟'**
  String get register_selected_card;

  /// No description provided for @card_not_registered.
  ///
  /// In fa, this message translates to:
  /// **'کارت انتخابی، در هاب شاپرک ثبت نشده است. جهت استفاده از کارت جهت مانده‌گیری، کارت باید در شاپرک ثبت شود'**
  String get card_not_registered;

  /// No description provided for @card_details.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات کارت'**
  String get card_details;

  /// No description provided for @recharge_amount_must_multiple_of_10000_rials.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ شارژ باید ضریبی از ۱.۰۰۰ ریال باشد'**
  String get recharge_amount_must_multiple_of_10000_rials;

  /// No description provided for @account_deleted_successfully.
  ///
  /// In fa, this message translates to:
  /// **'حساب‌کاربری شما با موفقیت حذف شد'**
  String get account_deleted_successfully;

  /// No description provided for @yes.
  ///
  /// In fa, this message translates to:
  /// **'بله'**
  String get yes;

  /// No description provided for @ground_floor.
  ///
  /// In fa, this message translates to:
  /// **'همکف'**
  String get ground_floor;

  /// No description provided for @pay_inquiry_fee.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت هزینه استعلام'**
  String get pay_inquiry_fee;

  /// No description provided for @enter_sms_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پیامک شده را وارد نمایید'**
  String get enter_sms_code;

  /// No description provided for @no.
  ///
  /// In fa, this message translates to:
  /// **'خیر'**
  String get no;

  /// No description provided for @dynamic_password_active_successfully.
  ///
  /// In fa, this message translates to:
  /// **'رمز پویا خودکار با موفقیت فعال شد.'**
  String get dynamic_password_active_successfully;

  /// No description provided for @select_as_default_card.
  ///
  /// In fa, this message translates to:
  /// **'آیا مایل به انتخاب این کارت به عنوان پیش‌فرض هستید؟'**
  String get select_as_default_card;

  /// No description provided for @default_card_message_to_fast.
  ///
  /// In fa, this message translates to:
  /// **'برای تسریع در انجام امور بانکی، کارت موردنظر را به عنوان کارت مبدا پیش‌فرض انتخاب کنید'**
  String get default_card_message_to_fast;

  /// No description provided for @search_source_card.
  ///
  /// In fa, this message translates to:
  /// **'جستجو کارت مبدا'**
  String get search_source_card;

  /// No description provided for @card_title_or_number.
  ///
  /// In fa, this message translates to:
  /// **'عنوان یا شماره کارت'**
  String get card_title_or_number;

  /// No description provided for @card_not_found.
  ///
  /// In fa, this message translates to:
  /// **'کارت بانکی یافت نشد'**
  String get card_not_found;

  /// No description provided for @design_test.
  ///
  /// In fa, this message translates to:
  /// **'تست طراحی'**
  String get design_test;

  /// No description provided for @recover_internet_bank_password.
  ///
  /// In fa, this message translates to:
  /// **'بازیابی رمز اینترنت بانک'**
  String get recover_internet_bank_password;

  /// No description provided for @issue_internet_bank_password.
  ///
  /// In fa, this message translates to:
  /// **'صدور اولیه رمز اینترنت بانک'**
  String get issue_internet_bank_password;

  /// No description provided for @internet_bank_username.
  ///
  /// In fa, this message translates to:
  /// **'نام کاربری اینترنت بانک'**
  String get internet_bank_username;

  /// No description provided for @internet_bank_username_hint.
  ///
  /// In fa, this message translates to:
  /// **'نام کاربری اینترنت بانک خود را وارد کنید'**
  String get internet_bank_username_hint;

  /// No description provided for @internet_bank_username_error.
  ///
  /// In fa, this message translates to:
  /// **'مقدار صحیح نام کاربری اینترنت بانک خود را وارد کنید'**
  String get internet_bank_username_error;

  /// No description provided for @confirm_and_recover_password_internet_bank.
  ///
  /// In fa, this message translates to:
  /// **'تایید و بازیابی رمز اینترنت بانک'**
  String get confirm_and_recover_password_internet_bank;

  /// No description provided for @internet_bank_services.
  ///
  /// In fa, this message translates to:
  /// **'خدمات اینترنت بانک'**
  String get internet_bank_services;

  /// No description provided for @mobile_bank_services.
  ///
  /// In fa, this message translates to:
  /// **'خدمات موبایل بانک'**
  String get mobile_bank_services;

  /// No description provided for @mobile_bank_username.
  ///
  /// In fa, this message translates to:
  /// **'نام کاربری موبایل بانک'**
  String get mobile_bank_username;

  /// No description provided for @mobile_bank_username_hint.
  ///
  /// In fa, this message translates to:
  /// **'نام کاربری موبایل بانک خود را وارد کنید'**
  String get mobile_bank_username_hint;

  /// No description provided for @mobile_bank_username_error.
  ///
  /// In fa, this message translates to:
  /// **'نام کاربری باید عددی یا به حروف انگلیسی یا ترکیبی از هر دو باشد'**
  String get mobile_bank_username_error;

  /// No description provided for @reset_password_continue_button_mobile_bank.
  ///
  /// In fa, this message translates to:
  /// **'تایید و بازیابی رمز موبایل بانک'**
  String get reset_password_continue_button_mobile_bank;

  /// No description provided for @reset_password_mobile_bank.
  ///
  /// In fa, this message translates to:
  /// **'بازیابی رمز موبایل بانک'**
  String get reset_password_mobile_bank;

  /// No description provided for @issue_password_mobile_bank.
  ///
  /// In fa, this message translates to:
  /// **'صدور اولیه رمز موبایل بانک'**
  String get issue_password_mobile_bank;

  /// No description provided for @activation_notice.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، جهت دریافت نام‌کاربری و رمزعبور، نیازمند فعال‌سازی سرویس می‌باشید'**
  String get activation_notice;

  /// No description provided for @activation_button.
  ///
  /// In fa, this message translates to:
  /// **'فعال‌سازی'**
  String get activation_button;

  /// No description provided for @transaction_filter_title.
  ///
  /// In fa, this message translates to:
  /// **'فیلتر تراکنش‌ها'**
  String get transaction_filter_title;

  /// No description provided for @receive_money.
  ///
  /// In fa, this message translates to:
  /// **'دریافت وجه'**
  String get receive_money;

  /// No description provided for @send_money.
  ///
  /// In fa, this message translates to:
  /// **'ارسال وجه'**
  String get send_money;

  /// No description provided for @transaction_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت تراکنش'**
  String get transaction_status;

  /// No description provided for @filter_results.
  ///
  /// In fa, this message translates to:
  /// **'فیلتر نتایج'**
  String get filter_results;

  /// No description provided for @update_required_message.
  ///
  /// In fa, this message translates to:
  /// **'برای استفاده از برنامه حتما باید به‌روزرسانی انجام شود. لطفا دریافت نسخه جدید را کلیک کنید'**
  String get update_required_message;

  /// No description provided for @close_app_button.
  ///
  /// In fa, this message translates to:
  /// **'بستن برنامه'**
  String get close_app_button;

  /// No description provided for @image_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنمای تصویری'**
  String get image_guide;

  /// No description provided for @audio_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنمای صوتی'**
  String get audio_guide;

  /// No description provided for @instruction_text.
  ///
  /// In fa, this message translates to:
  /// **'لطفا چهره خود را در کادر مشخص شده قرار دهید و دکمه را انتخاب نمایید'**
  String get instruction_text;

  /// No description provided for @upload_video_instruction.
  ///
  /// In fa, this message translates to:
  /// **'با توجه به راهنما یک ویدئو چهار ثانیه‌ای از چهره خود بارگذاری کنید'**
  String get upload_video_instruction;

  /// No description provided for @upload_video_instruction2.
  ///
  /// In fa, this message translates to:
  /// **' \'لطفا با توجه به راهنما یک ویدئو از چهره خود را بارگذاری کنید\''**
  String get upload_video_instruction2;

  /// No description provided for @camera.
  ///
  /// In fa, this message translates to:
  /// **'دوربین'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In fa, this message translates to:
  /// **'گالری'**
  String get gallery;

  /// No description provided for @authentication_title.
  ///
  /// In fa, this message translates to:
  /// **'احراز هویت'**
  String get authentication_title;

  /// No description provided for @authentication_instruction.
  ///
  /// In fa, this message translates to:
  /// **'در صورت مطابق بودن تصویر ثبت‌شده با تصویر قابل قبول دکمه تایید را بزنید در غیر اینصورت مجددا تلاش کنید'**
  String get authentication_instruction;

  /// No description provided for @registered_image_title.
  ///
  /// In fa, this message translates to:
  /// **'تصویر ثبت‌شده شما'**
  String get registered_image_title;

  /// No description provided for @registered_video_title.
  ///
  /// In fa, this message translates to:
  /// **'ویدیوی ثبت‌شده شما'**
  String get registered_video_title;

  /// No description provided for @acceptable_image_sample_new_id.
  ///
  /// In fa, this message translates to:
  /// **'نمونه تصویر قابل قبول شناسنامه جدید'**
  String get acceptable_image_sample_new_id;

  /// No description provided for @acceptable_image_sample_old_id.
  ///
  /// In fa, this message translates to:
  /// **'نمونه تصویر قابل قبول شناسنامه قدیمی'**
  String get acceptable_image_sample_old_id;

  /// No description provided for @acceptable_image_sample.
  ///
  /// In fa, this message translates to:
  /// **'  نمونه تصویر قابل قبول\n'**
  String get acceptable_image_sample;

  /// No description provided for @acceptable_video_sample.
  ///
  /// In fa, this message translates to:
  /// **'  نمونه ویدیوی قابل قبول\n'**
  String get acceptable_video_sample;

  /// No description provided for @postal_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی خود را وارد کنید'**
  String get postal_code_hint;

  /// No description provided for @postal_code_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کد پستی صحیح را وارد کنید'**
  String get postal_code_error;

  /// No description provided for @address_hint.
  ///
  /// In fa, this message translates to:
  /// **'آدرس خود را وارد کنید'**
  String get address_hint;

  /// No description provided for @address_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا آدرس را وارد کنید'**
  String get address_error;

  /// No description provided for @authentication_done_successfully.
  ///
  /// In fa, this message translates to:
  /// **'احراز هویت شما با موفقیت انجام شد!'**
  String get authentication_done_successfully;

  /// No description provided for @upload_identity_documents.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری مدارک هویتی'**
  String get upload_identity_documents;

  /// No description provided for @upload_documents_instruction.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تصاویر مدارک خواسته‌شده را بارگذاری کنید'**
  String get upload_documents_instruction;

  /// No description provided for @upload_documents_description.
  ///
  /// In fa, this message translates to:
  /// **'•  نور عکاسی مناسب باشد\n•  عکس واضح و بدون لرزش باشد\n•  حجم عکس بیش از 1 مگابایت نباشد\n•  کل تصویر کارت ملی داخل کادر باشد\n•  حاشیه دور تصویر کارت ملی نباید نسبت به کارت ملی زیاد باشد'**
  String get upload_documents_description;

  /// No description provided for @upload_documents_selfie_description.
  ///
  /// In fa, this message translates to:
  /// **'•  پوشش مناسب رعایت شود\n•  عکس باید واضح و بدون تاری باشد\n•  پس‌زمینه یکدست (ترجیحاً سفید یا روشن)\n•  عدم وجود هرگونه فرد دیگر در تصویر\n•  تصویر باید کامل ‌صورت کاربر را نشان دهد (بدون عینک آفتابی، ماسک یا سایه‌های شدید)'**
  String get upload_documents_selfie_description;

  /// No description provided for @upload_documents_message.
  ///
  /// In fa, this message translates to:
  /// **'نکات قابل توجه عکس'**
  String get upload_documents_message;

  /// No description provided for @upload_documents_video_description.
  ///
  /// In fa, this message translates to:
  /// **'•  پوشش مناسب رعایت شود\n•  فیلم باید واضح و بدون تاری باشد\n•  پس‌زمینه یکدست (ترجیحاً سفید یا روشن)\n•  تنها یک نفر در تصویر حضور داشته باشد\n•  ویدیو باید کامل ‌صورت کاربر را پوشش دهد (بدون عینک آفتابی، ماسک یا سایه‌های شدید)'**
  String get upload_documents_video_description;

  /// No description provided for @upload_documents_video_message.
  ///
  /// In fa, this message translates to:
  /// **'نکات قابل توجه ویدیو'**
  String get upload_documents_video_message;

  /// No description provided for @birth_certificate_page_one_two.
  ///
  /// In fa, this message translates to:
  /// **'صفحه اول و دوم شناسنامه'**
  String get birth_certificate_page_one_two;

  /// No description provided for @birth_certificate_page_three_four.
  ///
  /// In fa, this message translates to:
  /// **'صفحه سوم و چهارم شناسنامه'**
  String get birth_certificate_page_three_four;

  /// No description provided for @birth_certificate_page_five_six.
  ///
  /// In fa, this message translates to:
  /// **'صفحه پنجم و ششم شناسنامه'**
  String get birth_certificate_page_five_six;

  /// No description provided for @please_enter_additional_information.
  ///
  /// In fa, this message translates to:
  /// **'لطفا اطلاعات تکمیلی مورد نیاز را وارد کنید'**
  String get please_enter_additional_information;

  /// No description provided for @first_name_english.
  ///
  /// In fa, this message translates to:
  /// **'نام به انگلیسی'**
  String get first_name_english;

  /// No description provided for @enter_first_name_english.
  ///
  /// In fa, this message translates to:
  /// **'نام خود را به انگلیسی وارد کنید'**
  String get enter_first_name_english;

  /// No description provided for @please_enter_first_name_english.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نام انگلیسی خود را وارد کنید'**
  String get please_enter_first_name_english;

  /// No description provided for @last_name_english.
  ///
  /// In fa, this message translates to:
  /// **'نام خانوادگی به انگلیسی'**
  String get last_name_english;

  /// No description provided for @enter_last_name_english.
  ///
  /// In fa, this message translates to:
  /// **'نام خانوادگی خود را به انگلیسی وارد کنید'**
  String get enter_last_name_english;

  /// No description provided for @please_enter_last_name_english.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نام خانوادگی انگلیسی خود را وارد کنید'**
  String get please_enter_last_name_english;

  /// No description provided for @email.
  ///
  /// In fa, this message translates to:
  /// **'ایمیل'**
  String get email;

  /// No description provided for @last_name.
  ///
  /// In fa, this message translates to:
  /// **'نام خانوادگی'**
  String get last_name;

  /// No description provided for @enter_email.
  ///
  /// In fa, this message translates to:
  /// **'ایمیل خود را وارد کنید'**
  String get enter_email;

  /// No description provided for @home_phone_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن منزل'**
  String get home_phone_number;

  /// No description provided for @please_enter_valid_email.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یک ایمیل معتبر وارد کنید'**
  String get please_enter_valid_email;

  /// No description provided for @enter_home_phone_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن منزل را با پیش‌شماره استان وارد کنید'**
  String get enter_home_phone_number;

  /// No description provided for @submit_process.
  ///
  /// In fa, this message translates to:
  /// **'تکمیل فرآیند'**
  String get submit_process;

  /// No description provided for @please_enter_valid_home_phone.
  ///
  /// In fa, this message translates to:
  /// **'لطفا شماره تلفن صحیح منزل را وارد کنید'**
  String get please_enter_valid_home_phone;

  /// No description provided for @process_in_progress.
  ///
  /// In fa, this message translates to:
  /// **'ثبت فرآیند زمانبر است. منتظر بمانید...'**
  String get process_in_progress;

  /// No description provided for @smart_national_card_back_image.
  ///
  /// In fa, this message translates to:
  /// **'تصویر پشت کارت ملی هوشمند'**
  String get smart_national_card_back_image;

  /// No description provided for @smart_national_card_front_image.
  ///
  /// In fa, this message translates to:
  /// **'تصویر روی کارت ملی هوشمند'**
  String get smart_national_card_front_image;

  /// No description provided for @no_new_national_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت ملی جدید ندارم'**
  String get no_new_national_card;

  /// No description provided for @verify_mobile_number_to_start.
  ///
  /// In fa, this message translates to:
  /// **'برای شروع احراز هویت شماره موبایل خود را تایید کنید'**
  String get verify_mobile_number_to_start;

  /// No description provided for @enter_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن همراه خود را وارد نمایید'**
  String get enter_mobile_number;

  /// No description provided for @get_activation_code.
  ///
  /// In fa, this message translates to:
  /// **'دریافت کد فعالسازی'**
  String get get_activation_code;

  /// No description provided for @signature.
  ///
  /// In fa, this message translates to:
  /// **'دریافت امضا'**
  String get signature;

  /// No description provided for @signature_instruction.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نمونه امضا خود را در کادر زیر وارد کنید و پس از تایید، دکمه تایید و ادامه را فشار دهید.'**
  String get signature_instruction;

  /// No description provided for @signature_location.
  ///
  /// In fa, this message translates to:
  /// **'محل امضا'**
  String get signature_location;

  /// No description provided for @check_serial.
  ///
  /// In fa, this message translates to:
  /// **'صحت سریال پشت کارت ملی هوشمند را بررسی کنید'**
  String get check_serial;

  /// No description provided for @serial_number.
  ///
  /// In fa, this message translates to:
  /// **'سریال پشت کارت ملی هوشمند'**
  String get serial_number;

  /// No description provided for @enter_serial_number.
  ///
  /// In fa, this message translates to:
  /// **'سریال پشت کارت ملی'**
  String get enter_serial_number;

  /// No description provided for @enter_receipt_code.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری روی رسید کاغذی کارت ملی هوشمند خود را وارد نمایید'**
  String get enter_receipt_code;

  /// No description provided for @receipt_code_on_reciept.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری روی رسید'**
  String get receipt_code_on_reciept;

  /// No description provided for @capture_instruction.
  ///
  /// In fa, this message translates to:
  /// **'به منظور انطباق تصویر شما با کارت ملی، لطفا بعد از آماده شدن جهت تصویربرداری از چهره خود، دکمه گرفتن عکس را فشار دهید.'**
  String get capture_instruction;

  /// No description provided for @capture_photo_from_face.
  ///
  /// In fa, this message translates to:
  /// **'ثبت عکس از چهره'**
  String get capture_photo_from_face;

  /// No description provided for @delete_photo.
  ///
  /// In fa, this message translates to:
  /// **'حذف عکس'**
  String get delete_photo;

  /// No description provided for @capture_video_from_face.
  ///
  /// In fa, this message translates to:
  /// **'ثبت ویدیو از چهره'**
  String get capture_video_from_face;

  /// No description provided for @please_enter_serial.
  ///
  /// In fa, this message translates to:
  /// **'لطفا سریال را وارد نمایید'**
  String get please_enter_serial;

  /// No description provided for @enter_receipt_code_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کد رهگیری را وارد نمایید'**
  String get enter_receipt_code_error;

  /// No description provided for @guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنما'**
  String get guide;

  /// No description provided for @otp_to_phone_number.
  ///
  /// In fa, this message translates to:
  /// **'کد ارسالی به شماره {mobile} را وارد نمایید.'**
  String otp_to_phone_number(String mobile);

  /// No description provided for @enter_activion_code.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کد فعالسازی را وارد نمایید'**
  String get enter_activion_code;

  /// No description provided for @verify_code.
  ///
  /// In fa, this message translates to:
  /// **'تایید کد'**
  String get verify_code;

  /// No description provided for @loan_info_azki.
  ///
  /// In fa, this message translates to:
  /// **'شما برای دریافت تسهیلات از سوی ازکی وام به توبانک معرفی شده‌اید'**
  String get loan_info_azki;

  /// No description provided for @loan_process.
  ///
  /// In fa, this message translates to:
  /// **'مراحل دریافت تسهیلات'**
  String get loan_process;

  /// No description provided for @buy_promissory.
  ///
  /// In fa, this message translates to:
  /// **'خرید و دریافت سفته'**
  String get buy_promissory;

  /// No description provided for @view_and_sign_contract.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده و امضای قرارداد دیجیتال'**
  String get view_and_sign_contract;

  /// No description provided for @receive_loan.
  ///
  /// In fa, this message translates to:
  /// **'دریافت تسهیلات'**
  String get receive_loan;

  /// No description provided for @select_electronic_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب سفته الکترونیک'**
  String get select_electronic_promissory_note;

  /// No description provided for @electronic_promissory.
  ///
  /// In fa, this message translates to:
  /// **'سفته الکترونیک'**
  String get electronic_promissory;

  /// No description provided for @show_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'نمایش سفته'**
  String get show_promissory_note;

  /// No description provided for @save_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره سفته'**
  String get save_promissory_note;

  /// No description provided for @share_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'اشتراک‌گذاری سفته'**
  String get share_promissory_note;

  /// No description provided for @complete.
  ///
  /// In fa, this message translates to:
  /// **'تکمیل'**
  String get complete;

  /// No description provided for @electronic_promissory_note_description.
  ///
  /// In fa, this message translates to:
  /// **'سفته الکترونیکی، یک سند تجاری است که به صورت الکترونیکی، صادر شده و به موجب آن، صادر‌کننده، پرداخت مبلغی را در قبال شخص دیگر، متعهد میشود'**
  String get electronic_promissory_note_description;

  /// No description provided for @agreement_text.
  ///
  /// In fa, this message translates to:
  /// **'متن توافق نامه'**
  String get agreement_text;

  /// No description provided for @branch_list_title.
  ///
  /// In fa, this message translates to:
  /// **'لیست صندوق‌های شعبه'**
  String get branch_list_title;

  /// No description provided for @terms_and_conditions_title_safe_box.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات صندوق امانات'**
  String get terms_and_conditions_title_safe_box;

  /// No description provided for @no_open_process.
  ///
  /// In fa, this message translates to:
  /// **'فرآیند باز وجود ندارد.'**
  String get no_open_process;

  /// No description provided for @register_guarantee.
  ///
  /// In fa, this message translates to:
  /// **'ثبت ضمانت'**
  String get register_guarantee;

  /// No description provided for @contract_loan_pdf_azki.
  ///
  /// In fa, this message translates to:
  /// **'قرارداد ازکی وام'**
  String get contract_loan_pdf_azki;

  /// No description provided for @azki.
  ///
  /// In fa, this message translates to:
  /// **'ازکی وام'**
  String get azki;

  /// No description provided for @return_to_other_services.
  ///
  /// In fa, this message translates to:
  /// **'بازگشت به لیست سایر خدمات'**
  String get return_to_other_services;

  /// No description provided for @search_box_placeholder.
  ///
  /// In fa, this message translates to:
  /// **'جستجو صندوق بر اساس کد یا نام شعبه'**
  String get search_box_placeholder;

  /// No description provided for @contract_acceptance.
  ///
  /// In fa, this message translates to:
  /// **'پذیرش قرارداد'**
  String get contract_acceptance;

  /// No description provided for @loan_details.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات تسهیلات'**
  String get loan_details;

  /// No description provided for @approved_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تایید شده'**
  String get approved_amount;

  /// No description provided for @repayment_period.
  ///
  /// In fa, this message translates to:
  /// **'مدت بازپرداخت'**
  String get repayment_period;

  /// No description provided for @promissory_note_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات سفته'**
  String get promissory_note_info;

  /// No description provided for @promissory_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ سفته'**
  String get promissory_amount;

  /// No description provided for @no_record_yet.
  ///
  /// In fa, this message translates to:
  /// **'موردی هنوز ثبت نشده است'**
  String get no_record_yet;

  /// No description provided for @payment_promissory_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ پرداخت سفته'**
  String get payment_promissory_date;

  /// No description provided for @confirmation_message_safe_box.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، ثبت درخواست به منزله تأیید واگذاری صندوق امانات به شما نمی‌باشد و تأیید نهایی منوط به مراجعه حضوری، مذاکره و تأمین شرایط تعیین شده می‌باشد'**
  String get confirmation_message_safe_box;

  /// No description provided for @acceptance_text_safe_box.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات اجاره صندوق امانات را قبول دارم'**
  String get acceptance_text_safe_box;

  /// No description provided for @due_on_demand.
  ///
  /// In fa, this message translates to:
  /// **'عندالمطالبه'**
  String get due_on_demand;

  /// No description provided for @visit_time_range.
  ///
  /// In fa, this message translates to:
  /// **'بازه زمانی بازدید'**
  String get visit_time_range;

  /// No description provided for @rent_safety_box.
  ///
  /// In fa, this message translates to:
  /// **'اجاره صندوق امانات'**
  String get rent_safety_box;

  /// No description provided for @select_payment_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ پرداخت را انتخاب کنید'**
  String get select_payment_date;

  /// No description provided for @enter_select_payment_date.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ پرداخت را انتخاب کنید'**
  String get enter_select_payment_date;

  /// No description provided for @no_request_found.
  ///
  /// In fa, this message translates to:
  /// **'درخواستی یافت نشد'**
  String get no_request_found;

  /// No description provided for @visit_date_.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ بازدید'**
  String get visit_date_;

  /// No description provided for @promissory_note_description.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات سفته'**
  String get promissory_note_description;

  /// No description provided for @visits_list.
  ///
  /// In fa, this message translates to:
  /// **'لیست بازدیدها'**
  String get visits_list;

  /// No description provided for @mobile_bank_password_issued.
  ///
  /// In fa, this message translates to:
  /// **'رمز موبایل بانک صادر گردید!'**
  String get mobile_bank_password_issued;

  /// No description provided for @percent_of_loan.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ سفته برابر است با {percent} درصد مبلغ اصل و سود تسهیلات'**
  String percent_of_loan(int percent);

  /// No description provided for @issued_to.
  ///
  /// In fa, this message translates to:
  /// **'در وجه {recipientFullName}'**
  String issued_to(String recipientFullName);

  /// No description provided for @safe_box_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت صندوق'**
  String get safe_box_status;

  /// No description provided for @confirmed_box_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تایید صندوق'**
  String get confirmed_box_date;

  /// No description provided for @first_visit_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ مراجعه اول'**
  String get first_visit_date;

  /// No description provided for @transferable_note.
  ///
  /// In fa, this message translates to:
  /// **'قابل انتقال به غیر'**
  String get transferable_note;

  /// No description provided for @transfer_to.
  ///
  /// In fa, this message translates to:
  /// **'انتقال به '**
  String get transfer_to;

  /// No description provided for @non_transferable_note.
  ///
  /// In fa, this message translates to:
  /// **'غیرقابل انتقال به غیر'**
  String get non_transferable_note;

  /// No description provided for @digital_signature_finalize.
  ///
  /// In fa, this message translates to:
  /// **'امضای دیجیتال و نهایی سازی'**
  String get digital_signature_finalize;

  /// No description provided for @loan_ready_message.
  ///
  /// In fa, this message translates to:
  /// **'مشتری گرامی، تسهیلات درخواستی شما آماده پرداخت است.'**
  String get loan_ready_message;

  /// No description provided for @not_now.
  ///
  /// In fa, this message translates to:
  /// **'الان نه'**
  String get not_now;

  /// No description provided for @instant_card_request.
  ///
  /// In fa, this message translates to:
  /// **'درخواست آنی صدور کارت'**
  String get instant_card_request;

  /// No description provided for @user_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات شما'**
  String get user_information;

  /// No description provided for @full_name.
  ///
  /// In fa, this message translates to:
  /// **'نام و نام‌خانوادگی'**
  String get full_name;

  /// No description provided for @branch_agent.
  ///
  /// In fa, this message translates to:
  /// **'شعبه عامل'**
  String get branch_agent;

  /// No description provided for @tracking_code_centeral_bank.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری بانک مرکزی'**
  String get tracking_code_centeral_bank;

  /// No description provided for @tracking_code_centeral_bank_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری بانک مرکزی متقاضی را وارد نمایید'**
  String get tracking_code_centeral_bank_hint;

  /// No description provided for @tracking_code_error.
  ///
  /// In fa, this message translates to:
  /// **'مقدار کد رهگیری معتبری وارد نمایید'**
  String get tracking_code_error;

  /// No description provided for @copy_guarantor_residence_document_or_lease.
  ///
  /// In fa, this message translates to:
  /// **'تصویر سند یا اجاره نامه محل سکونت ضامن'**
  String get copy_guarantor_residence_document_or_lease;

  /// No description provided for @children.
  ///
  /// In fa, this message translates to:
  /// **'فرزند'**
  String get children;

  /// No description provided for @select_children.
  ///
  /// In fa, this message translates to:
  /// **'فرزند واجد شرایط تسهیلات را انتخاب کنید'**
  String get select_children;

  /// No description provided for @loan_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تسهیلات'**
  String get loan_amount;

  /// No description provided for @tracking_code_info_title.
  ///
  /// In fa, this message translates to:
  /// **'طریقه دریافت کد رهگیری بانک مرکزی'**
  String get tracking_code_info_title;

  /// No description provided for @tracking_code_info_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، در صورتی که کد رهگیری دریافت نکرده‌اید با مراجعه به سامانه بانک مرکزی آن را دریافت نمایید'**
  String get tracking_code_info_message;

  /// No description provided for @central_bank_system.
  ///
  /// In fa, this message translates to:
  /// **'سامانه بانک مرکزی'**
  String get central_bank_system;

  /// No description provided for @website_link_cbi.
  ///
  /// In fa, this message translates to:
  /// **'ve.cbi.ir'**
  String get website_link_cbi;

  /// No description provided for @company_name.
  ///
  /// In fa, this message translates to:
  /// **'نام شرکت'**
  String get company_name;

  /// No description provided for @conditions_children.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات درخواست تسهیلات فرزندآوری'**
  String get conditions_children;

  /// No description provided for @accept_conditions_children.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات تسهیلات فرزندآوری را قبول دارم'**
  String get accept_conditions_children;

  /// No description provided for @guarantee_info_title.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات هویتی ضامن'**
  String get guarantee_info_title;

  /// No description provided for @guarantee_mobile_title.
  ///
  /// In fa, this message translates to:
  /// **'شماره همراه ضامن'**
  String get guarantee_mobile_title;

  /// No description provided for @guarantee_mobile_error.
  ///
  /// In fa, this message translates to:
  /// **'مقدار تلفن همراه ضامن وارد کنید'**
  String get guarantee_mobile_error;

  /// No description provided for @guarantee_birthday_title.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد ضامن'**
  String get guarantee_birthday_title;

  /// No description provided for @search_branch.
  ///
  /// In fa, this message translates to:
  /// **'جستجو بر اساس نام شعبه، کد شعبه، اسم شهر'**
  String get search_branch;

  /// No description provided for @guarantee_birthday_hint.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد ضامن را انتخاب کنید'**
  String get guarantee_birthday_hint;

  /// No description provided for @guarantee_birthday_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ تولد ضامن را انتخاب نمایید'**
  String get guarantee_birthday_error;

  /// No description provided for @requested_loan_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تسهیلات درخواستی'**
  String get requested_loan_amount;

  /// No description provided for @requested_amount_in_central_bank_system.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ درخواستی شما در سامانه بانک مرکزی'**
  String get requested_amount_in_central_bank_system;

  /// No description provided for @guarantee_national_code_title.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی ضامن'**
  String get guarantee_national_code_title;

  /// No description provided for @enter_guarantor_removal_reason.
  ///
  /// In fa, this message translates to:
  /// **'دلیل حذف ضامن را وارد نمایید'**
  String get enter_guarantor_removal_reason;

  /// No description provided for @guarantor_removal_reason.
  ///
  /// In fa, this message translates to:
  /// **'دلیل حذف ضامن'**
  String get guarantor_removal_reason;

  /// No description provided for @guarantee_national_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی ضامن را وارد کنید'**
  String get guarantee_national_code_hint;

  /// No description provided for @upload_cheque_info.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا چک صیادی متقاضی را آپلود نمایید. چک صیادی نباید امضا، مبلغ یا تاریخ داشته باشد'**
  String get upload_cheque_info;

  /// No description provided for @cheque_id_title.
  ///
  /// In fa, this message translates to:
  /// **'کد صیادی'**
  String get cheque_id_title;

  /// No description provided for @marriage_loan_.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات ازدواج'**
  String get marriage_loan_;

  /// No description provided for @cheque_image_upload_title.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری تصویر چک صیادی متقاضی'**
  String get cheque_image_upload_title;

  /// No description provided for @bank_guarantee_info.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، با انتخاب این گزینه در حین مراجعه به بانک، سفته مورد نیاز را ارائه خواهید داد.'**
  String get bank_guarantee_info;

  /// No description provided for @select_salary_deduction_certificate_info.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا گواهی کسر از حقوق متقاضی را انتخاب کنید'**
  String get select_salary_deduction_certificate_info;

  /// No description provided for @salary_deduction_certificate_title.
  ///
  /// In fa, this message translates to:
  /// **'گواهی کسر از حقوق متقاضی'**
  String get salary_deduction_certificate_title;

  /// No description provided for @guarantee_cheque_upload_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا چک صیادی ضامن را آپلود نمایید. چک صیادی نباید امضا، مبلغ یا تاریخ داشته باشد'**
  String get guarantee_cheque_upload_message;

  /// No description provided for @cheque_id_error.
  ///
  /// In fa, this message translates to:
  /// **'شناسه صیاد معتبر وارد نمایید'**
  String get cheque_id_error;

  /// No description provided for @guarantee_cheque_upload_title.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری تصویر چک صیادی ضامن'**
  String get guarantee_cheque_upload_title;

  /// No description provided for @marriage_loan_terms_conditions.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات درخواست تسهیلات ازدواج'**
  String get marriage_loan_terms_conditions;

  /// No description provided for @guarantee_salary_deduction_upload_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، گواهی کسر از حقوق ضامن را بارگذاری نمایید'**
  String get guarantee_salary_deduction_upload_message;

  /// No description provided for @guarantee_salary_deduction_upload_title.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری تصویر کسر از حقوق ضامن'**
  String get guarantee_salary_deduction_upload_title;

  /// No description provided for @children_loan_amounts_title.
  ///
  /// In fa, this message translates to:
  /// **'مبالغ تسهیلات فرزندآوری'**
  String get children_loan_amounts_title;

  /// No description provided for @child_info_title.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات هویتی فرزند'**
  String get child_info_title;

  /// No description provided for @minimum_commitment_twenty_million.
  ///
  /// In fa, this message translates to:
  /// **'حداقل مبلغ تعهد بیست میلیون ریال می‌باشد'**
  String get minimum_commitment_twenty_million;

  /// No description provided for @salary_slip_or_employment_certificate.
  ///
  /// In fa, this message translates to:
  /// **'تصویر فیش حقوقی/گواهی شغلی'**
  String get salary_slip_or_employment_certificate;

  /// No description provided for @accept_marriage_loan_terms_conditions.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات تسهیلات ازدواج را قبول دارم'**
  String get accept_marriage_loan_terms_conditions;

  /// No description provided for @child_national_code_label.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی فرزند'**
  String get child_national_code_label;

  /// No description provided for @child_national_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی فرزند را وارد کنید'**
  String get child_national_code_hint;

  /// No description provided for @national_code_error_.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی معتبر نیست'**
  String get national_code_error_;

  /// No description provided for @receiver_type_individual.
  ///
  /// In fa, this message translates to:
  /// **'حقیقی'**
  String get receiver_type_individual;

  /// No description provided for @receiver_type_legal.
  ///
  /// In fa, this message translates to:
  /// **'حقوقی'**
  String get receiver_type_legal;

  /// No description provided for @child_birth_date_label.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد فرزند'**
  String get child_birth_date_label;

  /// No description provided for @child_birth_date_hint.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد فرزند خود را انتخاب کنید'**
  String get child_birth_date_hint;

  /// No description provided for @child_birth_date_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ تولد فرزند خود را انتخاب نمایید'**
  String get child_birth_date_error;

  /// No description provided for @uploading_documents_title.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری مدارک'**
  String get uploading_documents_title;

  /// No description provided for @child_documents_title.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری مدارک هویتی فرزند'**
  String get child_documents_title;

  /// No description provided for @marriage_loan_amounts.
  ///
  /// In fa, this message translates to:
  /// **'مبالغ تسهیلات ازدواج'**
  String get marriage_loan_amounts;

  /// No description provided for @select_deposit_number_for_minimum_balance_average_inquiry.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب شماره سپرده بابت استعلام میانگین حداقل موجودی'**
  String get select_deposit_number_for_minimum_balance_average_inquiry;

  /// No description provided for @loans_only_available_through_short_term_and_qard_hasana_savings_deposits.
  ///
  /// In fa, this message translates to:
  /// **'دریافت تسهیلات تنها از طریق سپرده‌های کوتاه مدت و قرض‌الحسنه پس‌انداز توبانکی امکان‌پذیر است.'**
  String
      get loans_only_available_through_short_term_and_qard_hasana_savings_deposits;

  /// No description provided for @child_documents_description.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا تصویر تمامی صفحات شناسنامه فرزند خود را بارگذاری نمایید. توجه کنید تصاویر می‌بایست از اصل مدارک فرزند باشد'**
  String get child_documents_description;

  /// No description provided for @child_identity_information_upload.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری اطلاعات هویتی فرزند'**
  String get child_identity_information_upload;

  /// No description provided for @upload_additional_documents.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری مدارک اضافی متقاضی'**
  String get upload_additional_documents;

  /// No description provided for @upload_instructions.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا تصویر صفحات درخواست شده را بارگذاری نمایید. توجه کنید تصاویر می‌بایست از اصل مدارک باشد'**
  String get upload_instructions;

  /// No description provided for @inquire_postal_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کدپستی متقاضی را استعلام نمایید'**
  String get inquire_postal_code_hint;

  /// No description provided for @inquire_postal_code_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کدپستی متقاضی را استعلام کنید'**
  String get inquire_postal_code_error;

  /// No description provided for @ownership_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع مالکیت'**
  String get ownership_type;

  /// No description provided for @ownership_type_hint.
  ///
  /// In fa, this message translates to:
  /// **'نوع مالکیت را انتخاب نمایید'**
  String get ownership_type_hint;

  /// No description provided for @verify_postal_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کدپستی را استعلام نمایید'**
  String get verify_postal_code_hint;

  /// No description provided for @please_verify_postal_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کدپستی را استعلام نمایید'**
  String get please_verify_postal_code_hint;

  /// No description provided for @ownership_type_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نوع مالکیت را انتخاب نمایید'**
  String get ownership_type_error;

  /// No description provided for @ownership_description.
  ///
  /// In fa, this message translates to:
  /// **'توضیح نوع مالکیت'**
  String get ownership_description;

  /// No description provided for @hint_text_property_document.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری اجاره‌نامه یا سند مالکیت'**
  String get hint_text_property_document;

  /// No description provided for @ownership_description_hint.
  ///
  /// In fa, this message translates to:
  /// **'لطفا توضیحات مربوط به نوع مالکیت را وارد کنید'**
  String get ownership_description_hint;

  /// No description provided for @ownership_description_error.
  ///
  /// In fa, this message translates to:
  /// **'مقدار معتبری برای توضیحات ذکر کنید'**
  String get ownership_description_error;

  /// No description provided for @tracking_code_rent.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری اجاره‌نامه'**
  String get tracking_code_rent;

  /// No description provided for @ownership_type_explanation.
  ///
  /// In fa, this message translates to:
  /// **'لطفا توضیحات مربوط به نوع مالکیت را وارد نمایید.'**
  String get ownership_type_explanation;

  /// No description provided for @valid_explanation_required.
  ///
  /// In fa, this message translates to:
  /// **'مقدار معتبری برای توضیحات ذکر نمایید.'**
  String get valid_explanation_required;

  /// No description provided for @document_picker_title.
  ///
  /// In fa, this message translates to:
  /// **'تصویر سند یا اجاره نامه محل سکونت'**
  String get document_picker_title;

  /// No description provided for @upload_applicant_identity_info.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری اطلاعات هویتی متقاضی'**
  String get upload_applicant_identity_info;

  /// No description provided for @please_upload_requested_birth_certificate_pages.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا تصویر صفحات شناسنامه درخواست شده را بارگذاری نمایید. توجه کنید تصاویر می‌بایست از اصل شناسنامه متقاضی باشد'**
  String get please_upload_requested_birth_certificate_pages;

  /// No description provided for @applicant_relationship_with_child.
  ///
  /// In fa, this message translates to:
  /// **'نسبت متقاضی با فرزند:'**
  String get applicant_relationship_with_child;

  /// No description provided for @father.
  ///
  /// In fa, this message translates to:
  /// **'پدر'**
  String get father;

  /// No description provided for @residence_ownership_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات مالکیت محل سکونت'**
  String get residence_ownership_information;

  /// No description provided for @legal_guardian.
  ///
  /// In fa, this message translates to:
  /// **'قیم قانونی'**
  String get legal_guardian;

  /// No description provided for @guardianship_document.
  ///
  /// In fa, this message translates to:
  /// **'سند قیومیت'**
  String get guardianship_document;

  /// No description provided for @address_match_warning.
  ///
  /// In fa, this message translates to:
  /// **'لازم است آدرس سند بارگذاری شده با اطلاعات وارد شده تطابق داشته باشد.'**
  String get address_match_warning;

  /// No description provided for @guarantor_address_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات آدرس ضامن'**
  String get guarantor_address_info;

  /// No description provided for @guarantee_residence_info.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا اطلاعات محل سکونت ضامن را وارد و تصویر اصل سند یا اجاره نامه محل سکونت ضامن را بارگذاری نمایید.'**
  String get guarantee_residence_info;

  /// No description provided for @guarantee_request.
  ///
  /// In fa, this message translates to:
  /// **'درخواست ضمانت'**
  String get guarantee_request;

  /// No description provided for @guarantor_residence_address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس محل سکونت ضامن'**
  String get guarantor_residence_address;

  /// No description provided for @guarantor_residence_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی محل سکونت ضامن'**
  String get guarantor_residence_postal_code;

  /// No description provided for @guarantee_postcode_hint.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کدپستی ضامن را استعلام نمایید'**
  String get guarantee_postcode_hint;

  /// No description provided for @guarantee_main_street_hint.
  ///
  /// In fa, this message translates to:
  /// **'خیابان اصلی ضامن را وارد نمایید'**
  String get guarantee_main_street_hint;

  /// No description provided for @first_page_of_birth_certificate.
  ///
  /// In fa, this message translates to:
  /// **'صفحه اول شناسنامه'**
  String get first_page_of_birth_certificate;

  /// No description provided for @second_page_of_birth_certificate.
  ///
  /// In fa, this message translates to:
  /// **'صفحه دوم شناسنامه'**
  String get second_page_of_birth_certificate;

  /// No description provided for @birth_certificate_description_page.
  ///
  /// In fa, this message translates to:
  /// **'صفحه توضیحات شناسنامه'**
  String get birth_certificate_description_page;

  /// No description provided for @guarantee_unit_hint.
  ///
  /// In fa, this message translates to:
  /// **'واحد ضامن را وارد کنید'**
  String get guarantee_unit_hint;

  /// No description provided for @guarantee_request_message.
  ///
  /// In fa, this message translates to:
  /// **'یک درخواست ضامن با مشخصات زیر ثبت گردیده‌است'**
  String get guarantee_request_message;

  /// No description provided for @loan_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع تسهیلات'**
  String get loan_type;

  /// No description provided for @check_guarantor_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کدپستی ضامن را استعلام کنید'**
  String get check_guarantor_postal_code;

  /// No description provided for @request_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ درخواست'**
  String get request_date;

  /// No description provided for @confirm_request_button.
  ///
  /// In fa, this message translates to:
  /// **'تایید درخواست'**
  String get confirm_request_button;

  /// No description provided for @reject_request_button.
  ///
  /// In fa, this message translates to:
  /// **'رد درخواست'**
  String get reject_request_button;

  /// No description provided for @customer_number_applicant.
  ///
  /// In fa, this message translates to:
  /// **'شماره مشتری متقاضی'**
  String get customer_number_applicant;

  /// No description provided for @upload_id_image_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا تصویر تمامی صفحات شناسنامه خود را بارگذاری نمایید. توجه کنید تصاویر می‌بایست از اصل مدارک ضامن باشد'**
  String get upload_id_image_message;

  /// No description provided for @upload_guarantee_identity_documents.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری مدارک هویتی ضامن'**
  String get upload_guarantee_identity_documents;

  /// No description provided for @page_marriage_certificate.
  ///
  /// In fa, this message translates to:
  /// **'صفحه ازدواج شناسنامه ضامن'**
  String get page_marriage_certificate;

  /// No description provided for @second_page_marriage_certificate.
  ///
  /// In fa, this message translates to:
  /// **'صفحه ازدواج شناسنامه'**
  String get second_page_marriage_certificate;

  /// No description provided for @page_children_certificate_garantee.
  ///
  /// In fa, this message translates to:
  /// **'صفحه فرزندان شناسنامه ضامن'**
  String get page_children_certificate_garantee;

  /// No description provided for @page_children_certificate_.
  ///
  /// In fa, this message translates to:
  /// **'صفحه فرزندان شناسنامه'**
  String get page_children_certificate_;

  /// No description provided for @page_life_certificate_garantee.
  ///
  /// In fa, this message translates to:
  /// **'صفحه حیات شناسنامه ضامن'**
  String get page_life_certificate_garantee;

  /// No description provided for @page_life_certificate_.
  ///
  /// In fa, this message translates to:
  /// **'صفحه حیات شناسنامه'**
  String get page_life_certificate_;

  /// No description provided for @upload_marriage_certificate_pages.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری صفحات عقدنامه'**
  String get upload_marriage_certificate_pages;

  /// No description provided for @spouse_identity_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات هویتی همسر'**
  String get spouse_identity_information;

  /// No description provided for @spouse_national_code.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی همسر'**
  String get spouse_national_code;

  /// No description provided for @spouse_national_code_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی همسر را وارد کنید'**
  String get spouse_national_code_hint;

  /// No description provided for @spouse_birthdate.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد همسر'**
  String get spouse_birthdate;

  /// No description provided for @spouse_birthdate_hint.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد همسر خود را انتخاب کنید'**
  String get spouse_birthdate_hint;

  /// No description provided for @spouse_birthdate_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ تولد همسر خود را انتخاب نمایید'**
  String get spouse_birthdate_error;

  /// No description provided for @spouse_identity_documents_upload.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری مدارک هویتی همسر'**
  String get spouse_identity_documents_upload;

  /// No description provided for @spouse_documents_info.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا تصویر تمامی صفحات شناسنامه و کارت ملی همسر خود را بارگذاری نمایید. توجه کنید تصاویر می‌بایست از اصل مدارک همسر باشد'**
  String get spouse_documents_info;

  /// No description provided for @no_spouse_national_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت ملی هوشمند ندارد'**
  String get no_spouse_national_card;

  /// No description provided for @spouse_national_card_tracking_number.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری رسید کاغذی کارت ملی هوشمند'**
  String get spouse_national_card_tracking_number;

  /// No description provided for @spouse_national_card_tracking_number_hint.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری را وارد نمایید'**
  String get spouse_national_card_tracking_number_hint;

  /// No description provided for @spouse_national_card_tracking_number_error.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری باید بین ۸ تا ۱۰ رقم باشد'**
  String get spouse_national_card_tracking_number_error;

  /// No description provided for @front_national_card_image.
  ///
  /// In fa, this message translates to:
  /// **'تصویر روی کارت ملی همسر'**
  String get front_national_card_image;

  /// No description provided for @back_national_card_image.
  ///
  /// In fa, this message translates to:
  /// **'تصویر پشت کارت ملی همسر'**
  String get back_national_card_image;

  /// No description provided for @upload_spouse_identity_information.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری اطلاعات هویتی همسر'**
  String get upload_spouse_identity_information;

  /// No description provided for @upload_original_marriage_documents.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا تصویر اصل اسناد ازدواج را بارگذاری کنید.'**
  String get upload_original_marriage_documents;

  /// No description provided for @marriage_certificate_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع عقد‌نامه:'**
  String get marriage_certificate_type;

  /// No description provided for @single_page.
  ///
  /// In fa, this message translates to:
  /// **'تک برگ'**
  String get single_page;

  /// No description provided for @booklet.
  ///
  /// In fa, this message translates to:
  /// **'دفترچه'**
  String get booklet;

  /// No description provided for @upload_marriage_certificate_front_page.
  ///
  /// In fa, this message translates to:
  /// **'تصویر روی عقدنامه'**
  String get upload_marriage_certificate_front_page;

  /// No description provided for @upload_marriage_certificate_back_page.
  ///
  /// In fa, this message translates to:
  /// **'تصویر پشت عقدنامه'**
  String get upload_marriage_certificate_back_page;

  /// No description provided for @upload_second_third_marriage_certificate_pages.
  ///
  /// In fa, this message translates to:
  /// **'تصویر دوم و سوم عقدنامه'**
  String get upload_second_third_marriage_certificate_pages;

  /// No description provided for @upload_fourth_fifth_marriage_certificate_pages.
  ///
  /// In fa, this message translates to:
  /// **'تصویر چهارم و پنجم عقدنامه'**
  String get upload_fourth_fifth_marriage_certificate_pages;

  /// No description provided for @upload_notary_information.
  ///
  /// In fa, this message translates to:
  /// **'تصویر اطلاعات دفترخانه عقدنامه'**
  String get upload_notary_information;

  /// No description provided for @upload_professional_certificate.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری سند شغلی'**
  String get upload_professional_certificate;

  /// No description provided for @upload_professional_certificate_description.
  ///
  /// In fa, this message translates to:
  /// **'سند شغلی شامل گواهی اشتغال، جواز کسب، قرارداد کاری و فیش حقوقی می‌باشد'**
  String get upload_professional_certificate_description;

  /// No description provided for @professional_certificate_image.
  ///
  /// In fa, this message translates to:
  /// **'تصویر سند شغلی'**
  String get professional_certificate_image;

  /// No description provided for @customer_commitment_to_non_connection_of_requested_deposit.
  ///
  /// In fa, this message translates to:
  /// **'تعهد مشتری نسبت به عدم اتصال سپرده درخواستی'**
  String get customer_commitment_to_non_connection_of_requested_deposit;

  /// No description provided for @customer_responsibility_disclaimer.
  ///
  /// In fa, this message translates to:
  /// **'مشتری گرامی، بانک هیچ‌گونه مسئولیتی در خصوص جبران زیان مالی احتمالی ناشی از بستن سپرده‌های مرتبط با صندوق‌های سرمایه‌گذاری، سامانه سجام، کارگزاری‌های بورس، پایانه‌های فروشگاهی، سهام عدالت و ... ندارد. لذا خواهشمند است پیش از ثبت درخواست بستن سپرده، از عدم وجود ارتباطات یاد شده اطمینان حاصل نمایید'**
  String get customer_responsibility_disclaimer;

  /// No description provided for @confirm_and_close_deposit.
  ///
  /// In fa, this message translates to:
  /// **'تایید و بستن سپرده'**
  String get confirm_and_close_deposit;

  /// No description provided for @close_deposit.
  ///
  /// In fa, this message translates to:
  /// **'بستن سپرده'**
  String get close_deposit;

  /// No description provided for @review_message.
  ///
  /// In fa, this message translates to:
  /// **'این درخواست توسط همکاران ما بررسی می‌گردد و مراتب از طریق پیامک به شما اطلاع‌رسانی خواهد شد'**
  String get review_message;

  /// No description provided for @select_deposit_closing_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع بستن سپرده را انتخاب کنید'**
  String get select_deposit_closing_type;

  /// No description provided for @withdrawal_amount_from_deposit.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ برداشت از سپرده'**
  String get withdrawal_amount_from_deposit;

  /// No description provided for @select_requested_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ درخواستی را انتخاب کنید'**
  String get select_requested_amount;

  /// No description provided for @enter_requested_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ درخواستی را وارد کنید'**
  String get enter_requested_amount;

  /// No description provided for @requested_amount_multiple.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ درخواستی باید مضربی از {depositPart} ریال باشد'**
  String requested_amount_multiple(String depositPart);

  /// No description provided for @confirm_close_deposit_request.
  ///
  /// In fa, this message translates to:
  /// **'تایید درخواست بستن سپرده'**
  String get confirm_close_deposit_request;

  /// No description provided for @toman.
  ///
  /// In fa, this message translates to:
  /// **'تومان'**
  String get toman;

  /// No description provided for @validation_check_result.
  ///
  /// In fa, this message translates to:
  /// **'نتیجه بررسی اعتبارسنجی'**
  String get validation_check_result;

  /// No description provided for @waiting_to_complete_status.
  ///
  /// In fa, this message translates to:
  /// **'⬤ در انتظار تکمیل'**
  String get waiting_to_complete_status;

  /// No description provided for @average_account.
  ///
  /// In fa, this message translates to:
  /// **'میانگین معدل حساب '**
  String get average_account;

  /// No description provided for @user_message_average.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، سپرده خود را جهت محاسبه میانگین معدل حساب انتخاب نمایید.'**
  String get user_message_average;

  /// No description provided for @no_deposit_message.
  ///
  /// In fa, this message translates to:
  /// **'شما سپرده‌ای از نوع جاری یا کوتاه مدت ندارید'**
  String get no_deposit_message;

  /// No description provided for @warranty_title.
  ///
  /// In fa, this message translates to:
  /// **'مشخصات وثیقه '**
  String get warranty_title;

  /// No description provided for @applicant_title.
  ///
  /// In fa, this message translates to:
  /// **'متقاضی'**
  String get applicant_title;

  /// No description provided for @guarantee_with_customer_number.
  ///
  /// In fa, this message translates to:
  /// **'ضامن با شماره مشتری '**
  String get guarantee_with_customer_number;

  /// No description provided for @warranty_select_message.
  ///
  /// In fa, this message translates to:
  /// **'نوع وثیقه را انتخاب نمایید'**
  String get warranty_select_message;

  /// No description provided for @warranty_error_message.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نوع وثیقه را انتخاب کنید'**
  String get warranty_error_message;

  /// No description provided for @upload_all_pages_of_guarantor_birth_certificate_and_employment_document.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا تصویر تمامی صفحات شناسنامه سند شغلی خود را بارگذاری نمایید. توجه کنید تصاویر می‌بایست از اصل مدارک ضامن باشد'**
  String
      get upload_all_pages_of_guarantor_birth_certificate_and_employment_document;

  /// No description provided for @minimum_average_balance_for_loan_is_10_million_riyal_for_6_months.
  ///
  /// In fa, this message translates to:
  /// **'برای دریافت این تسهیلات، حداقل میانگین موجودی 6 ماه باید ده میلیون ریال یا بیشتر باشد.'**
  String get minimum_average_balance_for_loan_is_10_million_riyal_for_6_months;

  /// No description provided for @no_deposit_found_for_loan_use.
  ///
  /// In fa, this message translates to:
  /// **'سپرده‌ی توبانکی جهت استفاده در این تسهیلات یافت نشد.\n از طریق منوی شعبه شخصی اقدام به افتتاح سپرده کنید.'**
  String get no_deposit_found_for_loan_use;

  /// No description provided for @inventory.
  ///
  /// In fa, this message translates to:
  /// **'موجودی'**
  String get inventory;

  /// No description provided for @remove_guarantor.
  ///
  /// In fa, this message translates to:
  /// **'حذف ضامن'**
  String get remove_guarantor;

  /// No description provided for @guarantor_defined_message.
  ///
  /// In fa, this message translates to:
  /// **'شما یک ضامن با مشخصات زیر تعریف نموده‌اید. در صورتی که تمایل به معرفی ضامن جدید دارید، لطفاً ضامن قبلی را حذف نمایید.'**
  String get guarantor_defined_message;

  /// No description provided for @i_am_a_martyr_sacrifice.
  ///
  /// In fa, this message translates to:
  /// **'ایثارگر هستم'**
  String get i_am_a_martyr_sacrifice;

  /// No description provided for @guarantor_with_customer_number.
  ///
  /// In fa, this message translates to:
  /// **'ضامن با شماره مشتری {PersianNumbers}'**
  String guarantor_with_customer_number(String? PersianNumbers);

  /// No description provided for @insufficient_balance.
  ///
  /// In fa, this message translates to:
  /// **'کمبود موجودی'**
  String get insufficient_balance;

  /// No description provided for @expert_opinion.
  ///
  /// In fa, this message translates to:
  /// **'نظر کارشناس'**
  String get expert_opinion;

  /// No description provided for @document_verified.
  ///
  /// In fa, this message translates to:
  /// **'مدرک تایید شده است'**
  String get document_verified;

  /// No description provided for @cash_deposit.
  ///
  /// In fa, this message translates to:
  /// **'سپرده نقدی:'**
  String get cash_deposit;

  /// No description provided for @fees_and_charges.
  ///
  /// In fa, this message translates to:
  /// **'هزینه و کارمزد'**
  String get fees_and_charges;

  /// No description provided for @current_cash_deposit_balance.
  ///
  /// In fa, this message translates to:
  /// **'موجودی فعلی سپرده نقدی:'**
  String get current_cash_deposit_balance;

  /// No description provided for @collateral_deposit.
  ///
  /// In fa, this message translates to:
  /// **'سپرده بابت وثیقه:'**
  String get collateral_deposit;

  /// No description provided for @collateral_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ وثیقه'**
  String get collateral_amount;

  /// No description provided for @current_collateral_deposit_balance.
  ///
  /// In fa, this message translates to:
  /// **'موجودی فعلی سپرده وثیقه:'**
  String get current_collateral_deposit_balance;

  /// No description provided for @check_balance_button.
  ///
  /// In fa, this message translates to:
  /// **'بررسی موجودی'**
  String get check_balance_button;

  /// No description provided for @military_service_guarantee.
  ///
  /// In fa, this message translates to:
  /// **'ضمانت‌نامه نظام وظیفه'**
  String get military_service_guarantee;

  /// No description provided for @receive_original_guarantee.
  ///
  /// In fa, this message translates to:
  /// **'دریافت اصل ضمانت‌نامه'**
  String get receive_original_guarantee;

  /// No description provided for @military_service_guarantee_delivery_question.
  ///
  /// In fa, this message translates to:
  /// **'آیا ضمانت‌نامه نظام وظیفه توسط پست به شما تحویل داده شده است؟'**
  String get military_service_guarantee_delivery_question;

  /// No description provided for @not_received.
  ///
  /// In fa, this message translates to:
  /// **'تحویل نگرفته‌ام'**
  String get not_received;

  /// No description provided for @received.
  ///
  /// In fa, this message translates to:
  /// **'تحویل گرفته‌ام'**
  String get received;

  /// No description provided for @select_cash_deposit_account.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب شماره سپرده بابت سپرده نقدی'**
  String get select_cash_deposit_account;

  /// No description provided for @select_cash_deposit_explanation.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب سپرده بابت کسر ۲۰٪ سپرده نقدی و حداقل {feeAmount} ریال هزینه‌ها و کارمزد:'**
  String select_cash_deposit_explanation(String? feeAmount);

  /// No description provided for @no_deposit_found.
  ///
  /// In fa, this message translates to:
  /// **'سپرده‌ای جهت استفاده در این ضمانت یافت نشد.\n از طریق منوی شعبه شخصی اقدام به افتتاح سپرده کنید'**
  String get no_deposit_found;

  /// No description provided for @select_collateral_deposit_account.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب شماره سپرده بابت سپرده وثیقه'**
  String get select_collateral_deposit_account;

  /// No description provided for @select_collateral_deposit_explanation.
  ///
  /// In fa, this message translates to:
  /// **'ﺷﻤﺎره ﺳﭙﺮده ﺑﺎﺑﺖ درﯾﺎﻓﺖ وﺛﯿﻘﻪ را اﻧﺘﺨﺎب ﻧﻤﺎﯾﯿﺪ:'**
  String get select_collateral_deposit_explanation;

  /// No description provided for @no_collateral_deposit_found.
  ///
  /// In fa, this message translates to:
  /// **'سپرده‌ای جهت استفاده در این ضمانت یافت نشد.\n از طریق منوی شعبه شخصی اقدام به افتتاح سپرده کنید'**
  String get no_collateral_deposit_found;

  /// No description provided for @submit_collateral_button.
  ///
  /// In fa, this message translates to:
  /// **'ثبت وثیقه'**
  String get submit_collateral_button;

  /// No description provided for @collateral_deposit_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع سپرده بابت وثیقه'**
  String get collateral_deposit_type;

  /// No description provided for @please_select_collateral_deposit_type.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نوع سپرده خود را انتخاب نمایید:'**
  String get please_select_collateral_deposit_type;

  /// No description provided for @applicant_employment_information_registration.
  ///
  /// In fa, this message translates to:
  /// **'ثبت اطلاعات شغلی متقاضی'**
  String get applicant_employment_information_registration;

  /// No description provided for @confirm_employment_document_upload_prompt.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی آیا تمایل دارید نوع شغل خود را ثبت و مدارک شغلی‌تان را بارگذاری کنید؟'**
  String get confirm_employment_document_upload_prompt;

  /// No description provided for @not_interested.
  ///
  /// In fa, this message translates to:
  /// **'تمایل ندارم'**
  String get not_interested;

  /// No description provided for @interested.
  ///
  /// In fa, this message translates to:
  /// **'تمایل دارم'**
  String get interested;

  /// No description provided for @draft_guarantee_commitment_advance.
  ///
  /// In fa, this message translates to:
  /// **'پیش‌نویس ضمانت‌نامه تعهد پرداخت'**
  String get draft_guarantee_commitment_advance;

  /// No description provided for @edit_information.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش اطلاعات'**
  String get edit_information;

  /// No description provided for @upload_employment_documents.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری مدارک شغلی متقاضی'**
  String get upload_employment_documents;

  /// No description provided for @upload_employment_documents_description.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا تصاویر مدارک شغلی متقاضی خود را بارگذاری نمایید. توجه کنید تصاویر می‌بایست از اصل مدارک باشد.'**
  String get upload_employment_documents_description;

  /// No description provided for @image_of_legal_certificate_or_employment_certificate.
  ///
  /// In fa, this message translates to:
  /// **'تصویر فیش حقوقی / گواهی شغلی'**
  String get image_of_legal_certificate_or_employment_certificate;

  /// No description provided for @salary_deduction_certificate.
  ///
  /// In fa, this message translates to:
  /// **'گواهی کسر از حقوق'**
  String get salary_deduction_certificate;

  /// No description provided for @select_employment_type.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب نوع شغل متقاضی'**
  String get select_employment_type;

  /// No description provided for @employment_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع شغل'**
  String get employment_type;

  /// No description provided for @select_employment_type_hint.
  ///
  /// In fa, this message translates to:
  /// **'نوع شغل را انتخاب کنید'**
  String get select_employment_type_hint;

  /// No description provided for @select_employment_type_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نوع شغل را انتخاب کنید'**
  String get select_employment_type_error;

  /// No description provided for @upload_military_service_letter_image.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری تصویر نامه سازمان نظام‌وظیفه'**
  String get upload_military_service_letter_image;

  /// No description provided for @upload_military_service_letter_description.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا تصویر نامه سازمان نظام وظیفه عمومی در خصوص صدور ضمانت‌نامه را بارگذاری کنید'**
  String get upload_military_service_letter_description;

  /// No description provided for @military_service_letter_image_title.
  ///
  /// In fa, this message translates to:
  /// **'تصویر نامه سازمان نظام وظیفه'**
  String get military_service_letter_image_title;

  /// No description provided for @military_service_letter_confirm_button.
  ///
  /// In fa, this message translates to:
  /// **'تایید و ثبت'**
  String get military_service_letter_confirm_button;

  /// No description provided for @beneficiary_address_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات پستی ذینفع'**
  String get beneficiary_address_info;

  /// No description provided for @beneficiary_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی ذینفع'**
  String get beneficiary_postal_code;

  /// No description provided for @job.
  ///
  /// In fa, this message translates to:
  /// **'شغل'**
  String get job;

  /// No description provided for @please_check_beneficiary_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کدپستی ذینفع را استعلام نمایید'**
  String get please_check_beneficiary_postal_code;

  /// No description provided for @enter_beneficiary_main_street.
  ///
  /// In fa, this message translates to:
  /// **'خیابان اصلی ذینفع را وارد نمایید'**
  String get enter_beneficiary_main_street;

  /// No description provided for @enter_beneficiary_second_street.
  ///
  /// In fa, this message translates to:
  /// **'خیابان فرعی ذینفع را وارد نمایید'**
  String get enter_beneficiary_second_street;

  /// No description provided for @enter_beneficiary_plaque.
  ///
  /// In fa, this message translates to:
  /// **'پلاک ذینفع را وارد نمایید'**
  String get enter_beneficiary_plaque;

  /// No description provided for @enter_beneficiary_unit.
  ///
  /// In fa, this message translates to:
  /// **'واحد ذینفع را وارد نمایید'**
  String get enter_beneficiary_unit;

  /// No description provided for @beneficiary_details_title.
  ///
  /// In fa, this message translates to:
  /// **'مشخصات ذینفع(سازمان نظام وظیفه)'**
  String get beneficiary_details_title;

  /// No description provided for @name.
  ///
  /// In fa, this message translates to:
  /// **'نام'**
  String get name;

  /// No description provided for @enter_beneficiary_name.
  ///
  /// In fa, this message translates to:
  /// **'نام سازمان را وارد کنید'**
  String get enter_beneficiary_name;

  /// No description provided for @please_enter_beneficiary_name_value.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار نام سازمان را وارد نمایید'**
  String get please_enter_beneficiary_name_value;

  /// No description provided for @national_code.
  ///
  /// In fa, this message translates to:
  /// **'شناسه ملی'**
  String get national_code;

  /// No description provided for @enter_beneficiary_national_code.
  ///
  /// In fa, this message translates to:
  /// **'شناسه ملی سازمان را وارد کنید'**
  String get enter_beneficiary_national_code;

  /// No description provided for @organization_enter_contact_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تماس سازمان را وارد نمایید'**
  String get organization_enter_contact_number;

  /// No description provided for @please_organization_enter_contact_number.
  ///
  /// In fa, this message translates to:
  /// **'لطفا شماره تماس سازمان را وارد نمایید'**
  String get please_organization_enter_contact_number;

  /// No description provided for @please_organization_enter_national_code_number.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار شناسه ملی را وارد نمایید'**
  String get please_organization_enter_national_code_number;

  /// No description provided for @contact_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تماس'**
  String get contact_number;

  /// No description provided for @guarantee_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات ضمانت‌نامه مشمول'**
  String get guarantee_information;

  /// No description provided for @guarantee_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ ضمانت‌نامه'**
  String get guarantee_amount;

  /// No description provided for @enter_guarantee_amount_rial.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ ضمانت‌نامه را به ریال وارد کنید'**
  String get enter_guarantee_amount_rial;

  /// No description provided for @military_letter_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره نامه نظام‌ وظیفه'**
  String get military_letter_number;

  /// No description provided for @enter_military_letter_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره نامه نظام‌وظیفه را وارد نمایید'**
  String get enter_military_letter_number;

  /// No description provided for @please_enter_invalid_amount.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار معتبری وارد نمایید'**
  String get please_enter_invalid_amount;

  /// No description provided for @military_letter_issue_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ صدور نامه نظام وظیفه'**
  String get military_letter_issue_date;

  /// No description provided for @select_military_letter_issue_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ صدور نامه نظام‌وظیفه را انتخاب کنید'**
  String get select_military_letter_issue_date;

  /// No description provided for @valid_military_letter_issue_date_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ صدور نامه نظام‌وظیفه را انتخاب کنید'**
  String get valid_military_letter_issue_date_error;

  /// No description provided for @military_letter_due_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ سررسید نامه نظام وظیفه'**
  String get military_letter_due_date;

  /// No description provided for @select_military_letter_due_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ سررسید نامه نظام‌وظیفه را انتخاب کنید'**
  String get select_military_letter_due_date;

  /// No description provided for @valid_military_letter_due_date_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ سررسید نامه نظام‌وظیفه را انتخاب کنید'**
  String get valid_military_letter_due_date_error;

  /// No description provided for @image_certificate_or_student_document.
  ///
  /// In fa, this message translates to:
  /// **'تصویر استشهادنامه/مدرک اشتغال به تحصیل'**
  String get image_certificate_or_student_document;

  /// No description provided for @applicant_residence_ownership_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات مالکیت محل سکونت متقاضی'**
  String get applicant_residence_ownership_info;

  /// No description provided for @user_message_residence_ownership.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، لطفا اطلاعات نوع مالکیت محل سکونت خود را وارد و تصویر اصل سند یا اجاره نامه محل سکونت خود را بارگذاری نمایید.'**
  String get user_message_residence_ownership;

  /// No description provided for @business_license_image.
  ///
  /// In fa, this message translates to:
  /// **'تصویر جواز کسب'**
  String get business_license_image;

  /// No description provided for @applicant_residence_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات محل سکونت متقاضی'**
  String get applicant_residence_info;

  /// No description provided for @please_inquire_beneficiary_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کدپستی مشمول را استعلام نمایید'**
  String get please_inquire_beneficiary_postal_code;

  /// No description provided for @enter_main_street_of_beneficiary.
  ///
  /// In fa, this message translates to:
  /// **'خیابان اصلی مشمول را وارد نمایید'**
  String get enter_main_street_of_beneficiary;

  /// No description provided for @beneficiary_identity_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات هویتی مشمول'**
  String get beneficiary_identity_info;

  /// No description provided for @dont_have_national_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت ملی هوشمند ندارم'**
  String get dont_have_national_card;

  /// No description provided for @enter_national_code.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی مشمول را وارد کنید'**
  String get enter_national_code;

  /// No description provided for @national_id_tracking_number.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری رسید کاغذی کارت ملی هوشمند'**
  String get national_id_tracking_number;

  /// No description provided for @serial_back_national_id.
  ///
  /// In fa, this message translates to:
  /// **'سریال پشت کارت ملی هوشمند'**
  String get serial_back_national_id;

  /// No description provided for @enter_tracking_code.
  ///
  /// In fa, this message translates to:
  /// **'کد رهگیری رسید مشمول را وارد نمایید'**
  String get enter_tracking_code;

  /// No description provided for @enter_serial_back_id.
  ///
  /// In fa, this message translates to:
  /// **'سریال پشت کارت ملی مشمول را وارد نمایید'**
  String get enter_serial_back_id;

  /// No description provided for @birth_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد'**
  String get birth_date;

  /// No description provided for @enter_birth_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد را وارد کنید'**
  String get enter_birth_date;

  /// No description provided for @enter_birth_date_beneficiary.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد مشمول را انتخاب کنید'**
  String get enter_birth_date_beneficiary;

  /// No description provided for @enter_valid_mobile_number_value.
  ///
  /// In fa, this message translates to:
  /// **'مقدار موبایل همراه را وارد کنید'**
  String get enter_valid_mobile_number_value;

  /// No description provided for @enter_beneficiary_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره موبایل مشمول را وارد نمایید'**
  String get enter_beneficiary_mobile_number;

  /// No description provided for @contract_acceptance_tosigh.
  ///
  /// In fa, this message translates to:
  /// **'پذیرش قرارداد توثیق'**
  String get contract_acceptance_tosigh;

  /// No description provided for @contract_acceptance_warranty.
  ///
  /// In fa, this message translates to:
  /// **'پذیرش قرارداد ضمانت'**
  String get contract_acceptance_warranty;

  /// No description provided for @digital_signature.
  ///
  /// In fa, this message translates to:
  /// **'امضای دیجیتال'**
  String get digital_signature;

  /// No description provided for @job_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع شغل:'**
  String get job_type;

  /// No description provided for @rayan_credit_card_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ رایان کارت'**
  String get rayan_credit_card_amount;

  /// No description provided for @rayan_select_credit_card_amount_hint.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ رایان کارت را انتخاب کنید'**
  String get rayan_select_credit_card_amount_hint;

  /// No description provided for @rayan_card_facility.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات رایان کارت'**
  String get rayan_card_facility;

  /// No description provided for @rayan_card_loan_conditions_and_rules_title.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات درخواست تسهیلات رایان کارت'**
  String get rayan_card_loan_conditions_and_rules_title;

  /// No description provided for @rayan_card_accept_loan_rules_and_conditions.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات تسهیلات رایان کارت را قبول دارم'**
  String get rayan_card_accept_loan_rules_and_conditions;

  /// No description provided for @small_loan_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تسهیلات خرد'**
  String get small_loan_amount;

  /// No description provided for @small_loan.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات خرد'**
  String get small_loan;

  /// No description provided for @select_small_loan_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تسهیلات خرد را انتخاب کنید'**
  String get select_small_loan_amount;

  /// No description provided for @small_loan_terms_and_conditions.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات درخواست تسهیلات خرد'**
  String get small_loan_terms_and_conditions;

  /// No description provided for @accept_small_loan_terms_and_conditions.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات تسهیلات خرد را قبول دارم'**
  String get accept_small_loan_terms_and_conditions;

  /// No description provided for @show_credit_evaluation.
  ///
  /// In fa, this message translates to:
  /// **'نمایش اعتبارسنجی'**
  String get show_credit_evaluation;

  /// No description provided for @request_pazirandegi.
  ///
  /// In fa, this message translates to:
  /// **'درخواست پذیرندگی'**
  String get request_pazirandegi;

  /// No description provided for @credit_evaluation_report.
  ///
  /// In fa, this message translates to:
  /// **'گزارش اعتبارسنجی'**
  String get credit_evaluation_report;

  /// No description provided for @credit_evaluation_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ اعتبار سنجی'**
  String get credit_evaluation_date;

  /// No description provided for @tracking_code_peygiri.
  ///
  /// In fa, this message translates to:
  /// **'کد پیگیری'**
  String get tracking_code_peygiri;

  /// No description provided for @view.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده'**
  String get view;

  /// No description provided for @myself.
  ///
  /// In fa, this message translates to:
  /// **'خودم'**
  String get myself;

  /// No description provided for @others.
  ///
  /// In fa, this message translates to:
  /// **'دیگران'**
  String get others;

  /// No description provided for @sim_card_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره سیم‌کارت'**
  String get sim_card_number;

  /// No description provided for @invitation_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ دعوت'**
  String get invitation_date;

  /// No description provided for @ipg_pos_request.
  ///
  /// In fa, this message translates to:
  /// **'سرویس درخواست POS و IPG'**
  String get ipg_pos_request;

  /// No description provided for @payment_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ پرداخت'**
  String get payment_amount;

  /// No description provided for @payment_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ پرداخت'**
  String get payment_date;

  /// No description provided for @credit_report_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی گزارش اعتبارسنجی شما در بخش گزارش‌ها نیز قابل مشاهده است'**
  String get credit_report_message;

  /// No description provided for @view_credit_report.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده گزارش اعتبارسنجی'**
  String get view_credit_report;

  /// No description provided for @credit_check.
  ///
  /// In fa, this message translates to:
  /// **'اعتبارسنجی'**
  String get credit_check;

  /// No description provided for @credit_check_description.
  ///
  /// In fa, this message translates to:
  /// **'اعتبارسنجی به منظور بررسی وضعیت اعتباری اشخاص و تعیین میزان اعتبار شخص، بر اساس اینکه بدهی معوق و چک برگشتی دارند و همچنین تسهیلات گذشته اشخاص انجام می‌شود و بر اساس ابزارهای مالی و تحلیل اطلاعات شخص حد اعتباری متقاضی تعیین می‌گردد'**
  String get credit_check_description;

  /// No description provided for @dont_show_page_again.
  ///
  /// In fa, this message translates to:
  /// **'این صفحه را دیگر به من نشان نده.'**
  String get dont_show_page_again;

  /// No description provided for @reports.
  ///
  /// In fa, this message translates to:
  /// **'گزارش‌ها'**
  String get reports;

  /// No description provided for @show_contract.
  ///
  /// In fa, this message translates to:
  /// **'نمایش قرارداد'**
  String get show_contract;

  /// No description provided for @save_contract.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره قرارداد'**
  String get save_contract;

  /// No description provided for @front_of_card.
  ///
  /// In fa, this message translates to:
  /// **'روی کارت'**
  String get front_of_card;

  /// No description provided for @gift_amount_label.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ هدیه'**
  String get gift_amount_label;

  /// No description provided for @pending_status.
  ///
  /// In fa, this message translates to:
  /// **'در حال انتظار'**
  String get pending_status;

  /// No description provided for @back_of_card.
  ///
  /// In fa, this message translates to:
  /// **'پشت کارت'**
  String get back_of_card;

  /// No description provided for @upload_successful.
  ///
  /// In fa, this message translates to:
  /// **'⬤ بارگذاری موفق'**
  String get upload_successful;

  /// No description provided for @uploading_image.
  ///
  /// In fa, this message translates to:
  /// **'در حال آپلود تصویر'**
  String get uploading_image;

  /// No description provided for @mtn.
  ///
  /// In fa, this message translates to:
  /// **'mtn'**
  String get mtn;

  /// No description provided for @mci.
  ///
  /// In fa, this message translates to:
  /// **'mci'**
  String get mci;

  /// No description provided for @rightel.
  ///
  /// In fa, this message translates to:
  /// **'rightel'**
  String get rightel;

  /// No description provided for @shatel.
  ///
  /// In fa, this message translates to:
  /// **'shatel'**
  String get shatel;

  /// No description provided for @ir_iran.
  ///
  /// In fa, this message translates to:
  /// **'I.R.\\nIRAN'**
  String get ir_iran;

  /// No description provided for @light.
  ///
  /// In fa, this message translates to:
  /// **'light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In fa, this message translates to:
  /// **'dark'**
  String get dark;

  /// No description provided for @pending_ENG.
  ///
  /// In fa, this message translates to:
  /// **'pending'**
  String get pending_ENG;

  /// No description provided for @internet_bank_password_issued_message.
  ///
  /// In fa, this message translates to:
  /// **'رمز اینترنت بانک صادر گردید!'**
  String get internet_bank_password_issued_message;

  /// No description provided for @services_list_title.
  ///
  /// In fa, this message translates to:
  /// **'لیست سرویس‌های استعلامی'**
  String get services_list_title;

  /// No description provided for @credit_check_service.
  ///
  /// In fa, this message translates to:
  /// **'سامانه اعتبارسنجی'**
  String get credit_check_service;

  /// No description provided for @returned_cheque_service.
  ///
  /// In fa, this message translates to:
  /// **'چک برگشتی'**
  String get returned_cheque_service;

  /// No description provided for @bank_blacklist_service.
  ///
  /// In fa, this message translates to:
  /// **'لیست سیاه بانکی'**
  String get bank_blacklist_service;

  /// No description provided for @loan_request_title.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ درخواستی و مدت زمان بازپرداخت را مشخص کنید'**
  String get loan_request_title;

  /// No description provided for @credit_ranking_label.
  ///
  /// In fa, this message translates to:
  /// **'رتبه اعتبارسنجی'**
  String get credit_ranking_label;

  /// No description provided for @payable_amount_label.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ قابل پرداخت:'**
  String get payable_amount_label;

  /// No description provided for @repayment_duration_label.
  ///
  /// In fa, this message translates to:
  /// **'دوره بازپرداخت:'**
  String get repayment_duration_label;

  /// No description provided for @installment_amount_label.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ هر قسط'**
  String get installment_amount_label;

  /// No description provided for @pol_tranfer.
  ///
  /// In fa, this message translates to:
  /// **'انتقال پل'**
  String get pol_tranfer;

  /// No description provided for @installment_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ قسط'**
  String get installment_amount;

  /// No description provided for @pol_tranfer_message.
  ///
  /// In fa, this message translates to:
  /// **'حداکثر مبلغ برای انتقال پل ۵۰.۰۰۰.۰۰۰ تومان است.'**
  String get pol_tranfer_message;

  /// No description provided for @total_repayment_label.
  ///
  /// In fa, this message translates to:
  /// **'مجموع بازپرداخت'**
  String get total_repayment_label;

  /// No description provided for @pdf_title.
  ///
  /// In fa, this message translates to:
  /// **'قرارداد توربو وام'**
  String get pdf_title;

  /// No description provided for @return_to_loan_list_button.
  ///
  /// In fa, this message translates to:
  /// **'بازگشت به لیست تسهیلات'**
  String get return_to_loan_list_button;

  /// No description provided for @average_balance_and_deposit_opening_time_title.
  ///
  /// In fa, this message translates to:
  /// **'محاسبه میانگین موجودی و زمان افتتاح سپرده'**
  String get average_balance_and_deposit_opening_time_title;

  /// No description provided for @select_deposit_instruction.
  ///
  /// In fa, this message translates to:
  /// **'کاربرگرامی، سپرده خود را جهت محاسبه میانگین موجودی و بررسی زمان افتتاح سپرده انتخاب نمایید'**
  String get select_deposit_instruction;

  /// No description provided for @credit_check_title.
  ///
  /// In fa, this message translates to:
  /// **'استعلام رتبه اعتبارسنجی'**
  String get credit_check_title;

  /// No description provided for @credit_check_message.
  ///
  /// In fa, this message translates to:
  /// **'مشتری گرامی، هزینه‌های بررسی رتبه اعتباری شما شامل موارد زیر می‌باشد'**
  String get credit_check_message;

  /// No description provided for @loan_conditions_title.
  ///
  /// In fa, this message translates to:
  /// **'بررسی شرایط تسهیلات بر اساس میانگین موجودی'**
  String get loan_conditions_title;

  /// No description provided for @loan_conditions_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، با توجه به میانگین موجودی فعلی شما، واجد شرایط دریافت تسهیلات هستید. سقف تسهیلات قابل پرداخت به شما به شرح زیر است'**
  String get loan_conditions_message;

  /// No description provided for @max_payable_loan_key.
  ///
  /// In fa, this message translates to:
  /// **'سقف تسهیلات قابل پرداخت'**
  String get max_payable_loan_key;

  /// No description provided for @turbo_loan.
  ///
  /// In fa, this message translates to:
  /// **'توربو وام'**
  String get turbo_loan;

  /// No description provided for @rules_title.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات توربو وام'**
  String get rules_title;

  /// No description provided for @accept_rules.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات توربو وام را قبول دارم'**
  String get accept_rules;

  /// No description provided for @no_deposit_found_message2.
  ///
  /// In fa, this message translates to:
  /// **'سپرده‌ جهت استفاده در این تسهیلات یافت نشد.\n از طریق منوی شعبه شخصی اقدام به افتتاح سپرده کنید.'**
  String get no_deposit_found_message2;

  /// No description provided for @average_period.
  ///
  /// In fa, this message translates to:
  /// **'دوره میانگین‌گیری'**
  String get average_period;

  /// No description provided for @credit_score_rules_title.
  ///
  /// In fa, this message translates to:
  /// **'ضوابط و تعهدنامه استعلام رتبه اعتبارسنجی'**
  String get credit_score_rules_title;

  /// No description provided for @credit_score_rules_notice.
  ///
  /// In fa, this message translates to:
  /// **'فرآیند اخذ تسهیلات شامل اعتبارسنجی‌ها و پرداخت‌های کارمزد، {expirationDuration} ساعت معتبر خواهد بود و بعد از گذشت این زمان از شروع فرآیند، مجددا باید فرآیند را طی کنید.'**
  String credit_score_rules_notice(int? expirationDuration);

  /// No description provided for @accept_credit_score_rules.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و ضوابط فوق را به طور کامل بررسی نموده و آنها را تایید می‌کنم.'**
  String get accept_credit_score_rules;

  /// No description provided for @identity_update.
  ///
  /// In fa, this message translates to:
  /// **'بروزرسانی احراز هویت'**
  String get identity_update;

  /// No description provided for @job_entry_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا شغل را وارد کنید'**
  String get job_entry_error;

  /// No description provided for @job_input_hint.
  ///
  /// In fa, this message translates to:
  /// **'شغل خود را وارد کنید'**
  String get job_input_hint;

  /// No description provided for @complete_authentication_existing_customer.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی،\n با تکمیل اطلاعات زیر، مراحل احراز هویت شما به اتمام می‌رسد و می‌توانید از خدمات برنامه استفاده کنید.'**
  String get complete_authentication_existing_customer;

  /// No description provided for @complete_authentication_new_customer.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی،\nبا تکمیل اطلاعات زیر، شما به عنوان مشتری بانک گردشگری تعریف خواهید شد.'**
  String get complete_authentication_new_customer;

  /// No description provided for @invite_code_optional_prompt.
  ///
  /// In fa, this message translates to:
  /// **'در صورت تمایل، کد معرفِ دوستانتان را وارد کنید.'**
  String get invite_code_optional_prompt;

  /// No description provided for @activity_field_title.
  ///
  /// In fa, this message translates to:
  /// **'حوزه فعالیت'**
  String get activity_field_title;

  /// No description provided for @select_activity_field_prompt.
  ///
  /// In fa, this message translates to:
  /// **'حوزه فعالیت خود را انتخاب کنید'**
  String get select_activity_field_prompt;

  /// No description provided for @job_field_error_message.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از حوزه‌های فعالیت را انتخاب کنید'**
  String get job_field_error_message;

  /// No description provided for @job_title_label.
  ///
  /// In fa, this message translates to:
  /// **'عنوان شغلی'**
  String get job_title_label;

  /// No description provided for @enter_job_title_placeholder.
  ///
  /// In fa, this message translates to:
  /// **'عنوان شغلی خود را بنویسید'**
  String get enter_job_title_placeholder;

  /// No description provided for @job_title_error_message.
  ///
  /// In fa, this message translates to:
  /// **'عنوان شغلی خود را بنویسید'**
  String get job_title_error_message;

  /// No description provided for @select_date_time_fund_visit.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ و بازه زمانی بازدید صندوق را انتخاب کنید'**
  String get select_date_time_fund_visit;

  /// No description provided for @request_visit_box_successful.
  ///
  /// In fa, this message translates to:
  /// **'درخواست بازدید از صندوق با موفقیت ثبت شد!'**
  String get request_visit_box_successful;

  /// No description provided for @optional_invitation_code_label.
  ///
  /// In fa, this message translates to:
  /// **'کد دعوت(اختیاری)'**
  String get optional_invitation_code_label;

  /// No description provided for @enter_invitation_code_placeholder.
  ///
  /// In fa, this message translates to:
  /// **'کد دعوت را وارد نمایید'**
  String get enter_invitation_code_placeholder;

  /// No description provided for @non_attendance_deposit_opening_rules.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات افتتاح سپرده غیرحضوری'**
  String get non_attendance_deposit_opening_rules;

  /// No description provided for @deposit_terms_and_conditions_acceptance.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات .{depositType} به شرح فوق را رویت و مورد تایید و قبول اینجانب می‌باشد'**
  String deposit_terms_and_conditions_acceptance(String depositType);

  /// No description provided for @term_deposit_instructions.
  ///
  /// In fa, this message translates to:
  /// **'جهت افتتاح سپرده مدت دار، نیازمند انتخاب سپرده‌ای از بانک گردشگری جهت واریز وجه می‌باشید. در پایان سپرده مقصد خود را جهت واریز سود انتخاب نمایید و سپرده مدت دار خود را افتتاح کنید.'**
  String get term_deposit_instructions;

  /// No description provided for @initial_deposit_requirement.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، به جهت افتتاح سپرده مدت دار و تکمیل وجه اولیه، می‌بایست ابتدا یک سپرده کوتاه مدت یا قرض‌الحسنه پس‌انداز نزد بانک گردشگری داشته باشید.'**
  String get initial_deposit_requirement;

  /// No description provided for @start_deposit_process_button.
  ///
  /// In fa, this message translates to:
  /// **'شروع فرآیند افتتاح سپرده'**
  String get start_deposit_process_button;

  /// No description provided for @deposit_opening_success_message.
  ///
  /// In fa, this message translates to:
  /// **'افتتاح {depositTypeSelected} با موفقیت انجام شد!'**
  String deposit_opening_success_message(String? depositTypeSelected);

  /// No description provided for @long_term_deposit_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده مدت دار'**
  String get long_term_deposit_number;

  /// No description provided for @general_terms_conditions.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات عمومی افتتاح سپرده مدت دار'**
  String get general_terms_conditions;

  /// No description provided for @agree_terms.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات عمومی افتتاح سپرده مدت دار به شرح فوق را رویت و مورد تایید و قبول اینجانب می‌باشد'**
  String get agree_terms;

  /// No description provided for @select_deposit.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب سپرده'**
  String get select_deposit;

  /// No description provided for @deposit_instructions.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، سپرده‌ای که می‌خواهید از آن برداشت وجه جهت واریز و افتتاح سپرده مدت دار انجام دهید را انتخاب نمایید'**
  String get deposit_instructions;

  /// No description provided for @minimum_deposit_amount_10mil_rial.
  ///
  /// In fa, this message translates to:
  /// **'حداقل مبلغ قابل واریز ۱۰.۰۰۰.۰۰۰ ریال است'**
  String get minimum_deposit_amount_10mil_rial;

  /// No description provided for @opening_deposit_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ افتتاح سپرده'**
  String get opening_deposit_amount;

  /// No description provided for @amount_input_hint.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ افتتاح سپرده را به ریال وارد نمایید'**
  String get amount_input_hint;

  /// No description provided for @invalid_amount_message.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مبلغ معتبر وارد نمایید'**
  String get invalid_amount_message;

  /// No description provided for @confirm_amount_button.
  ///
  /// In fa, this message translates to:
  /// **'تایید مبلغ'**
  String get confirm_amount_button;

  /// No description provided for @destination_deposit_selection_title.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب سپرده مقصد سود'**
  String get destination_deposit_selection_title;

  /// No description provided for @deposit_type_label.
  ///
  /// In fa, this message translates to:
  /// **'نوع سپرده'**
  String get deposit_type_label;

  /// No description provided for @source_deposit_number_label.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده برداشت وجه'**
  String get source_deposit_number_label;

  /// No description provided for @destination_deposit_number_label.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده واریز سود'**
  String get destination_deposit_number_label;

  /// No description provided for @deposit_amount_label.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ واریزی'**
  String get deposit_amount_label;

  /// No description provided for @amount_format.
  ///
  /// In fa, this message translates to:
  /// **'{amount} ریال'**
  String amount_format(String amount);

  /// No description provided for @parsa_facilities.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات پارسا'**
  String get parsa_facilities;

  /// No description provided for @annually_2_4.
  ///
  /// In fa, this message translates to:
  /// **'۲٪ یا ۴٪ سالانه'**
  String get annually_2_4;

  /// No description provided for @electronic_guarantee_amount.
  ///
  /// In fa, this message translates to:
  /// **'سفته الکترونیک به مبلغ'**
  String get electronic_guarantee_amount;

  /// No description provided for @collateral.
  ///
  /// In fa, this message translates to:
  /// **'وثایق'**
  String get collateral;

  /// No description provided for @specify_requested_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ درخواستی را مشخص کنید'**
  String get specify_requested_amount;

  /// No description provided for @confirm_deposit_button.
  ///
  /// In fa, this message translates to:
  /// **'تایید اطلاعات و افتتاح سپرده'**
  String get confirm_deposit_button;

  /// No description provided for @open_term_deposit.
  ///
  /// In fa, this message translates to:
  /// **'افتتاح سپرده مدت دار'**
  String get open_term_deposit;

  /// No description provided for @select_destination_deposit_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، سپرده‌ای که می‌خواهید سود سپرده مدت دار شما به آن واریز گردد را انتخاب نمایید.'**
  String get select_destination_deposit_message;

  /// No description provided for @select_branch_agent.
  ///
  /// In fa, this message translates to:
  /// **'شعبه عامل را انتخاب کنید'**
  String get select_branch_agent;

  /// No description provided for @please_select_branch_agent.
  ///
  /// In fa, this message translates to:
  /// **'لطفا شعبه عامل را انتخاب نمایید'**
  String get please_select_branch_agent;

  /// No description provided for @select_branch_agent_note.
  ///
  /// In fa, this message translates to:
  /// **'لطفا جهت بررسی پرونده خود یکی از شعب بانک گردشگری را انتخاب نمائید.'**
  String get select_branch_agent_note;

  /// No description provided for @documents_completed_successfully.
  ///
  /// In fa, this message translates to:
  /// **'تکمیل مدارک با موفقیت انجام شد'**
  String get documents_completed_successfully;

  /// No description provided for @parsa_loan_contract_success_message.
  ///
  /// In fa, this message translates to:
  /// **'قرارداد تسهیلات پارسا'**
  String get parsa_loan_contract_success_message;

  /// No description provided for @end.
  ///
  /// In fa, this message translates to:
  /// **'پایان'**
  String get end;

  /// No description provided for @pazirandegi.
  ///
  /// In fa, this message translates to:
  /// **'پذیرندگی'**
  String get pazirandegi;

  /// No description provided for @required_documents.
  ///
  /// In fa, this message translates to:
  /// **'مدارک مورد نیاز'**
  String get required_documents;

  /// No description provided for @identity_documents.
  ///
  /// In fa, this message translates to:
  /// **'مدارک هویتی'**
  String get identity_documents;

  /// No description provided for @pages_of_birth_certificate.
  ///
  /// In fa, this message translates to:
  /// **'صفحات شناسنامه'**
  String get pages_of_birth_certificate;

  /// No description provided for @occupation_documents.
  ///
  /// In fa, this message translates to:
  /// **'مدارک شغلی متقاضی'**
  String get occupation_documents;

  /// No description provided for @employee_documents.
  ///
  /// In fa, this message translates to:
  /// **'کارمند: بارگذاری تصویر فیش حقوقی/گواهی، شغلی گواهی کسر از حقوق'**
  String get employee_documents;

  /// No description provided for @retiree_documents.
  ///
  /// In fa, this message translates to:
  /// **'بازنشسته: بارگذاری تصویر حکم باز نشستگی'**
  String get retiree_documents;

  /// No description provided for @self_employed_documents.
  ///
  /// In fa, this message translates to:
  /// **'آزاد: بارگذاری تصویر جواز کسب'**
  String get self_employed_documents;

  /// No description provided for @select_employment_type_.
  ///
  /// In fa, this message translates to:
  /// **'نوع شغل را انتخاب نمایید'**
  String get select_employment_type_;

  /// No description provided for @employment_type_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نوع شغل را انتخاب کنید'**
  String get employment_type_error;

  /// No description provided for @workplace_address_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات پستی محل کار کارمند'**
  String get workplace_address_info;

  /// No description provided for @postal_code_label.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی محل کار کارمند'**
  String get postal_code_label;

  /// No description provided for @mandatory_documents.
  ///
  /// In fa, this message translates to:
  /// **'ارائه یکی از مدارک ذیل الزامی است.'**
  String get mandatory_documents;

  /// No description provided for @customer_commitment_form_title.
  ///
  /// In fa, this message translates to:
  /// **'فرم تعهدات مشتری در سامانه توبانک'**
  String get customer_commitment_form_title;

  /// No description provided for @parsa_loan_plans_based_on_balance.
  ///
  /// In fa, this message translates to:
  /// **'طرح‌های تسهیلات پارسا براساس میانگین موجودی شما'**
  String get parsa_loan_plans_based_on_balance;

  /// No description provided for @average_not_found_in_period.
  ///
  /// In fa, this message translates to:
  /// **'میانگینی در دوره یافت نشد'**
  String get average_not_found_in_period;

  /// No description provided for @no_plan_found.
  ///
  /// In fa, this message translates to:
  /// **'طرح تسهیلات یافت نشد.'**
  String get no_plan_found;

  /// No description provided for @remove_filters.
  ///
  /// In fa, this message translates to:
  /// **'حذف فیلترها'**
  String get remove_filters;

  /// No description provided for @service_fee.
  ///
  /// In fa, this message translates to:
  /// **'نرخ کارمزد:'**
  String get service_fee;

  /// No description provided for @repayment.
  ///
  /// In fa, this message translates to:
  /// **'بازپرداخت:'**
  String get repayment;

  /// No description provided for @apply_filters.
  ///
  /// In fa, this message translates to:
  /// **'اعمال فیلتر'**
  String get apply_filters;

  /// No description provided for @averaging_period_not_found.
  ///
  /// In fa, this message translates to:
  /// **'دوره میانگین گیری یافت نشد'**
  String get averaging_period_not_found;

  /// No description provided for @loan_fee.
  ///
  /// In fa, this message translates to:
  /// **'کارمزد تسهیلات'**
  String get loan_fee;

  /// No description provided for @percent.
  ///
  /// In fa, this message translates to:
  /// **'درصد'**
  String get percent;

  /// No description provided for @service_fee_text.
  ///
  /// In fa, this message translates to:
  /// **'نرخ کارمزد {perecent}%'**
  String service_fee_text(int perecent);

  /// No description provided for @commitment_check_title.
  ///
  /// In fa, this message translates to:
  /// **'اینجانب در کمال صحت و سلامت و با قبول ضوابط فوق الذکر نسبت به ثبت درخواست و بارگزاری مدارک در سامانه اقدام نموده و حق هرگونه اعتراضی را از خود سلب و ساقط نمودم.'**
  String get commitment_check_title;

  /// No description provided for @process_start_time.
  ///
  /// In fa, this message translates to:
  /// **'شروع فرآیند'**
  String get process_start_time;

  /// No description provided for @my_actions.
  ///
  /// In fa, this message translates to:
  /// **'اقدامات من'**
  String get my_actions;

  /// No description provided for @process_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت فرآیند'**
  String get process_status;

  /// No description provided for @process_result_rejected.
  ///
  /// In fa, this message translates to:
  /// **'نتیجه فرآیند'**
  String get process_result_rejected;

  /// No description provided for @request_rejected.
  ///
  /// In fa, this message translates to:
  /// **'رد شدن درخواست'**
  String get request_rejected;

  /// No description provided for @process_detail.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات'**
  String get process_detail;

  /// No description provided for @deposit_closing_description.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات'**
  String get deposit_closing_description;

  /// No description provided for @promissory_id_treasury.
  ///
  /// In fa, this message translates to:
  /// **'شناسه خزانه‌داری سفته'**
  String get promissory_id_treasury;

  /// No description provided for @promissory_due_date.
  ///
  /// In fa, this message translates to:
  /// **'سررسید سفته'**
  String get promissory_due_date;

  /// No description provided for @marriage_loan_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تسهیلات ازدواج'**
  String get marriage_loan_amount;

  /// No description provided for @parcel_code.
  ///
  /// In fa, this message translates to:
  /// **'کد مرسوله'**
  String get parcel_code;

  /// No description provided for @unique_promissory_id.
  ///
  /// In fa, this message translates to:
  /// **'شناسه یکتای سفته'**
  String get unique_promissory_id;

  /// No description provided for @unique_promissory_code.
  ///
  /// In fa, this message translates to:
  /// **'کد یکتای سفته'**
  String get unique_promissory_code;

  /// No description provided for @enter_unique_promissory_id.
  ///
  /// In fa, this message translates to:
  /// **'شناسه یکتای سفته را وارد کنید'**
  String get enter_unique_promissory_id;

  /// No description provided for @role.
  ///
  /// In fa, this message translates to:
  /// **'نقش'**
  String get role;

  /// No description provided for @parcel_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت پست'**
  String get parcel_status;

  /// No description provided for @promissory_id.
  ///
  /// In fa, this message translates to:
  /// **'شناسه خزانه‌داری سفته'**
  String get promissory_id;

  /// No description provided for @applicant_reject_reason.
  ///
  /// In fa, this message translates to:
  /// **'علت رد شدن متقاضی'**
  String get applicant_reject_reason;

  /// No description provided for @promissory_owner_national_code.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی صاحب سفته'**
  String get promissory_owner_national_code;

  /// No description provided for @final_approval_reject_reason.
  ///
  /// In fa, this message translates to:
  /// **'علت رد شدن تایید نهایی'**
  String get final_approval_reject_reason;

  /// No description provided for @creation_time.
  ///
  /// In fa, this message translates to:
  /// **'زمان ایجاد'**
  String get creation_time;

  /// No description provided for @completion_time.
  ///
  /// In fa, this message translates to:
  /// **'زمان اتمام'**
  String get completion_time;

  /// No description provided for @task_status_completed.
  ///
  /// In fa, this message translates to:
  /// **'تکمیل‌شده'**
  String get task_status_completed;

  /// No description provided for @task_status_pending.
  ///
  /// In fa, this message translates to:
  /// **'در انتظار تکمیل'**
  String get task_status_pending;

  /// No description provided for @compeleted.
  ///
  /// In fa, this message translates to:
  /// **'تکمیل شده'**
  String get compeleted;

  /// No description provided for @process_details.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات فرآیند'**
  String get process_details;

  /// No description provided for @national_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت ملی'**
  String get national_card;

  /// No description provided for @process_details_title.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات فرآیند'**
  String get process_details_title;

  /// No description provided for @user_instruction.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی،\n لطفا موارد زیر را جهت احراز هویت آماده نمایید.'**
  String get user_instruction;

  /// No description provided for @required_documents_for_verification.
  ///
  /// In fa, this message translates to:
  /// **'مدارک لازم جهت احراز هویت'**
  String get required_documents_for_verification;

  /// No description provided for @identity_card.
  ///
  /// In fa, this message translates to:
  /// **'شناسنامه'**
  String get identity_card;

  /// No description provided for @security_activation_instruction.
  ///
  /// In fa, this message translates to:
  /// **'فعال‌سازی حداقل یکی از موارد امنیتی زیر'**
  String get security_activation_instruction;

  /// No description provided for @phone_password.
  ///
  /// In fa, this message translates to:
  /// **'رمز گوشی'**
  String get phone_password;

  /// No description provided for @phone_pin.
  ///
  /// In fa, this message translates to:
  /// **'پین گوشی'**
  String get phone_pin;

  /// No description provided for @fingerprint.
  ///
  /// In fa, this message translates to:
  /// **'اثر انگشت'**
  String get fingerprint;

  /// No description provided for @select_service.
  ///
  /// In fa, this message translates to:
  /// **'خدمت مورد نظر خود را انتخاب کنید'**
  String get select_service;

  /// No description provided for @existing_customer_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی،\n با تکمیل اطلاعات زیر، مراحل احراز هویت شما به اتمام می‌رسد و می‌توانید از خدمات برنامه استفاده کنید.'**
  String get existing_customer_message;

  /// No description provided for @new_customer_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی،\nبا تکمیل اطلاعات زیر، شما به عنوان مشتری بانک گردشگری تعریف خواهید شد.'**
  String get new_customer_message;

  /// No description provided for @referral_code_prompt.
  ///
  /// In fa, this message translates to:
  /// **'در صورت تمایل، کد معرفِ دوستانتان را وارد کنید.'**
  String get referral_code_prompt;

  /// No description provided for @general_terms_and_conditions_title.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات عمومی استفاده از خدمات سپرده غیرحضوری'**
  String get general_terms_and_conditions_title;

  /// No description provided for @branch_rules_title.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات شعبه'**
  String get branch_rules_title;

  /// No description provided for @acceptance_confirmation_text.
  ///
  /// In fa, this message translates to:
  /// **'شرایط و مقررات عمومی استفاده از خدمات سپرده غیر حضوری به شرح فوق را رویت و مورد تایید و قبول اینجانب می‌باشد'**
  String get acceptance_confirmation_text;

  /// No description provided for @continue_button_confirm_rules.
  ///
  /// In fa, this message translates to:
  /// **'تایید قوانین و ادامه'**
  String get continue_button_confirm_rules;

  /// No description provided for @digital_signature_certificate.
  ///
  /// In fa, this message translates to:
  /// **'گواهی امضای دیجیتال'**
  String get digital_signature_certificate;

  /// No description provided for @certificate_expired_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، اعتبار گواهی امضای دیجیتال شما به پایان رسیده است. لطفاً جهت استفاده از خدمات شعبه مجازی بانک گردشگری، مجدداً احراز هویت نمایید.'**
  String get certificate_expired_message;

  /// No description provided for @digital_signature_creation_success.
  ///
  /// In fa, this message translates to:
  /// **'امضای دیجیتال شما با موفقیت ایجاد شد. با زدن تایید نهایی، می‌توانید از خدمات شعبه مجازی بانک گردشگری استفاده نمایید'**
  String get digital_signature_creation_success;

  /// No description provided for @final_confirmation_button.
  ///
  /// In fa, this message translates to:
  /// **'تایید نهایی'**
  String get final_confirmation_button;

  /// No description provided for @visit_request.
  ///
  /// In fa, this message translates to:
  /// **'درخواست بازدید'**
  String get visit_request;

  /// No description provided for @digital_signature_renewal.
  ///
  /// In fa, this message translates to:
  /// **'تمدید گواهی امضای دیجیتال'**
  String get digital_signature_renewal;

  /// No description provided for @certificate_expiration_warning.
  ///
  /// In fa, this message translates to:
  /// **'امضای دیجیتال شما تا'**
  String get certificate_expiration_warning;

  /// No description provided for @remaining_days_message.
  ///
  /// In fa, this message translates to:
  /// **'روز دیگر منقضی خواهد شد.'**
  String get remaining_days_message;

  /// No description provided for @side_street_alley.
  ///
  /// In fa, this message translates to:
  /// **'خیابان فرعی/کوچه'**
  String get side_street_alley;

  /// No description provided for @province_city.
  ///
  /// In fa, this message translates to:
  /// **'استان/شهر'**
  String get province_city;

  /// No description provided for @request_delete_successfully.
  ///
  /// In fa, this message translates to:
  /// **'درخواست با موفقیت حذف شد'**
  String get request_delete_successfully;

  /// No description provided for @sure_to_cancel_request.
  ///
  /// In fa, this message translates to:
  /// **'آیا از لغو درخواست اطمینان دارید؟'**
  String get sure_to_cancel_request;

  /// No description provided for @request_submit_successfully.
  ///
  /// In fa, this message translates to:
  /// **'درخواست با موفقیت ثبت شد'**
  String get request_submit_successfully;

  /// No description provided for @side_street_hint_alley.
  ///
  /// In fa, this message translates to:
  /// **'خیابان فرعی/کوچه خود را وارد کنید'**
  String get side_street_hint_alley;

  /// No description provided for @side_street_error_alley.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مقدار خیابان فرعی/کوچه را وارد کنید'**
  String get side_street_error_alley;

  /// No description provided for @renewal_instructions.
  ///
  /// In fa, this message translates to:
  /// **'در صورت عدم تمدید، لازم است مجددا احراز هویت کنید. برای به‌روزرسانی و تمدید امضای دیجیتال خود، لطفا بر روی دکمه «ادامه» کلیک کنید.'**
  String get renewal_instructions;

  /// No description provided for @continue_payment_browser_text.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت را در مرورگر و توسط درگاه بانکی تحت وب ادامه دهید.'**
  String get continue_payment_browser_text;

  /// No description provided for @instruction_text_promissory_signature.
  ///
  /// In fa, this message translates to:
  /// **'با انتخاب گزینه امضای سفته، امضاء شما پایین تصویر سفته به صورت الکترونیکی ثبت می‌شود و این عمل به منزله تایید درخواست و ثبت نهایی فرآیند است.'**
  String get instruction_text_promissory_signature;

  /// No description provided for @promissory_signature.
  ///
  /// In fa, this message translates to:
  /// **'امضای سفته'**
  String get promissory_signature;

  /// No description provided for @promissory_issuance.
  ///
  /// In fa, this message translates to:
  /// **'صدور سفته'**
  String get promissory_issuance;

  /// No description provided for @stamp_duty.
  ///
  /// In fa, this message translates to:
  /// **'حق تمبر'**
  String get stamp_duty;

  /// No description provided for @renewal_authentication.
  ///
  /// In fa, this message translates to:
  /// **'احراز هویت مجدد'**
  String get renewal_authentication;

  /// No description provided for @issuance_fee.
  ///
  /// In fa, this message translates to:
  /// **'کارمزد صدور'**
  String get issuance_fee;

  /// No description provided for @online_promissory_and_bill_issuance.
  ///
  /// In fa, this message translates to:
  /// **'صدور سفته و برات آنلاین'**
  String get online_promissory_and_bill_issuance;

  /// No description provided for @online_promissory_and_bill.
  ///
  /// In fa, this message translates to:
  /// **'سفته و برات آنلاین'**
  String get online_promissory_and_bill;

  /// No description provided for @select_finalized_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'سفته نهایی شده را جهت ضمانت تسهیلات انتخاب کنید:'**
  String get select_finalized_promissory_note;

  /// No description provided for @choose_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب سفته'**
  String get choose_promissory_note;

  /// No description provided for @treasury_identifier.
  ///
  /// In fa, this message translates to:
  /// **'شناسه خزانه‌داری:'**
  String get treasury_identifier;

  /// No description provided for @select_finalized_promissory_title.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب سفته نهایی شده'**
  String get select_finalized_promissory_title;

  /// No description provided for @issuer_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات صادرکننده'**
  String get issuer_information;

  /// No description provided for @recipient_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات دریافت‌کننده'**
  String get recipient_information;

  /// No description provided for @address_of_residence.
  ///
  /// In fa, this message translates to:
  /// **'آدرس محل اقامت'**
  String get address_of_residence;

  /// No description provided for @full_settlement_of_promissory.
  ///
  /// In fa, this message translates to:
  /// **'تسویه کامل سفته'**
  String get full_settlement_of_promissory;

  /// No description provided for @issuer_residence_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات محل اقامت صادرکننده'**
  String get issuer_residence_info;

  /// No description provided for @warrenty_location_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات محل ارسال ضمانت‌نامه'**
  String get warrenty_location_info;

  /// No description provided for @warrenty_post_code_info.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی محل ارسال ضمانت‌نامه'**
  String get warrenty_post_code_info;

  /// No description provided for @online_promissory.
  ///
  /// In fa, this message translates to:
  /// **'سفته آنلاین'**
  String get online_promissory;

  /// No description provided for @online_promissory_issuance_terms.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات صدور سفته آنلاین'**
  String get online_promissory_issuance_terms;

  /// No description provided for @online_promissory_issuance.
  ///
  /// In fa, this message translates to:
  /// **'صدور سفته آنلاین'**
  String get online_promissory_issuance;

  /// No description provided for @accept_online_promissory_terms.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات صدور سفته آنلاین را قبول دارم'**
  String get accept_online_promissory_terms;

  /// No description provided for @select_deposit_for_promissory.
  ///
  /// In fa, this message translates to:
  /// **'سپرده خود را جهت صدور سفته انتخاب کنید'**
  String get select_deposit_for_promissory;

  /// No description provided for @no_deposit_found_personal_branch.
  ///
  /// In fa, this message translates to:
  /// **'سپرده‌ای یافت نشد.\n از طریق منوی شعبه شخصی اقدام به افتتاح سپرده کنید'**
  String get no_deposit_found_personal_branch;

  /// No description provided for @finalize_cancel_request.
  ///
  /// In fa, this message translates to:
  /// **'نهایی‌سازی لغو درخواست'**
  String get finalize_cancel_request;

  /// No description provided for @cancel_request_button.
  ///
  /// In fa, this message translates to:
  /// **'لغو درخواست'**
  String get cancel_request_button;

  /// No description provided for @no_transfer_found.
  ///
  /// In fa, this message translates to:
  /// **'انتقالی یافت نشد'**
  String get no_transfer_found;

  /// No description provided for @mashmol_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات مشمول'**
  String get mashmol_information;

  /// No description provided for @deposit_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات سپرده'**
  String get deposit_info;

  /// No description provided for @commitment_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تعهد'**
  String get commitment_amount;

  /// No description provided for @unique_identifier.
  ///
  /// In fa, this message translates to:
  /// **'شناسه یکتا'**
  String get unique_identifier;

  /// No description provided for @continue_request.
  ///
  /// In fa, this message translates to:
  /// **'ادامه درخواست'**
  String get continue_request;

  /// No description provided for @issued_promissory_file.
  ///
  /// In fa, this message translates to:
  /// **'فایل سفته صادر‌شده'**
  String get issued_promissory_file;

  /// No description provided for @promissory_file.
  ///
  /// In fa, this message translates to:
  /// **'فایل سفته'**
  String get promissory_file;

  /// No description provided for @remaining_commitment.
  ///
  /// In fa, this message translates to:
  /// **'باقیمانده تعهد'**
  String get remaining_commitment;

  /// No description provided for @issuer_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره موبایل صادرکننده'**
  String get issuer_mobile_number;

  /// No description provided for @no_guarantor_found.
  ///
  /// In fa, this message translates to:
  /// **'ضامنی یافت نشد'**
  String get no_guarantor_found;

  /// No description provided for @select_deposit_for_guarantee.
  ///
  /// In fa, this message translates to:
  /// **'سپرده خود را جهت ضمانت سفته انتخاب کنید:'**
  String get select_deposit_for_guarantee;

  /// No description provided for @no_settlement_found.
  ///
  /// In fa, this message translates to:
  /// **'تسویه یافت نشد'**
  String get no_settlement_found;

  /// No description provided for @guarantee_submission_button.
  ///
  /// In fa, this message translates to:
  /// **'ثبت ضمانت سفته'**
  String get guarantee_submission_button;

  /// No description provided for @transfer_information.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات انتقال'**
  String get transfer_information;

  /// No description provided for @view_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده سفته'**
  String get view_promissory_note;

  /// No description provided for @registrant_name.
  ///
  /// In fa, this message translates to:
  /// **'نام ثبت‌کننده'**
  String get registrant_name;

  /// No description provided for @promissory_amount_rial.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ سفته را به ریال وارد کنید'**
  String get promissory_amount_rial;

  /// No description provided for @registrant_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره موبایل ثبت‌کننده'**
  String get registrant_mobile_number;

  /// No description provided for @registrant_phone_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن ثبت‌کننده'**
  String get registrant_phone_number;

  /// No description provided for @recipient_name_.
  ///
  /// In fa, this message translates to:
  /// **'نام دریافت‌کننده'**
  String get recipient_name_;

  /// No description provided for @settled_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تسویه شده'**
  String get settled_amount;

  /// No description provided for @recipient_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره موبایل دریافت‌کننده'**
  String get recipient_mobile_number;

  /// No description provided for @enter_recipient_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره موبایل دریافت‌کننده را وارد نمایید'**
  String get enter_recipient_mobile_number;

  /// No description provided for @recipient_phone_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تلفن دریافت‌کننده'**
  String get recipient_phone_number;

  /// No description provided for @issuer_deposit_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات سپرده صادر‌کننده'**
  String get issuer_deposit_info;

  /// No description provided for @residence_address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس محل اقامت'**
  String get residence_address;

  /// No description provided for @remaining_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ باقیمانده'**
  String get remaining_amount;

  /// No description provided for @instructions_all_promissory_amount.
  ///
  /// In fa, this message translates to:
  /// **'دریافت‌کننده پس از وصول کامل و یا بیشتر از باقیمانده تعهد سفته می‌بایست مبلغ را در این بخش وارد کند. این عمل به جهت تایید دریافت «کل وجه سفته» است.'**
  String get instructions_all_promissory_amount;

  /// No description provided for @promissory_receiver_partial_payment.
  ///
  /// In fa, this message translates to:
  /// **'دریافت‌کننده سفته پس از وصول بخشی از تعهد سفته می‌بایست مبلغ دریافتی را در این بخش وارد کند. این عمل به جهت تایید دریافت بخشی از وجه است'**
  String get promissory_receiver_partial_payment;

  /// No description provided for @payment_address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس محل پرداخت'**
  String get payment_address;

  /// No description provided for @guarantor_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات ضامن'**
  String get guarantor_info;

  /// No description provided for @issuer_name.
  ///
  /// In fa, this message translates to:
  /// **'نام صادر‌کننده'**
  String get issuer_name;

  /// No description provided for @guarantor_mobile_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره موبایل ضامن'**
  String get guarantor_mobile_number;

  /// No description provided for @settlement_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات تسویه'**
  String get settlement_info;

  /// No description provided for @settlement_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع تسویه'**
  String get settlement_type;

  /// No description provided for @settlement_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تسویه'**
  String get settlement_amount;

  /// No description provided for @full.
  ///
  /// In fa, this message translates to:
  /// **'کامل'**
  String get full;

  /// No description provided for @total_commitment_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ کل تعهد'**
  String get total_commitment_amount;

  /// No description provided for @third_party_transfer_possible.
  ///
  /// In fa, this message translates to:
  /// **'امکان انتقال به شخص ثالث'**
  String get third_party_transfer_possible;

  /// No description provided for @installment.
  ///
  /// In fa, this message translates to:
  /// **'تدریجی'**
  String get installment;

  /// No description provided for @guarantors.
  ///
  /// In fa, this message translates to:
  /// **'ضامنین'**
  String get guarantors;

  /// No description provided for @settlements.
  ///
  /// In fa, this message translates to:
  /// **'تسویه‌ها'**
  String get settlements;

  /// No description provided for @settlement.
  ///
  /// In fa, this message translates to:
  /// **'تسویه‌'**
  String get settlement;

  /// No description provided for @recipient_info.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات دریافت‌ کننده'**
  String get recipient_info;

  /// No description provided for @settlement_success.
  ///
  /// In fa, this message translates to:
  /// **'تسویه سفته شما با موفقیت ثبت شد!'**
  String get settlement_success;

  /// No description provided for @payment_address_hint.
  ///
  /// In fa, this message translates to:
  /// **'آدرس محل پرداخت را بنویسید (تا 200 کاراکتر)'**
  String get payment_address_hint;

  /// No description provided for @payment_address_error.
  ///
  /// In fa, this message translates to:
  /// **'محل پرداخت باید بین 5 تا 200 کاراکتر باشد'**
  String get payment_address_error;

  /// No description provided for @guarantee_description_hint.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات ضمانت را بنویسید (تا 200 کاراکتر)'**
  String get guarantee_description_hint;

  /// No description provided for @guarantee_description_error.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات ضمانت باید بین 5 تا 200 کاراکتر باشد'**
  String get guarantee_description_error;

  /// No description provided for @description_title.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات (اختیاری)'**
  String get description_title;

  /// No description provided for @description_hint.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات ظهرنویسی سفته را وارد کنید'**
  String get description_hint;

  /// No description provided for @description_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا توضیحات ظهرنویسی سفته را وارد کنید'**
  String get description_error;

  /// No description provided for @amount_error.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ معتبری وارد نمایید'**
  String get amount_error;

  /// No description provided for @operation_successful_.
  ///
  /// In fa, this message translates to:
  /// **'عملیات موفق'**
  String get operation_successful_;

  /// No description provided for @promissory_success_message.
  ///
  /// In fa, this message translates to:
  /// **'سفته با موفقیت ظهرنویسی شد!'**
  String get promissory_success_message;

  /// No description provided for @promissory_download_message.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی سفته شما در بخش سفته‌های من نیز قابل دانلود است'**
  String get promissory_download_message;

  /// No description provided for @promissory_title.
  ///
  /// In fa, this message translates to:
  /// **'سفته'**
  String get promissory_title;

  /// No description provided for @deposit_shaba.
  ///
  /// In fa, this message translates to:
  /// **'شبا سپرده'**
  String get deposit_shaba;

  /// No description provided for @enter_receiver_national_code.
  ///
  /// In fa, this message translates to:
  /// **'کد ملی دریافت‌کننده را وارد کنید'**
  String get enter_receiver_national_code;

  /// No description provided for @national_code_error_reciever.
  ///
  /// In fa, this message translates to:
  /// **'لطفا کد ملی دریافت‌کننده را وارد کنید'**
  String get national_code_error_reciever;

  /// No description provided for @select_receiver_birthday.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد دریافت‌کننده را انتخاب کنید'**
  String get select_receiver_birthday;

  /// No description provided for @birthday_date_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ تولد دریافت‌کننده را انتخاب نمایید'**
  String get birthday_date_error;

  /// No description provided for @select_bank_as_recipient.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب بانک گردشگری به عنوان دریافت‌کننده'**
  String get select_bank_as_recipient;

  /// No description provided for @enter_receiver_national_identifier.
  ///
  /// In fa, this message translates to:
  /// **'شناسه ملی دریافت‌کننده را وارد کنید'**
  String get enter_receiver_national_identifier;

  /// No description provided for @enter_valid_national_code.
  ///
  /// In fa, this message translates to:
  /// **'شناسه ملی معتبر وارد نمایید'**
  String get enter_valid_national_code;

  /// No description provided for @enter_receiver_contact_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تماس دریافت‌کننده را وارد نمایید'**
  String get enter_receiver_contact_number;

  /// No description provided for @enter_valid_contact_number.
  ///
  /// In fa, this message translates to:
  /// **'مقدار شماره تماس را وارد کنید'**
  String get enter_valid_contact_number;

  /// No description provided for @terms_and_conditions_promissory.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات ظهرنویسی سفته'**
  String get terms_and_conditions_promissory;

  /// No description provided for @accept_terms_zahr.
  ///
  /// In fa, this message translates to:
  /// **'قوانین و مقررات ظهرنویسی را قبول دارم'**
  String get accept_terms_zahr;

  /// No description provided for @promissory_endorsement_title.
  ///
  /// In fa, this message translates to:
  /// **'ظهرنویسی سفته'**
  String get promissory_endorsement_title;

  /// No description provided for @issuer.
  ///
  /// In fa, this message translates to:
  /// **'صادر‌کننده'**
  String get issuer;

  /// No description provided for @issue_description_hint.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات صدور سفته را وارد کنید'**
  String get issue_description_hint;

  /// No description provided for @issue_description_error.
  ///
  /// In fa, this message translates to:
  /// **'لطفا توضیحات صدور سفته را وارد کنید'**
  String get issue_description_error;

  /// No description provided for @current_owner.
  ///
  /// In fa, this message translates to:
  /// **'مالک سفته'**
  String get current_owner;

  /// No description provided for @guarantor.
  ///
  /// In fa, this message translates to:
  /// **'ضامن سفته'**
  String get guarantor;

  /// No description provided for @transmitter.
  ///
  /// In fa, this message translates to:
  /// **'انتقال‌دهنده'**
  String get transmitter;

  /// No description provided for @unknown.
  ///
  /// In fa, this message translates to:
  /// **'نامشخص'**
  String get unknown;

  /// No description provided for @published.
  ///
  /// In fa, this message translates to:
  /// **'صادر شده'**
  String get published;

  /// No description provided for @partial_settled.
  ///
  /// In fa, this message translates to:
  /// **'تسویه تدریجی شده'**
  String get partial_settled;

  /// No description provided for @settled.
  ///
  /// In fa, this message translates to:
  /// **'تسویه شده'**
  String get settled;

  /// No description provided for @demanded.
  ///
  /// In fa, this message translates to:
  /// **'واخواست شده'**
  String get demanded;

  /// No description provided for @canceled.
  ///
  /// In fa, this message translates to:
  /// **'ابطال شده'**
  String get canceled;

  /// No description provided for @canceled_ENG.
  ///
  /// In fa, this message translates to:
  /// **'canceled'**
  String get canceled_ENG;

  /// No description provided for @confirmed_ENG.
  ///
  /// In fa, this message translates to:
  /// **'confirmed'**
  String get confirmed_ENG;

  /// No description provided for @guarantee_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'ضمانت سفته'**
  String get guarantee_promissory_note;

  /// No description provided for @state_unknown.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت نامشخص'**
  String get state_unknown;

  /// No description provided for @promissory_services.
  ///
  /// In fa, this message translates to:
  /// **'خدمات سفته'**
  String get promissory_services;

  /// No description provided for @completed_promissory_notes.
  ///
  /// In fa, this message translates to:
  /// **'سفته‌های تکمیل‌شده'**
  String get completed_promissory_notes;

  /// No description provided for @guarantee_success_message.
  ///
  /// In fa, this message translates to:
  /// **'ضمانت سفته شما با موفقیت ثبت شد!'**
  String get guarantee_success_message;

  /// No description provided for @filter.
  ///
  /// In fa, this message translates to:
  /// **'فیلتر'**
  String get filter;

  /// No description provided for @my_promissory.
  ///
  /// In fa, this message translates to:
  /// **'سفته‌های من'**
  String get my_promissory;

  /// No description provided for @promissory.
  ///
  /// In fa, this message translates to:
  /// **'سفته'**
  String get promissory;

  /// No description provided for @promissory_inquiry.
  ///
  /// In fa, this message translates to:
  /// **'استعلام سفته'**
  String get promissory_inquiry;

  /// No description provided for @total_remaining_amount.
  ///
  /// In fa, this message translates to:
  /// **'کل مبلغ باقیمانده'**
  String get total_remaining_amount;

  /// No description provided for @partial_settlement_success.
  ///
  /// In fa, this message translates to:
  /// **'تسویه تدریجی سفته با موفقیت انجام شد'**
  String get partial_settlement_success;

  /// No description provided for @partial_settlement.
  ///
  /// In fa, this message translates to:
  /// **'تسویه تدریجی سفته'**
  String get partial_settlement;

  /// No description provided for @confirm_selection_message.
  ///
  /// In fa, this message translates to:
  /// **'لطفا اطلاعات صندوق انتخاب شده را تایید نمایید'**
  String get confirm_selection_message;

  /// No description provided for @selected_branch.
  ///
  /// In fa, this message translates to:
  /// **'شعبه انتخابی'**
  String get selected_branch;

  /// No description provided for @box_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع صندوق'**
  String get box_type;

  /// No description provided for @dimensions.
  ///
  /// In fa, this message translates to:
  /// **'ابعاد'**
  String get dimensions;

  /// No description provided for @annual_rent.
  ///
  /// In fa, this message translates to:
  /// **'اجاره بهای سالانه'**
  String get annual_rent;

  /// No description provided for @rent.
  ///
  /// In fa, this message translates to:
  /// **'اجاره'**
  String get rent;

  /// No description provided for @trusteeship_deposit.
  ///
  /// In fa, this message translates to:
  /// **'ودیعه'**
  String get trusteeship_deposit;

  /// No description provided for @value_added_services.
  ///
  /// In fa, this message translates to:
  /// **'خدمات ارزش افزوده'**
  String get value_added_services;

  /// No description provided for @selected_time_period.
  ///
  /// In fa, this message translates to:
  /// **'بازه زمانی انتخابی'**
  String get selected_time_period;

  /// No description provided for @branch_address.
  ///
  /// In fa, this message translates to:
  /// **'آدرس شعبه'**
  String get branch_address;

  /// No description provided for @select_bank_visit_date_and_time.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ و بازه زمانی مراجعه به بانک را انتخاب کنید'**
  String get select_bank_visit_date_and_time;

  /// No description provided for @visit_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ مراجعه'**
  String get visit_date;

  /// No description provided for @visit_time_period.
  ///
  /// In fa, this message translates to:
  /// **'بازه زمانی مراجعه'**
  String get visit_time_period;

  /// No description provided for @empty_capacity_funds.
  ///
  /// In fa, this message translates to:
  /// **'ظرفیت خالی: {fund} صندوق'**
  String empty_capacity_funds(String fund);

  /// No description provided for @capacity_filled.
  ///
  /// In fa, this message translates to:
  /// **'ظرفیت تکمیل'**
  String get capacity_filled;

  /// No description provided for @volume.
  ///
  /// In fa, this message translates to:
  /// **'حجم'**
  String get volume;

  /// No description provided for @no_safe_box_registered.
  ///
  /// In fa, this message translates to:
  /// **'شما صندوق اماناتی ثبت نکرده‌اید'**
  String get no_safe_box_registered;

  /// No description provided for @rent_safe_box.
  ///
  /// In fa, this message translates to:
  /// **'اجاره صندوق'**
  String get rent_safe_box;

  /// No description provided for @access_to_camera.
  ///
  /// In fa, this message translates to:
  /// **'دسترسی به دوربین'**
  String get access_to_camera;

  /// No description provided for @for_scanning_need_access_to_camera.
  ///
  /// In fa, this message translates to:
  /// **'برای اسکن نیاز به دسترسی به دوربین دستگاه است'**
  String get for_scanning_need_access_to_camera;

  /// No description provided for @national_card_front_image_kb.
  ///
  /// In fa, this message translates to:
  /// **'حجم تصویر کارت ملی جلو'**
  String get national_card_front_image_kb;

  /// No description provided for @sure_sign_promissory_warranty.
  ///
  /// In fa, this message translates to:
  /// **'از امضای ضمانت سفته مطمئن هستید؟'**
  String get sure_sign_promissory_warranty;

  /// No description provided for @image_size_exceeded.
  ///
  /// In fa, this message translates to:
  /// **'حجم تصویر بیش از حد مجاز است'**
  String get image_size_exceeded;

  /// No description provided for @error_in_image_process.
  ///
  /// In fa, this message translates to:
  /// **'خطا در پردازش تصویر'**
  String get error_in_image_process;

  /// No description provided for @please_select_national_card_front.
  ///
  /// In fa, this message translates to:
  /// **'لطفا روی کارت ملی خود را انتخاب نمایید'**
  String get please_select_national_card_front;

  /// No description provided for @please_select_national_card_back.
  ///
  /// In fa, this message translates to:
  /// **'لطفا پشت کارت ملی خود را انتخاب نمایید'**
  String get please_select_national_card_back;

  /// No description provided for @please_select_account.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از حساب‌های خود را انتخاب نمایید'**
  String get please_select_account;

  /// No description provided for @please_select_face_image.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تصویر از چهره را ثبت نمایید'**
  String get please_select_face_image;

  /// No description provided for @please_select_face_video.
  ///
  /// In fa, this message translates to:
  /// **'لطفا ویدئو از چهره را ثبت نمایید'**
  String get please_select_face_video;

  /// No description provided for @please_draw_signature_carefully.
  ///
  /// In fa, this message translates to:
  /// **'امضا خود را با دقت بیشتری ترسیم نمایید'**
  String get please_draw_signature_carefully;

  /// No description provided for @please_draw_your_signature.
  ///
  /// In fa, this message translates to:
  /// **'لطفا امضای خود را ترسیم نمایید'**
  String get please_draw_your_signature;

  /// No description provided for @please_select_first_and_second_pages_of_birth_certificate.
  ///
  /// In fa, this message translates to:
  /// **'لطفا صفحه اول و دوم شناسنامه را انتخاب نمایید'**
  String get please_select_first_and_second_pages_of_birth_certificate;

  /// No description provided for @please_select_first_page_of_birth_certificate.
  ///
  /// In fa, this message translates to:
  /// **'لطفا صفحه اول شناسنامه را انتخاب نمایید'**
  String get please_select_first_page_of_birth_certificate;

  /// No description provided for @please_select_second_page_of_birth_certificate.
  ///
  /// In fa, this message translates to:
  /// **'لطفا صفحه دوم شناسنامه را انتخاب نمایید'**
  String get please_select_second_page_of_birth_certificate;

  /// No description provided for @enter_valid_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'مقدار معتبری برای کد پستی وارد نمایید'**
  String get enter_valid_postal_code;

  /// No description provided for @qr_code_approval_description.
  ///
  /// In fa, this message translates to:
  /// **'اینجانب تایید می‌نمایم اطلاعات مورد نظر کمیته اربعین در قالب QR CODE بر روی کارت نقدی ارسالی اینجانب درج گردد.'**
  String get qr_code_approval_description;

  /// No description provided for @select_birthdate.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد را انتخاب نمایید'**
  String get select_birthdate;

  /// No description provided for @guarantor_confirmation_description.
  ///
  /// In fa, this message translates to:
  /// **'جهت تایید ضمانت شما و بارگذاری مدارک، ضامن باید اپلیکیشن توبانک را نصب کرده و از قسمت کارتابل فرآیند را ادامه دهد.'**
  String get guarantor_confirmation_description;

  /// No description provided for @confirm_message.
  ///
  /// In fa, this message translates to:
  /// **'ثبت ضامن'**
  String get confirm_message;

  /// No description provided for @copy_snackbar_message.
  ///
  /// In fa, this message translates to:
  /// **'کپی شد'**
  String get copy_snackbar_message;

  /// No description provided for @type_of_loans.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از انواع تسهیلات را انتخاب نمایید'**
  String get type_of_loans;

  /// No description provided for @querying_zip_code.
  ///
  /// In fa, this message translates to:
  /// **'کد پستی را استعلام نمایید'**
  String get querying_zip_code;

  /// No description provided for @share_subject.
  ///
  /// In fa, this message translates to:
  /// **'لینک دانلود'**
  String get share_subject;

  /// No description provided for @tobank_address_download_link.
  ///
  /// In fa, this message translates to:
  /// **'اپلیکیشن توبانک\nhttps://tobank.ir\n'**
  String get tobank_address_download_link;

  /// No description provided for @please_select_cheque.
  ///
  /// In fa, this message translates to:
  /// **'لطفا چک را انتخاب نمایید'**
  String get please_select_cheque;

  /// No description provided for @please_select_applicant_salary_certificate.
  ///
  /// In fa, this message translates to:
  /// **'لطفا گواهی کسر از حقوق متقاضی را انتخاب نمایید'**
  String get please_select_applicant_salary_certificate;

  /// No description provided for @please_select_guarantor_cheque.
  ///
  /// In fa, this message translates to:
  /// **'لطفا چک ضامن را انتخاب نمایید'**
  String get please_select_guarantor_cheque;

  /// No description provided for @please_select_guarantor_salary_certificate.
  ///
  /// In fa, this message translates to:
  /// **'لطفا گواهی کسر از حقوق ضامن را انتخاب نمایید'**
  String get please_select_guarantor_salary_certificate;

  /// No description provided for @please_select_guarantee_type.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نوع ضمانت ضامن را انتخاب نمایید'**
  String get please_select_guarantee_type;

  /// No description provided for @file_size_too_large.
  ///
  /// In fa, this message translates to:
  /// **'حجم فایل انتخابی زیاد است!'**
  String get file_size_too_large;

  /// No description provided for @tehran_central_branch.
  ///
  /// In fa, this message translates to:
  /// **'تهران - شعبه مرکزی'**
  String get tehran_central_branch;

  /// No description provided for @please_read_and_accept_terms.
  ///
  /// In fa, this message translates to:
  /// **'لطفا قوانین و مقررات را مطالعه و تایید نمایید'**
  String get please_read_and_accept_terms;

  /// No description provided for @please_select_eligible_children_count.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تعداد فرزند واجد شرایط تسهیلات را انتخاب نمایید'**
  String get please_select_eligible_children_count;

  /// No description provided for @please_select_re_upload_all_doc.
  ///
  /// In fa, this message translates to:
  /// **'لطفا همه مدارک دارای اشکال را مجدد انتخاب و آپلود نمایید'**
  String get please_select_re_upload_all_doc;

  /// No description provided for @processing_not_found.
  ///
  /// In fa, this message translates to:
  /// **'پردازش یافت نشد.'**
  String get processing_not_found;

  /// No description provided for @documents_registered_successfully.
  ///
  /// In fa, this message translates to:
  /// **'مدارک با موفقیت ثبت شد. نتیجه به اطلاع شما خواهد رسید.'**
  String get documents_registered_successfully;

  /// No description provided for @please_select_and_upload_all_pages.
  ///
  /// In fa, this message translates to:
  /// **'لطفا همه صفحات را انتخاب و آپلود نمایید'**
  String get please_select_and_upload_all_pages;

  /// No description provided for @please_upload_rental_contract_or_document.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تصویر اجاره نامه یا سند را ارسال نمایید'**
  String get please_upload_rental_contract_or_document;

  /// No description provided for @please_read_and_accept_deposit_closure_terms.
  ///
  /// In fa, this message translates to:
  /// **'لطفا شرایط بستن سپرده را مطالعه و تایید نمایید'**
  String get please_read_and_accept_deposit_closure_terms;

  /// No description provided for @closing_deposit_possible_only_with_existing_deposit.
  ///
  /// In fa, this message translates to:
  /// **'بستن سپرده زمانی امکان‌پذیر است که سپرده دیگری در بانک گردشگری داشته باشید'**
  String get closing_deposit_possible_only_with_existing_deposit;

  /// No description provided for @please_select_a_deposit.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از سپرده‌ها را انتخاب نمایید'**
  String get please_select_a_deposit;

  /// No description provided for @deposit_closure_confirmation_title.
  ///
  /// In fa, this message translates to:
  /// **'شما درخواست بستن سپرده زیر را دارید. آیا مطمئن هستید؟'**
  String get deposit_closure_confirmation_title;

  /// No description provided for @please_select_requested_amount.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مبلغ درخواستی را انتخاب نمایید'**
  String get please_select_requested_amount;

  /// No description provided for @select_deposit_closure_type.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نوع بستن سپرده را انتخاب نمایید'**
  String get select_deposit_closure_type;

  /// No description provided for @amount_exceeds_balance.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ وارد شده از موجودی سپرده بیشتر است'**
  String get amount_exceeds_balance;

  /// No description provided for @ve_cbi_link.
  ///
  /// In fa, this message translates to:
  /// **'https://ve.cbi.ir'**
  String get ve_cbi_link;

  /// No description provided for @upload_all_pages_.
  ///
  /// In fa, this message translates to:
  /// **'لطفا همه صفحات را آپلود نمایید'**
  String get upload_all_pages_;

  /// No description provided for @select_collateral_deposit_type.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نوع سپرده وثیقه را انتخاب کنید'**
  String get select_collateral_deposit_type;

  /// No description provided for @please_select_deposit.
  ///
  /// In fa, this message translates to:
  /// **'لطفا سپرده را انتخاب کنید'**
  String get please_select_deposit;

  /// No description provided for @select_employment_documents.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مدارک شغلی را انتخاب کنید'**
  String get select_employment_documents;

  /// No description provided for @select_your_employment_documents.
  ///
  /// In fa, this message translates to:
  /// **'لطفا مدرک شغلی خود را انتخاب کنید'**
  String get select_your_employment_documents;

  /// No description provided for @select_upload_letter_image.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تصویر نامه را انتخاب و آپلود کنید'**
  String get select_upload_letter_image;

  /// No description provided for @select_job_type_applicant.
  ///
  /// In fa, this message translates to:
  /// **'لطفا نوع شغل متقاضی را انتخاب کنید'**
  String get select_job_type_applicant;

  /// No description provided for @title_due_date_of_national_service_letter.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ سررسید نامه نظام وظیفه'**
  String get title_due_date_of_national_service_letter;

  /// No description provided for @file_collateral_contract.
  ///
  /// In fa, this message translates to:
  /// **'فایل قرارداد توثیق'**
  String get file_collateral_contract;

  /// No description provided for @file_guarantee.
  ///
  /// In fa, this message translates to:
  /// **'فایل ضمانت'**
  String get file_guarantee;

  /// No description provided for @select_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'سفته الکترونیک را انتخاب نمایید.'**
  String get select_promissory_note;

  /// No description provided for @select_credit_card_type.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از انواع کارت اعتباری را انتخاب نمایید'**
  String get select_credit_card_type;

  /// No description provided for @minimum_balance_below_loan_conditions.
  ///
  /// In fa, this message translates to:
  /// **'میانگین حداقل موجودی این سپرده از شرایط تسهیلات کمتر می‌باشد.'**
  String get minimum_balance_below_loan_conditions;

  /// No description provided for @please_select_loan_amount_type.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از انواع مبلغ تسهیلات را انتخاب کنید'**
  String get please_select_loan_amount_type;

  /// No description provided for @check_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'کدپستی را استعلام کنید'**
  String get check_postal_code;

  /// No description provided for @no_address_found_for_postal_code2.
  ///
  /// In fa, this message translates to:
  /// **'برای کد پستی وارد شده آدرسی یافت نشد'**
  String get no_address_found_for_postal_code2;

  /// No description provided for @certificate_salary_deduction_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ گواهی کسر از حقوق {amount_of_money} ریال می‌باشد'**
  String certificate_salary_deduction_amount(String amount_of_money);

  /// No description provided for @am.
  ///
  /// In fa, this message translates to:
  /// **'قبل از ظهر'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In fa, this message translates to:
  /// **'بعد از ظهر'**
  String get pm;

  /// No description provided for @please_upload_lease_or_document_image.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تصویر اجاره نامه یا سند را ارسال کنید'**
  String get please_upload_lease_or_document_image;

  /// No description provided for @contract_file.
  ///
  /// In fa, this message translates to:
  /// **'فایل قرارداد'**
  String get contract_file;

  /// No description provided for @access_to_device_storage.
  ///
  /// In fa, this message translates to:
  /// **'دسترسی به حافظه دستگاه'**
  String get access_to_device_storage;

  /// No description provided for @need_access_to_save_promisoory.
  ///
  /// In fa, this message translates to:
  /// **'برای ذخیره سفته به این دسترسی نیاز است.'**
  String get need_access_to_save_promisoory;

  /// No description provided for @storage_permission_needed.
  ///
  /// In fa, this message translates to:
  /// **'برای ذخیره‌سازی به این دسترسی نیاز است.'**
  String get storage_permission_needed;

  /// No description provided for @successfully_deleted.
  ///
  /// In fa, this message translates to:
  /// **'با موفقیت حذف شد.'**
  String get successfully_deleted;

  /// No description provided for @share_bank_branch.
  ///
  /// In fa, this message translates to:
  /// **'شعبه بانک گردشگری'**
  String get share_bank_branch;

  /// No description provided for @new_password_not_match.
  ///
  /// In fa, this message translates to:
  /// **'رمزهای جدید وارد شده با هم مطابقت ندارند'**
  String get new_password_not_match;

  /// No description provided for @password_not_match_.
  ///
  /// In fa, this message translates to:
  /// **'رمزهای وارد شده با هم مطابقت ندارند'**
  String get password_not_match_;

  /// No description provided for @password_not_match_with_entered_one.
  ///
  /// In fa, this message translates to:
  /// **'رمز وارد شده با رمز اولیه یکسان نیست'**
  String get password_not_match_with_entered_one;

  /// No description provided for @select_card_bank_first.
  ///
  /// In fa, this message translates to:
  /// **'ابتدا کارت بانکی را انتخاب نمایید'**
  String get select_card_bank_first;

  /// No description provided for @select_card_.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب کارت'**
  String get select_card_;

  /// No description provided for @saved_cards.
  ///
  /// In fa, this message translates to:
  /// **'کارت‌های ذخیره شده:'**
  String get saved_cards;

  /// No description provided for @reading_sms_error.
  ///
  /// In fa, this message translates to:
  /// **'خواندن کد پیامک شده، با اشکال مواجه شد.'**
  String get reading_sms_error;

  /// No description provided for @card_registration_success.
  ///
  /// In fa, this message translates to:
  /// **'کارت با موفقیت ثبت شد'**
  String get card_registration_success;

  /// No description provided for @announcement.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعیه'**
  String get announcement;

  /// No description provided for @select_origin_card.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب کارت مبدا'**
  String get select_origin_card;

  /// No description provided for @authentication_successful.
  ///
  /// In fa, this message translates to:
  /// **'روند احراز هویت با موفقیت انجام شد'**
  String get authentication_successful;

  /// No description provided for @card_scan_failed.
  ///
  /// In fa, this message translates to:
  /// **'اسکن کارت با موفقیت انجام نشد. دوباره تلاش کنید'**
  String get card_scan_failed;

  /// No description provided for @no_address_for_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'آدرسی برای این کد پستی یافت نشد'**
  String get no_address_for_postal_code;

  /// No description provided for @confirm_card_blocking.
  ///
  /// In fa, this message translates to:
  /// **'آیا از مسدودی کارت خود به شماره زیر اطمینان دارید؟'**
  String get confirm_card_blocking;

  /// No description provided for @card_blocking_success.
  ///
  /// In fa, this message translates to:
  /// **'مسدودسازی کارت با موفقیت ثبت شد'**
  String get card_blocking_success;

  /// No description provided for @invalid_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'مقدار معتبری برای کد پستی وارد کنید'**
  String get invalid_postal_code;

  /// No description provided for @delete_card_successfully.
  ///
  /// In fa, this message translates to:
  /// **'کارت با موفقیت حذف شد'**
  String get delete_card_successfully;

  /// No description provided for @upload_and_select_all_page.
  ///
  /// In fa, this message translates to:
  /// **'لطفا همه صفحات را انتخاب و آپلود کنید'**
  String get upload_and_select_all_page;

  /// No description provided for @confirm_card_deletion.
  ///
  /// In fa, this message translates to:
  /// **'آیا از حذف کارت زیر اطمینان دارید؟'**
  String get confirm_card_deletion;

  /// No description provided for @confirm_payment.
  ///
  /// In fa, this message translates to:
  /// **'آیا از پرداخت وجه مطمئن هستید؟'**
  String get confirm_payment;

  /// No description provided for @payment_irreversible.
  ///
  /// In fa, this message translates to:
  /// **'بعد از پرداخت، بازگشت وجه امکان پذیر نیست. لذا از دستور پرداخت اطمینان حاصل فرمایید'**
  String get payment_irreversible;

  /// No description provided for @unknown_transaction_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت تراکنش نامعلوم است'**
  String get unknown_transaction_status;

  /// No description provided for @wallet_limit_exceeded.
  ///
  /// In fa, this message translates to:
  /// **'سقف کیف پول بیشتر از حد مجاز است'**
  String get wallet_limit_exceeded;

  /// No description provided for @confirm_wallet_top_up.
  ///
  /// In fa, this message translates to:
  /// **'از افزایش موجودی کیف پول مطمئن هستید؟'**
  String get confirm_wallet_top_up;

  /// No description provided for @copied_to_clipboard.
  ///
  /// In fa, this message translates to:
  /// **'مقدار در حافظه کپی شد'**
  String get copied_to_clipboard;

  /// No description provided for @card_number_copied.
  ///
  /// In fa, this message translates to:
  /// **'شماره کارت کپی شد'**
  String get card_number_copied;

  /// No description provided for @please_select_third_and_fourth_pages_of_birth_certificate.
  ///
  /// In fa, this message translates to:
  /// **'لطفا صفحه سوم و چهارم شناسنامه را انتخاب نمایید'**
  String get please_select_third_and_fourth_pages_of_birth_certificate;

  /// No description provided for @warning.
  ///
  /// In fa, this message translates to:
  /// **'هشدار'**
  String get warning;

  /// No description provided for @read_and_accept_terms_conditions.
  ///
  /// In fa, this message translates to:
  /// **'لطفا ضوابط و تعهدنامه را مطالعه و تایید نمایید'**
  String get read_and_accept_terms_conditions;

  /// No description provided for @to_use_service_open_deposit.
  ///
  /// In fa, this message translates to:
  /// **'برای استفاده از این سرویس لازم است که ابتدا افتتاح سپرده انجام دهید'**
  String get to_use_service_open_deposit;

  /// No description provided for @error_in_saving.
  ///
  /// In fa, this message translates to:
  /// **'خطا در ذخیره سازی'**
  String get error_in_saving;

  /// No description provided for @finalize_open_request.
  ///
  /// In fa, this message translates to:
  /// **'نهایی‌سازی درخواست باز'**
  String get finalize_open_request;

  /// No description provided for @issued_successfulyy.
  ///
  /// In fa, this message translates to:
  /// **'با موفقیت صادر شد.'**
  String get issued_successfulyy;

  /// No description provided for @error_in_digital_signature.
  ///
  /// In fa, this message translates to:
  /// **'خطا در امضا دیجیتال'**
  String get error_in_digital_signature;

  /// No description provided for @sure_to_quit_app.
  ///
  /// In fa, this message translates to:
  /// **'مطمئن به خروج از احراز‌هویت هستید؟'**
  String get sure_to_quit_app;

  /// No description provided for @continue_process_register_promissory.
  ///
  /// In fa, this message translates to:
  /// **'جهت ادامه فرآیند سفته خود را جهت ضمانت ثبت کنید.'**
  String get continue_process_register_promissory;

  /// No description provided for @select_electronic_promissory.
  ///
  /// In fa, this message translates to:
  /// **'سفته الکترونیک را انتخاب کنید.'**
  String get select_electronic_promissory;

  /// No description provided for @error_in_signature.
  ///
  /// In fa, this message translates to:
  /// **'خطا در امضا'**
  String get error_in_signature;

  /// No description provided for @no_address_found_for_postal_code.
  ///
  /// In fa, this message translates to:
  /// **'آدرسی برای این کد پستی یافت نشد'**
  String get no_address_found_for_postal_code;

  /// No description provided for @complete_identity_verification_from_deposit_section.
  ///
  /// In fa, this message translates to:
  /// **'لطفا از بخش سپرده‌ها، احراز هویت خود را کامل کنید'**
  String get complete_identity_verification_from_deposit_section;

  /// No description provided for @service_unavailable_for_selected_card.
  ///
  /// In fa, this message translates to:
  /// **'این سرویس برای کارت انتخاب شده غیرفعال است'**
  String get service_unavailable_for_selected_card;

  /// No description provided for @default_card_set_success.
  ///
  /// In fa, this message translates to:
  /// **'کارت پیش فرض با موفقیت ثبت شد'**
  String get default_card_set_success;

  /// No description provided for @default_card_removed_success.
  ///
  /// In fa, this message translates to:
  /// **'کارت پیش فرض حذف شد'**
  String get default_card_removed_success;

  /// No description provided for @complete_identity_verification.
  ///
  /// In fa, this message translates to:
  /// **'لطفا از بخش سپرده‌ها، احراز هویت خود را کامل کنید'**
  String get complete_identity_verification;

  /// No description provided for @card_to_card_not_available.
  ///
  /// In fa, this message translates to:
  /// **'امکان کارت به کارت برای این کارت وجود ندارد'**
  String get card_to_card_not_available;

  /// No description provided for @service_disabled_for_selected_card.
  ///
  /// In fa, this message translates to:
  /// **'این سرویس برای کارت انتخاب شده غیرفعال است'**
  String get service_disabled_for_selected_card;

  /// No description provided for @card_edit_success.
  ///
  /// In fa, this message translates to:
  /// **'کارت با موفقیت ویرایش شد'**
  String get card_edit_success;

  /// No description provided for @card_registration_error.
  ///
  /// In fa, this message translates to:
  /// **'خطا در حین ثبت کارت'**
  String get card_registration_error;

  /// No description provided for @card_registration_failed.
  ///
  /// In fa, this message translates to:
  /// **'کارت ثبت نشد. دوباره تلاش کنید'**
  String get card_registration_failed;

  /// No description provided for @submit_failed_card.
  ///
  /// In fa, this message translates to:
  /// **'کارت ثبت نشد'**
  String get submit_failed_card;

  /// No description provided for @file_validation_title.
  ///
  /// In fa, this message translates to:
  /// **'فایل اعتبارسنجی'**
  String get file_validation_title;

  /// No description provided for @storage_permission_description.
  ///
  /// In fa, this message translates to:
  /// **'برای ذخیره اعتبارسنجی به این دسترسی نیاز است.'**
  String get storage_permission_description;

  /// No description provided for @storage_permission_transaction_description.
  ///
  /// In fa, this message translates to:
  /// **'برای ذخیره تراکنش به این دسترسی نیاز است.'**
  String get storage_permission_transaction_description;

  /// No description provided for @status_recive_report_message.
  ///
  /// In fa, this message translates to:
  /// **'درخواست شما ثبت شده و در صف دریافت گزارش می‌باشید'**
  String get status_recive_report_message;

  /// No description provided for @default_status_message.
  ///
  /// In fa, this message translates to:
  /// **'درخواست شما ثبت شده و در انتظار ورود به صف دریافت گزارش می‌باشید'**
  String get default_status_message;

  /// No description provided for @failure_to_receive_validation_requestfunds_returned_wallet.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی به دلیل عدم دریافت استعلام اعتبارسنجی وجه دریافت شده به کیف پول شما عودت داده خواهد شد. لطفا مجددا تلاش نمایید.'**
  String get failure_to_receive_validation_requestfunds_returned_wallet;

  /// No description provided for @password_updated_successfully.
  ///
  /// In fa, this message translates to:
  /// **'رمزعبور با موفقیت ویرایش شد'**
  String get password_updated_successfully;

  /// No description provided for @touch_finger_print_sensor.
  ///
  /// In fa, this message translates to:
  /// **'سنسور اثر انگشت دستگاه را لمس نمایید'**
  String get touch_finger_print_sensor;

  /// No description provided for @incorrect_password_.
  ///
  /// In fa, this message translates to:
  /// **'رمز وارد شده صحیح نیست'**
  String get incorrect_password_;

  /// No description provided for @charity_payment_confirmation_message.
  ///
  /// In fa, this message translates to:
  /// **'از پرداخت نیکوکاری مطمئن هستید؟'**
  String get charity_payment_confirmation_message;

  /// No description provided for @charity_payment_confirmation_description.
  ///
  /// In fa, this message translates to:
  /// **'مقدار وارد شده به نیکوکاری انتخابی، کمک خواهد شد'**
  String get charity_payment_confirmation_description;

  /// No description provided for @three_wrong_password_attempts.
  ///
  /// In fa, this message translates to:
  /// **'سه بار رمز اشتباه وارد شده است. ۵ دقیقه بعد تلاش کنید'**
  String get three_wrong_password_attempts;

  /// No description provided for @face_recognize_sensor.
  ///
  /// In fa, this message translates to:
  /// **'سنسور تشخیص چهره'**
  String get face_recognize_sensor;

  /// No description provided for @login_with_finger_print.
  ///
  /// In fa, this message translates to:
  /// **' ورود با اثر انگشت'**
  String get login_with_finger_print;

  /// No description provided for @not_recognized.
  ///
  /// In fa, this message translates to:
  /// **'مطابقت داده نشد'**
  String get not_recognized;

  /// No description provided for @system_settings.
  ///
  /// In fa, this message translates to:
  /// **'رجوع به تنظیمات گوشی'**
  String get system_settings;

  /// No description provided for @set_finger_print_in_this_section.
  ///
  /// In fa, this message translates to:
  /// **'لطفا در بخش تنظیمات، اثر انگشت خود را ثبت نمایید'**
  String get set_finger_print_in_this_section;

  /// No description provided for @contacts_permission_message.
  ///
  /// In fa, this message translates to:
  /// **'دسترسی به لیست مخاطبین دستگاه'**
  String get contacts_permission_message;

  /// No description provided for @contacts_permission_description.
  ///
  /// In fa, this message translates to:
  /// **'برای نمایش لیست مخاطبین دستگاه و حساب‌های کاربری منطبق با مخاطبین شما به این دسترسی نیاز است. لیست مخاطبین شما در هیچ‌جا ذخیره نشده و فقط برای تطابق با مخاطبین ثبت‌نام شده استفاده می‌شود'**
  String get contacts_permission_description;

  /// No description provided for @document_being_reviewd.
  ///
  /// In fa, this message translates to:
  /// **'مدارک شما در حال بررسی می‌باشد. تا تایید مدارک لطفا شکیبا باشید.'**
  String get document_being_reviewd;

  /// No description provided for @your_deposit_services_disable_call_support.
  ///
  /// In fa, this message translates to:
  /// **'خدمات مرتبط با سپرده‌های بانک گردشگری شما غیرفعال شده است. با پشتیبانی توبانک ارتباط برقرار نمایید.'**
  String get your_deposit_services_disable_call_support;

  /// No description provided for @your_authentication_have_rejected.
  ///
  /// In fa, this message translates to:
  /// **'مدارک احراز هویت شما رد شده‌است. نیازمند انجام مجدد احراز هویت می‌باشید.'**
  String get your_authentication_have_rejected;

  /// No description provided for @prevent_authenticated_incomplete_documents.
  ///
  /// In fa, this message translates to:
  /// **'به دلیل نقص مدارک، از ادامه فرآیند جلوگیری شده‌است. لطفا مدارک خود را اصلاح نمایید.'**
  String get prevent_authenticated_incomplete_documents;

  /// No description provided for @initial_process_error.
  ///
  /// In fa, this message translates to:
  /// **'ابتدا مراحل تعریف مشتری را انجام دهید.'**
  String get initial_process_error;

  /// No description provided for @define_customer.
  ///
  /// In fa, this message translates to:
  /// **'تعریف مشتری'**
  String get define_customer;

  /// No description provided for @authentication_error.
  ///
  /// In fa, this message translates to:
  /// **'جهت شروع فرآیند‌های سپرده و کارت، نیازمند انجام فرآیند احراز هویت و امضاء دیجیتال می‌باشید'**
  String get authentication_error;

  /// No description provided for @file_size_error_more_than_1mb.
  ///
  /// In fa, this message translates to:
  /// **'حجم فایل انتخابی شما بیشتر از یک مگابایت است!'**
  String get file_size_error_more_than_1mb;

  /// No description provided for @transfer_not_allowed_for_deposit_type.
  ///
  /// In fa, this message translates to:
  /// **'امکان انتقال وجه برای این نوع سپرده وجود ندارد'**
  String get transfer_not_allowed_for_deposit_type;

  /// No description provided for @shaba_number_copied.
  ///
  /// In fa, this message translates to:
  /// **'شماره شبا کپی شد'**
  String get shaba_number_copied;

  /// No description provided for @avatar_editing_completed_successfully.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش آواتار با موفقیت انجام شد'**
  String get avatar_editing_completed_successfully;

  /// No description provided for @deposit_number_copied.
  ///
  /// In fa, this message translates to:
  /// **'شماره سپرده کپی شد'**
  String get deposit_number_copied;

  /// No description provided for @select_date_warning.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ را انتخاب کنید'**
  String get select_date_warning;

  /// No description provided for @select_option_warning.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از گزینه‌ها را انتخاب کنید'**
  String get select_option_warning;

  /// No description provided for @selected_service_unavailable.
  ///
  /// In fa, this message translates to:
  /// **'در حال حاضر، سرویس مورد نظر غیرفعال است'**
  String get selected_service_unavailable;

  /// No description provided for @service_unavailable.
  ///
  /// In fa, this message translates to:
  /// **'این سرویس در حال حاضر در دسترس نمی‌باشد'**
  String get service_unavailable;

  /// No description provided for @card_issue_not_allowed.
  ///
  /// In fa, this message translates to:
  /// **'امکان صدور کارت برای این نوع سپرده وجود ندارد'**
  String get card_issue_not_allowed;

  /// No description provided for @deposit_already_created.
  ///
  /// In fa, this message translates to:
  /// **'قبلا از این نوع سپرده برای شما ایجاد شده است'**
  String get deposit_already_created;

  /// No description provided for @service_unavailable_.
  ///
  /// In fa, this message translates to:
  /// **'این سرویس فعلا در دسترس نمی‌باشد'**
  String get service_unavailable_;

  /// No description provided for @card_issue.
  ///
  /// In fa, this message translates to:
  /// **'صدور کارت'**
  String get card_issue;

  /// No description provided for @text_copied.
  ///
  /// In fa, this message translates to:
  /// **'مقدار در حافظه کپی شد'**
  String get text_copied;

  /// No description provided for @information_update.
  ///
  /// In fa, this message translates to:
  /// **'بروزرسانی اطلاعات'**
  String get information_update;

  /// No description provided for @services_inactive_contact_support.
  ///
  /// In fa, this message translates to:
  /// **'خدمات مرتبط با سپرده‌های بانک گردشگری شما غیرفعال شده است. با پشتیبانی توبانک ارتباط برقرار نمایید.'**
  String get services_inactive_contact_support;

  /// No description provided for @customer_definition_success_wait_for_shahab_code.
  ///
  /// In fa, this message translates to:
  /// **'تعریف مشتری شما با موفقیت انجام شده است اما کد شهاب برای شما صادر نشده است. این کار معمولا بین ۵ تا ۱۰ دقیقه زمان خواهد برد. لطفا منتظر بمانید'**
  String get customer_definition_success_wait_for_shahab_code;

  /// No description provided for @please_complete_authentication_to_activate_services.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، برای فعال‌سازی خدمات مرتبط با سپرده‌های بانک گردشگری، لطفاً فرآیند احراز هویت را تکمیل نمایید.'**
  String get please_complete_authentication_to_activate_services;

  /// No description provided for @please_complete_information_update_for_services_activation.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، برای فعال‌سازی خدمات مرتبط با سپرده‌های بانک گردشگری، لطفاً فرآیند بروزرسانی اطلاعات را تکمیل نمایید.'**
  String get please_complete_information_update_for_services_activation;

  /// No description provided for @please_define_customer_for_services_activation.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، برای فعال‌سازی خدمات مرتبط با سپرده‌های بانک گردشگری، نیازمند انجام تعریف مشتری می‌باشید.'**
  String get please_define_customer_for_services_activation;

  /// No description provided for @update_in_progress.
  ///
  /// In fa, this message translates to:
  /// **'بروزرسانی'**
  String get update_in_progress;

  /// No description provided for @coming_soon_.
  ///
  /// In fa, this message translates to:
  /// **'به زودی ...'**
  String get coming_soon_;

  /// No description provided for @edit_doc.
  ///
  /// In fa, this message translates to:
  /// **'اصلاح مدارک'**
  String get edit_doc;

  /// No description provided for @due_to_document_deficiency_process_prevented.
  ///
  /// In fa, this message translates to:
  /// **'به دلیل نقص مدارک، از ادامه فرآیند جلوگیری شده‌است. لطفا مدارک خود را اصلاح نمایید.'**
  String get due_to_document_deficiency_process_prevented;

  /// No description provided for @documents_under_review_please_wait.
  ///
  /// In fa, this message translates to:
  /// **'مدارک شما در حال بررسی می‌باشد. تا تایید مدارک لطفا شکیبا باشید.'**
  String get documents_under_review_please_wait;

  /// No description provided for @authentication_documents_rejected_need_to_reauthenticate.
  ///
  /// In fa, this message translates to:
  /// **'مدارک احراز هویت شما رد شده‌است. نیازمند انجام مجدد احراز هویت می‌باشید.'**
  String get authentication_documents_rejected_need_to_reauthenticate;

  /// No description provided for @documents_under_review.
  ///
  /// In fa, this message translates to:
  /// **'مدارک شما در حال بررسی می‌باشد. تا تایید مدارک لطفا شکیبا باشید.'**
  String get documents_under_review;

  /// No description provided for @services_disabled_due_to_sheba_documents.
  ///
  /// In fa, this message translates to:
  /// **'خدمات مرتبط با سپرده‌های بانک گردشگری شما غیرفعال شده است. با پشتیبانی توبانک ارتباط برقرار نمایید.'**
  String get services_disabled_due_to_sheba_documents;

  /// No description provided for @documents_rejected_requires_reauthentication.
  ///
  /// In fa, this message translates to:
  /// **'مدارک احراز هویت شما رد شده‌است. نیازمند انجام مجدد احراز هویت می‌باشید.'**
  String get documents_rejected_requires_reauthentication;

  /// No description provided for @only_for_deposits_with_active_bank_cards.
  ///
  /// In fa, this message translates to:
  /// **'این امکان فقط برای سپرده‌های دارای کارت بانکی فعال است'**
  String get only_for_deposits_with_active_bank_cards;

  /// No description provided for @source_and_destination_card_numbers_cannot_be_same.
  ///
  /// In fa, this message translates to:
  /// **'شماره کارت مبدا و مقصد نمی‌توانند یکسان باشند'**
  String get source_and_destination_card_numbers_cannot_be_same;

  /// No description provided for @enter_valid_destination_card_number.
  ///
  /// In fa, this message translates to:
  /// **'مقدار صحیحی برای کارت مقصد وارد نمایید'**
  String get enter_valid_destination_card_number;

  /// No description provided for @scan_card_failed_try_again.
  ///
  /// In fa, this message translates to:
  /// **'اسکن کارت با موفقیت انجام نشد. دوباره تلاش کنید'**
  String get scan_card_failed_try_again;

  /// No description provided for @invalid_sheba_number_length.
  ///
  /// In fa, this message translates to:
  /// **'طول شماره شبا وارد شده صحیح نیست'**
  String get invalid_sheba_number_length;

  /// No description provided for @method_not_available.
  ///
  /// In fa, this message translates to:
  /// **'امکان انتخاب این روش وجود ندارد'**
  String get method_not_available;

  /// No description provided for @pay_not_successfull.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت با موفقیت انجام نشد'**
  String get pay_not_successfull;

  /// No description provided for @arbaeein_qr_code_credit_card.
  ///
  /// In fa, this message translates to:
  /// **'اینجانب تایید می‌نمایم اطلاعات مورد نظر کمیته اربعین در قالب QR CODE بر روی کارت نقدی ارسالی اینجانب درج گردد.'**
  String get arbaeein_qr_code_credit_card;

  /// No description provided for @amount_invalid_message_multiple_of_50.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ وارد شده باید مضربی از ۵۰ باشد'**
  String get amount_invalid_message_multiple_of_50;

  /// No description provided for @amount_invalid_message_below_minimum.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ وارد شده کمتر از حداقل مورد نیاز است'**
  String get amount_invalid_message_below_minimum;

  /// No description provided for @please_select_one_of_deposit.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از سپرده‌ها را انتخاب نمایید'**
  String get please_select_one_of_deposit;

  /// No description provided for @card_information_updated_successfully.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات کارت با موفقیت ویرایش شد'**
  String get card_information_updated_successfully;

  /// No description provided for @service_coming_soon.
  ///
  /// In fa, this message translates to:
  /// **'این سرویس به‌زودی در دسترس خواهد بود'**
  String get service_coming_soon;

  /// No description provided for @digital_signature_required.
  ///
  /// In fa, this message translates to:
  /// **'ابتدا باید امضا دیجیتال خود را ثبت کنید'**
  String get digital_signature_required;

  /// No description provided for @update_identity_information.
  ///
  /// In fa, this message translates to:
  /// **'جهت استفاده از خدمات می‌بایست اطلاعات احراز هویت را بروزرسانی کنید'**
  String get update_identity_information;

  /// No description provided for @re_authentication_required.
  ///
  /// In fa, this message translates to:
  /// **'جهت استفاده از خدمات می‌بایست مجدد احراز هویت کنید'**
  String get re_authentication_required;

  /// No description provided for @max_daily_cards_purchase.
  ///
  /// In fa, this message translates to:
  /// **'مجاز به خرید روزانه حداکثر ۵کارت هستید'**
  String get max_daily_cards_purchase;

  /// No description provided for @invalid_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ وارد شده معتبر نیست'**
  String get invalid_amount;

  /// No description provided for @add_at_least_one_card.
  ///
  /// In fa, this message translates to:
  /// **'لطفا حداقل یک کارت اضافه کنید'**
  String get add_at_least_one_card;

  /// No description provided for @select_delivery_time.
  ///
  /// In fa, this message translates to:
  /// **'لطفا زمان تحویل را انتخاب کنید'**
  String get select_delivery_time;

  /// No description provided for @payment_return_policy.
  ///
  /// In fa, this message translates to:
  /// **'بعد از پرداخت، بازگشت وجه امکان پذیر نیست. لذا از دستور پرداخت اطمینان حاصل فرمایید'**
  String get payment_return_policy;

  /// No description provided for @select_text_and_design.
  ///
  /// In fa, this message translates to:
  /// **'لطفا متن و طرح را انتخاب کنید'**
  String get select_text_and_design;

  /// No description provided for @default_text.
  ///
  /// In fa, this message translates to:
  /// **'متن مورد نظر شما'**
  String get default_text;

  /// No description provided for @daily_gift_card_limit_reached.
  ///
  /// In fa, this message translates to:
  /// **'شما ۵کارت هدیه روزانه خود را خریداری کرده‌اید. لطفا بعدا مراجعه نمایید'**
  String get daily_gift_card_limit_reached;

  /// No description provided for @default_text_required.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب یک متن پیش‌فرض اجباری است'**
  String get default_text_required;

  /// No description provided for @select_card_image.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تصویر روی کارت را انتخاب کنید'**
  String get select_card_image;

  /// No description provided for @custom_text_length.
  ///
  /// In fa, this message translates to:
  /// **'متن دلخواه باید بین ۳ تا ۴۰ کاراکتر باشد'**
  String get custom_text_length;

  /// No description provided for @help_description.
  ///
  /// In fa, this message translates to:
  /// **'در صورت ورود متن دلخواه، یکی از متن‌های پیشفرض را انتخاب کنید تا در صورت عدم موافقت بانک با متن دلخواه شما، متن پیشفرض جایگزین آن شود'**
  String get help_description;

  /// No description provided for @redirecting_to_browser_for_payment.
  ///
  /// In fa, this message translates to:
  /// **'برای پرداخت به مرورگر منتقل می‌شوید.'**
  String get redirecting_to_browser_for_payment;

  /// No description provided for @return_to_app_after_payment.
  ///
  /// In fa, this message translates to:
  /// **'بعد از فرآیند پرداخت جهت ادامه فرآیند به اپلیکیشن توبانک بازگردید.'**
  String get return_to_app_after_payment;

  /// No description provided for @contact_removed_from_favorites.
  ///
  /// In fa, this message translates to:
  /// **'شماره از لیست مخاطبین منتخب حذف شد'**
  String get contact_removed_from_favorites;

  /// No description provided for @transaction_status_unknown.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت تراکنش نامعلوم است'**
  String get transaction_status_unknown;

  /// No description provided for @wallet_payment_confirmation.
  ///
  /// In fa, this message translates to:
  /// **'آیا می‌خواهید از کیف پول پرداخت کنید؟'**
  String get wallet_payment_confirmation;

  /// No description provided for @internet_payment_confirmation.
  ///
  /// In fa, this message translates to:
  /// **'آیا می‌خواهید به صورت اینترنتی پرداخت کنید؟'**
  String get internet_payment_confirmation;

  /// No description provided for @wallet_payment_description.
  ///
  /// In fa, this message translates to:
  /// **'با پرداخت از کیف‌پول، از اعتبار آن کم خواهد شد'**
  String get wallet_payment_description;

  /// No description provided for @internet_payment_description.
  ///
  /// In fa, this message translates to:
  /// **'شما به درگاه پرداخت اینترنتی هدایت خواهید شد'**
  String get internet_payment_description;

  /// No description provided for @payment_amount_too_low.
  ///
  /// In fa, this message translates to:
  /// **'امکان پرداخت مبالغ کمتر از ۱۰هزار ریال از طریق درگاه وجود ندارد'**
  String get payment_amount_too_low;

  /// No description provided for @please_select_operator.
  ///
  /// In fa, this message translates to:
  /// **'لطفا اپراتور خود را انتخاب نمایید'**
  String get please_select_operator;

  /// No description provided for @select_sim_type.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از نوع‌های سیم‌کارت را انتخاب نمایید'**
  String get select_sim_type;

  /// No description provided for @invite_code_shared.
  ///
  /// In fa, this message translates to:
  /// **'کد دعوت به شعبه مجازی'**
  String get invite_code_shared;

  /// No description provided for @invite_code_copied.
  ///
  /// In fa, this message translates to:
  /// **'کد دعوت کپی شد'**
  String get invite_code_copied;

  /// No description provided for @password_copied.
  ///
  /// In fa, this message translates to:
  /// **'رمز کپی شد'**
  String get password_copied;

  /// No description provided for @confirm_button_title.
  ///
  /// In fa, this message translates to:
  /// **'استعلام هزینه'**
  String get confirm_button_title;

  /// No description provided for @bill_updated_successfully.
  ///
  /// In fa, this message translates to:
  /// **'قبض با موفقیت ویرایش شد'**
  String get bill_updated_successfully;

  /// No description provided for @bill_deleted_successfully.
  ///
  /// In fa, this message translates to:
  /// **'قبض با موفقیت حذف شد'**
  String get bill_deleted_successfully;

  /// No description provided for @are_you_sure_to_delete_bill.
  ///
  /// In fa, this message translates to:
  /// **'از حذف قبض جاری مطمئن هستید؟'**
  String get are_you_sure_to_delete_bill;

  /// No description provided for @bill_will_be_removed_from_list.
  ///
  /// In fa, this message translates to:
  /// **'قبض انتخاب شده از لیست قبض‌های شما حذف خواهد شد'**
  String get bill_will_be_removed_from_list;

  /// No description provided for @are_you_sure_to_pay_bill.
  ///
  /// In fa, this message translates to:
  /// **'از پرداخت قبض مطمئن هستید؟'**
  String get are_you_sure_to_pay_bill;

  /// No description provided for @bill_will_be_paid.
  ///
  /// In fa, this message translates to:
  /// **'قبض مشخص شده، پرداخت خواهد شد'**
  String get bill_will_be_paid;

  /// No description provided for @bill_already_paid.
  ///
  /// In fa, this message translates to:
  /// **'قبض مورد نظر پرداخت شده است'**
  String get bill_already_paid;

  /// No description provided for @payment_must_be_wallet_for_small_amounts.
  ///
  /// In fa, this message translates to:
  /// **'برای مبالغ کمتر از ۱۰۰۰ تومان، نوع پرداخت باید کیف پول باشد'**
  String get payment_must_be_wallet_for_small_amounts;

  /// No description provided for @camera_access_required.
  ///
  /// In fa, this message translates to:
  /// **'دسترسی به دوربین برای اسکن بارکد'**
  String get camera_access_required;

  /// No description provided for @camera_access_required_description.
  ///
  /// In fa, this message translates to:
  /// **'برای اسکن بارکد قبض، نیاز به دسترسی به دوربین دستگاه است'**
  String get camera_access_required_description;

  /// No description provided for @qr_camera_access_required_description.
  ///
  /// In fa, this message translates to:
  /// **'برای اسکن بارکد، نیاز به دسترسی به دوربین دستگاه است'**
  String get qr_camera_access_required_description;

  /// No description provided for @invalid_barcode.
  ///
  /// In fa, this message translates to:
  /// **'مقدار بارکد معتبر نیست'**
  String get invalid_barcode;

  /// No description provided for @save_bill_and_cheque_cost.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره قبض و استعلام هزینه'**
  String get save_bill_and_cheque_cost;

  /// No description provided for @app_not_supported_on_this_device.
  ///
  /// In fa, this message translates to:
  /// **'امکان اجرای برنامه بر روی این دستگاه وجود ندارد'**
  String get app_not_supported_on_this_device;

  /// No description provided for @logout_required_for_password_reset.
  ///
  /// In fa, this message translates to:
  /// **'به جهت ایجاد رمز عبور جدید، ابتدا می‌بایست از حساب‌کاربری خارج شده و مجددا به برنامه وارد شوید'**
  String get logout_required_for_password_reset;

  /// No description provided for @logout_warning_description.
  ///
  /// In fa, this message translates to:
  /// **'در صورت خروج از حساب‌کاربری، برای ورود مجدد نیاز به احراز هویت خواهید داشت. احراز هویت مجدد، به منظور افزایش امنیت حساب‌کاربری و جلوگیری از دسترسی غیرمجاز افراد ناشناس به حساب شما می‌باشد.'**
  String get logout_warning_description;

  /// No description provided for @logout.
  ///
  /// In fa, this message translates to:
  /// **'خروج'**
  String get logout;

  /// No description provided for @confirm_credit_rating_fee_payment.
  ///
  /// In fa, this message translates to:
  /// **'از پرداخت هزینه استعلام رتبه اعتباری مطمئن هستید؟'**
  String get confirm_credit_rating_fee_payment;

  /// No description provided for @please_select_loan_repayment_period.
  ///
  /// In fa, this message translates to:
  /// **'لطفا زمان بازپرداخت تسهیلات را انتخاب کنید'**
  String get please_select_loan_repayment_period;

  /// No description provided for @turbo_loan_eligibility.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، با توجه به رتبه اعتباری شما، اعطای تسهیلات طرح توربو به صورت غیر حضوری به شما امکانپذیر می‌باشد'**
  String get turbo_loan_eligibility;

  /// No description provided for @credit_rating.
  ///
  /// In fa, this message translates to:
  /// **'رتبه اعتباری شما'**
  String get credit_rating;

  /// No description provided for @request_registered_in_queue.
  ///
  /// In fa, this message translates to:
  /// **'درخواست شما ثبت شده و در صف دریافت گزارش می‌باشید'**
  String get request_registered_in_queue;

  /// No description provided for @request_registered_waiting_queue.
  ///
  /// In fa, this message translates to:
  /// **'درخواست شما ثبت شده و در انتظار ورود به صف دریافت گزارش می‌باشید'**
  String get request_registered_waiting_queue;

  /// No description provided for @credit_report_retry_time.
  ///
  /// In fa, this message translates to:
  /// **'جهت دریافت گزارش اعتبارسنجی خود ۳۰ دقیقه دیگر به این بخش مراجعه نمایید'**
  String get credit_report_retry_time;

  /// No description provided for @delete_notification.
  ///
  /// In fa, this message translates to:
  /// **'حذف اعلان'**
  String get delete_notification;

  /// No description provided for @delete_notification_confirmation.
  ///
  /// In fa, this message translates to:
  /// **'این اعلان به صورت دایم از لیست شما حذف شود؟'**
  String get delete_notification_confirmation;

  /// No description provided for @notification_deleted_successfully.
  ///
  /// In fa, this message translates to:
  /// **'اعلان با موفقیت حذف شد'**
  String get notification_deleted_successfully;

  /// No description provided for @amount_below_minimum_for_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ انتخاب شده از حداقل مبلغ مورد نیاز برای صدور سفته کمتر است'**
  String get amount_below_minimum_for_promissory_note;

  /// No description provided for @please_upload_all_required_documents.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تمامی مدارک مورد نیاز را آپلود کنید'**
  String get please_upload_all_required_documents;

  /// No description provided for @please_select_all_required_files.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تمامی فایل‌های مورد نیاز را انتخاب کنید'**
  String get please_select_all_required_files;

  /// No description provided for @enter_national_card_series_number.
  ///
  /// In fa, this message translates to:
  /// **'لطفا سریال کارت ملی را وارد کنید'**
  String get enter_national_card_series_number;

  /// No description provided for @enter_national_card_receipt_number.
  ///
  /// In fa, this message translates to:
  /// **'لطفا شماره رسید کارت ملی را وارد کنید'**
  String get enter_national_card_receipt_number;

  /// No description provided for @parsa_loan_eligibility.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، با توجه به رتبه اعتباری شما، اعطای تسهیلات طرح پارسا به صورت غیر حضوری به شما امکانپذیر می‌باشد'**
  String get parsa_loan_eligibility;

  /// No description provided for @not_eligible_for_loan_due_to_credit_score.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی، با توجه به رتبه اعتباری، شما مشمول دریافت وام نمی‌باشید'**
  String get not_eligible_for_loan_due_to_credit_score;

  /// No description provided for @return_to_homepage.
  ///
  /// In fa, this message translates to:
  /// **'بازگشت به صفحه اصلی'**
  String get return_to_homepage;

  /// No description provided for @retry_credit_score_request_after_48_hours.
  ///
  /// In fa, this message translates to:
  /// **'به دلیل عدم دریافت پاسخ رتبه اعتباری مجددا بعد از ۴۸ ساعت اقدام نمایید'**
  String get retry_credit_score_request_after_48_hours;

  /// No description provided for @please_register_promissory_note_for_guarantee.
  ///
  /// In fa, this message translates to:
  /// **'جهت ادامه فرآیند سفته خود را جهت ضمانت ثبت کنید'**
  String get please_register_promissory_note_for_guarantee;

  /// No description provided for @please_select_parsa_loan_plan.
  ///
  /// In fa, this message translates to:
  /// **'لطفا طرح وام پارسا را انتخاب نمایید'**
  String get please_select_parsa_loan_plan;

  /// No description provided for @cheque_receipt_description.
  ///
  /// In fa, this message translates to:
  /// **'در صورت صحت اطلاعات درج شده در نسخه کاغذی چک و دریافت آن از صادر کننده، دریافت چک را تایید نمایید'**
  String get cheque_receipt_description;

  /// No description provided for @final_confirmation.
  ///
  /// In fa, this message translates to:
  /// **'تایید نهایی'**
  String get final_confirmation;

  /// No description provided for @at_least_one_cheque_receiver_required.
  ///
  /// In fa, this message translates to:
  /// **'حداقل یک گیرنده چک ثبت نمایید'**
  String get at_least_one_cheque_receiver_required;

  /// No description provided for @error_occurred_try_again.
  ///
  /// In fa, this message translates to:
  /// **'خطایی روی داد. دوباره تلاش کنید'**
  String get error_occurred_try_again;

  /// No description provided for @registered_cards.
  ///
  /// In fa, this message translates to:
  /// **'کارت‌های ثبت شده:'**
  String get registered_cards;

  /// No description provided for @wait_30_sec.
  ///
  /// In fa, this message translates to:
  /// **'قبل از درخواست مجدد باید ۳۰ ثانیه صبر کنید'**
  String get wait_30_sec;

  /// No description provided for @select_bank_card.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب کارت بانکی'**
  String get select_bank_card;

  /// No description provided for @unknown_error.
  ///
  /// In fa, this message translates to:
  /// **'خطای نامشخص'**
  String get unknown_error;

  /// No description provided for @error_in_destination_card_inquiry_recheck_accuracy_of_destination_card_number.
  ///
  /// In fa, this message translates to:
  /// **'خطا در استعلام کارت مقصد - صحت شماره کارت مقصد را مجددا بررسی نمایید.'**
  String
      get error_in_destination_card_inquiry_recheck_accuracy_of_destination_card_number;

  /// No description provided for @select_bank_card_first.
  ///
  /// In fa, this message translates to:
  /// **'ابتدا کارت بانکی را انتخاب نمایید'**
  String get select_bank_card_first;

  /// No description provided for @dynamic_password_sent.
  ///
  /// In fa, this message translates to:
  /// **'رمز پویا برای شما پیامک شد'**
  String get dynamic_password_sent;

  /// No description provided for @operation_failed.
  ///
  /// In fa, this message translates to:
  /// **'خطا در عملیات'**
  String get operation_failed;

  /// No description provided for @sms_code_reading_failed.
  ///
  /// In fa, this message translates to:
  /// **'خواندن کد پیامک شده، با خطا مواجه شد'**
  String get sms_code_reading_failed;

  /// No description provided for @parcel_status_delivered.
  ///
  /// In fa, this message translates to:
  /// **'تحویل داده شده'**
  String get parcel_status_delivered;

  /// No description provided for @parcel_status_rejected.
  ///
  /// In fa, this message translates to:
  /// **'مرجوعی'**
  String get parcel_status_rejected;

  /// No description provided for @parcel_status_no_response.
  ///
  /// In fa, this message translates to:
  /// **'بدون پاسخ'**
  String get parcel_status_no_response;

  /// No description provided for @promissory_request_error.
  ///
  /// In fa, this message translates to:
  /// **'شما درخواست صدور سفته ناتمام و نامرتبط با تسهیلات درخواستی دارید.\nاز طریق منوی سفته و برات در سفته‌های من و در انتظار تکمیل نسبت به لغو درخواست اقدام فرمایید.'**
  String get promissory_request_error;

  /// No description provided for @promissory_issuance_title.
  ///
  /// In fa, this message translates to:
  /// **'صدور سفته'**
  String get promissory_issuance_title;

  /// No description provided for @select_promissory_from_issued.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب از سفته‌های صادر شده'**
  String get select_promissory_from_issued;

  /// No description provided for @select_account.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از حساب‌های خود را انتخاب کنید'**
  String get select_account;

  /// No description provided for @promissory_payment_confirmation.
  ///
  /// In fa, this message translates to:
  /// **'از پرداخت هزینه صدور سفته مطمئن هستید؟'**
  String get promissory_payment_confirmation;

  /// No description provided for @promissory_cancellation_info.
  ///
  /// In fa, this message translates to:
  /// **'در صورت لغو سفته امضا نشده، مبلغ تمبر به حساب شما برنمی‌گردد'**
  String get promissory_cancellation_info;

  /// No description provided for @no_promissory_selected.
  ///
  /// In fa, this message translates to:
  /// **'سفته‌ای انتخاب نکرده‌اید'**
  String get no_promissory_selected;

  /// No description provided for @selected_successfully.
  ///
  /// In fa, this message translates to:
  /// **'با موفقیت انتخاب شد.'**
  String get selected_successfully;

  /// No description provided for @promissory_signature_confirmation.
  ///
  /// In fa, this message translates to:
  /// **'از امضای سفته مطمئن هستید؟'**
  String get promissory_signature_confirmation;

  /// No description provided for @endorsement_signature_confirmation.
  ///
  /// In fa, this message translates to:
  /// **'از امضای ظهرنویسی سفته مطمئن هستید؟'**
  String get endorsement_signature_confirmation;

  /// No description provided for @coming_soon.
  ///
  /// In fa, this message translates to:
  /// **'به‌زودی'**
  String get coming_soon;

  /// No description provided for @promissory_unique_id_copied.
  ///
  /// In fa, this message translates to:
  /// **'شناسه یکتا سفته کپی شد'**
  String get promissory_unique_id_copied;

  /// No description provided for @select_birth_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ تولد را انتخاب نمایید'**
  String get select_birth_date;

  /// No description provided for @no_security_method.
  ///
  /// In fa, this message translates to:
  /// **'بر روی دستگاه شما رمز، پین یا اثر انگشت وجود ندارد'**
  String get no_security_method;

  /// No description provided for @authentication_update_success.
  ///
  /// In fa, this message translates to:
  /// **'روند بروزرسانی احراز هویت با موفقیت انجام شد'**
  String get authentication_update_success;

  /// No description provided for @authentication_not_completed.
  ///
  /// In fa, this message translates to:
  /// **'روند احراز هویت کامل نشد. لطفا دوباره تلاش کنید'**
  String get authentication_not_completed;

  /// No description provided for @select_branch.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از شعبه‌ها را انتخاب کنید'**
  String get select_branch;

  /// No description provided for @sure_of_payment.
  ///
  /// In fa, this message translates to:
  /// **'از پرداخت خود مطمئن هستید؟'**
  String get sure_of_payment;

  /// No description provided for @please_select_box.
  ///
  /// In fa, this message translates to:
  /// **'لطفا یکی از صندوق‌ها را انتخاب کنید'**
  String get please_select_box;

  /// No description provided for @select_visit_datetime.
  ///
  /// In fa, this message translates to:
  /// **'لطفا تاریخ و زمان بازدید را انتخاب کنید'**
  String get select_visit_datetime;

  /// No description provided for @safe_box_payment_description.
  ///
  /// In fa, this message translates to:
  /// **'هزینه صندوق امانات انتخاب شده، پرداخت خواهد شد'**
  String get safe_box_payment_description;

  /// No description provided for @pending_request_warning.
  ///
  /// In fa, this message translates to:
  /// **'شما در حال حاضر یک درخواست در انتظار تایید دارید. پس از تعیین وضعیت آن، می‌توانید برای صندوق امانات جدید درخواست بدهید.'**
  String get pending_request_warning;

  /// No description provided for @confirm_logout.
  ///
  /// In fa, this message translates to:
  /// **'مطمئن به خروج از حساب‌کاربری هستید؟'**
  String get confirm_logout;

  /// No description provided for @logout_from_account.
  ///
  /// In fa, this message translates to:
  /// **'خروج از حساب‌کاربری'**
  String get logout_from_account;

  /// No description provided for @logout_description.
  ///
  /// In fa, this message translates to:
  /// **'در صورت خروج از حساب‌کاربری، برای ورود مجدد نیاز به احراز هویت خواهید داشت. احراز هویت مجدد، به منظور افزایش امنیت حساب‌کاربری و جلوگیری از دسترسی غیرمجاز افراد ناشناس به حساب شما می‌باشد.'**
  String get logout_description;

  /// No description provided for @password_farsi_error.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور نباید شامل حروف فارسی باشد'**
  String get password_farsi_error;

  /// No description provided for @password_length_error.
  ///
  /// In fa, this message translates to:
  /// **'حداقل طول رمز عبور 8 کارکتر است'**
  String get password_length_error;

  /// No description provided for @confirm_sim_charge_payment.
  ///
  /// In fa, this message translates to:
  /// **'از پرداخت شارژ سیم‌کارت مطمئن هستید؟'**
  String get confirm_sim_charge_payment;

  /// No description provided for @sim_charge_description.
  ///
  /// In fa, this message translates to:
  /// **'سیم‌کارت شما به مقدار انتخاب شده شارژ خواهد شد'**
  String get sim_charge_description;

  /// No description provided for @wallet_payment_limit.
  ///
  /// In fa, this message translates to:
  /// **'برای مبالغ کمتر از ۱۰۰۰ تومان، نوع پرداخت باید کیف پول باشد'**
  String get wallet_payment_limit;

  /// No description provided for @info_verification_success.
  ///
  /// In fa, this message translates to:
  /// **'تطابق اطلاعات با موفقیت انجام شد'**
  String get info_verification_success;

  /// No description provided for @card_transfer_unavailable.
  ///
  /// In fa, this message translates to:
  /// **'برای این کارت امکان کارت به کارت فعلا مقدور نیست'**
  String get card_transfer_unavailable;

  /// No description provided for @card_set_as_default.
  ///
  /// In fa, this message translates to:
  /// **'کارت به عنوان پیش‌فرض ثبت شد'**
  String get card_set_as_default;

  /// No description provided for @distributor_company.
  ///
  /// In fa, this message translates to:
  /// **'شرکت توزیع‌کننده'**
  String get distributor_company;

  /// No description provided for @charity_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع نیکوکاری'**
  String get charity_type;

  /// No description provided for @package_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع بسته'**
  String get package_type;

  /// No description provided for @charge_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع شارژ'**
  String get charge_type;

  /// No description provided for @insurance_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره بیمه'**
  String get insurance_number;

  /// No description provided for @wallet_destination.
  ///
  /// In fa, this message translates to:
  /// **'مقصد کیف پول'**
  String get wallet_destination;

  /// No description provided for @destination.
  ///
  /// In fa, this message translates to:
  /// **'مقصد'**
  String get destination;

  /// No description provided for @name_of_card_owner.
  ///
  /// In fa, this message translates to:
  /// **'نام صاحب کارت'**
  String get name_of_card_owner;

  /// No description provided for @select_transaction_type.
  ///
  /// In fa, this message translates to:
  /// **'حداقل یک نوع تراکنش را انتخاب نمایید'**
  String get select_transaction_type;

  /// No description provided for @address_updated_successfully.
  ///
  /// In fa, this message translates to:
  /// **'آدرس با موفقیت ویرایش شد'**
  String get address_updated_successfully;

  /// No description provided for @download_new_version.
  ///
  /// In fa, this message translates to:
  /// **'دریافت نسخه جدید'**
  String get download_new_version;

  /// No description provided for @farvardin.
  ///
  /// In fa, this message translates to:
  /// **'فروردین'**
  String get farvardin;

  /// No description provided for @ordibehesht.
  ///
  /// In fa, this message translates to:
  /// **'اردیبهشت'**
  String get ordibehesht;

  /// No description provided for @khordad.
  ///
  /// In fa, this message translates to:
  /// **'خرداد'**
  String get khordad;

  /// No description provided for @tir.
  ///
  /// In fa, this message translates to:
  /// **'تیر'**
  String get tir;

  /// No description provided for @mordad.
  ///
  /// In fa, this message translates to:
  /// **'مرداد'**
  String get mordad;

  /// No description provided for @shahrivar.
  ///
  /// In fa, this message translates to:
  /// **'شهریور'**
  String get shahrivar;

  /// No description provided for @mehr.
  ///
  /// In fa, this message translates to:
  /// **'مهر'**
  String get mehr;

  /// No description provided for @aban.
  ///
  /// In fa, this message translates to:
  /// **'آبان'**
  String get aban;

  /// No description provided for @azar.
  ///
  /// In fa, this message translates to:
  /// **'آذر'**
  String get azar;

  /// No description provided for @dey.
  ///
  /// In fa, this message translates to:
  /// **'دی'**
  String get dey;

  /// No description provided for @bahman.
  ///
  /// In fa, this message translates to:
  /// **'بهمن'**
  String get bahman;

  /// No description provided for @esfand.
  ///
  /// In fa, this message translates to:
  /// **'اسفند'**
  String get esfand;

  /// No description provided for @january.
  ///
  /// In fa, this message translates to:
  /// **'Jan'**
  String get january;

  /// No description provided for @february.
  ///
  /// In fa, this message translates to:
  /// **'Feb'**
  String get february;

  /// No description provided for @march.
  ///
  /// In fa, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In fa, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In fa, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In fa, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In fa, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In fa, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In fa, this message translates to:
  /// **'Sep'**
  String get september;

  /// No description provided for @october.
  ///
  /// In fa, this message translates to:
  /// **'Oct'**
  String get october;

  /// No description provided for @november.
  ///
  /// In fa, this message translates to:
  /// **'Nov'**
  String get november;

  /// No description provided for @december.
  ///
  /// In fa, this message translates to:
  /// **'Dec'**
  String get december;

  /// No description provided for @signature_applied_successfully.
  ///
  /// In fa, this message translates to:
  /// **'با موفقیت امضا اعمال شد'**
  String get signature_applied_successfully;

  /// No description provided for @authentication_signature_not_supported.
  ///
  /// In fa, this message translates to:
  /// **'امضای احراز هویت پشتیبانی نمی‌شود'**
  String get authentication_signature_not_supported;

  /// No description provided for @intrabank_transfer.
  ///
  /// In fa, this message translates to:
  /// **'انتقال درون بانکی'**
  String get intrabank_transfer;

  /// No description provided for @intrabank_transfer_description.
  ///
  /// In fa, this message translates to:
  /// **'انتقال آنی'**
  String get intrabank_transfer_description;

  /// No description provided for @paya_transfer.
  ///
  /// In fa, this message translates to:
  /// **'انتقال پایا'**
  String get paya_transfer;

  /// No description provided for @paya_transfer_description.
  ///
  /// In fa, this message translates to:
  /// **'انتقال طبق سیکل بانک مرکزی'**
  String get paya_transfer_description;

  /// No description provided for @satna_transfer.
  ///
  /// In fa, this message translates to:
  /// **'انتقال ساتنا'**
  String get satna_transfer;

  /// No description provided for @satna_transfer_description.
  ///
  /// In fa, this message translates to:
  /// **'حداقل مبلغ برای انتقال ساتنا ۱۰۰.۰۰۰.۰۰۰ تومان است.'**
  String get satna_transfer_description;

  /// No description provided for @salary_deposit.
  ///
  /// In fa, this message translates to:
  /// **'واریز حقوق'**
  String get salary_deposit;

  /// No description provided for @insurance_services.
  ///
  /// In fa, this message translates to:
  /// **'امور بیمه خدمات'**
  String get insurance_services;

  /// No description provided for @medical_expenses.
  ///
  /// In fa, this message translates to:
  /// **'امور درمانی'**
  String get medical_expenses;

  /// No description provided for @investment_and_stock.
  ///
  /// In fa, this message translates to:
  /// **'امور سرمایه‌گذاری و بورس'**
  String get investment_and_stock;

  /// No description provided for @foreign_exchange.
  ///
  /// In fa, this message translates to:
  /// **'امور ارزی در چهار چوب ضوابط و مقررات'**
  String get foreign_exchange;

  /// No description provided for @debt_repayment.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت قرض و تادیه دیون(قرض‌الحسنه، بدهی و ...)'**
  String get debt_repayment;

  /// No description provided for @retirement.
  ///
  /// In fa, this message translates to:
  /// **'امور بازنشستگی'**
  String get retirement;

  /// No description provided for @movable_property_transactions.
  ///
  /// In fa, this message translates to:
  /// **'معاملات اموال منقول'**
  String get movable_property_transactions;

  /// No description provided for @immovable_property_transactions.
  ///
  /// In fa, this message translates to:
  /// **'معاملات اموال غیر منقول'**
  String get immovable_property_transactions;

  /// No description provided for @liquidity_management.
  ///
  /// In fa, this message translates to:
  /// **'مدیریت نقدینگی'**
  String get liquidity_management;

  /// No description provided for @customs_duties.
  ///
  /// In fa, this message translates to:
  /// **'عوارض گمرکی'**
  String get customs_duties;

  /// No description provided for @tax_settlement.
  ///
  /// In fa, this message translates to:
  /// **'تسویه مالیاتی'**
  String get tax_settlement;

  /// No description provided for @government_services.
  ///
  /// In fa, this message translates to:
  /// **'سایر خدمات دولتی'**
  String get government_services;

  /// No description provided for @facilities_and_commitments.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات و تعهدات'**
  String get facilities_and_commitments;

  /// No description provided for @depositing_collateral.
  ///
  /// In fa, this message translates to:
  /// **'تودیع وثیقه'**
  String get depositing_collateral;

  /// No description provided for @general_expenses.
  ///
  /// In fa, this message translates to:
  /// **'هزینه عمومی و امور روزمره'**
  String get general_expenses;

  /// No description provided for @charitable_donations.
  ///
  /// In fa, this message translates to:
  /// **'کمک‌های خیریه'**
  String get charitable_donations;

  /// No description provided for @goods_purchase.
  ///
  /// In fa, this message translates to:
  /// **'خرید کالا'**
  String get goods_purchase;

  /// No description provided for @services_purchase.
  ///
  /// In fa, this message translates to:
  /// **'خرید خدمات'**
  String get services_purchase;

  /// No description provided for @lost_card.
  ///
  /// In fa, this message translates to:
  /// **'مفقودی کارت'**
  String get lost_card;

  /// No description provided for @stolen_card.
  ///
  /// In fa, this message translates to:
  /// **'سرقت کارت'**
  String get stolen_card;

  /// No description provided for @owner.
  ///
  /// In fa, this message translates to:
  /// **'مالک'**
  String get owner;

  /// No description provided for @rental.
  ///
  /// In fa, this message translates to:
  /// **'استیجاری'**
  String get rental;

  /// No description provided for @others_.
  ///
  /// In fa, this message translates to:
  /// **'سایر'**
  String get others_;

  /// No description provided for @guarantor_cheque.
  ///
  /// In fa, this message translates to:
  /// **'چک ضامن'**
  String get guarantor_cheque;

  /// No description provided for @guarantor_salary_deduction.
  ///
  /// In fa, this message translates to:
  /// **'گواهی کسر از حقوق ضامن'**
  String get guarantor_salary_deduction;

  /// No description provided for @applicant_cheque.
  ///
  /// In fa, this message translates to:
  /// **'چک متقاضی'**
  String get applicant_cheque;

  /// No description provided for @applicant_promissory_note.
  ///
  /// In fa, this message translates to:
  /// **'سفته متقاضی'**
  String get applicant_promissory_note;

  /// No description provided for @applicant_salary_deduction.
  ///
  /// In fa, this message translates to:
  /// **'گواهی کسر از حقوق متقاضی'**
  String get applicant_salary_deduction;

  /// No description provided for @complete_closing.
  ///
  /// In fa, this message translates to:
  /// **'بستن کلی'**
  String get complete_closing;

  /// No description provided for @partial_closing.
  ///
  /// In fa, this message translates to:
  /// **'بستن قسمتی از سپرده'**
  String get partial_closing;

  /// No description provided for @short_term_saving_title.
  ///
  /// In fa, this message translates to:
  /// **'سپرده قرض‌الحسنه/جاری/کوتاه مدت'**
  String get short_term_saving_title;

  /// No description provided for @short_term_saving_description.
  ///
  /// In fa, this message translates to:
  /// **'در صورت انتخاب این نوع سپرده، معادل ۸۰ درصد مبلغ ضمانت‌نامه در سپرده شما مسدود می‌گردد'**
  String get short_term_saving_description;

  /// No description provided for @long_term_saving_title.
  ///
  /// In fa, this message translates to:
  /// **'سپرده کوتاه مدت ویژه/بلندمدت'**
  String get long_term_saving_title;

  /// No description provided for @long_term_saving_description.
  ///
  /// In fa, this message translates to:
  /// **'در صورت انتخاب این نوع سپرده، معادل ۸۸ درصد مبلغ ضمانت‌نامه در سپرده شما مسدود می‌گردد'**
  String get long_term_saving_description;

  /// No description provided for @full_settlement.
  ///
  /// In fa, this message translates to:
  /// **'تسویه کامل سفته'**
  String get full_settlement;

  /// No description provided for @gradual_settlement.
  ///
  /// In fa, this message translates to:
  /// **'تسویه تدریجی سفته'**
  String get gradual_settlement;

  /// No description provided for @image.
  ///
  /// In fa, this message translates to:
  /// **'تصویر'**
  String get image;

  /// No description provided for @text.
  ///
  /// In fa, this message translates to:
  /// **'متن'**
  String get text;

  /// No description provided for @endorsement.
  ///
  /// In fa, this message translates to:
  /// **'ظهرنویسی'**
  String get endorsement;

  /// No description provided for @bank_meli.
  ///
  /// In fa, this message translates to:
  /// **'بانک ملی ایران'**
  String get bank_meli;

  /// No description provided for @bank_sepah.
  ///
  /// In fa, this message translates to:
  /// **'بانک سپه'**
  String get bank_sepah;

  /// No description provided for @bank_tosee_saderat.
  ///
  /// In fa, this message translates to:
  /// **'بانک توسعه صادرات'**
  String get bank_tosee_saderat;

  /// No description provided for @bank_sanat_madan.
  ///
  /// In fa, this message translates to:
  /// **'بانک صنعت و معدن'**
  String get bank_sanat_madan;

  /// No description provided for @bank_keshavarzi.
  ///
  /// In fa, this message translates to:
  /// **'بانک کشاورزی'**
  String get bank_keshavarzi;

  /// No description provided for @bank_maskan.
  ///
  /// In fa, this message translates to:
  /// **'بانک مسکن'**
  String get bank_maskan;

  /// No description provided for @post_bank_iran.
  ///
  /// In fa, this message translates to:
  /// **'پست بانک ایران'**
  String get post_bank_iran;

  /// No description provided for @bank_tosee_taavon.
  ///
  /// In fa, this message translates to:
  /// **'بانک توسعه تعاون'**
  String get bank_tosee_taavon;

  /// No description provided for @bank_eqtesad_novin.
  ///
  /// In fa, this message translates to:
  /// **'بانک اقتصاد نوین'**
  String get bank_eqtesad_novin;

  /// No description provided for @bank_parsian.
  ///
  /// In fa, this message translates to:
  /// **'بانک پارسیان'**
  String get bank_parsian;

  /// No description provided for @bank_pasargad.
  ///
  /// In fa, this message translates to:
  /// **'بانک پاسارگاد'**
  String get bank_pasargad;

  /// No description provided for @bank_karafarin.
  ///
  /// In fa, this message translates to:
  /// **'بانک کار آفرین'**
  String get bank_karafarin;

  /// No description provided for @bank_saman.
  ///
  /// In fa, this message translates to:
  /// **'بانک سامان'**
  String get bank_saman;

  /// No description provided for @bank_sarmayeh.
  ///
  /// In fa, this message translates to:
  /// **'بانک سرمایه'**
  String get bank_sarmayeh;

  /// No description provided for @bank_tat.
  ///
  /// In fa, this message translates to:
  /// **'بانک تات'**
  String get bank_tat;

  /// No description provided for @bank_dey.
  ///
  /// In fa, this message translates to:
  /// **'بانک دی'**
  String get bank_dey;

  /// No description provided for @bank_saderat.
  ///
  /// In fa, this message translates to:
  /// **'بانک صادرات'**
  String get bank_saderat;

  /// No description provided for @bank_mellat.
  ///
  /// In fa, this message translates to:
  /// **'بانک ملت'**
  String get bank_mellat;

  /// No description provided for @bank_tejarat.
  ///
  /// In fa, this message translates to:
  /// **'بانک تجارت'**
  String get bank_tejarat;

  /// No description provided for @bank_refah.
  ///
  /// In fa, this message translates to:
  /// **'بانک رفاه'**
  String get bank_refah;

  /// No description provided for @bank_ansar.
  ///
  /// In fa, this message translates to:
  /// **'بانک انصار'**
  String get bank_ansar;

  /// No description provided for @bank_gardeshgari.
  ///
  /// In fa, this message translates to:
  /// **'بانک گردشگری'**
  String get bank_gardeshgari;

  /// No description provided for @bank_ghavamin.
  ///
  /// In fa, this message translates to:
  /// **'بانک قوامین'**
  String get bank_ghavamin;

  /// No description provided for @bank_sina.
  ///
  /// In fa, this message translates to:
  /// **'بانک سینا'**
  String get bank_sina;

  /// No description provided for @bank_shahr.
  ///
  /// In fa, this message translates to:
  /// **'بانک شهر'**
  String get bank_shahr;

  /// No description provided for @bank_mehr_eqtesad.
  ///
  /// In fa, this message translates to:
  /// **'بانک مهر اقتصاد'**
  String get bank_mehr_eqtesad;

  /// No description provided for @moasse_nour.
  ///
  /// In fa, this message translates to:
  /// **'موسسه اعتباری نور'**
  String get moasse_nour;

  /// No description provided for @moasse_tosee.
  ///
  /// In fa, this message translates to:
  /// **'موسسه اعتباری توسعه'**
  String get moasse_tosee;

  /// No description provided for @moasse_kowsar.
  ///
  /// In fa, this message translates to:
  /// **'موسسه اعتباری کوثر'**
  String get moasse_kowsar;

  /// No description provided for @moasse_melal.
  ///
  /// In fa, this message translates to:
  /// **'موسسه اعتباری ملل(عسکریه)'**
  String get moasse_melal;

  /// No description provided for @bank_gharzolhasane_mehr.
  ///
  /// In fa, this message translates to:
  /// **'بانک قرض الحسنه مهرایرانیان'**
  String get bank_gharzolhasane_mehr;

  /// No description provided for @monday.
  ///
  /// In fa, this message translates to:
  /// **'دوشنبه'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In fa, this message translates to:
  /// **'سه‌شنبه'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In fa, this message translates to:
  /// **'چهارشنبه'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In fa, this message translates to:
  /// **'پنج‌شنبه'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In fa, this message translates to:
  /// **'جمعه'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In fa, this message translates to:
  /// **'شنبه'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In fa, this message translates to:
  /// **'یک‌شنبه'**
  String get sunday;

  /// No description provided for @cheque_registration.
  ///
  /// In fa, this message translates to:
  /// **'ثبت چک در سامانه صیاد'**
  String get cheque_registration;

  /// No description provided for @cheque_receive.
  ///
  /// In fa, this message translates to:
  /// **'دریافت چک'**
  String get cheque_receive;

  /// No description provided for @confirm_or_reject_from_reciver.
  ///
  /// In fa, this message translates to:
  /// **'تایید یا رد چک توسط دریافت‌کننده'**
  String get confirm_or_reject_from_reciver;

  /// No description provided for @cheque_transfer_description.
  ///
  /// In fa, this message translates to:
  /// **'انتقال چک توسط دریافت‌کننده فعلی چک'**
  String get cheque_transfer_description;

  /// No description provided for @issued_cheques_inquiry_description.
  ///
  /// In fa, this message translates to:
  /// **'بررسی وضعیت چک توسط صادرکننده'**
  String get issued_cheques_inquiry_description;

  /// No description provided for @received_cheque_status_inquiry.
  ///
  /// In fa, this message translates to:
  /// **'استعلام وضعیت انتقال چک'**
  String get received_cheque_status_inquiry;

  /// No description provided for @received_cheque_status_inquiry_description.
  ///
  /// In fa, this message translates to:
  /// **'بررسی اطلاعات چک توسط دریافت‌کننده چک'**
  String get received_cheque_status_inquiry_description;

  /// No description provided for @all_bills.
  ///
  /// In fa, this message translates to:
  /// **'همه قبوض'**
  String get all_bills;

  /// No description provided for @telephone_bill.
  ///
  /// In fa, this message translates to:
  /// **'قبض تلفن'**
  String get telephone_bill;

  /// No description provided for @mobile_bill.
  ///
  /// In fa, this message translates to:
  /// **'قبض موبایل'**
  String get mobile_bill;

  /// No description provided for @water_bill.
  ///
  /// In fa, this message translates to:
  /// **'قبض آب'**
  String get water_bill;

  /// No description provided for @electricity_bill.
  ///
  /// In fa, this message translates to:
  /// **'قبض برق'**
  String get electricity_bill;

  /// No description provided for @gas_bill.
  ///
  /// In fa, this message translates to:
  /// **'قبض گاز'**
  String get gas_bill;

  /// No description provided for @telephone.
  ///
  /// In fa, this message translates to:
  /// **'تلفن'**
  String get telephone;

  /// No description provided for @mobile.
  ///
  /// In fa, this message translates to:
  /// **'موبایل'**
  String get mobile;

  /// No description provided for @water.
  ///
  /// In fa, this message translates to:
  /// **'آب'**
  String get water;

  /// No description provided for @electricity.
  ///
  /// In fa, this message translates to:
  /// **'برق'**
  String get electricity;

  /// No description provided for @gas.
  ///
  /// In fa, this message translates to:
  /// **'گاز'**
  String get gas;

  /// No description provided for @telephone_mobile.
  ///
  /// In fa, this message translates to:
  /// **'تلفن/موبایل'**
  String get telephone_mobile;

  /// No description provided for @pay_bills_.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت قبوض'**
  String get pay_bills_;

  /// No description provided for @group_bill_payment.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت گروهی قبوض'**
  String get group_bill_payment;

  /// No description provided for @buy_internet_package.
  ///
  /// In fa, this message translates to:
  /// **'خرید بسته اینترنتی'**
  String get buy_internet_package;

  /// No description provided for @buy_internet_package_.
  ///
  /// In fa, this message translates to:
  /// **'خرید بسته اینترنت'**
  String get buy_internet_package_;

  /// No description provided for @card_to_card_transfer.
  ///
  /// In fa, this message translates to:
  /// **'انتقال کارت به کارت'**
  String get card_to_card_transfer;

  /// No description provided for @wallet_transfer_money.
  ///
  /// In fa, this message translates to:
  /// **'انتقال کیف پول'**
  String get wallet_transfer_money;

  /// No description provided for @refund.
  ///
  /// In fa, this message translates to:
  /// **'استرداد وجه'**
  String get refund;

  /// No description provided for @buy_direct_charge.
  ///
  /// In fa, this message translates to:
  /// **'خرید شارژ مستقیم'**
  String get buy_direct_charge;

  /// No description provided for @travel_insurance.
  ///
  /// In fa, this message translates to:
  /// **'بیمه مسافرتی'**
  String get travel_insurance;

  /// No description provided for @unpaid.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت نشده'**
  String get unpaid;

  /// No description provided for @wait_for_bank_to_confirm.
  ///
  /// In fa, this message translates to:
  /// **'منتظر تایید بانک'**
  String get wait_for_bank_to_confirm;

  /// No description provided for @confirmed.
  ///
  /// In fa, this message translates to:
  /// **'تایید شده'**
  String get confirmed;

  /// No description provided for @sending.
  ///
  /// In fa, this message translates to:
  /// **'منتشر شده'**
  String get sending;

  /// No description provided for @posted.
  ///
  /// In fa, this message translates to:
  /// **'ارسال شده'**
  String get posted;

  /// No description provided for @normal.
  ///
  /// In fa, this message translates to:
  /// **'عادی'**
  String get normal;

  /// No description provided for @bank.
  ///
  /// In fa, this message translates to:
  /// **'بانکی'**
  String get bank;

  /// No description provided for @secured.
  ///
  /// In fa, this message translates to:
  /// **'رمزدار'**
  String get secured;

  /// No description provided for @digital_not_supported.
  ///
  /// In fa, this message translates to:
  /// **'دیجیتالی(فعلا پشتیبانی نمی‌شود)'**
  String get digital_not_supported;

  /// No description provided for @individual_domestic.
  ///
  /// In fa, this message translates to:
  /// **'حقیقی داخلی'**
  String get individual_domestic;

  /// No description provided for @corporate_domestic.
  ///
  /// In fa, this message translates to:
  /// **'حقوقی داخلی'**
  String get corporate_domestic;

  /// No description provided for @foreign_national.
  ///
  /// In fa, this message translates to:
  /// **'اتباع خارجی'**
  String get foreign_national;

  /// No description provided for @issued_and_approved.
  ///
  /// In fa, this message translates to:
  /// **'صادر و تایید شده است'**
  String get issued_and_approved;

  /// No description provided for @cashed.
  ///
  /// In fa, this message translates to:
  /// **'نقد شده است'**
  String get cashed;

  /// No description provided for @set_aside.
  ///
  /// In fa, this message translates to:
  /// **'کنار گذاشته شد'**
  String get set_aside;

  /// No description provided for @returned.
  ///
  /// In fa, this message translates to:
  /// **'برگشت خورده است'**
  String get returned;

  /// No description provided for @returning_in_progress.
  ///
  /// In fa, this message translates to:
  /// **'درحال برگشت خوردن است'**
  String get returning_in_progress;

  /// No description provided for @awaiting_guarantor_signature.
  ///
  /// In fa, this message translates to:
  /// **'در انتظار امضای ضامن'**
  String get awaiting_guarantor_signature;

  /// No description provided for @awaiting_recipient_approval_after_registration.
  ///
  /// In fa, this message translates to:
  /// **'در انتظار تایید گیرنده پس از ثبت'**
  String get awaiting_recipient_approval_after_registration;

  /// No description provided for @awaiting_recipient_approval_after_transfer.
  ///
  /// In fa, this message translates to:
  /// **'در انتظار تایید گیرنده پس از انتقال'**
  String get awaiting_recipient_approval_after_transfer;

  /// No description provided for @not_blocked.
  ///
  /// In fa, this message translates to:
  /// **'مسدود نشده'**
  String get not_blocked;

  /// No description provided for @temporarily_blocked.
  ///
  /// In fa, this message translates to:
  /// **'به طور موقف مسدود شده'**
  String get temporarily_blocked;

  /// No description provided for @permanently_blocked.
  ///
  /// In fa, this message translates to:
  /// **'به طور دائم مسدود شده'**
  String get permanently_blocked;

  /// No description provided for @unblocked.
  ///
  /// In fa, this message translates to:
  /// **'رفع مسدود شده'**
  String get unblocked;

  /// No description provided for @wrong_recipient_in_check_list.
  ///
  /// In fa, this message translates to:
  /// **'اشتباه در لیست دریافت‌کنندگان چک'**
  String get wrong_recipient_in_check_list;

  /// No description provided for @wrong_check_amount.
  ///
  /// In fa, this message translates to:
  /// **'اشتباه در مبلغ چک'**
  String get wrong_check_amount;

  /// No description provided for @wrong_check_date.
  ///
  /// In fa, this message translates to:
  /// **'اشتباه در تاریخ چک'**
  String get wrong_check_date;

  /// No description provided for @other_errors.
  ///
  /// In fa, this message translates to:
  /// **'اشتباه‌های دیگر'**
  String get other_errors;

  /// No description provided for @original_transaction_cancelled.
  ///
  /// In fa, this message translates to:
  /// **'معامله اصلی لغو شد'**
  String get original_transaction_cancelled;

  /// No description provided for @check_returned.
  ///
  /// In fa, this message translates to:
  /// **'چک برگشت خورده'**
  String get check_returned;

  /// No description provided for @check_info_corrupted.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات چک مخدوش است'**
  String get check_info_corrupted;

  /// No description provided for @markazi.
  ///
  /// In fa, this message translates to:
  /// **'بانک مرکزی'**
  String get markazi;

  /// No description provided for @sanat_madan.
  ///
  /// In fa, this message translates to:
  /// **'صنعت و معدن'**
  String get sanat_madan;

  /// No description provided for @melat.
  ///
  /// In fa, this message translates to:
  /// **'ملت'**
  String get melat;

  /// No description provided for @refah.
  ///
  /// In fa, this message translates to:
  /// **'رفاه'**
  String get refah;

  /// No description provided for @maskan.
  ///
  /// In fa, this message translates to:
  /// **'مسکن'**
  String get maskan;

  /// No description provided for @sepeh.
  ///
  /// In fa, this message translates to:
  /// **'سپه'**
  String get sepeh;

  /// No description provided for @keshavarzi.
  ///
  /// In fa, this message translates to:
  /// **'کشاورزی'**
  String get keshavarzi;

  /// No description provided for @melli.
  ///
  /// In fa, this message translates to:
  /// **'ملی'**
  String get melli;

  /// No description provided for @tejarat.
  ///
  /// In fa, this message translates to:
  /// **'تجارت'**
  String get tejarat;

  /// No description provided for @saderat.
  ///
  /// In fa, this message translates to:
  /// **'صادرات'**
  String get saderat;

  /// No description provided for @export_development.
  ///
  /// In fa, this message translates to:
  /// **'توسعه صادرات'**
  String get export_development;

  /// No description provided for @post_bank.
  ///
  /// In fa, this message translates to:
  /// **'پست بانک ایران'**
  String get post_bank;

  /// No description provided for @cooperation_development.
  ///
  /// In fa, this message translates to:
  /// **'توسعه تعاون'**
  String get cooperation_development;

  /// No description provided for @etebari_tosee.
  ///
  /// In fa, this message translates to:
  /// **'موسسه اعتباری توسعه'**
  String get etebari_tosee;

  /// No description provided for @karafarin.
  ///
  /// In fa, this message translates to:
  /// **'کارآفرین'**
  String get karafarin;

  /// No description provided for @parsian.
  ///
  /// In fa, this message translates to:
  /// **'پارسیان'**
  String get parsian;

  /// No description provided for @eghtesad_novin.
  ///
  /// In fa, this message translates to:
  /// **'اقتصاد نویین'**
  String get eghtesad_novin;

  /// No description provided for @saman.
  ///
  /// In fa, this message translates to:
  /// **'سامان'**
  String get saman;

  /// No description provided for @pasargad.
  ///
  /// In fa, this message translates to:
  /// **'پاسارگاد'**
  String get pasargad;

  /// No description provided for @sarmayeh.
  ///
  /// In fa, this message translates to:
  /// **'سرمایه'**
  String get sarmayeh;

  /// No description provided for @sina.
  ///
  /// In fa, this message translates to:
  /// **'سینا'**
  String get sina;

  /// No description provided for @mehr_qard_al_hassan.
  ///
  /// In fa, this message translates to:
  /// **'قرض الحسنه مهر'**
  String get mehr_qard_al_hassan;

  /// No description provided for @shahr.
  ///
  /// In fa, this message translates to:
  /// **'بانک شهر'**
  String get shahr;

  /// No description provided for @tat.
  ///
  /// In fa, this message translates to:
  /// **'تات'**
  String get tat;

  /// No description provided for @ansar.
  ///
  /// In fa, this message translates to:
  /// **'انصار'**
  String get ansar;

  /// No description provided for @tourism.
  ///
  /// In fa, this message translates to:
  /// **'گردشگری'**
  String get tourism;

  /// No description provided for @hikmat_iranian.
  ///
  /// In fa, this message translates to:
  /// **'حکمت ایرانیان'**
  String get hikmat_iranian;

  /// No description provided for @iran_zamin.
  ///
  /// In fa, this message translates to:
  /// **'ایران زمین'**
  String get iran_zamin;

  /// No description provided for @no_action.
  ///
  /// In fa, this message translates to:
  /// **'بدون اقدام'**
  String get no_action;

  /// No description provided for @rejected.
  ///
  /// In fa, this message translates to:
  /// **'رد شده'**
  String get rejected;

  /// No description provided for @approved.
  ///
  /// In fa, this message translates to:
  /// **'تایید شده'**
  String get approved;

  /// No description provided for @in_progress.
  ///
  /// In fa, this message translates to:
  /// **'درحال انجام'**
  String get in_progress;

  /// No description provided for @no_guarantee.
  ///
  /// In fa, this message translates to:
  /// **'بدون ضامن'**
  String get no_guarantee;

  /// No description provided for @under_review.
  ///
  /// In fa, this message translates to:
  /// **'درحال بررسی'**
  String get under_review;

  /// No description provided for @suspended_mode.
  ///
  /// In fa, this message translates to:
  /// **'در حالت تعلیق'**
  String get suspended_mode;

  /// No description provided for @guaranteed.
  ///
  /// In fa, this message translates to:
  /// **'ضمانت شده'**
  String get guaranteed;

  /// No description provided for @guarantee_rejected.
  ///
  /// In fa, this message translates to:
  /// **'عدم تایید ضامنین'**
  String get guarantee_rejected;

  /// No description provided for @daily.
  ///
  /// In fa, this message translates to:
  /// **'روزانه'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In fa, this message translates to:
  /// **'هفتگی'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In fa, this message translates to:
  /// **'ماهانه'**
  String get monthly;

  /// No description provided for @three_months.
  ///
  /// In fa, this message translates to:
  /// **'سه ماهه'**
  String get three_months;

  /// No description provided for @six_months.
  ///
  /// In fa, this message translates to:
  /// **'شش ماهه'**
  String get six_months;

  /// No description provided for @one_year.
  ///
  /// In fa, this message translates to:
  /// **'یک ساله'**
  String get one_year;

  /// No description provided for @employee.
  ///
  /// In fa, this message translates to:
  /// **'کارمند'**
  String get employee;

  /// No description provided for @retired.
  ///
  /// In fa, this message translates to:
  /// **'بازنشسته'**
  String get retired;

  /// No description provided for @self_employed.
  ///
  /// In fa, this message translates to:
  /// **'آزاد'**
  String get self_employed;

  /// No description provided for @iran_cell.
  ///
  /// In fa, this message translates to:
  /// **'ایرانسل'**
  String get iran_cell;

  /// No description provided for @mci_fa.
  ///
  /// In fa, this message translates to:
  /// **'همراه اول'**
  String get mci_fa;

  /// No description provided for @rightel_fa.
  ///
  /// In fa, this message translates to:
  /// **'رایتل'**
  String get rightel_fa;

  /// No description provided for @shatel_fa.
  ///
  /// In fa, this message translates to:
  /// **'شاتل'**
  String get shatel_fa;

  /// No description provided for @mobile_bank_services_password.
  ///
  /// In fa, this message translates to:
  /// **'فعال‌سازی خدمات و صدور رمز'**
  String get mobile_bank_services_password;

  /// No description provided for @complete_initial_application_documents.
  ///
  /// In fa, this message translates to:
  /// **'تکمیل مدارک درخواست اولیه'**
  String get complete_initial_application_documents;

  /// No description provided for @internet_banking_account_password.
  ///
  /// In fa, this message translates to:
  /// **'فعال‌سازی خدمات و صدور رمز'**
  String get internet_banking_account_password;

  /// No description provided for @safe_box_title_rent.
  ///
  /// In fa, this message translates to:
  /// **'اجاره صندوق، رزرو زمان بازدید'**
  String get safe_box_title_rent;

  /// No description provided for @military_lg_submit.
  ///
  /// In fa, this message translates to:
  /// **'ثبت ضمانت‌نامه'**
  String get military_lg_submit;

  /// No description provided for @credit_check_yourself_others.
  ///
  /// In fa, this message translates to:
  /// **'اعتبارسنجی خود و سایرین'**
  String get credit_check_yourself_others;

  /// No description provided for @issuance_services.
  ///
  /// In fa, this message translates to:
  /// **'صدور و خدمات'**
  String get issuance_services;

  /// No description provided for @azki_signature.
  ///
  /// In fa, this message translates to:
  /// **'امضای قرارداد ازکی'**
  String get azki_signature;

  /// No description provided for @no_pay_for_guarantor.
  ///
  /// In fa, this message translates to:
  /// **'بدون پرداخت وجه برای ضمانت‌کننده'**
  String get no_pay_for_guarantor;

  /// No description provided for @view_promissory_details.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده جزئیات سفته'**
  String get view_promissory_details;

  /// No description provided for @view_details.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده جزئیات'**
  String get view_details;

  /// No description provided for @included_myself.
  ///
  /// In fa, this message translates to:
  /// **'خودم مشمول هستم'**
  String get included_myself;

  /// No description provided for @included_others.
  ///
  /// In fa, this message translates to:
  /// **'فرد دیگری مشمول است'**
  String get included_others;

  /// No description provided for @white_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت سفید'**
  String get white_status;

  /// No description provided for @white_status_description.
  ///
  /// In fa, this message translates to:
  /// **'صادرکننده چک فاقد هرگونه سابقه چک برگشتی بوده یا در صورت وجود سابقه، تمامی موارد رفع سو اثر شده است'**
  String get white_status_description;

  /// No description provided for @yellow_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت زرد'**
  String get yellow_status;

  /// No description provided for @yellow_status_description.
  ///
  /// In fa, this message translates to:
  /// **'صادرکننده چک دارای یک فقره چک برگشتی یا حداکثر مبلغ ۵۰ میلیون ریال تعهد برگشتی است'**
  String get yellow_status_description;

  /// No description provided for @orange_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت نارنجی'**
  String get orange_status;

  /// No description provided for @orange_status_description.
  ///
  /// In fa, this message translates to:
  /// **'صادرکننده چک دارای دو الی چهار فقره چک برگشتی یا حداکثر مبلغ ۲۰۰ میلیون ریال تعهد برگشتی است'**
  String get orange_status_description;

  /// No description provided for @brown_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت قهوه‌ای'**
  String get brown_status;

  /// No description provided for @brown_status_description.
  ///
  /// In fa, this message translates to:
  /// **'صادرکننده چک دارای پنج تا ده فقره چک برگشتی یا حداکثر مبلغ ۵۰۰ میلیون ریال تعهد برگشتی است'**
  String get brown_status_description;

  /// No description provided for @red_status.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت قرمز'**
  String get red_status;

  /// No description provided for @red_status_description.
  ///
  /// In fa, this message translates to:
  /// **'صادرکننده چک دارای بیش از ده فقره چک برگشتی یا بیش از مبلغ ۵۰۰ میلیون ریال تعهد برگشتی است'**
  String get red_status_description;

  /// No description provided for @ten.
  ///
  /// In fa, this message translates to:
  /// **'ده'**
  String get ten;

  /// No description provided for @twenty.
  ///
  /// In fa, this message translates to:
  /// **'بیست'**
  String get twenty;

  /// No description provided for @thirty.
  ///
  /// In fa, this message translates to:
  /// **'سی'**
  String get thirty;

  /// No description provided for @forty.
  ///
  /// In fa, this message translates to:
  /// **'چهل'**
  String get forty;

  /// No description provided for @fifty.
  ///
  /// In fa, this message translates to:
  /// **'پنجاه'**
  String get fifty;

  /// No description provided for @sixty.
  ///
  /// In fa, this message translates to:
  /// **'شصت'**
  String get sixty;

  /// No description provided for @seventy.
  ///
  /// In fa, this message translates to:
  /// **'هفتاد'**
  String get seventy;

  /// No description provided for @eighty.
  ///
  /// In fa, this message translates to:
  /// **'هشتاد'**
  String get eighty;

  /// No description provided for @ninety.
  ///
  /// In fa, this message translates to:
  /// **'نود'**
  String get ninety;

  /// No description provided for @one.
  ///
  /// In fa, this message translates to:
  /// **'یک'**
  String get one;

  /// No description provided for @two.
  ///
  /// In fa, this message translates to:
  /// **'دو'**
  String get two;

  /// No description provided for @three.
  ///
  /// In fa, this message translates to:
  /// **'سه'**
  String get three;

  /// No description provided for @four.
  ///
  /// In fa, this message translates to:
  /// **'چهار'**
  String get four;

  /// No description provided for @five.
  ///
  /// In fa, this message translates to:
  /// **'پنج'**
  String get five;

  /// No description provided for @six.
  ///
  /// In fa, this message translates to:
  /// **'شش'**
  String get six;

  /// No description provided for @seven.
  ///
  /// In fa, this message translates to:
  /// **'هفت'**
  String get seven;

  /// No description provided for @eight.
  ///
  /// In fa, this message translates to:
  /// **'هشت'**
  String get eight;

  /// No description provided for @nine.
  ///
  /// In fa, this message translates to:
  /// **'نه'**
  String get nine;

  /// No description provided for @eleven.
  ///
  /// In fa, this message translates to:
  /// **'یازده'**
  String get eleven;

  /// No description provided for @twelve.
  ///
  /// In fa, this message translates to:
  /// **'دوازده'**
  String get twelve;

  /// No description provided for @thirteen.
  ///
  /// In fa, this message translates to:
  /// **'سیزده'**
  String get thirteen;

  /// No description provided for @fourteen.
  ///
  /// In fa, this message translates to:
  /// **'چهارده'**
  String get fourteen;

  /// No description provided for @fifteen.
  ///
  /// In fa, this message translates to:
  /// **'پانزده'**
  String get fifteen;

  /// No description provided for @sixteen.
  ///
  /// In fa, this message translates to:
  /// **'شانزده'**
  String get sixteen;

  /// No description provided for @seventeen.
  ///
  /// In fa, this message translates to:
  /// **'هفده'**
  String get seventeen;

  /// No description provided for @eighteen.
  ///
  /// In fa, this message translates to:
  /// **'هجده'**
  String get eighteen;

  /// No description provided for @nineteen.
  ///
  /// In fa, this message translates to:
  /// **'نوزده'**
  String get nineteen;

  /// No description provided for @hundred.
  ///
  /// In fa, this message translates to:
  /// **'صد'**
  String get hundred;

  /// No description provided for @two_hundred.
  ///
  /// In fa, this message translates to:
  /// **'دویست'**
  String get two_hundred;

  /// No description provided for @three_hundred.
  ///
  /// In fa, this message translates to:
  /// **'سیصد'**
  String get three_hundred;

  /// No description provided for @four_hundred.
  ///
  /// In fa, this message translates to:
  /// **'چهارصد'**
  String get four_hundred;

  /// No description provided for @five_hundred.
  ///
  /// In fa, this message translates to:
  /// **'پانصد'**
  String get five_hundred;

  /// No description provided for @six_hundred.
  ///
  /// In fa, this message translates to:
  /// **'ششصد'**
  String get six_hundred;

  /// No description provided for @seven_hundred.
  ///
  /// In fa, this message translates to:
  /// **'هفتصد'**
  String get seven_hundred;

  /// No description provided for @eight_hundred.
  ///
  /// In fa, this message translates to:
  /// **'هشتصد'**
  String get eight_hundred;

  /// No description provided for @nine_hundred.
  ///
  /// In fa, this message translates to:
  /// **'نهصد'**
  String get nine_hundred;

  /// No description provided for @front_national_card_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنمای بارگذاری تصویر روی کارت ملی هوشمند'**
  String get front_national_card_guide;

  /// No description provided for @back_national_card_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنمای بارگذاری تصویر پشت کارت ملی هوشمند'**
  String get back_national_card_guide;

  /// No description provided for @birth_certificate_main_pages_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنمای بارگذاری صفحه اول و دوم شناسنامه'**
  String get birth_certificate_main_pages_guide;

  /// No description provided for @birth_certificate_comments_pages_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنمای بارگذاری صفحه سوم و چهارم شناسنامه'**
  String get birth_certificate_comments_pages_guide;

  /// No description provided for @signature_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنمای بارگذاری ثبت صحیح امضا'**
  String get signature_guide;

  /// No description provided for @personal_image_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنمای بارگذاری ثبت تصویر شخص'**
  String get personal_image_guide;

  /// No description provided for @personal_video_guide.
  ///
  /// In fa, this message translates to:
  /// **'راهنمای بارگذاری ثبت ویدیو شخص'**
  String get personal_video_guide;

  /// No description provided for @check_your_internet_connection.
  ///
  /// In fa, this message translates to:
  /// **'اتصال اینترنت خود را بررسی نمایید'**
  String get check_your_internet_connection;

  /// No description provided for @timeout_message.
  ///
  /// In fa, this message translates to:
  /// **'مهلت درخواست به پایان رسیده دوباره تلاش کنید'**
  String get timeout_message;

  /// No description provided for @server_exception_message.
  ///
  /// In fa, this message translates to:
  /// **'در سرور مشکلی رخ داده دوباره تلاش کنید'**
  String get server_exception_message;

  /// No description provided for @insufficient_wallet_balance.
  ///
  /// In fa, this message translates to:
  /// **'موجودی کیف پول کافی نیست'**
  String get insufficient_wallet_balance;

  /// No description provided for @vpn_forbidden_message.
  ///
  /// In fa, this message translates to:
  /// **'جهت استفاده از امکانات برنامه VPN خود را خاموش کنید'**
  String get vpn_forbidden_message;

  /// No description provided for @null_error_message.
  ///
  /// In fa, this message translates to:
  /// **'خطا در درخواست شما. دقایقی دیگر تلاش کنید'**
  String get null_error_message;

  /// No description provided for @device_not_secured.
  ///
  /// In fa, this message translates to:
  /// **'بر روی دستگاه شما رمز، پین یا اثر انگشت وجود ندارد'**
  String get device_not_secured;

  /// No description provided for @digital_signature_invalid.
  ///
  /// In fa, this message translates to:
  /// **'امضای دیجیتال را تایید نکردید'**
  String get digital_signature_invalid;

  /// No description provided for @enter_credit_sim_card_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره سیم کارت اعتباری را وارد کنید'**
  String get enter_credit_sim_card_number;

  /// No description provided for @enter_sim_card_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره سیم کارت را وارد کنید'**
  String get enter_sim_card_number;

  /// No description provided for @like_09125848484.
  ///
  /// In fa, this message translates to:
  /// **'مانند: 09000000000'**
  String get like_09125848484;

  /// No description provided for @mobile_number_is_invalid.
  ///
  /// In fa, this message translates to:
  /// **'شماره همراه نامعتبر است'**
  String get mobile_number_is_invalid;

  /// No description provided for @internet.
  ///
  /// In fa, this message translates to:
  /// **'اینترنت'**
  String get internet;

  /// No description provided for @no_package_found.
  ///
  /// In fa, this message translates to:
  /// **'بسته‌ ای یافت نشد'**
  String get no_package_found;

  /// No description provided for @daily_eng.
  ///
  /// In fa, this message translates to:
  /// **'DAILY'**
  String get daily_eng;

  /// No description provided for @monthly_eng.
  ///
  /// In fa, this message translates to:
  /// **'WEEKLY'**
  String get monthly_eng;

  /// No description provided for @weekly_eng.
  ///
  /// In fa, this message translates to:
  /// **'MONTHLY'**
  String get weekly_eng;

  /// No description provided for @other_eng.
  ///
  /// In fa, this message translates to:
  /// **'OTHER'**
  String get other_eng;

  /// No description provided for @sim_cards.
  ///
  /// In fa, this message translates to:
  /// **'سیم‌کارت‌ها'**
  String get sim_cards;

  /// No description provided for @problem_in_server.
  ///
  /// In fa, this message translates to:
  /// **'در سرور مشکلی رخ داده است'**
  String get problem_in_server;

  /// No description provided for @error_in_server.
  ///
  /// In fa, this message translates to:
  /// **'در سرور خطایی رخ داده است'**
  String get error_in_server;

  /// No description provided for @new_package.
  ///
  /// In fa, this message translates to:
  /// **'بسته جدید'**
  String get new_package;

  /// No description provided for @new_charge.
  ///
  /// In fa, this message translates to:
  /// **'شارژ جدید'**
  String get new_charge;

  /// No description provided for @you_havent_purchased_charge.
  ///
  /// In fa, this message translates to:
  /// **'شارژی نخریده‌اید'**
  String get you_havent_purchased_charge;

  /// No description provided for @you_havent_purchased_internet_package.
  ///
  /// In fa, this message translates to:
  /// **'بسته‌ی اینترنتی نخریده‌اید'**
  String get you_havent_purchased_internet_package;

  /// No description provided for @buy_first_charge.
  ///
  /// In fa, this message translates to:
  /// **'اولین شارژ خود را بخرید'**
  String get buy_first_charge;

  /// No description provided for @buy_first_internet_pack.
  ///
  /// In fa, this message translates to:
  /// **'اولین بسته اینترنت خود را بخرید'**
  String get buy_first_internet_pack;

  /// No description provided for @error_occurred.
  ///
  /// In fa, this message translates to:
  /// **'خطا'**
  String get error_occurred;

  /// No description provided for @cant_buy_charge_with_this_number.
  ///
  /// In fa, this message translates to:
  /// **'با این شماره امکان خرید شارژ وجود ندارد'**
  String get cant_buy_charge_with_this_number;

  /// No description provided for @desired_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ دلخواه'**
  String get desired_amount;

  /// No description provided for @desired_value.
  ///
  /// In fa, this message translates to:
  /// **'مقدار دلخواه'**
  String get desired_value;

  /// No description provided for @charge_amount_hint.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ نمیتواند کمتر از {minimumAmount} ریال یا بیشتر از {maximumAmount} ریال باشد.'**
  String charge_amount_hint(String minimumAmount, String maximumAmount);

  /// No description provided for @amazing_charge.
  ///
  /// In fa, this message translates to:
  /// **'شارژ شگفت انگیز'**
  String get amazing_charge;

  /// No description provided for @operator.
  ///
  /// In fa, this message translates to:
  /// **'اپراتور'**
  String get operator;

  /// No description provided for @permanent.
  ///
  /// In fa, this message translates to:
  /// **'دائمی'**
  String get permanent;

  /// No description provided for @credit.
  ///
  /// In fa, this message translates to:
  /// **'اعتباری'**
  String get credit;

  /// No description provided for @after_confirm_sim_card_will_delete.
  ///
  /// In fa, this message translates to:
  /// **'پس از تائید، سیم‌کارت از لیست حذف خواهد شد.'**
  String get after_confirm_sim_card_will_delete;

  /// No description provided for @deleting.
  ///
  /// In fa, this message translates to:
  /// **'حذف کردن'**
  String get deleting;

  /// No description provided for @loan_format.
  ///
  /// In fa, this message translates to:
  /// **'وام {loanName}'**
  String loan_format(String loanName);

  /// No description provided for @buy_charge.
  ///
  /// In fa, this message translates to:
  /// **'خرید شارژ'**
  String get buy_charge;

  /// No description provided for @access_to_contact_dialog_message.
  ///
  /// In fa, this message translates to:
  /// **'برای انتخاب سریع شماره به دسترسی مخاطبین نیاز داریم، آیا اجازه می‌دهید؟'**
  String get access_to_contact_dialog_message;

  /// No description provided for @pay_your_own_loan.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت اقساط خود'**
  String get pay_your_own_loan;

  /// No description provided for @pay_others_loan.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت اقساط دیگران'**
  String get pay_others_loan;

  /// No description provided for @pay_loans.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت اقساط'**
  String get pay_loans;

  /// No description provided for @marriage_loan_not_available.
  ///
  /// In fa, this message translates to:
  /// **'سرویس تسهیلات ازدواج در حال حاضر در دسترس نیست'**
  String get marriage_loan_not_available;

  /// No description provided for @see_loans_and_pay.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده تسهیلات و پرداخت'**
  String get see_loans_and_pay;

  /// No description provided for @pay_loan.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت قسط'**
  String get pay_loan;

  /// No description provided for @code.
  ///
  /// In fa, this message translates to:
  /// **'کد'**
  String get code;

  /// No description provided for @bank_.
  ///
  /// In fa, this message translates to:
  /// **'بانک'**
  String get bank_;

  /// No description provided for @more_options.
  ///
  /// In fa, this message translates to:
  /// **'گزینه‌های بیشتر'**
  String get more_options;

  /// No description provided for @soon.
  ///
  /// In fa, this message translates to:
  /// **'به زودی'**
  String get soon;

  /// No description provided for @send_direct_link_pay_to_others.
  ///
  /// In fa, this message translates to:
  /// **'ارسال لینک مستقیم پرداخت به دیگران'**
  String get send_direct_link_pay_to_others;

  /// No description provided for @loan_details_.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات وام'**
  String get loan_details_;

  /// No description provided for @loan_auto_payment.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت خودکار اقساط'**
  String get loan_auto_payment;

  /// No description provided for @loan_amount_.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ وام'**
  String get loan_amount_;

  /// No description provided for @total_loan_remain.
  ///
  /// In fa, this message translates to:
  /// **'مانده کل وام'**
  String get total_loan_remain;

  /// No description provided for @loan_granting_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ اعطای وام'**
  String get loan_granting_date;

  /// No description provided for @last_repayment_date.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ اخرین بازپرداخت'**
  String get last_repayment_date;

  /// No description provided for @facility_file_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره پرونده تسهیلات'**
  String get facility_file_number;

  /// No description provided for @paid.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت شده'**
  String get paid;

  /// No description provided for @installment_.
  ///
  /// In fa, this message translates to:
  /// **'قسط'**
  String get installment_;

  /// No description provided for @postponed.
  ///
  /// In fa, this message translates to:
  /// **'معوق'**
  String get postponed;

  /// No description provided for @suspicious_arrival.
  ///
  /// In fa, this message translates to:
  /// **'مشکوک الوصول'**
  String get suspicious_arrival;

  /// No description provided for @after_maturity.
  ///
  /// In fa, this message translates to:
  /// **'بعد از سررسید'**
  String get after_maturity;

  /// No description provided for @installments_pay_date_range.
  ///
  /// In fa, this message translates to:
  /// **'{installmentsPaidNumber} از {installmentsNumber} قسط پرداخت شده'**
  String installments_pay_date_range(
      int installmentsPaidNumber, String installmentsNumber);

  /// No description provided for @outstanding_debt.
  ///
  /// In fa, this message translates to:
  /// **'بدهی مانده'**
  String get outstanding_debt;

  /// No description provided for @payment_type.
  ///
  /// In fa, this message translates to:
  /// **'نوع پرداخت'**
  String get payment_type;

  /// No description provided for @loan_settlement.
  ///
  /// In fa, this message translates to:
  /// **'تسویه وام'**
  String get loan_settlement;

  /// No description provided for @the_number_installments_requested_exceeds_allowed_limit.
  ///
  /// In fa, this message translates to:
  /// **'تعداد اقساط مورد نظر بیش از حد مجاز است'**
  String get the_number_installments_requested_exceeds_allowed_limit;

  /// No description provided for @requested_amount_exceeds_allowed_limit.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ مورد نظر بیش از حد مجاز است'**
  String get requested_amount_exceeds_allowed_limit;

  /// No description provided for @installments_number.
  ///
  /// In fa, this message translates to:
  /// **'تعداد اقساط'**
  String get installments_number;

  /// No description provided for @installment_number.
  ///
  /// In fa, this message translates to:
  /// **'تعداد قسط'**
  String get installment_number;

  /// No description provided for @change_to_number_installments.
  ///
  /// In fa, this message translates to:
  /// **'تغییر به تعداد قسط'**
  String get change_to_number_installments;

  /// No description provided for @change_to_number_desired_amount.
  ///
  /// In fa, this message translates to:
  /// **'تغییر به مبلغ دلخواه'**
  String get change_to_number_desired_amount;

  /// No description provided for @access_permission.
  ///
  /// In fa, this message translates to:
  /// **'مجوز دسترسی'**
  String get access_permission;

  /// No description provided for @access_permission_erorr.
  ///
  /// In fa, this message translates to:
  /// **'لطفا ابتدا اجازه دسترسی مخاطبین را به توبانک بدهید'**
  String get access_permission_erorr;

  /// No description provided for @next_pay_date.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت بعدی: {nextPayDate} روز بعد'**
  String next_pay_date(int nextPayDate);

  /// No description provided for @unpayed_loans_number.
  ///
  /// In fa, this message translates to:
  /// **'شما {delayedInstallmentNumber} قسط پرداخت نشده دارید'**
  String unpayed_loans_number(int delayedInstallmentNumber);

  /// No description provided for @payment_deadline_without_penalty_installments.
  ///
  /// In fa, this message translates to:
  /// **'مهلت پرداخت بدون جریمه دیرکرد برای قسط'**
  String get payment_deadline_without_penalty_installments;

  /// No description provided for @until_end_of_the_day.
  ///
  /// In fa, this message translates to:
  /// **'تا پایان روز'**
  String get until_end_of_the_day;

  /// No description provided for @is_.
  ///
  /// In fa, this message translates to:
  /// **'می‌باشد'**
  String get is_;

  /// No description provided for @you_have_no_active_loan.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی تسهیلات فعالی ندارید'**
  String get you_have_no_active_loan;

  /// No description provided for @facility_number.
  ///
  /// In fa, this message translates to:
  /// **'شماره تسهیلات'**
  String get facility_number;

  /// No description provided for @receiver.
  ///
  /// In fa, this message translates to:
  /// **'دریافت کننده'**
  String get receiver;

  /// No description provided for @enter_desired_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ مورد نظر را وارد نمایید'**
  String get enter_desired_amount;

  /// No description provided for @amount_entered_exceeds_facility_limit.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ وارد شده بیش از سقف تسهیلات می‌باشد'**
  String get amount_entered_exceeds_facility_limit;

  /// No description provided for @facility_owner_national_code.
  ///
  /// In fa, this message translates to:
  /// **'کدملی دارنده تسهیلات'**
  String get facility_owner_national_code;

  /// No description provided for @requested_information_not_found.
  ///
  /// In fa, this message translates to:
  /// **'اطلاعات مورد نظر یافت نشد'**
  String get requested_information_not_found;

  /// No description provided for @account.
  ///
  /// In fa, this message translates to:
  /// **'حساب'**
  String get account;

  /// No description provided for @installment_paid_successfully.
  ///
  /// In fa, this message translates to:
  /// **'قسط با موفقیت پرداخت گردید'**
  String get installment_paid_successfully;

  /// No description provided for @installment_settlement_successfully.
  ///
  /// In fa, this message translates to:
  /// **'تسویه تسهیلات با موفقیت انجام شد'**
  String get installment_settlement_successfully;

  /// No description provided for @installment_paid_unsuccessfully.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت قسط با شکست مواجه شد'**
  String get installment_paid_unsuccessfully;

  /// No description provided for @installment_settlement_unsuccessfully.
  ///
  /// In fa, this message translates to:
  /// **'تسویه تسهیلات با شکست مواجه شد'**
  String get installment_settlement_unsuccessfully;

  /// No description provided for @uncertain_loan_payment_status_message.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت پرداخت قسط نامشخص است \nلطفا لحظاتی بعد لیست اقساط خود را مجددا چک نمایید، در صورت ناموفق بودن پرداخت و کسر وجه از حساب شما طی 24 ساعت آینده عودت داده خواهد شد'**
  String get uncertain_loan_payment_status_message;

  /// No description provided for @uncertain_charge_payment_status_message.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت پرداخت شارژ نامشخص است  در صورت ناموفق بودن پرداخت و کسر وجه از حساب شما طی 24 ساعت آینده عودت داده خواهد شد'**
  String get uncertain_charge_payment_status_message;

  /// No description provided for @uncertain_package_payment_status_message.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت پرداخت بسته نامشخص است  در صورت ناموفق بودن پرداخت و کسر وجه از حساب شما طی 24 ساعت آینده عودت داده خواهد شد'**
  String get uncertain_package_payment_status_message;

  /// No description provided for @error_has_occurred.
  ///
  /// In fa, this message translates to:
  /// **'خطایی رخ داده است'**
  String get error_has_occurred;

  /// No description provided for @charge_account.
  ///
  /// In fa, this message translates to:
  /// **'شارژ حساب'**
  String get charge_account;

  /// No description provided for @withdrawable_amount.
  ///
  /// In fa, this message translates to:
  /// **'قابل برداشت'**
  String get withdrawable_amount;

  /// No description provided for @insufficient_inventory.
  ///
  /// In fa, this message translates to:
  /// **'موجودی ناکافی'**
  String get insufficient_inventory;

  /// No description provided for @charge_amount_plus_tax.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ شارژ + مالیات'**
  String get charge_amount_plus_tax;

  /// No description provided for @package_amount_plus_tax.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ بسته + مالیات'**
  String get package_amount_plus_tax;

  /// No description provided for @tax.
  ///
  /// In fa, this message translates to:
  /// **'مالیات'**
  String get tax;

  /// No description provided for @accounts.
  ///
  /// In fa, this message translates to:
  /// **'حساب‌ها'**
  String get accounts;

  /// No description provided for @top_up_balance_message.
  ///
  /// In fa, this message translates to:
  /// **'برای تکمیل موجودی حساب، مبلغ {getMainAmount} ریال مورد نیاز است، آیا اطمینان دارید؟'**
  String top_up_balance_message(String getMainAmount);

  /// No description provided for @confirm_and_pay.
  ///
  /// In fa, this message translates to:
  /// **'تائید و پرداخت'**
  String get confirm_and_pay;

  /// No description provided for @you_dont_have_active_account.
  ///
  /// In fa, this message translates to:
  /// **'کاربر گرامی حساب فعالی ندارید'**
  String get you_dont_have_active_account;

  /// No description provided for @amazing.
  ///
  /// In fa, this message translates to:
  /// **'AMAZING'**
  String get amazing;

  /// No description provided for @wow.
  ///
  /// In fa, this message translates to:
  /// **'WOW'**
  String get wow;

  /// No description provided for @msn.
  ///
  /// In fa, this message translates to:
  /// **'MSN'**
  String get msn;

  /// No description provided for @loan_setteled_message.
  ///
  /// In fa, this message translates to:
  /// **'تسهیلات مورد نظر تسویه گردیده است'**
  String get loan_setteled_message;

  /// No description provided for @not_yet.
  ///
  /// In fa, this message translates to:
  /// **'فعلا نه'**
  String get not_yet;

  /// No description provided for @transfer_reversal_hint.
  ///
  /// In fa, this message translates to:
  /// **'با تایید و عودت چک به نفر قبلی پس داده میشود.'**
  String get transfer_reversal_hint;

  /// No description provided for @i_allow.
  ///
  /// In fa, this message translates to:
  /// **'اجازه میدهم'**
  String get i_allow;

  /// No description provided for @min_max_desired_amount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ دلخواه حداقل {minPayableAmount} و حداکثر {maxPayableAmount} ریال می‌باشد'**
  String min_max_desired_amount(
      String maxPayableAmount, String minPayableAmount);

  /// No description provided for @selected_text_and_design.
  ///
  /// In fa, this message translates to:
  /// **'طرح و متن انتخاب شده'**
  String get selected_text_and_design;

  /// No description provided for @your_desire_design.
  ///
  /// In fa, this message translates to:
  /// **'طرح دلخواه شما'**
  String get your_desire_design;

  /// No description provided for @has_letter_condition.
  ///
  /// In fa, this message translates to:
  /// **'شامل حروف کوچیک و بزرگ انگلیسی'**
  String get has_letter_condition;

  /// No description provided for @has_Length_condition.
  ///
  /// In fa, this message translates to:
  /// **'شامل حداقل 8 کارکتر'**
  String get has_Length_condition;

  /// No description provided for @has_digit_condition.
  ///
  /// In fa, this message translates to:
  /// **'شامل عدد'**
  String get has_digit_condition;

  /// No description provided for @password_condition_error.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور شما باید حاوی حروف انگلیسی کوچک و بزرگ، حداقل یک عدد و ۸ کاراکتر باشد'**
  String get password_condition_error;

  /// No description provided for @user.
  ///
  /// In fa, this message translates to:
  /// **'کاربر'**
  String get user;

  /// No description provided for @sure_to_exit_auth.
  ///
  /// In fa, this message translates to:
  /// **'مطمئن به خروج از احراز‌هویت هستید؟'**
  String get sure_to_exit_auth;

  /// No description provided for @selected_file_not_valid.
  ///
  /// In fa, this message translates to:
  /// **'فایل‌های انتخابی معتبر نیستند'**
  String get selected_file_not_valid;

  /// No description provided for @file_data_not_valid.
  ///
  /// In fa, this message translates to:
  /// **'داده‌های فایل نامعتبر هستند'**
  String get file_data_not_valid;

  /// No description provided for @file_process_time_end.
  ///
  /// In fa, this message translates to:
  /// **'زمان پردازش فایل‌ها به پایان رسید'**
  String get file_process_time_end;

  /// No description provided for @error_in_file_process.
  ///
  /// In fa, this message translates to:
  /// **'خطا در پردازش فایل‌ها: {error}'**
  String error_in_file_process(String error);

  /// No description provided for @error_in_reading_files.
  ///
  /// In fa, this message translates to:
  /// **'خطا در خواندن فایل‌ها'**
  String get error_in_reading_files;

  /// No description provided for @error_in_operation.
  ///
  /// In fa, this message translates to:
  /// **'خطا در عملیات:'**
  String get error_in_operation;

  /// No description provided for @error_signature_process.
  ///
  /// In fa, this message translates to:
  /// **'خطا در پردازش امضا'**
  String get error_signature_process;

  /// No description provided for @to_share_file_download_and_share.
  ///
  /// In fa, this message translates to:
  /// **'برای اشتراک‌گذاری فایل، می‌توانید آن را دانلود کرده و با دیگران به اشتراک بگذارید.'**
  String get to_share_file_download_and_share;

  /// No description provided for @to_share_file_download_and_share_link.
  ///
  /// In fa, this message translates to:
  /// **'برای اشتراک‌گذاری فایل، می‌توانید آن را دانلود کرده یا لینک را کپی کنید.'**
  String get to_share_file_download_and_share_link;

  /// No description provided for @download_file.
  ///
  /// In fa, this message translates to:
  /// **'دانلود فایل'**
  String get download_file;

  /// No description provided for @web_not_support_contact_call_selection.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب تماس در وب پشتیبانی نمی‌شود'**
  String get web_not_support_contact_call_selection;

  /// No description provided for @pay_url_not_recieve.
  ///
  /// In fa, this message translates to:
  /// **'URL پرداخت دریافت نشد'**
  String get pay_url_not_recieve;

  /// No description provided for @error_in_pay_request.
  ///
  /// In fa, this message translates to:
  /// **'مشکلی در درخواست پرداخت پیش آمد'**
  String get error_in_pay_request;

  /// No description provided for @problem_in_generating_token.
  ///
  /// In fa, this message translates to:
  /// **'مشکلی در تولید توکن پیش آمد'**
  String get problem_in_generating_token;

  /// No description provided for @problem_in_register.
  ///
  /// In fa, this message translates to:
  /// **'مشکلی در ثبت نام پیش آمده است.'**
  String get problem_in_register;

  /// No description provided for @gardesh_pay_site_cannot_displayed_security.
  ///
  /// In fa, this message translates to:
  /// **'سایت گردش‌پی به دلیل تنظیمات امنیتی نمی‌تواند مستقیماً در اینجا نمایش داده شود.'**
  String get gardesh_pay_site_cannot_displayed_security;

  /// No description provided for @to_view_site_press_button_open_new_page.
  ///
  /// In fa, this message translates to:
  /// **'برای مشاهده سایت، لطفاً دکمه زیر را فشار دهید تا سایت در صفحه جدیدی باز شود.'**
  String get to_view_site_press_button_open_new_page;

  /// No description provided for @open_gardesh_pay_in_new_tab.
  ///
  /// In fa, this message translates to:
  /// **'باز کردن گردش‌پی در تب جدید'**
  String get open_gardesh_pay_in_new_tab;

  /// No description provided for @no_card_selected.
  ///
  /// In fa, this message translates to:
  /// **'هیچ کارتی انتخاب نشده است'**
  String get no_card_selected;

  /// No description provided for @final_.
  ///
  /// In fa, this message translates to:
  /// **'پایانی'**
  String get final_;

  /// No description provided for @view_pdf_in_new_tab.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده فایل PDF در تب جدید'**
  String get view_pdf_in_new_tab;

  /// No description provided for @enter_.
  ///
  /// In fa, this message translates to:
  /// **'را وارد کنید'**
  String get enter_;

  /// No description provided for @online_support_open_in_new_tab.
  ///
  /// In fa, this message translates to:
  /// **'پشتیبانی آنلاین در تب جدید باز شده است'**
  String get online_support_open_in_new_tab;

  /// No description provided for @new_tab_not_open_use_below_button.
  ///
  /// In fa, this message translates to:
  /// **'اگر تب جدید باز نشد، از دکمه زیر استفاده کنید'**
  String get new_tab_not_open_use_below_button;

  /// No description provided for @open_online_support.
  ///
  /// In fa, this message translates to:
  /// **'باز کردن پشتیبانی آنلاین'**
  String get open_online_support;

  /// No description provided for @return_to_previous_page.
  ///
  /// In fa, this message translates to:
  /// **'بازگشت به صفحه قبل'**
  String get return_to_previous_page;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
