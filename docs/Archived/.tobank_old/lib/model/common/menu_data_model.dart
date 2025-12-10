import 'dart:convert';

MenuDataModel menuDataModelFromJson(String str) => MenuDataModel.fromJson(json.decode(str));

String menuDataModelToJson(MenuDataModel data) => json.encode(data.toJson());

class MenuDataModel {
  MenuDataModel({
    required this.facilityServices,
    required this.tobankServices,
    required this.paymentServices,
    required this.citizenServices,
    this.daranService,
    this.customerClub,
    this.bannerData,
  });

  List<MenuItemData> facilityServices = [];
  List<MenuItemData> tobankServices = [];
  List<MenuItemData> paymentServices = [];
  List<MenuItemData> citizenServices = [];
  MenuItemData? daranService;
  MenuItemData? customerClub;
  BannerData? bannerData;

  factory MenuDataModel.fromJson(Map<String, dynamic> json) => MenuDataModel(
        tobankServices: json['tobank_services'] == null
            ? []
            : List<MenuItemData>.from(json['tobank_services'].map((x) => MenuItemData.fromJson(x))),
        facilityServices: json['facility_services'] == null
            ? []
            : List<MenuItemData>.from(json['facility_services'].map((x) => MenuItemData.fromJson(x))),
        paymentServices: json['payment_services'] == null
            ? []
            : List<MenuItemData>.from(json['payment_services'].map((x) => MenuItemData.fromJson(x))),
        citizenServices: json['citizen_services'] == null
            ? []
            : List<MenuItemData>.from(json['citizen_services'].map((x) => MenuItemData.fromJson(x))),
        daranService: json['daran_service'] == null ? null : MenuItemData.fromJson(json['daran_service']),
        customerClub: json['customer_club'] == null ? null : MenuItemData.fromJson(json['customer_club']),
        bannerData: json['banner_data'] == null ? null : BannerData.fromJson(json['banner_data']),
      );

  Map<String, dynamic> toJson() => {
        'tobank_services': List<dynamic>.from(tobankServices.map((x) => x.toJson())),
        'facility_services': List<dynamic>.from(facilityServices.map((x) => x.toJson())),
        'payment_services': List<dynamic>.from(paymentServices.map((x) => x.toJson())),
        'citizen_services': List<dynamic>.from(citizenServices.map((x) => x.toJson())),
        'daran_service': daranService?.toJson(),
        'customer_club': customerClub?.toJson(),
        'banner_data': bannerData?.toJson(),
      };
}

class MenuItemData {
  MenuItemData({
    required this.uuid,
    this.title,
    this.subtitle,
    this.order,
    this.message,
    this.isDisable,
    this.requireNationalCode,
    this.requireCard,
    this.requireDeposit,
    this.child,
  });

  String? uuid;
  String? title;
  String? subtitle;
  int? order;
  String? message;
  bool? isDisable;
  bool? requireNationalCode;
  bool? requireCard;
  bool? requireDeposit;
  List<MenuItemData>? child;

  factory MenuItemData.fromJson(Map<String, dynamic> json) => MenuItemData(
        uuid: json['uuid'],
        title: json['title'],
        subtitle: json['subtitle'],
        order: json['order'],
        message: json['message'],
        isDisable: json['is_disable'],
        requireNationalCode: json['require_national_code'],
        requireCard: json['require_card'],
        requireDeposit: json['require_deposit'] ?? false,
        child:
            json['child'] == null ? null : List<MenuItemData>.from(json['child'].map((x) => MenuItemData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'subtitle': subtitle,
        'order': order,
        'message': message,
        'is_disable': isDisable,
        'require_national_code': requireNationalCode,
        'require_card': requireCard,
        'require_deposit': requireDeposit,
        'child': child == null ? null : List<dynamic>.from(child!.map((x) => x.toJson())),
      };
}

class BannerData {
  String? uuid;
  int interval;
  bool isLoop;
  bool showDismiss;
  double minHeight;
  List<BannerItem>? bannerItemList = [];

  BannerData({
    required this.interval,
    required this.isLoop,
    required this.showDismiss,
    required this.minHeight,
    this.uuid,
    this.bannerItemList,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        uuid: json['uuid'],
        interval: json['interval'] ?? 10000,
        isLoop: json['is_loop'] ?? true,
        showDismiss: json['show_dismiss'] ?? true,
        minHeight: json['min_height'] ?? 200,
        bannerItemList: json['banner_item_list'] == null
            ? []
            : List<BannerItem>.from(json['banner_item_list'].map((x) => BannerItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'interval': interval,
        'is_loop': isLoop,
        'show_dismiss': showDismiss,
        'min_height': minHeight,
        'banner_item_list': bannerItemList == null ? null : List<dynamic>.from(bannerItemList!.map((x) => x.toJson())),
      };
}

class BannerItem {
  String? type;
  String? url;
  String? imageUrl;
  String? eventCode;
  bool? isDisable;
  String? message;
  String? screenTitle;

  BannerItem({
    this.type,
    this.url,
    this.imageUrl,
    this.eventCode,
    this.isDisable,
    this.message,
    this.screenTitle,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
        type: json['type'],
        url: json['url'],
        imageUrl: json['image_url'],
        eventCode: json['event_code'],
        isDisable: json['is_disable'],
        message: json['message'],
        screenTitle: json['screen_title'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
        'image_url': imageUrl,
        'event_code': eventCode,
        'is_disable': isDisable,
        'message': message,
        'screen_title': screenTitle,
      };
}
