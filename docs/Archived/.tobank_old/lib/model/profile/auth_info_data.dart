import 'dart:convert';

import '../../util/enums_constants.dart';
import 'response/token_data.dart';

AuthInfoData authInfoFromJson(String str) => AuthInfoData.fromJson(json.decode(str));

String authInfoToJson(AuthInfoData data) => json.encode(data.toJson());

class AuthInfoData {
  String? mobile;
  String? firstName;
  String? lastName;
  String? token;
  int? maxAmount;
  String? imageUrl;
  String? nationalCode;
  String? uuid;
  Avatar? avatar;
  String? deviceUUID;
  String? birthdayDate;
  String? customerNumber;
  String? shahabCodeAcquired;
  int? shabahangCustomerStatus;
  bool? digitalBankingCustomer;
  bool? virtualBranchIsRegistered;
  VirtualBranchStatus? virtualBranchStatus;
  String? ekycDeviceId;
  String? publicKey;
  bool? isSajamVerify;
  String? fcmToken;
  String? zoomIdLicenseAndroid;
  String? zoomIdLicenseIos;
  String? goftinoId;
  String? loyaltyCode;

  AuthInfoData({
    this.mobile,
    this.firstName,
    this.lastName,
    this.token,
    this.maxAmount,
    this.imageUrl,
    this.nationalCode,
    this.uuid,
    this.avatar,
    this.deviceUUID,
    this.customerNumber,
    this.shahabCodeAcquired,
    this.birthdayDate,
    this.shabahangCustomerStatus,
    this.digitalBankingCustomer,
    this.virtualBranchIsRegistered,
    this.virtualBranchStatus,
    this.ekycDeviceId,
    this.publicKey,
    this.isSajamVerify,
    this.fcmToken,
    this.zoomIdLicenseAndroid,
    this.zoomIdLicenseIos,
    this.goftinoId,
    this.loyaltyCode,
  });

  factory AuthInfoData.fromJson(Map<String, dynamic> json) => AuthInfoData(
        mobile: json['mobile'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        token: json['token'],
        maxAmount: json['max_amount'],
        imageUrl: json['file'],
        nationalCode: json['national_code'],
        uuid: json['uuid'],
        avatar: json['avatar'] == null ? null : Avatar.fromJson(json['avatar']),
        deviceUUID: json['device_uuid'],
        customerNumber: json['customer_number'],
        shahabCodeAcquired: json['shahab_code_acquired'],
        birthdayDate: json['birthday_date'],
        shabahangCustomerStatus: json['shabahang_customer_status'],
        digitalBankingCustomer: json['digital_banking_customer'],
        virtualBranchIsRegistered: json['shabahang_registered'],
        virtualBranchStatus:
            json['virtual_branch_status'] == null ? null : VirtualBranchStatus.values[json['virtual_branch_status']],
        ekycDeviceId: json['ekyc_device_id'],
        publicKey: json['public_key'],
        isSajamVerify: json['isSajamVerify'],
        fcmToken: json['fcm_token'],
        zoomIdLicenseAndroid: json['zoomIdLicenseAndroid'],
        zoomIdLicenseIos: json['zoomIdLicenseIos'],
        goftinoId: json['goftino_id'],
        loyaltyCode: json['loyalty_code'],
      );

  Map<String, dynamic> toJson() =>
      {
        'mobile': mobile,
        'first_name': firstName,
        'last_name': lastName,
        'token': token,
        'max_amount': maxAmount,
        'file': imageUrl,
        'national_code': nationalCode,
        'uuid': uuid,
        'avatar': avatar?.toJson(),
        'device_uuid': deviceUUID,
        'customer_number': customerNumber,
        'shahab_code_acquired': shahabCodeAcquired,
        'birthday_date': birthdayDate,
        'shabahang_customer_status': shabahangCustomerStatus,
        'digital_banking_customer': digitalBankingCustomer,
        'shabahang_registered': virtualBranchIsRegistered,
        'virtual_branch_status': virtualBranchStatus?.index,
        'ekyc_device_id': ekycDeviceId,
        'public_key': publicKey,
        'isSajamVerify': isSajamVerify,
        'fcm_token': fcmToken,
        'zoomIdLicenseAndroid': zoomIdLicenseAndroid,
        'zoomIdLicenseIos': zoomIdLicenseIos,
        'goftino_id': goftinoId,
        'loyalty_code': loyaltyCode,
      };
}
