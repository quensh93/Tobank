import 'dart:convert';

CustomContact customContactFromJson(String str) => CustomContact.fromJson(json.decode(str));

String customContactToJson(CustomContact data) => json.encode(data.toJson());

class CustomContact {
  String? displayName;
  String? givenName;
  String? familyName;
  List<dynamic>? phones;

  CustomContact({
    this.displayName,
    this.givenName,
    this.familyName,
    this.phones,
  });

  factory CustomContact.fromJson(Map<String, dynamic> json) => CustomContact(
        displayName: json['display_name'],
        givenName: json['given_name'],
        familyName: json['familyName'],
        phones: List<dynamic>.from(json['phones'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        '_1': displayName,
        '_2': givenName,
        '_3': familyName,
        '_4': List<dynamic>.from(phones!.map((x) => x)),
      };
}
