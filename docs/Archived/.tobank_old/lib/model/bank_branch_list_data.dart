import 'dart:convert';

List<BankBranchListData> bankBranchListDataFromJson(String str) =>
    List<BankBranchListData>.from(json.decode(str).map((x) => BankBranchListData.fromJson(x)));

String bankBranchListDataToJson(List<BankBranchListData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankBranchListData {
  int? id;
  String? faTitle;
  int? code;
  List<String>? phones;
  String? address;
  int? postalCode;
  double? long;
  double? lat;
  String? workingTime;

  BankBranchListData({
    this.id,
    this.faTitle,
    this.code,
    this.phones,
    this.address,
    this.postalCode,
    this.long,
    this.lat,
    this.workingTime,
  });

  factory BankBranchListData.fromJson(Map<String, dynamic> json) => BankBranchListData(
        id: json['id'],
        faTitle: json['fa_title'],
        code: json['code'],
        phones: json['phones'] == null ? [] : List<String>.from(json['phones']!.map((x) => x)),
        address: json['address'],
        postalCode: json['postal_code'],
        long: json['long']?.toDouble(),
        lat: json['lat']?.toDouble(),
        workingTime: json['working_time'],
      );

  Map<String, dynamic> toJson() => {
        '_2': faTitle,
        '_3': code,
        '_4': phones == null ? [] : List<dynamic>.from(phones!.map((x) => x)),
        '_5': address,
      };
}
