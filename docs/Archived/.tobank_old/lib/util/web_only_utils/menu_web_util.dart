import 'dart:convert';

abstract class MenuWebUtil {
  static const String _menuWebJson = '''
{
  "tobank_services": [
    {
      "title": "خدمات موبایل بانک",
      "subtitle": "فعال‌سازی خدمات و صدور رمز",
      "uuid": "134e24cc-fcca-4673-92cb-65ae5db4ce17",
      "order": 6,
      "message": "",
      "is_disable": false,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "خدمات اینترنت بانک",
      "subtitle": "فعال‌سازی خدمات و صدور رمز",
      "uuid": "ad387ef5-ed46-4341-abd4-d01ea5a35562",
      "order": 7,
      "message": "",
      "is_disable": false,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "صندوق امانات",
      "subtitle": "اجاره صندوق، رزرو زمان بازدید",
      "uuid": "273dfc4b-977a-4ddc-a493-346887113590",
      "order": 11,
      "message": "",
      "is_disable": false,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "ضمانت‌نامه نظام وظیفه",
      "subtitle": "ثبت ضمانت‌نامه",
      "uuid": "a438cc47-8d39-43bc-af55-67f0782e3bf1",
      "order": 18,
      "message": "",
      "is_disable": true,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": true,
      "child": []
    },
    {
      "title": "اعتبارسنجی",
      "subtitle": "اعتبارسنجی خود و سایرین",
      "uuid": "a8f3f7f5-654f-48ea-8742-edfb736aa892",
      "order": 12,
      "message": "سرویس اعتبارسنجی در حال حاضر در دسترس نیست",
      "is_disable": true,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "سفته آنلاین",
      "subtitle": "صدور و خدمات",
      "uuid": "7edd4156-e911-4cc1-9dab-05d3d00765b4",
      "order": 13,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": true,
      "child": []
    },
    {
      "title": "ازکی وام",
      "subtitle": "امضای قرارداد ازکی",
      "uuid": "d9a63cdc-60f6-4759-aa2f-1759d7074e7c",
      "order": 14,
      "message": "",
      "is_disable": false,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": true,
      "child": []
    }
  ],
  "facility_services": [
    {
      "title": "تسهیلات ازدواج",
      "subtitle": "تکمیل مدارک درخواست اولیه",
      "uuid": "615adac8-78f1-48b8-97e4-2e846c4c0154",
      "order": 2,
      "message": "سرویس تسهیلات ازدواج در حال حاضر در دسترس نیست",
      "is_disable": false,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": true,
      "child": []
    },
    {
      "title": "تسهیلات کارت اعتباری",
      "subtitle": "تکمیل مدارک درخواست اولیه",
      "uuid": "922cde78-1427-4c8f-99e7-3979268deb04",
      "order": 4,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": true,
      "child": []
    },
    {
      "title": "تسهیلات فرزندآوری",
      "subtitle": "تکمیل مدارک درخواست اولیه",
      "uuid": "088dc15c-4f34-49ee-97c5-5fecbad97149",
      "order": 3,
      "message": "سرویس تسهیلات فرزندآوری در حال حاضر در دسترس نیست",
      "is_disable": false,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": true,
      "child": []
    },
    {
      "title": "توربو وام",
      "subtitle": "تکمیل مدارک درخواست اولیه",
      "uuid": "673277fd-a078-4e63-a4ca-963f44825251",
      "order": 1,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": true,
      "child": []
    },
    {
      "title": "تسهیلات پارسا",
      "subtitle": "۲٪ یا ۴٪ سالانه",
      "uuid": "69aa2ae6-7891-4a73-83d6-2e29053b1192",
      "order": 20,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": true,
      "child": []
    },
    {
      "title": "پرداخت اقساط",
      "subtitle": "مشاهده تسهیلات و پرداخت",
      "uuid": "676f9acb-327a-4ed9-af8d-7f82725386ad",
      "order": 21,
      "message": "سرویس پرداخت تسهیلات در حال حاضر در دسترس نیست",
      "is_disable": true,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": false,
      "child": []
    }
  ],
  "payment_services": [
    {
      "title": "کارت به کارت",
      "subtitle": null,
      "uuid": "59874b9a-7ece-44c1-9176-8294cb8779f6",
      "order": 1,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": false,
      "require_card": false,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "چک صیادی",
      "subtitle": null,
      "uuid": "c18c84bf-266c-4727-a22e-a38c96ceadec",
      "order": 2,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": true,
      "require_card": true,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "موجودی",
      "subtitle": null,
      "uuid": "52d32be3-cbe2-434f-a28a-0c0d9b1c75d5",
      "order": 3,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "شارژ",
      "subtitle": null,
      "uuid": "ef77c542-6f76-41ac-a715-c5b337c3b486",
      "order": 4,
      "message": "سرویس شارژ در حال حاضر در دسترس نیست",
      "is_disable": true,
      "require_national_code": false,
      "require_card": true,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "بسته اینترنت",
      "subtitle": null,
      "uuid": "cea2a830-23d7-4f15-8c2b-cea2ade50834",
      "order": 5,
      "message": "سرویس بسته اینترنت در حال حاضر در دسترس نیست",
      "is_disable": true,
      "require_national_code": false,
      "require_card": true,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "خدمات سفر",
      "subtitle": null,
      "uuid": "a9a45f2e-b5d5-4f87-be8c-cf019460beaa",
      "order": 6,
      "message": "",
      "is_disable": false,
      "require_national_code": false,
      "require_card": true,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "کارت هدیه",
      "subtitle": null,
      "uuid": "837f763b-ab46-43b4-84b5-613f0c34ae23",
      "order": 7,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": false,
      "require_card": true,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "قبض",
      "subtitle": null,
      "uuid": "b3c3fccb-1f65-483f-8186-4cd73d10e778",
      "order": 9,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": false,
      "require_card": true,
      "require_deposit": false,
      "child": []
    },
    {
      "title": "پذیرندگی",
      "subtitle": "",
      "uuid": "3c05cb9f-e952-40cd-b7c8-9a7f007545fb",
      "order": 10,
      "message": "این سرویس به زودی در دسترس خواهد بود",
      "is_disable": true,
      "require_national_code": true,
      "require_card": false,
      "require_deposit": false,
      "child": []
    }
  ],
  "citizen_services": [],
  "daran_service": {
    "title": "صندوق سرمایه‌گذاری ازکی‌سرمایه",
    "subtitle": null,
    "uuid": "e9eee3ff-eb45-4041-b2c0-71694c1123a2",
    "order": 2,
    "message": "این سرویس به زودی در دسترس خواهد بود",
    "is_disable": false,
    "require_national_code": true,
    "require_card": true,
    "require_deposit": false,
    "child": []
  },
  "customer_club": {
    "title": "باشگاه مشتریان",
    "subtitle": null,
    "uuid": "ddfab471-da33-4638-8755-c671618f15de",
    "order": 1,
    "message": "سرویس باشگاه مشتریان در حال حاضر در دسترس نیست",
    "is_disable": false,
    "require_national_code": false,
    "require_card": false,
    "require_deposit": false,
    "child": [
      {
        "title": "پیش‌بینی مسابقات فوتبال (توپ بانک)",
        "subtitle": "درست پیش‌بینی کن و جایزه ببر!",
        "uuid": "cc54e071-8d16-458a-8bad-29873ea3af78",
        "order": 2,
        "message": "",
        "is_disable": false,
        "require_national_code": false,
        "require_card": false,
        "require_deposit": false,
        "child": []
      },
      {
        "title": "دریافت کد تخفیف",
        "subtitle": "نماوا، فیلیمو، تخفیفان و ...",
        "uuid": "f7923477-96fa-479f-bbb8-cca79c866037",
        "order": 3,
        "message": "به زودی",
        "is_disable": true,
        "require_national_code": false,
        "require_card": false,
        "require_deposit": false,
        "child": []
      },
      {
        "title": "نحوه دریافت امتیاز",
        "subtitle": "نحوه امتیازگیری در باشگاه مشتریان",
        "uuid": "da5aeff3-9f86-41ff-b4fe-5ec5476b5244",
        "order": 4,
        "message": "به زودی",
        "is_disable": true,
        "require_national_code": false,
        "require_card": false,
        "require_deposit": false,
        "child": []
      },
      {
        "title": "سابقه امتیازها",
        "subtitle": "امتیازهای دریافتی و پرداختی",
        "uuid": "c01ae467-0f14-4f86-bda7-0ecc248221c9",
        "order": 5,
        "message": "به زودی",
        "is_disable": true,
        "require_national_code": false,
        "require_card": false,
        "require_deposit": false,
        "child": []
      },
      {
        "title": "قرعه‌کشی",
        "subtitle": "دریافت شانس و نتایج قرعه‌کشی",
        "uuid": "a2215f1d-63be-4122-a28f-a7bb169e4407",
        "order": 6,
        "message": "به زودی",
        "is_disable": true,
        "require_national_code": false,
        "require_card": false,
        "require_deposit": false,
        "child": []
      }
    ]
  },
  "banner_data": {
    "uuid": "d5106dd8-8e59-4dfd-94cc-b1e2d8a2ecc0",
    "interval": 2000,
    "is_loop": true,
    "show_dismiss": false,
    "min_height": 110.0,
    "banner_item_list": [
      {
        "type": "externalUrl",
        "url": "https://www.tourismbank.ir/s/mfabMvr",
        "image_url": "/media/banners/nikan.jpeg",
        "event_code": null,
        "is_disable": false,
        "message": "",
        "screen_title": ""
      },
      {
        "type": "externalUrl",
        "url": "https://www.sheyda.com/?utm_source=tobank&utm_medium=referral&utm_campaign=app-banner-404-5",
        "image_url": "/media/banners/ajal_moalagh.JPG",
        "event_code": null,
        "is_disable": false,
        "message": "",
        "screen_title": ""
      },
      {
        "type": "externalUrl",
        "url": "https://www.sheyda.com/?utm_source=tobank&utm_medium=referral&utm_campaign=app-banner-404-5",
        "image_url": "/media/banners/new-sheyda.jpeg",
        "event_code": null,
        "is_disable": false,
        "message": "",
        "screen_title": ""
      }
    ]
  }
}
''';

  // Method to get the menu data as a Map
  static Map<String, dynamic> getMenuData() {
    return jsonDecode(_menuWebJson);
  }
}
