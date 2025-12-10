import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../model/bpms/enum_value_data.dart';
import '../model/bpms/military_guarantee/military_guarantee_person_type_item_data.dart';
import '../model/card/pin_type_data.dart';
import '../model/common/main_menu_item_data.dart';
import '../model/common/menu_data_model.dart';
import '../model/common/operator_data.dart';
import '../model/common/pichak_item_data.dart';
import '../model/common/settings_data.dart';
import '../model/gift_card/gift_card_status_data.dart';
import '../model/internet/internet_plan_filter_data.dart';
import '../model/invoice/bill_type_data.dart';
import '../model/pichak/bank_data.dart';
import '../model/pichak/check_block_status_data.dart';
import '../model/pichak/check_material_data.dart';
import '../model/pichak/check_owner_status_data.dart';
import '../model/pichak/check_status_data.dart';
import '../model/pichak/check_type_data.dart';
import '../model/pichak/customer_type_data.dart';
import '../model/pichak/guarantee_status_data.dart';
import '../model/pichak/reject_reason_data.dart';
import '../model/pichak/transfer_action_data.dart';
import '../model/promissory/promissory_finalized_role_type_filter_item_data.dart';
import '../model/promissory/promissory_item_data.dart';
import '../model/service_item_data.dart';
import '../model/theme_item_data.dart';
import '../model/transaction/transaction_service_data.dart';
import '../widget/svg/svg_icon.dart';
import 'app_theme.dart';
import 'enums_constants.dart';

class DataConstants {
  DataConstants._();

  static String mobileBankService = '134e24cc-fcca-4673-92cb-65ae5db4ce17';
  static String internetBankService = 'ad387ef5-ed46-4341-abd4-d01ea5a35562';
  static String acceptorService = 'bfbe2d29-1ead-4284-a848-f0d2f9a63cb1';
  static String paymentAcceptorService = '3c05cb9f-e952-40cd-b7c8-9a7f007545fb';
  static String safeBoxService = '273dfc4b-977a-4ddc-a493-346887113590';
  static String militaryGuaranteeService = 'a438cc47-8d39-43bc-af55-67f0782e3bf1';
  static String cbsService = 'a8f3f7f5-654f-48ea-8742-edfb736aa892';
  static String promissoryService = '7edd4156-e911-4cc1-9dab-05d3d00765b4';
  static String marriageLoanService = '615adac8-78f1-48b8-97e4-2e846c4c0154';
  static String loanPaymentService = '676f9acb-327a-4ed9-af8d-7f82725386ad';
  static String creditCardLoanService = '922cde78-1427-4c8f-99e7-3979268deb04';
  static String rayanCardService = '2f87e43b-193f-4111-8d6f-5cb7cee69843';
  static String childrenLoanService = '088dc15c-4f34-49ee-97c5-5fecbad97149';
  static String tobankMicroLendingLoanService = '673277fd-a078-4e63-a4ca-963f44825251';
  static String retailLoanService = '945a6ed6-f19b-47aa-8210-8a072c69d9aa';
  static String parsaLoanService = '69aa2ae6-7891-4a73-83d6-2e29053b1192';
  static String cardToCardService = '59874b9a-7ece-44c1-9176-8294cb8779f6';
  static String cardBalanceService = '52d32be3-cbe2-434f-a28a-0c0d9b1c75d5';
  static String simChargeService = 'ef77c542-6f76-41ac-a715-c5b337c3b486';
  static String internetService = 'cea2a830-23d7-4f15-8c2b-cea2ade50834';
  static String giftCardService = '837f763b-ab46-43b4-84b5-613f0c34ae23';
  static String charityService = 'd6074e9f-0b98-4c17-8a10-114322091aae';
  static String invoiceService = 'b3c3fccb-1f65-483f-8186-4cd73d10e778';
  static String pichakService = 'c18c84bf-266c-4727-a22e-a38c96ceadec';
  static String daranService = 'e9eee3ff-eb45-4041-b2c0-71694c1123a2';
  static String megagashtService = 'a9a45f2e-b5d5-4f87-be8c-cf019460beaa';
  static String customerClubService = 'ddfab471-da33-4638-8755-c671618f15de';
  static String iranTicService = 'c4a94e5e-8313-46b2-9082-3ab6b53c45bc';
  static String azkiService = 'd9a63cdc-60f6-4759-aa2f-1759d7074e7c';
  static String iranConcertService = 'd754cecf-b6a3-4936-b021-69fa5d9d5131';
  static String honarTicketService = 'a950d6a7-f9b7-4a53-be56-4342e019ec17';

  static String facilityServices = 'bfc55e2a-c62d-46db-a3d3-96cf6cb18b15';
  static String tobankServices = '18058366-c2ef-4a12-9d6a-573986020af8';

  static const Map<String, String> cardBankMap = {
    '603799': 'بانک ملی ایران',
    '589210': 'بانک سپه',
    '627648': 'بانک توسعه صادرات',
    '627961': 'بانک صنعت و معدن',
    '603770': 'بانک کشاورزی',
    '628023': 'بانک مسکن',
    '627760': 'پست بانک ایران',
    '502908': 'بانک توسعه تعاون',
    '627412': 'بانک اقتصاد نوین',
    '622106': 'بانک پارسیان',
    '502229': 'بانک پاسارگاد',
    '627488': 'بانک کار آفرین',
    '621986': 'بانک سامان',
    '639607': 'بانک سرمایه',
    '636214': 'بانک تات',
    '502938': 'بانک دی',
    '603769': 'بانک صادرات',
    '610433': 'بانک ملت',
    '627353': 'بانک تجارت',
    '589463': 'بانک رفاه',
    '627381': 'بانک انصار',
    '585983': 'بانک تجارت',
    '505416': 'بانک گردشگری',
    '639599': 'بانک قوامین',
    '639346': 'بانک سینا',
    '504706': 'بانک شهر',
    '502806': 'بانک شهر',
    '639370': 'بانک مهر اقتصاد',
    '507677': 'موسسه اعتباری نور',
    '628157': 'موسسه اعتباری توسعه',
    '505801': 'موسسه اعتباری کوثر',
    '606256': 'موسسه اعتباری ملل(عسکریه)',
    '606373': 'بانک قرض الحسنه مهرایرانیان',
  };

  static const Map<String, String> simCardData = {
    '0910': 'mci',
    '0911': 'mci',
    '0912': 'mci',
    '0913': 'mci',
    '0914': 'mci',
    '0915': 'mci',
    '0916': 'mci',
    '0917': 'mci',
    '0918': 'mci',
    '0919': 'mci',
    '0990': 'mci',
    '0993': 'mci',
    '0991': 'mci',
    '0992': 'mci',
    '0994': 'mci',
    '0901': 'mtn',
    '0902': 'mtn',
    '0903': 'mtn',
    '0904': 'mtn',
    '0905': 'mtn',
    '0930': 'mtn',
    '0933': 'mtn',
    '0935': 'mtn',
    '0936': 'mtn',
    '0937': 'mtn',
    '0938': 'mtn',
    '0939': 'mtn',
    '0941': 'mtn',
    '0900': 'mtn',
    '0920': 'rightel',
    '0921': 'rightel',
    '0922': 'rightel',
    '0998': 'shatel',
  };

  static const Map<String, String> mimTypes = {
    'png': 'image/png',
    'jpeg': 'image/jpeg',
    'jpg': 'image/jpeg',
    'pdf': 'application/pdf',
  };

  static const List<String> weekDay = <String>[
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنج‌شنبه',
    'جمعه',
    'شنبه',
    'یک‌شنبه',
  ];
  static const List<String> monthNumber = <String>[
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];

  static List<String> yearNumbers() {
    final list = <String>[];
    final int currentYear = Jalali.now().year;
    for (int i = 0; i <= 10; i++) {
      list.add((currentYear + i).toString());
    }
    return list;
  }

