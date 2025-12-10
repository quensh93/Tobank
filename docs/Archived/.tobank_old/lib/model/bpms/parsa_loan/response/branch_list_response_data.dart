import 'dart:convert';

BranchListResponseData branchListResponseDataFromJson(String str) => BranchListResponseData.fromJson(json.decode(str));

String branchListResponseDataToJson(BranchListResponseData data) => json.encode(data.toJson());

class BranchListResponseData {
  String? message;
  bool? success;
  List<BranchData>? data;
  int? branchSelectedCode;

  BranchListResponseData({
    this.message,
    this.success,
    this.data,
    this.branchSelectedCode,
  });

  factory BranchListResponseData.fromJson(Map<String, dynamic> json) => BranchListResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? [] : List<BranchData>.from(json['data']!.map((x) => BranchData.fromJson(x))),
        branchSelectedCode: json['branch_selected_code'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        'branch_selected_code': branchSelectedCode,
      };
}

class BranchData {
  int? id;
  String? title;
  String? faTitle;
  int? code;
  List<Phone>? phones;
  String? address;
  int? postalCode;
  double? lat;
  double? long;
  List<WorkingTime>? workingTime;
  String? cityName;

  BranchData({
    this.id,
    this.title,
    this.faTitle,
    this.code,
    this.phones,
    this.address,
    this.postalCode,
    this.lat,
    this.long,
    this.workingTime,
    this.cityName,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
        id: json['id'],
        title: json['title'],
        faTitle: json['fa_title'],
        code: json['code'],
        phones: json['phones'] == null ? [] : List<Phone>.from(json['phones']!.map((x) => Phone.fromJson(x))),
        address: json['address'],
        postalCode: json['postal_code'],
        lat: json['lat']?.toDouble(),
        long: json['long']?.toDouble(),
        workingTime: json['working_time'] == null
            ? []
            : List<WorkingTime>.from(json['working_time']!.map((x) => WorkingTime.fromJson(x))),
        cityName: json['city_name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'fa_title': faTitle,
        'code': code,
        'phones': phones == null ? [] : List<dynamic>.from(phones!.map((x) => x.toJson())),
        'address': address,
        'postal_code': postalCode,
        'lat': lat,
        'long': long,
        'working_time': workingTime == null ? [] : List<dynamic>.from(workingTime!.map((x) => x.toJson())),
        'city_name': cityName,
      };
}

class Phone {
  String? number;
  String? numberType;

  Phone({
    this.number,
    this.numberType,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        number: json['number'],
        numberType: json['number_type'],
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'number_type': numberType,
      };
}

class WorkingTime {
  int? weekDay;
  String? weekDayFa;
  String? weekDayEn;
  String? startTime;
  String? endTime;

  WorkingTime({
    this.weekDay,
    this.weekDayFa,
    this.weekDayEn,
    this.startTime,
    this.endTime,
  });

  factory WorkingTime.fromJson(Map<String, dynamic> json) => WorkingTime(
        weekDay: json['week_day'],
        weekDayFa: json['week_day_fa'],
        weekDayEn: json['week_day_en'],
        startTime: json['start_time'],
        endTime: json['end_time'],
      );

  Map<String, dynamic> toJson() => {
        'week_day': weekDay,
        'week_day_fa': weekDayFa,
        'week_day_en': weekDayEn,
        'start_time': startTime,
        'end_time': endTime,
      };
}
