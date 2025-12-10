import 'token_data.dart';

class ProfileData {
  ProfileData({
    this.data,
    this.message,
    this.success,
  });

  MainData? data;
  String? message;
  bool? success;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        data: MainData.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class MainData {
  MainData({
    this.birthDate,
    this.expirePass,
    this.file,
    this.firstName,
    this.lastName,
    this.maxAmount,
    this.mobile,
    this.nationalId,
    this.avatarId,
    this.avatar,
    this.goftinoId,
  });

  Avatar? avatar;
  String? birthDate;
  bool? expirePass;
  String? file;
  String? firstName;
  String? lastName;
  int? maxAmount;
  String? mobile;
  String? nationalId;
  int? avatarId;
  String? goftinoId;

  factory MainData.fromJson(Map<String, dynamic> json) => MainData(
        avatar: json['avatar'] == null ? null : Avatar.fromJson(json['avatar']),
        birthDate: json['birth_date'],
        expirePass: json['expire_pass'],
        file: json['file'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        maxAmount: json['max_amount'],
        mobile: json['mobile'],
        nationalId: json['national_id'],
        avatarId: json['avatar_id'],
        goftinoId: json['goftino_id'],
      );
}