  static List<MainMenuItemData> getMenuItems() {
    final List<MainMenuItemData> menuItems = [];

    final MainMenuItemData cardToCard = MainMenuItemData(
      uuid: cardToCardService,
      title: 'کارت به کارت',
      icon: SvgIcons.cardToCard,
      iconDark: SvgIcons.cardToCardDark,
    );
    final MainMenuItemData simCharge = MainMenuItemData(
      uuid: simChargeService,
      title: 'شارژ',
      icon: SvgIcons.simCharge,
      iconDark: SvgIcons.simChargeDark,
    );
    final MainMenuItemData internetPlan = MainMenuItemData(
      uuid: internetService,
      title: 'بسته اینترنت',
      icon: SvgIcons.internet,
      iconDark: SvgIcons.internetDark,
    );

    final MainMenuItemData charity = MainMenuItemData(
      uuid: charityService,
      title: 'نیکوکاری',
      icon: SvgIcons.charity,
      iconDark: SvgIcons.charityDark,
    );

    final MainMenuItemData invoice = MainMenuItemData(
      uuid: invoiceService,
      title: 'قبض',
      icon: SvgIcons.invoice,
      iconDark: SvgIcons.invoiceDark,
    );

    final MainMenuItemData physicalGiftCard = MainMenuItemData(
      uuid: giftCardService,
      title: 'کارت هدیه',
      icon: SvgIcons.giftCard,
      iconDark: SvgIcons.giftCardDark,
    );

    final MainMenuItemData cardBalance = MainMenuItemData(
      uuid: cardBalanceService,
      title: 'موجودی',
      icon: SvgIcons.cardBalance,
      iconDark: SvgIcons.cardBalanceDark,
    );
    final MainMenuItemData pichak = MainMenuItemData(
      uuid: pichakService,
      title: 'پیچک',
      icon: SvgIcons.pichak,
      iconDark: SvgIcons.pichakDark,
    );

    final MainMenuItemData daran = MainMenuItemData(
      uuid: daranService,
      title: 'صندوق‌های سرمایه‌گذاری در بانک گردشگری',
      icon: SvgIcons.gardeshgariSarmayeh,
      iconDark: SvgIcons.gardeshgariSarmayeh,
    );

    final MainMenuItemData megaGasht = MainMenuItemData(
      uuid: megagashtService,
      title: 'خدمات سفر',
      icon: SvgIcons.megagasht,
      iconDark: SvgIcons.megagashtDark,
    );

    final MainMenuItemData marriageLoan = MainMenuItemData(
      uuid: marriageLoanService,
      title: 'تسهیلات ازدواج',
      icon: SvgIcons.loan,
      iconDark: SvgIcons.loanDark,
    );

    final MainMenuItemData creditCard = MainMenuItemData(
      uuid: creditCardLoanService,
      title: 'تسهیلات کارت اعتباری',
      icon: SvgIcons.creditCard,
      iconDark: SvgIcons.creditCardDark,
    );

    final MainMenuItemData loanPayment = MainMenuItemData(
      uuid: loanPaymentService,
      title: 'پرداخت اقساط',
      icon: SvgIcons.loanPayment,
      iconDark: SvgIcons.loanPaymentDark,
    );

    final MainMenuItemData rayanCard = MainMenuItemData(
      uuid: rayanCardService,
      title: 'تسهیلات رایان کارت',
      icon: SvgIcons.rayanCard,
      iconDark: SvgIcons.rayanCardDark,
    );

    final MainMenuItemData childrenLoan = MainMenuItemData(
      uuid: childrenLoanService,
      title: 'تسهیلات فرزندآوری',
      icon: SvgIcons.childrenLoan,
      iconDark: SvgIcons.childrenLoanDark,
    );

    final MainMenuItemData retailLoan = MainMenuItemData(
      uuid: retailLoanService,
      title: 'تسهیلات خرد',
      icon: SvgIcons.retailLoan,
      iconDark: SvgIcons.retailLoanDark,
    );
    final MainMenuItemData microLendingLoan = MainMenuItemData(
      uuid: tobankMicroLendingLoanService,
      title: 'توربو وام',
      icon: SvgIcons.microLendingLoan,
      iconDark: SvgIcons.microLendingLoanDark,
    );

    final MainMenuItemData parsaLoan = MainMenuItemData(
      uuid: parsaLoanService,
      title: 'تسهیلات پارسا',
      icon: SvgIcons.parsa,
      iconDark: SvgIcons.parsaDark,
    );

    final MainMenuItemData paymentAcceptor = MainMenuItemData(
      uuid: paymentAcceptorService,
      title: 'پذیرندگی',
      icon: SvgIcons.acceptor,
      iconDark: SvgIcons.acceptorDark,
    );
    final MainMenuItemData mobileBank = MainMenuItemData(
      uuid: mobileBankService,
      title: 'خدمات موبایل بانک',
      icon: SvgIcons.menuMobile,
      iconDark: SvgIcons.menuMobileDark,
    );

    final MainMenuItemData internetBank = MainMenuItemData(
      uuid: internetBankService,
      title: 'خدمات اینترنت بانک',
      icon: SvgIcons.menuInternet,
      iconDark: SvgIcons.menuInternetDark,
    );

    final MainMenuItemData acceptor = MainMenuItemData(
      uuid: acceptorService,
      title: 'درخواست پذیرندگی',
      icon: SvgIcons.requestAcceptor,
      iconDark: SvgIcons.requestAcceptorDark,
    );

    final MainMenuItemData safeBox = MainMenuItemData(
      uuid: safeBoxService,
      title: 'صندوق امانات',
      icon: SvgIcons.safeBox,
      iconDark: SvgIcons.safeBoxDark,
    );

    final MainMenuItemData cbs = MainMenuItemData(
      uuid: cbsService,
      title: 'اعتبارسنجی',
      icon: SvgIcons.cbs,
      iconDark: SvgIcons.cbsDark,
    );

    final MainMenuItemData promissory = MainMenuItemData(
      uuid: promissoryService,
      title: 'سفته و برات آنلاین',
      icon: SvgIcons.promissory,
      iconDark: SvgIcons.promissoryDark,
    );

    final MainMenuItemData militaryGuarantee = MainMenuItemData(
      uuid: militaryGuaranteeService,
      title: 'ضمانت‌نامه نظام وظیفه',
      icon: SvgIcons.militaryGuarantee,
      iconDark: SvgIcons.militaryGuaranteeDark,
    );

    final MainMenuItemData iranTic = MainMenuItemData(
      uuid: iranTicService,
      title: 'ایران تیک',
      icon: SvgIcons.irantic,
      iconDark: SvgIcons.iranticDark,
    );

    final MainMenuItemData iranConcert = MainMenuItemData(
      uuid: iranConcertService,
      title: 'ایران کنسرت',
      icon: SvgIcons.iranConcert,
      iconDark: SvgIcons.iranConcertDark,
    );

    final MainMenuItemData honarTicket = MainMenuItemData(
      uuid: honarTicketService,
      title: 'هنر تیکت',
      icon: SvgIcons.honarTicket,
      iconDark: SvgIcons.honarTicketDark,
    );

    final MainMenuItemData azki = MainMenuItemData(
      uuid: azkiService,
      title: 'ازکی وام',
      icon: SvgIcons.azkiLoan,
      iconDark: SvgIcons.azkiLoanDark,
    );

    menuItems.add(cardToCard);
    menuItems.add(simCharge);
    menuItems.add(internetPlan);
    menuItems.add(charity);
    menuItems.add(invoice);
    menuItems.add(physicalGiftCard);
    menuItems.add(cardBalance);
    menuItems.add(pichak);
    menuItems.add(daran);
    menuItems.add(megaGasht);
    menuItems.add(marriageLoan);
    menuItems.add(childrenLoan);
    menuItems.add(creditCard);
    menuItems.add(loanPayment);
    menuItems.add(rayanCard);
    menuItems.add(retailLoan);
    menuItems.add(microLendingLoan);
    menuItems.add(parsaLoan);

    menuItems.add(mobileBank);
    menuItems.add(internetBank);
    menuItems.add(acceptor);
    menuItems.add(safeBox);
    menuItems.add(cbs);
    menuItems.add(promissory);

    menuItems.add(militaryGuarantee);
    menuItems.add(paymentAcceptor);
    menuItems.add(iranTic);
    menuItems.add(iranConcert);
    menuItems.add(honarTicket);
    menuItems.add(azki);
    return menuItems;
  }

