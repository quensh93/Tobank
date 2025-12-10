import 'dart:convert';

import '../../common/error_response_data.dart';
import '../../other/app_version_data.dart';

TokenData tokenDataFromJson(String str) => TokenData.fromJson(json.decode(str));

String tokenDataToJson(TokenData data) => json.encode(data.toJson());

class TokenData {
  TokenData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;
  late AppVersionData appVersionData;

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.user,
    this.available,
    this.customer,
  });

  User? user;
  bool? available;
  Customer? customer;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json['user'] == null ? null : User.fromJson(json['user']),
        available: json['available'],
        customer: Customer.fromJson(json['customer']),
      );

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'available': available,
        'customer': customer?.toJson(),
      };
}

class Customer {
  Customer({
    this.customerNumber,
    this.customerStatus,
    this.digitalBankingCustomer,
    this.firstName,
    this.gender,
    this.lastName,
    this.loyaltyCode,
    this.message,
    this.nationalCode,
    this.registrationDate,
    this.shahabCodeAcquired,
    this.status,
    this.trackingNumber,
    this.transactionId,
  });

  String? customerNumber;
  int? customerStatus;
  bool? digitalBankingCustomer;
  String? firstName;
  int? gender;
  String? lastName;
  String? loyaltyCode;
  String? message;
  String? nationalCode;
  int? registrationDate;
  bool? shahabCodeAcquired;
  int? status;
  String? trackingNumber;
  String? transactionId;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerNumber: json['customerNumber'],
        customerStatus: json['customerStatus'],
        digitalBankingCustomer: json['digitalBankingCustomer'],
        firstName: json['firstName'],
        gender: json['gender'],
        lastName: json['lastName'],
        loyaltyCode: json['loyaltyCode'],
        message: json['message'],
        nationalCode: json['nationalCode'],
        registrationDate: json['registrationDate'],
        shahabCodeAcquired: json['shahabCodeAcquired'],
        status: json['status'],
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
      );

  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'customerStatus': customerStatus,
        'digitalBankingCustomer': digitalBankingCustomer,
        'firstName': firstName,
        'gender': gender,
        'lastName': lastName,
        'loyaltyCode': loyaltyCode,
        'message': message,
        'nationalCode': nationalCode,
        'registrationDate': registrationDate,
        'shahabCodeAcquired': shahabCodeAcquired,
        'status': status,
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
      };
}

class User {
  User({
    this.avatar,
    this.birthDate,
    this.deviceUuid,
    this.expirePass,
    this.file,
    this.firstName,
    this.hasPassword,
    this.havadary,
    this.lastName,
    this.maxAmount,
    this.mobile,
    this.nationalCode,
    this.theme,
    this.token,
    this.goftinoId,
  });

  Avatar? avatar;
  String? birthDate;
  String? deviceUuid;
  bool? expirePass;
  String? file;
  String? firstName;
  bool? hasPassword;
  bool? havadary;
  String? lastName;
  int? maxAmount;
  String? mobile;
  String? nationalCode;
  String? theme;
  String? token;
  String? goftinoId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json['avatar'] == null ? null : Avatar.fromJson(json['avatar']),
        birthDate: json['birth_date'],
        deviceUuid: json['device_uuid'],
        expirePass: json['expire_pass'],
        file: json['file'],
        firstName: json['first_name'],
        hasPassword: json['has_password'],
        havadary: json['havadary'],
        lastName: json['last_name'],
        maxAmount: json['max_amount'],
        mobile: json['mobile'],
        nationalCode: json['national_code'],
        theme: json['theme'],
        token: json['token'],
        goftinoId: json['goftino_id'],
      );

  Map<String, dynamic> toJson() => {
        'avatar': avatar?.toJson(),
        'birth_date': birthDate,
        'device_uuid': deviceUuid,
        'expire_pass': expirePass,
        'file': file,
        'first_name': firstName,
        'has_password': hasPassword,
        'havadary': havadary,
        'last_name': lastName,
        'max_amount': maxAmount,
        'mobile': mobile,
        'national_code': nationalCode,
        'theme': theme,
        'token': token,
        'goftino_id': goftinoId,
      };
}

class Avatar {
  Avatar({
    this.avatar,
    this.id,
    this.title,
  });

  String? avatar;
  int? id;
  String? title;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        avatar: json['avatar'],
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'id': id,
        'title': title,
      };
}
