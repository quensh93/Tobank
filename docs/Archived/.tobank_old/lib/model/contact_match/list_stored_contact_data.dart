class ListStoredContactData {
  ListStoredContactData({
    this.storedContactDataList,
  });

  List<StoredContactData>? storedContactDataList;

  factory ListStoredContactData.fromJson(Map<String, dynamic> json) => ListStoredContactData(
        storedContactDataList:
            List<StoredContactData>.from(json['storedContactDataList'].map((x) => StoredContactData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'storedContactDataList': List<dynamic>.from(storedContactDataList!.map((x) => x.toJson())),
      };
}

class StoredContactData {
  StoredContactData({
    this.contactName,
    this.phoneNumber,
  });

  String? contactName;
  String? phoneNumber;

  factory StoredContactData.fromJson(Map<String, dynamic> json) => StoredContactData(
        contactName: json['contactName'],
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
        'contactName': contactName,
        'phoneNumber': phoneNumber,
      };
}
