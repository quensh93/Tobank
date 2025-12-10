import 'dart:convert';

CustomMatchContact customMatchContactFromJson(String str) => CustomMatchContact.fromJson(json.decode(str));

String customMatchContactToJson(CustomMatchContact data) => json.encode(data.toJson());

class CustomMatchContact {
  String? displayName;
  String? givenName;
  String? familyName;
  String? phone;

  CustomMatchContact({
    this.displayName,
    this.givenName,
    this.familyName,
    this.phone,
  });

  factory CustomMatchContact.fromJson(Map<String, dynamic> json) => CustomMatchContact(
        displayName: json['display_name'],
        givenName: json['given_name'],
        familyName: json['familyName'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        '_1': displayName,
        '_2': givenName,
        '_3': familyName,
        '_4': phone,
      };
}