  static List<PichakItemData> getPichakItems() {
    final List<PichakItemData> pichakDataList = [];

    final PichakItemData pichakItemData1 = PichakItemData(
      eventId: 1,
      iconName: SvgIcons.checkOwnerStatus,
      iconDark: SvgIcons.checkOwnerStatusDark,
      title: 'استعلام اعتبار صادرکننده چک',
      description: 'بررسی وضعیت چک توسط صادرکننده',
    );

    final PichakItemData pichakItemData2 = PichakItemData(
      eventId: 2,
      iconName: SvgIcons.checkSubmit,
      iconDark: SvgIcons.checkSubmitDark,
      title: 'ثبت چک',
      description: 'ثبت چک در سامانه صیاد',
    );

    final PichakItemData pichakItemData3 = PichakItemData(
      eventId: 3,
      iconName: SvgIcons.checkReceive,
      iconDark: SvgIcons.checkReceiveDark,
      title: 'دریافت چک',
      description: 'تایید یا رد چک توسط دریافت‌کننده',
    );

    final PichakItemData pichakItemData4 = PichakItemData(
      eventId: 4,
      iconName: SvgIcons.checkTransfer,
      iconDark: SvgIcons.checkTransferDark,
      title: 'انتقال چک',
      description: 'انتقال چک توسط دریافت‌کننده فعلی چک',
    );

    final PichakItemData pichakItemData6 = PichakItemData(
      eventId: 6,
      iconName: SvgIcons.checkInquiryStatus,
      iconDark: SvgIcons.checkInquiryStatusDark,
      title: 'استعلام چک‌های صادر شده',
      description: 'بررسی وضعیت چک توسط صادرکننده',
    );

    final PichakItemData pichakItemData7 = PichakItemData(
      eventId: 7,
      iconName: SvgIcons.checkTransfer,
      iconDark: SvgIcons.checkTransferDark,
      title: 'عودت چک',
      description: 'عودت چک به صادرکننده چک',
    );

    final PichakItemData pichakItemData8 = PichakItemData(
      eventId: 8,
      iconName: SvgIcons.checkStatus,
      iconDark: SvgIcons.checkStatusDark,
      title: 'استعلام وضعیت انتقال چک',
      description: 'بررسی اطلاعات چک توسط دریافت‌کننده چک',
    );
    pichakDataList.add(pichakItemData2);
    pichakDataList.add(pichakItemData6);
    pichakDataList.add(pichakItemData1);
    pichakDataList.add(pichakItemData3);
    pichakDataList.add(pichakItemData4);
    pichakDataList.add(pichakItemData7);
    pichakDataList.add(pichakItemData8);
    return pichakDataList;
  }

  static List<PichakItemData> getShaparakItems() {
    final List<PichakItemData> pichakDataList = [];
    final PichakItemData pichakItemData0 = PichakItemData(
      eventId: 0,
      iconName: SvgIcons.checkSubmit,
      iconDark: SvgIcons.checkSubmitDark,
      title: 'ثبت کارت در شاپرک',
      description: '',
    );
    pichakDataList.add(pichakItemData0);
    return pichakDataList;
  }

  static List<SettingsItemData> getOtherPageItems(bool availableTransactionGift) {
    final List<SettingsItemData> settingsItemDataList = [];
    final SettingsItemData bankAccount = SettingsItemData(
      icon: SvgIcons.bankAccount,
      iconDark: SvgIcons.nullIcon,
      title: 'اطلاعات بانکی',
      event: 1,
    );
    final SettingsItemData inviteMember = SettingsItemData(
      icon: SvgIcons.inviteMember,
      iconDark: SvgIcons.nullIcon,
      title: 'دعوت از دوستان',
      event: 2,
    );
    final SettingsItemData storedDestinations = SettingsItemData(
      icon: SvgIcons.storedDeposit,
      iconDark: SvgIcons.nullIcon,
      title: 'مدیریت مقصدها',
      event: 3,
    );
    final SettingsItemData settings = SettingsItemData(
      icon: SvgIcons.settings,
      iconDark: SvgIcons.nullIcon,
      title: 'تنظیمات',
      event: 4,
    );
    final SettingsItemData rules = SettingsItemData(
      icon: SvgIcons.rules,
      iconDark: SvgIcons.nullIcon,
      title: 'قوانین و مقررات',
      event: 5,
    );

    final SettingsItemData aboutUs = SettingsItemData(
      icon: SvgIcons.aboutUs,
      iconDark: SvgIcons.nullIcon,
      title: 'درباره ما',
      event: 6,
    );
    final SettingsItemData contactUs = SettingsItemData(
      icon: SvgIcons.contact,
      iconDark: SvgIcons.nullIcon,
      title: 'تماس با ما',
      event: 7,
    );
    final SettingsItemData security = SettingsItemData(
      icon: SvgIcons.profile,
      iconDark: SvgIcons.nullIcon,
      title: 'تست پلاگین ساین',
      event: 8,
    );
    // final SettingsItemData authorization = SettingsItemData(
    //   icon: SvgIcons.profile,
    //   iconDark: SvgIcons.nullIcon,
    //   title: 'احراز هویت یکتا',
    //   event: 9,
    // );
    final SettingsItemData renewCertificate = SettingsItemData(
      icon: SvgIcons.profile,
      iconDark: SvgIcons.nullIcon,
      title: 'به‌روزرسانی احراز هویت',
      event: 10,
    );
    settingsItemDataList.add(bankAccount);
    settingsItemDataList.add(inviteMember);
    settingsItemDataList.add(storedDestinations);
    settingsItemDataList.add(settings);
    settingsItemDataList.add(rules);
    settingsItemDataList.add(aboutUs);
    settingsItemDataList.add(contactUs);
    // settingsItemDataList.add(authorization);
    // settingsItemDataList.add(security);
    // settingsItemDataList.add(renewCertificate);
    return settingsItemDataList;
  }

  static List<BillTypeData> getBllTypeDataList() {
    final List<BillTypeData> billTypeDataList = [];
    const BillTypeData all = BillTypeData(
      id: -1,
      title: 'همه قبوض',
      icon: SvgIcons.nullIcon,
      iconDark: SvgIcons.nullIcon,
    );
    billTypeDataList.add(all);
    const BillTypeData telephone = BillTypeData(
      id: 4,
      title: 'قبض تلفن',
      icon: SvgIcons.telBill,
      iconDark: SvgIcons.telBillDark,
    );
    billTypeDataList.add(telephone);
    const BillTypeData mobile = BillTypeData(
      id: 5,
      title: 'قبض موبایل',
      icon: SvgIcons.telBill,
      iconDark: SvgIcons.telBillDark,
    );
    billTypeDataList.add(mobile);
    const BillTypeData water = BillTypeData(
      id: 1,
      title: 'قبض آب',
      icon: SvgIcons.waterBill,
      iconDark: SvgIcons.waterBillDark,
    );
    billTypeDataList.add(water);
    const BillTypeData power = BillTypeData(
      id: 2,
      title: 'قبض برق',
      icon: SvgIcons.electricBill,
      iconDark: SvgIcons.electricBillDark,
    );
    billTypeDataList.add(power);
    const BillTypeData gas = BillTypeData(
      id: 3,
      title: 'قبض گاز',
      icon: SvgIcons.gasBill,
      iconDark: SvgIcons.gasBillDark,
    );
    billTypeDataList.add(gas);
    return billTypeDataList;
  }

