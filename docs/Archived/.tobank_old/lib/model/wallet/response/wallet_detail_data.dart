import 'dart:convert';

import '../../card/card_data_model.dart';
import '../../card/response/customer_card_response_data.dart';
import '../../common/error_response_data.dart';
import '../../other/app_version_data.dart';

WalletDetailData walletDetailDataFromJson(String str) => WalletDetailData.fromJson(json.decode(str));

String walletDetailDataToJson(WalletDetailData data) => json.encode(data.toJson());

class WalletDetailData {
  WalletDetailData({
    this.data,
    this.message,
    this.success,
  });

  WalletInfo? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;
  late AppVersionData appVersionData;

  factory WalletDetailData.fromJson(Map<String, dynamic> json) => WalletDetailData(
        data: json['data'] == null ? null : WalletInfo.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class WalletInfo {
  WalletInfo({
    this.amount,
    this.availableTransactionGift,
    this.customerClub,
    this.deviceUuid,
    this.hasAnyCards,
    this.havadary,
    this.lastestMenuUpdate,
    this.maxAmount,
    this.isDirectOtpActive,
    this.theme,
    this.unreadMessageCount,
    this.user,
    this.cardDefault,
    this.zoomId,
  });

  int? amount;
  bool? availableTransactionGift;
  CustomerClub? customerClub;
  String? deviceUuid;
  bool? hasAnyCards;
  bool? havadary;
  String? lastestMenuUpdate;
  int? maxAmount;
  bool? isDirectOtpActive;
  String? theme;
  int? unreadMessageCount;
  User? user;
  CardDataModel? cardDefault;
  ZoomIdData? zoomId;
  CustomerCard? customerCardDefault;

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
        amount: json['amount'],
        availableTransactionGift: json['available_transaction_gift'],
        customerClub: json['customer_club'] == null ? null : CustomerClub.fromJson(json['customer_club']),
        deviceUuid: json['device_uuid'],
        hasAnyCards: json['has_any_cards'],
        havadary: json['havadary'],
        lastestMenuUpdate: json['lastest_menu_update'],
        maxAmount: json['max_amount'],
        isDirectOtpActive: json['is_direct_otp_active'],
        theme: json['theme'],
        unreadMessageCount: json['unread_message_count'],
        user: json['user'] == null ? null : User.fromJson(json['user']),
        cardDefault: json['card_default'] == null ? null : CardDataModel.fromJson(json['card_default']),
        zoomId: json['zoom_id'] == null ? null : ZoomIdData.fromJson(json['zoom_id']),
      );

  Map<String, dynamic> toJson() =>
      {
        'amount': amount,
        'available_transaction_gift': availableTransactionGift,
        'customer_club': customerClub?.toJson(),
        'device_uuid': deviceUuid,
        'has_any_cards': hasAnyCards,
        'havadary': havadary,
        'lastest_menu_update': lastestMenuUpdate,
        'max_amount': maxAmount,
        'is_direct_otp_active': isDirectOtpActive,
        'theme': theme,
        'unread_message_count': unreadMessageCount,
        'user': user?.toJson(),
        'card_default': cardDefault?.toJson(),
        'zoom_id': zoomId?.toJson(),
      };
}

class CustomerClub {
  CustomerClub({
    this.point,
    this.role,
    this.roleLocal,
  });

  String? point;
  String? role;
  String? roleLocal;

  factory CustomerClub.fromJson(Map<String, dynamic> json) => CustomerClub(
        point: json['point'],
        role: json['role'],
        roleLocal: json['role_local'],
      );

  Map<String, dynamic> toJson() => {
        'point': point,
        'role': role,
        'role_local': roleLocal,
      };
}

class User {
  User({
    this.birthDate,
    this.firstName,
    this.lastName,
    this.nationalCode,
    this.goftinoId,
  });

  String? birthDate;
  String? firstName;
  String? lastName;
  String? nationalCode;
  String? goftinoId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        birthDate: json['birth_date'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        nationalCode: json['national_code'],
        goftinoId: json['goftino_id'],
      );

  Map<String, dynamic> toJson() => {
        'birth_date': birthDate,
        'first_name': firstName,
        'last_name': lastName,
        'national_code': nationalCode,
        'goftino_id': goftinoId,
      };
}

class ZoomIdData {
  ZoomIdData({
    this.zoomIdLicenseAndroid,
    this.zoomIdLicenseIos,
  });

  String? zoomIdLicenseAndroid;
  String? zoomIdLicenseIos;

  factory ZoomIdData.fromJson(Map<String, dynamic> json) => ZoomIdData(
        zoomIdLicenseAndroid: json['zoomid_license_android'],
        zoomIdLicenseIos: json['zoomid_license_ios'],
      );

  Map<String, dynamic> toJson() => {
        'zoomid_license_android': zoomIdLicenseAndroid,
        'zoomid_license_ios': zoomIdLicenseIos,
      };
}