  static List<BillTypeData> getBllTypeDataListMinify() {
    final List<BillTypeData> billTypeDataList = [];
    const BillTypeData telephone = BillTypeData(
      id: 4,
      title: 'تلفن',
      icon: SvgIcons.telBill,
      iconDark: SvgIcons.telBillDark,
    );
    billTypeDataList.add(telephone);
    const BillTypeData mobile = BillTypeData(
      id: 5,
      title: 'موبایل',
      icon: SvgIcons.telBill,
      iconDark: SvgIcons.telBillDark,
    );
    billTypeDataList.add(mobile);
    const BillTypeData water = BillTypeData(
      id: 1,
      title: 'آب',
      icon: SvgIcons.waterBill,
      iconDark: SvgIcons.waterBillDark,
    );
    billTypeDataList.add(water);
    const BillTypeData power = BillTypeData(
      id: 2,
      title: 'برق',
      icon: SvgIcons.electricBill,
      iconDark: SvgIcons.electricBillDark,
    );
    billTypeDataList.add(power);
    const BillTypeData gas = BillTypeData(
      id: 3,
      title: 'گاز',
      icon: SvgIcons.gasBill,
      iconDark: SvgIcons.gasBillDark,
    );
    billTypeDataList.add(gas);
    return billTypeDataList;
  }

  static List<BillTypeData> getBillTypeSelectors() {
    final List<BillTypeData> billTypeDataList = [];
    const BillTypeData telephone = BillTypeData(
      id: 1,
      title: 'تلفن/موبایل',
      icon: SvgIcons.telBill,
      iconDark: SvgIcons.telBillDark,
    );
    billTypeDataList.add(telephone);
    const BillTypeData power = BillTypeData(
      id: 2,
      title: 'برق',
      icon: SvgIcons.electricBill,
      iconDark: SvgIcons.electricBillDark,
    );
    billTypeDataList.add(power);
    const BillTypeData water = BillTypeData(
      id: 3,
      title: 'آب',
      icon: SvgIcons.waterBill,
      iconDark: SvgIcons.waterBillDark,
    );
    billTypeDataList.add(water);
    const BillTypeData gas = BillTypeData(
      id: 4,
      title: 'گاز',
      icon: SvgIcons.gasBill,
      iconDark: SvgIcons.gasBillDark,
    );
    billTypeDataList.add(gas);
    return billTypeDataList;
  }

  static List<TransactionServiceData> getTransactionServiceDataList() {
    final List<TransactionServiceData> transactionServiceDataList = [];
    final TransactionServiceData carFines = TransactionServiceData(
      title: 'پرداخت قبوض',
      id: 12,
    );

    final TransactionServiceData invoice = TransactionServiceData(
      title: 'پرداخت گروهی قبوض',
      id: 19,
    );

    final TransactionServiceData wallet = TransactionServiceData(
      title: 'شارژ کیف پول',
      id: 1,
    );

    final TransactionServiceData charity = TransactionServiceData(
      title: 'نیکوکاری',
      id: 2,
    );

    final TransactionServiceData charge = TransactionServiceData(
      title: 'خرید شارژ مستقیم',
      id: 105,
    );

    final TransactionServiceData internet = TransactionServiceData(
      title: 'خرید بسته اینترنتی',
      id: 108,
    );

    final TransactionServiceData cardToCard = TransactionServiceData(
      title: 'کارت به کارت',
      id: 8,
    );

    final TransactionServiceData walletTransaction = TransactionServiceData(
      title: 'انتقال کیف پول',
      id: 5,
    );
    final TransactionServiceData giftCard = TransactionServiceData(
      title: 'خرید کارت هدیه',
      id: 20,
    );

    final TransactionServiceData payBack = TransactionServiceData(
      title: 'استرداد وجه',
      id: 16,
    );

    final TransactionServiceData safeBox = TransactionServiceData(
      title: 'صندوق امانات',
      id: 50,
    );

    transactionServiceDataList.add(giftCard);
    transactionServiceDataList.add(walletTransaction);
    transactionServiceDataList.add(cardToCard);
    transactionServiceDataList.add(internet);
    transactionServiceDataList.add(charge);
    transactionServiceDataList.add(charity);
    transactionServiceDataList.add(wallet);
    transactionServiceDataList.add(carFines);
    transactionServiceDataList.add(invoice);
    transactionServiceDataList.add(payBack);
    transactionServiceDataList.add(safeBox);
    return transactionServiceDataList;
  }

  static List<TransactionServiceData> getTransactionServiceDataWalletList() {
    final List<TransactionServiceData> transactionServiceDataList = [];
    final TransactionServiceData carFines = TransactionServiceData(
      title: 'پرداخت قبوض',
      id: 12,
    );

    final TransactionServiceData travelInsurance = TransactionServiceData(
      title: 'بیمه مسافرتی',
      id: 17,
    );

    final TransactionServiceData invoice = TransactionServiceData(
      title: 'پرداخت گروهی قبوض',
      id: 19,
    );

    final TransactionServiceData wallet = TransactionServiceData(
      title: 'شارژ کیف پول',
      id: 1,
    );

    final TransactionServiceData charity = TransactionServiceData(
      title: 'نیکوکاری',
      id: 2,
    );

    final TransactionServiceData charge = TransactionServiceData(
      title: 'خرید شارژ مستقیم',
      id: 3,
    );

    final TransactionServiceData internet = TransactionServiceData(
      title: 'خرید بسته اینترنتی',
      id: 4,
    );

    final TransactionServiceData walletTransaction = TransactionServiceData(
      title: 'انتقال کیف پول',
      id: 5,
    );

    final TransactionServiceData giftCard = TransactionServiceData(
      title: 'خرید کارت هدیه',
      id: 20,
    );

    transactionServiceDataList.add(giftCard);
    transactionServiceDataList.add(walletTransaction);
    transactionServiceDataList.add(internet);
    transactionServiceDataList.add(charge);
    transactionServiceDataList.add(charity);
    transactionServiceDataList.add(wallet);
    transactionServiceDataList.add(carFines);
    transactionServiceDataList.add(travelInsurance);
    transactionServiceDataList.add(invoice);
    return transactionServiceDataList;
  }

  static List<TransactionServiceData> getTransactionServiceDataTourismList() {
    final List<TransactionServiceData> transactionServiceDataList = [];
    final TransactionServiceData travelInsurance = TransactionServiceData(
      title: 'بیمه مسافرتی',
      id: 17,
    );
    transactionServiceDataList.add(travelInsurance);
    return transactionServiceDataList;
  }

  static List<PhysicalGiftCardStatusData> getGiftCardStatusDataList() {
    final List<PhysicalGiftCardStatusData> physicalGiftCardStatusDataList = [];
    final PhysicalGiftCardStatusData unpaid = PhysicalGiftCardStatusData(
      status: 'unpaid',
      statusTitle: 'پرداخت نشده',
      statusColor: Colors.red,
    );
    final PhysicalGiftCardStatusData confirming = PhysicalGiftCardStatusData(
      status: 'confirming',
      statusTitle: 'منتظر تایید بانک',
      statusColor: const Color(0xffffbb00),
    );
    final PhysicalGiftCardStatusData confirmed = PhysicalGiftCardStatusData(
      status: 'confirmed',
      statusTitle: 'تایید شده',
      statusColor: const Color(0xff28aae1),
    );
    final PhysicalGiftCardStatusData sending = PhysicalGiftCardStatusData(
      status: 'sending',
      statusTitle: 'صادر شده',
      statusColor: AppTheme.textColor,
    );
    final PhysicalGiftCardStatusData posted = PhysicalGiftCardStatusData(
      status: 'posted',
      statusTitle: 'ارسال شده',
      statusColor: const Color(0xff5ed562),
    );
    physicalGiftCardStatusDataList.add(unpaid);
    physicalGiftCardStatusDataList.add(confirming);
    physicalGiftCardStatusDataList.add(confirmed);
    physicalGiftCardStatusDataList.add(sending);
    physicalGiftCardStatusDataList.add(posted);
    return physicalGiftCardStatusDataList;
  }

  static List<CheckTypeData> getCheckTypeDataList() {
    final List<CheckTypeData> checkTypeDataList = [];
    const CheckTypeData checkTypeData1 = CheckTypeData(
      title: 'عادی',
      id: '1',
    );
    const CheckTypeData checkTypeData2 = CheckTypeData(
      title: 'بانکی',
      id: '2',
    );
    const CheckTypeData checkTypeData3 = CheckTypeData(
      title: 'رمزدار',
      id: '3',
    );
    checkTypeDataList.add(checkTypeData1);
    checkTypeDataList.add(checkTypeData2);
    checkTypeDataList.add(checkTypeData3);
    return checkTypeDataList;
  }

  static List<CheckMaterialData> getCheckMaterialDataList() {
    final List<CheckMaterialData> checkMaterialDataList = [];
    const CheckMaterialData checkMaterialData1 = CheckMaterialData(
      title: 'کاغذی',
      id: '1',
    );
    const CheckMaterialData checkMaterialData2 = CheckMaterialData(
      title: 'دیجیتالی(فعلا پشتیبانی نمی‌شود)',
      id: '2',
    );
    checkMaterialDataList.add(checkMaterialData1);
    checkMaterialDataList.add(checkMaterialData2);
    return checkMaterialDataList;
  }

  static List<CustomerTypeData> getCustomerTypeDataList() {
    final List<CustomerTypeData> customerTypeDataList = [];
    const CustomerTypeData customerTypeData1 = CustomerTypeData(
      title: 'حقیقی داخلی',
      id: 0,
    );
    const CustomerTypeData customerTypeData2 = CustomerTypeData(
      title: 'حقوقی داخلی',
      id: 1,
    );
    const CustomerTypeData customerTypeData3 = CustomerTypeData(
      title: 'اتباع خارجی',
      id: 2,
    );
    customerTypeDataList.add(customerTypeData1);
    customerTypeDataList.add(customerTypeData2);
    customerTypeDataList.add(customerTypeData3);
    return customerTypeDataList;
  }

  static List<CheckStatusData> getCheckStatusList() {
    final List<CheckStatusData> checkStatusDataList = [];
    const CheckStatusData checkStatusData1 = CheckStatusData(
      title: 'صادر و تایید شده است',
      id: 1,
    );
    const CheckStatusData checkStatusData2 = CheckStatusData(
      title: 'نقد شده است',
      id: 2,
    );
    const CheckStatusData checkStatusData3 = CheckStatusData(
      title: 'کنار گذاشته شد',
      id: 3,
    );
    const CheckStatusData checkStatusData4 = CheckStatusData(
      title: 'برگشت خورده است',
      id: 4,
    );
    const CheckStatusData checkStatusData5 = CheckStatusData(
      title: 'درحال برگشت خوردن است',
      id: 5,
    );
    const CheckStatusData checkStatusData6 = CheckStatusData(
      title: 'در انتظار امضای ضامن',
      id: 6,
    );
    const CheckStatusData checkStatusData7 = CheckStatusData(
      title: 'در انتظار تایید گیرنده پس از ثبت',
      id: 7,
    );
    const CheckStatusData checkStatusData8 = CheckStatusData(
      title: 'در انتظار تایید گیرنده پس از انتقال',
      id: 8,
    );
    checkStatusDataList.add(checkStatusData1);
    checkStatusDataList.add(checkStatusData2);
    checkStatusDataList.add(checkStatusData3);
    checkStatusDataList.add(checkStatusData4);
    checkStatusDataList.add(checkStatusData5);
    checkStatusDataList.add(checkStatusData6);
    checkStatusDataList.add(checkStatusData7);
    checkStatusDataList.add(checkStatusData8);
    return checkStatusDataList;
  }

  static List<CheckBlockStatusData> getCheckBlockStatusList() {
    final List<CheckBlockStatusData> checkBlockStatusDataList = [];
    const CheckBlockStatusData checkStatusData1 = CheckBlockStatusData(
      title: 'مسدود نشده',
      id: 0,
    );
    const CheckBlockStatusData checkStatusData2 = CheckBlockStatusData(
      title: 'به طور موقف مسدود شده',
      id: 1,
    );
    const CheckBlockStatusData checkStatusData3 = CheckBlockStatusData(
      title: 'به طور دائم مسدود شده',
      id: 2,
    );
    const CheckBlockStatusData checkStatusData4 = CheckBlockStatusData(
      title: 'رفع مسدود شده',
      id: 3,
    );
    checkBlockStatusDataList.add(checkStatusData1);
    checkBlockStatusDataList.add(checkStatusData2);
    checkBlockStatusDataList.add(checkStatusData3);
    checkBlockStatusDataList.add(checkStatusData4);
    return checkBlockStatusDataList;
  }

  static List<RejectReasonData> getRejectReasonList() {
    final List<RejectReasonData> rejectReasonDataList = [];
    const RejectReasonData checkStatusData0 = RejectReasonData(
      title: 'اشتباه در لیست دریافت‌کنندگان چک',
      id: 0,
    );
    const RejectReasonData checkStatusData1 = RejectReasonData(
      title: 'اشتباه در مبلغ چک',
      id: 1,
    );
    const RejectReasonData checkStatusData2 = RejectReasonData(
      title: 'اشتباه در تاریخ چک',
      id: 2,
    );
    const RejectReasonData checkStatusData3 = RejectReasonData(
      title: 'اشتباه‌های دیگر',
      id: 3,
    );
    const RejectReasonData checkStatusData4 = RejectReasonData(
      title: 'معامله اصلی لغو شد',
      id: 4,
    );
    const RejectReasonData checkStatusData5 = RejectReasonData(
      title: 'چک برگشت خورده',
      id: 5,
    );
    const RejectReasonData checkStatusData6 = RejectReasonData(
      title: 'اطلاعات چک مخدوش است',
      id: 6,
    );
    rejectReasonDataList.add(checkStatusData0);
    rejectReasonDataList.add(checkStatusData1);
    rejectReasonDataList.add(checkStatusData2);
    rejectReasonDataList.add(checkStatusData3);
    rejectReasonDataList.add(checkStatusData4);
    rejectReasonDataList.add(checkStatusData5);
    rejectReasonDataList.add(checkStatusData6);
    return rejectReasonDataList;
  }

  static List<BankData> getBankDataList() {
    final List<BankData> bankDataList = [];
    final BankData bankData1 = BankData(
      title: 'بانک مرکزی',
      id: '10',
    );
    final BankData bankData2 = BankData(
      title: 'صنعت و معدن',
      id: '11',
    );
    final BankData bankData3 = BankData(
      title: 'ملت',
      id: '12',
    );
    final BankData bankData4 = BankData(
      title: 'رفاه',
      id: '13',
    );
    final BankData bankData5 = BankData(
      title: 'مسکن',
      id: '14',
    );
    final BankData bankData6 = BankData(
      title: 'سپه',
      id: '15',
    );
    final BankData bankData7 = BankData(
      title: 'کشاورزی',
      id: '16',
    );
    final BankData bankData8 = BankData(
      title: 'ملی',
      id: '17',
    );
    final BankData bankData9 = BankData(
      title: 'تجارت',
      id: '18',
    );
    final BankData bankData10 = BankData(
      title: 'صادرات',
      id: '19',
    );
    final BankData bankData11 = BankData(
      title: 'توسعه صادرات',
      id: '20',
    );
    final BankData bankData12 = BankData(
      title: 'پست بانک ایران',
      id: '21',
    );
    final BankData bankData13 = BankData(
      title: 'توسعه تعاون',
      id: '22',
    );
    final BankData bankData14 = BankData(
      title: 'موسسه اعتباری توسعه',
      id: '51',
    );
    final BankData bankData15 = BankData(
      title: 'کارآفرین',
      id: '53',
    );
    final BankData bankData16 = BankData(
      title: 'پارسیان',
      id: '54',
    );
    final BankData bankData17 = BankData(
      title: 'اقتصاد نویین',
      id: '55',
    );
    final BankData bankData18 = BankData(
      title: 'سامان',
      id: '56',
    );
    final BankData bankData19 = BankData(
      title: 'پاسارگاد',
      id: '57',
    );
    final BankData bankData20 = BankData(
      title: 'سرمایه',
      id: '58',
    );
    final BankData bankData21 = BankData(
      title: 'سینا',
      id: '59',
    );
    final BankData bankData22 = BankData(
      title: 'قرض الحسنه مهر',
      id: '60',
    );
    final BankData bankData23 = BankData(
      title: 'بانک شهر',
      id: '61',
    );
    final BankData bankData24 = BankData(
      title: 'تات',
      id: '62',
    );
    final BankData bankData25 = BankData(
      title: 'انصار',
      id: '63',
    );
    final BankData bankData26 = BankData(
      title: 'گردشگری',
      id: '64',
    );
    final BankData bankData27 = BankData(
      title: 'حکمت ایرانیان',
      id: '65',
    );
    final BankData bankData28 = BankData(
      title: 'دی',
      id: '66',
    );
    final BankData bankData29 = BankData(
      title: 'ایران زمین',
      id: '69',
    );
    bankDataList.add(bankData1);
    bankDataList.add(bankData2);
    bankDataList.add(bankData3);
    bankDataList.add(bankData4);
    bankDataList.add(bankData5);
    bankDataList.add(bankData6);
    bankDataList.add(bankData7);
    bankDataList.add(bankData8);
    bankDataList.add(bankData9);
    bankDataList.add(bankData10);
    bankDataList.add(bankData11);
    bankDataList.add(bankData12);
    bankDataList.add(bankData13);
    bankDataList.add(bankData14);
    bankDataList.add(bankData15);
    bankDataList.add(bankData16);
    bankDataList.add(bankData17);
    bankDataList.add(bankData18);
    bankDataList.add(bankData19);
    bankDataList.add(bankData20);
    bankDataList.add(bankData21);
    bankDataList.add(bankData22);
    bankDataList.add(bankData23);
    bankDataList.add(bankData24);
    bankDataList.add(bankData25);
    bankDataList.add(bankData26);
    bankDataList.add(bankData27);
    bankDataList.add(bankData28);
    bankDataList.add(bankData29);
    return bankDataList;
  }

  static List<GuaranteeStatusData> getGuaranteeStatusDataList() {
    final List<GuaranteeStatusData> guaranteeStatusDataList = [];
    final GuaranteeStatusData guaranteeStatusData1 = GuaranteeStatusData(
      title: 'بدون ضامن',
      id: '1',
    );
    final GuaranteeStatusData guaranteeStatusData2 = GuaranteeStatusData(
      title: 'درحال بررسی',
      id: '2',
    );
    final GuaranteeStatusData guaranteeStatusData3 = GuaranteeStatusData(
      title: 'در حالت تعلیق',
      id: '3',
    );
    final GuaranteeStatusData guaranteeStatusData4 = GuaranteeStatusData(
      title: 'ضمانت شده',
      id: '4',
    );
    final GuaranteeStatusData guaranteeStatusData5 = GuaranteeStatusData(
      title: 'عدم تایید ضامنین',
      id: '5',
    );
    guaranteeStatusDataList.add(guaranteeStatusData1);
    guaranteeStatusDataList.add(guaranteeStatusData2);
    guaranteeStatusDataList.add(guaranteeStatusData3);
    guaranteeStatusDataList.add(guaranteeStatusData4);
    guaranteeStatusDataList.add(guaranteeStatusData5);
    return guaranteeStatusDataList;
  }

  static List<TransferActionData> getTransferActionList() {
    final List<TransferActionData> transferActionDataList = [];
    final TransferActionData transferActionData1 = TransferActionData(
      title: 'بدون اقدام',
      id: 0,
    );
    final TransferActionData transferActionData2 = TransferActionData(
      title: 'رد شده',
      id: 1,
    );
    final TransferActionData transferActionData3 = TransferActionData(
      title: 'تایید شده',
      id: 2,
    );
    final TransferActionData transferActionData4 = TransferActionData(
      title: 'درحال انجام',
      id: 3,
    );
    transferActionDataList.add(transferActionData1);
    transferActionDataList.add(transferActionData2);
    transferActionDataList.add(transferActionData3);
    transferActionDataList.add(transferActionData4);
    return transferActionDataList;
  }

  static List<InternetPlanFilterData> getInternetPlanFilterData() {
    final List<InternetPlanFilterData> list = [];
    const InternetPlanFilterData day = InternetPlanFilterData(
      index: 0,
      title: 'روزانه',
      durationInHours: [24],
    );
    list.add(day);
    const InternetPlanFilterData week = InternetPlanFilterData(
      index: 1,
      title: 'هفتگی',
      durationInHours: [72, 168],
    );
    list.add(week);
    const InternetPlanFilterData month = InternetPlanFilterData(
      index: 2,
      title: 'ماهانه',
      durationInHours: [720, 744, 1440],
    );
    list.add(month);
    const InternetPlanFilterData months_3 = InternetPlanFilterData(
      index: 3,
      title: 'سه ماهه',
      durationInHours: [2160],
    );
    list.add(months_3);
    const InternetPlanFilterData months_6 = InternetPlanFilterData(
      index: 4,
      title: 'شش ماهه',
      durationInHours: [4320],
    );
    list.add(months_6);
    const InternetPlanFilterData year = InternetPlanFilterData(
      index: 5,
      title: 'یک ساله',
      durationInHours: [8760],
    );
    list.add(year);
    return list;
  }

  static List<int> getParsaLoanWageCosts() {
    final List<int> list = [2, 4];
    return list;
  }

  static List<int> getParsaLoanRepaymentDurations() {
    final List<int> list = [12, 24];
    return list;
  }

  static List<EnumValue> getParsaLoanEmploymentTypes() {
    final List<EnumValue> list = [];
    list.add(EnumValue(key: '1', title: 'کارمند'));
    list.add(EnumValue(key: '2', title: 'بازنشسته'));
    list.add(EnumValue(key: '3', title: 'آزاد'));
    return list;
  }

  static List<OperatorData> getOperatorDataList() {
    final List<OperatorData> operatorDataList = [];
    final OperatorData iranCell = OperatorData(title: 'ایرانسل', icon: 'assets/images/mtn.png', id: 0);
    final OperatorData mci = OperatorData(title: 'همراه اول', icon: 'assets/images/mci.png', id: 1);
    final OperatorData rightel = OperatorData(title: 'رایتل', icon: 'assets/images/rightel.png', id: 2);
    final OperatorData shatel = OperatorData(title: 'شاتل', icon: 'assets/images/shatel.png', id: 3);
    operatorDataList.add(iranCell);
    operatorDataList.add(mci);
    operatorDataList.add(rightel);
    operatorDataList.add(shatel);
    return operatorDataList;
  }

  static List<String> getPlaqueChars() {
    final List<String> list = [
      'الف',
      'ب',
      'پ',
      'ت',
      'ث',
      'ج',
      'د',
      'ز',
      'س',
      'ش',
      'ص',
      'ط',
      'ع',
      'ف',
      'ق',
      'ک',
      'گ',
      'ل',
      'م',
      'ن',
      'و',
      'ه',
      'ی',
      'p',
    ];
    return list;
  }

  static MenuDataModel getMenuDataModel() {
    final MenuDataModel menuDataModel = MenuDataModel(
      tobankServices: [],
      facilityServices: [],
      paymentServices: [],
      citizenServices: [],
    );

    //*********************** */

    menuDataModel.daranService = MenuItemData(
      uuid: daranService,
      title: 'صندوق‌های سرمایه‌گذاری در بانک گردشگری',
      order: 2,
      message: '',
      isDisable: false,
      requireCard: true,
      requireNationalCode: true,
      requireDeposit: false,
    );

    menuDataModel.tobankServices.add(MenuItemData(
      uuid: mobileBankService,
      title: 'خدمات موبایل بانک',
      subtitle: 'فعال‌سازی خدمات و صدور رمز',
      order: 6,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.tobankServices.add(MenuItemData(
      uuid: internetBankService,
      title: 'خدمات اینترنت بانک',
      subtitle: 'فعال‌سازی خدمات و صدور رمز',
      order: 7,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.tobankServices.add(MenuItemData(
      uuid: acceptorService,
      title: 'درخواست پذیرندگی',
      subtitle: 'سرویس درخواست POS و IPG',
      order: 10,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.tobankServices.add(MenuItemData(
      uuid: safeBoxService,
      title: 'صندوق امانات',
      subtitle: 'اجاره صندوق، رزرو زمان بازدید',
      order: 11,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.tobankServices.add(MenuItemData(
      uuid: militaryGuaranteeService,
      title: 'ضمانت‌نامه نظام وظیفه',
      subtitle: 'ثبت ضمانت‌نامه',
      order: 18,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));

    menuDataModel.tobankServices.add(MenuItemData(
      uuid: cbsService,
      title: 'اعتبارسنجی',
      subtitle: 'اعتبارسنجی خود و سایرین',
      order: 12,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.tobankServices.add(MenuItemData(
      uuid: promissoryService,
      title: 'سفته و برات آنلاین',
      subtitle: 'صدور و خدمات',
      order: 13,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));

    menuDataModel.tobankServices.add(MenuItemData(
      uuid: azkiService,
      title: 'ازکی وام',
      subtitle: 'امضای قرارداد ازکی',
      order: 14,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));
    //*********************** */

    menuDataModel.facilityServices.add(MenuItemData(
      uuid: marriageLoanService,
      title: 'تسهیلات ازدواج',
      subtitle: 'تکمیل مدارک درخواست اولیه',
      order: 8,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));

    menuDataModel.facilityServices.add(MenuItemData(
      uuid: creditCardLoanService,
      title: 'تسهیلات کارت اعتباری',
      subtitle: 'تکمیل مدارک درخواست اولیه',
      message: '',
      order: 12,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));

    menuDataModel.facilityServices.add(MenuItemData(
      uuid: rayanCardService,
      title: 'تسهیلات رایان کارت',
      subtitle: 'تکمیل مدارک درخواست اولیه',
      message: '',
      order: 14,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));

    menuDataModel.facilityServices.add(MenuItemData(
      uuid: childrenLoanService,
      title: 'تسهیلات فرزندآوری',
      subtitle: 'تکمیل مدارک درخواست اولیه',
      order: 15,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));

    menuDataModel.facilityServices.add(MenuItemData(
      uuid: tobankMicroLendingLoanService,
      title: 'توربو وام',
      subtitle: 'تکمیل مدارک درخواست اولیه',
      message: '',
      order: 20,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));
    menuDataModel.facilityServices.add(MenuItemData(
      uuid: retailLoanService,
      title: 'تسهیلات خرد',
      subtitle: 'تکمیل مدارک درخواست اولیه',
      message: '',
      order: 19,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));
    menuDataModel.facilityServices.add(MenuItemData(
      uuid: parsaLoanService,
      title: 'تسهیلات پارسا',
      subtitle: '۲٪ یا ۴٪ سالانه',
      message: '',
      order: 20,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: true,
    ));

    //*********************** */

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: cardToCardService,
      title: 'کارت به کارت',
      order: 1,
      message: '',
      requireCard: false,
      requireNationalCode: false,
      isDisable: false,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: cardBalanceService,
      title: 'موجودی',
      order: 2,
      message: '',
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: simChargeService,
      title: 'شارژ',
      order: 3,
      message: '',
      isDisable: false,
      requireNationalCode: false,
      requireCard: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: internetService,
      title: 'بسته اینترنت',
      order: 4,
      message: '',
      isDisable: false,
      requireNationalCode: false,
      requireCard: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: giftCardService,
      title: 'کارت هدیه',
      order: 5,
      message: '',
      isDisable: false,
      requireNationalCode: false,
      requireCard: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: charityService,
      title: 'نیکوکاری',
      order: 6,
      message: '',
      isDisable: false,
      requireNationalCode: false,
      requireCard: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: invoiceService,
      title: 'قبض',
      order: 7,
      message: '',
      isDisable: false,
      requireNationalCode: false,
      requireCard: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: paymentAcceptorService,
      title: 'پذیرندگی',
      subtitle: '',
      order: 10,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: iranTicService,
      title: 'ایران تیک',
      subtitle: '',
      order: 11,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: iranConcertService,
      title: 'ایران کنسرت',
      subtitle: '',
      order: 12,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: honarTicketService,
      title: 'هنر تیکت',
      subtitle: '',
      order: 13,
      isDisable: false,
      requireCard: false,
      requireNationalCode: true,
      requireDeposit: false,
    ));
    //*********************** */

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: pichakService,
      title: 'چک صیادی',
      order: 1,
      message: '',
      isDisable: false,
      requireCard: true,
      requireNationalCode: true,
      requireDeposit: false,
    ));

    menuDataModel.paymentServices.add(MenuItemData(
      uuid: megagashtService,
      title: 'خدمات سفر',
      order: 3,
      message: '',
      isDisable: false,
      requireNationalCode: false,
      requireCard: true,
    ));

    //*********************** */

    menuDataModel.customerClub = MenuItemData(
      uuid: customerClubService,
      title: 'باشگاه مشتریان',
      order: 1,
      message: '',
      requireNationalCode: false,
      isDisable: false,
      requireCard: false,
      requireDeposit: false,
    );

    return menuDataModel;
  }

  static List<PromissoryItemData> getPromissoryServiceItemList() {
    final List<PromissoryItemData> items = [];
    items.add(PromissoryItemData(
        title: 'صدور سفته',
        subtitle: 'صدور سفته آنلاین',
        icon: SvgIcons.promissoryRequest,
        iconDark: SvgIcons.promissoryRequestDark,
        eventId: 1));
    items.add(PromissoryItemData(
        title: 'ضمانت سفته',
        subtitle: 'بدون پرداخت وجه برای ضمانت‌کننده',
        icon: SvgIcons.promissoryGuarantee,
        iconDark: SvgIcons.promissoryGuaranteeDark,
        eventId: 5));
    items.add(PromissoryItemData(
        title: 'استعلام سفته',
        subtitle: 'مشاهده جزئیات سفته',
        icon: SvgIcons.promissoryInquiry,
        iconDark: SvgIcons.promissoryInquiryDark,
        eventId: 6));
    // TODO: Add Endorsement
    // TODO: Add Settlement
    // TODO: Add Gradual Settlement
    return items;
  }

  static List<PromissoryItemData> getMyPromissoryItemList() {
    final List<PromissoryItemData> items = [];
    items.add(PromissoryItemData(
        title: 'تکمیل شده',
        subtitle: '',
        icon: SvgIcons.promissoryRequestHistory,
        iconDark: SvgIcons.promissoryRequestHistory,
        eventId: 3));
    items.add(PromissoryItemData(
        title: 'در انتظار تکمیل',
        subtitle: '',
        icon: SvgIcons.promissoryFinalizeHistory,
        iconDark: SvgIcons.promissoryFinalizeHistory,
        eventId: 2));
    return items;
  }

  static List<PromissoryFinalizedRoleTypeFilterItemData> roleFilterList() {
    final List<PromissoryFinalizedRoleTypeFilterItemData> items = [];
    items.add(PromissoryFinalizedRoleTypeFilterItemData(title: 'صدور', promissoryRoleType: PromissoryRoleType.issuer));
    items.add(
        PromissoryFinalizedRoleTypeFilterItemData(title: 'ضمانت', promissoryRoleType: PromissoryRoleType.guarantor));
    items.add(PromissoryFinalizedRoleTypeFilterItemData(
      title: 'دریافت',
      promissoryRoleType: PromissoryRoleType.currentOwner,
    ));
    items.add(PromissoryFinalizedRoleTypeFilterItemData(
        title: 'انتقال', promissoryRoleType: PromissoryRoleType.previousOwner));

    return items;
  }

  static List<ServiceItemData> getCardServicesItems() {
    final List<ServiceItemData> list = [];
    list.add(
      ServiceItemData(
        title: 'رمز اول',
        icon: SvgIcons.cardServicePasswordChange,
        iconDark: SvgIcons.cardServicePasswordChangeDark,
        eventCode: 1,
      ),
    );
    list.add(
      ServiceItemData(
        title: 'رمز دوم',
        icon: SvgIcons.cardServicePasswordChange,
        iconDark: SvgIcons.cardServicePasswordChangeDark,
        eventCode: 2,
      ),
    );
    list.add(
      ServiceItemData(
        title: 'کارت المثنی',
        icon: SvgIcons.cardServiceReissue,
        iconDark: SvgIcons.cardServiceReissueDark,
        eventCode: 3,
      ),
    );
    list.add(
      ServiceItemData(
        title: 'مسدودسازی',
        icon: SvgIcons.cardServiceBlock,
        iconDark: SvgIcons.cardServiceBlockDark,
        eventCode: 4,
      ),
    );
    return list;
  }

  static List<ServiceItemData> getExtraCardServicesItems(bool isGardeshgary) {
    final List<ServiceItemData> list = [];
    list.add(
      ServiceItemData(
        title: 'کارت به کارت',
        icon: SvgIcons.cardToCard,
        iconDark: SvgIcons.cardToCardDark,
        eventCode: 1,
      ),
    );
    if (!isGardeshgary) {
      list.add(
        ServiceItemData(
          title: 'موجودی',
          icon: SvgIcons.cardBalance,
          iconDark: SvgIcons.cardBalanceDark,
          eventCode: 2,
        ),
      );
    }
    return list;
  }

  static List<ServiceItemData> getWalletServicesItems() {
    final List<ServiceItemData> list = [];
    list.add(
      ServiceItemData(
        title: 'افزایش موجودی',
        icon: SvgIcons.cardService,
        iconDark: SvgIcons.cardServiceDark,
        eventCode: 7,
      ),
    );
    list.add(
      ServiceItemData(
        title: 'انتقال وجه',
        icon: SvgIcons.cardService,
        iconDark: SvgIcons.cardServiceDark,
        eventCode: 8,
      ),
    );
    return list;
  }

  static List<SettingsItemData> getSettingItems() {
    final List<SettingsItemData> settingsItemDataList = [];
    settingsItemDataList.add(SettingsItemData(
      icon: SvgIcons.changePin,
      iconDark: SvgIcons.changePinDark,
      title: 'تغییر رمز عبور',
      event: 1,
    ));
    settingsItemDataList.add(SettingsItemData(
      icon: SvgIcons.deleteAccount,
      iconDark: SvgIcons.deleteAccountDark,
      title: 'حذف اطلاعات حساب‌کاربری',
      event: 2,
    ));

    settingsItemDataList.add(SettingsItemData(
      icon: SvgIcons.logout,
      iconDark: SvgIcons.logoutDark,
      title: 'خروج از حساب‌کاربری',
      event: 3,
    ));
    return settingsItemDataList;
  }

  static List<ThemeItemData> getThemeDataList() {
    final List<ThemeItemData> themeDataList = [];
    themeDataList.add(ThemeItemData(title: 'حالت روز', code: 'light'));
    themeDataList.add(ThemeItemData(title: 'حالت شب', code: 'dark'));
    themeDataList.add(ThemeItemData(title: 'پیش‌فرض سیستم‌عامل', code: 'system'));
    return themeDataList;
  }

  static List<String> getCardPrimaryPasswordServicesDataList() {
    final List<String> list = [
      'دریافت رمز اول',
      'تغییر رمز اول',
    ];
    return list;
  }

  static List<String> getCardSecondaryPasswordServicesDataList() {
    final List<String> list = [
      'دریافت رمز دوم',
      'تغییر رمز دوم',
    ];
    return list;
  }

  static List<PinTypeData> getPrimaryPinTypeDataList() {
    final List<PinTypeData> pinTypeDataList = [];
    pinTypeDataList.add(PinTypeData(
      eventId: 1,
      title: 'دریافت رمز اول',
      icon: SvgIcons.getPin,
      iconDark: SvgIcons.getPinDark,
    ));
    pinTypeDataList.add(PinTypeData(
      eventId: 2,
      title: 'تغییر رمز اول',
      icon: SvgIcons.changeCardPin,
      iconDark: SvgIcons.changeCardPinDark,
    ));
    return pinTypeDataList;
  }

  static List<PinTypeData> getSecondaryPinTypeDataList() {
    final List<PinTypeData> pinTypeDataList = [];
    pinTypeDataList.add(PinTypeData(
      eventId: 1,
      title: 'دریافت رمز دوم',
      icon: SvgIcons.getPin,
      iconDark: SvgIcons.getPinDark,
    ));
    pinTypeDataList.add(PinTypeData(
      eventId: 2,
      title: 'تغییر رمز دوم',
      icon: SvgIcons.changeCardPin,
      iconDark: SvgIcons.changeCardPinDark,
    ));
    return pinTypeDataList;
  }

  static List<MilitaryGuaranteePersonTypeItemData> getMilitaryGuaranteePersonTypeList() {
    final List<MilitaryGuaranteePersonTypeItemData> items = [];
    items.add(
        MilitaryGuaranteePersonTypeItemData(title: 'خودم مشمول هستم', subtitle: '', icon: SvgIcons.myOwn, eventId: 1));
    items.add(MilitaryGuaranteePersonTypeItemData(
        title: 'فرد دیگری مشمول است', subtitle: '', icon: SvgIcons.others, eventId: 2));
    return items;
  }

  static List<CheckOwnerStatusData> getCheckOwnerStatusList() {
    final List<CheckOwnerStatusData> checkOwnerStatusList = [];
    checkOwnerStatusList.add(
      CheckOwnerStatusData(
          title: 'وضعیت سفید',
          description:
          'صادرکننده چک فاقد هرگونه سابقه چک برگشتی بوده یا در صورت وجود سابقه، تمامی موارد رفع سو اثر شده است',
          iconColor: Colors.white),
    );
    checkOwnerStatusList.add(
      CheckOwnerStatusData(
          title: 'وضعیت زرد',
          description: 'صادرکننده چک دارای یک فقره چک برگشتی یا حداکثر مبلغ ۵۰ میلیون ریال تعهد برگشتی است',
          iconColor: const Color(0xffe8e13b)),
    );
    checkOwnerStatusList.add(
      CheckOwnerStatusData(
          title: 'وضعیت نارنجی',
          description: 'صادرکننده چک دارای دو الی چهار فقره چک برگشتی یا حداکثر مبلغ ۲۰۰ میلیون ریال تعهد برگشتی است',
          iconColor: const Color(0xffffa200)),
    );
    checkOwnerStatusList.add(
      CheckOwnerStatusData(
          title: 'وضعیت قهوه‌ای',
          description: 'صادرکننده چک دارای پنج تا ده فقره چک برگشتی یا حداکثر مبلغ ۵۰۰ میلیون ریال تعهد برگشتی است',
          iconColor: const Color(0xff845f1e)),
    );
    checkOwnerStatusList.add(
      CheckOwnerStatusData(
          title: 'وضعیت قرمز',
          description: 'صادرکننده چک دارای بیش از ده فقره چک برگشتی یا بیش از مبلغ ۵۰۰ میلیون ریال تعهد برگشتی است',
          iconColor: const Color(0xffdb3434)),
    );
    return checkOwnerStatusList;
  }
}
