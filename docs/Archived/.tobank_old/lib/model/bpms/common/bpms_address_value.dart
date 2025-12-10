class BPMSAddressValue {
  BPMSAddressValue({
    required this.province,
    required this.township,
    required this.city,
    required this.village,
    required this.localityName,
    required this.lastStreet,
    required this.secondLastStreet,
    required this.alley,
    required this.plaque,
    required this.unit,
    required this.postalCode,
    required this.longitude,
    required this.latitude,
    required this.description,
  });

  String? province;
  String? township;
  String? city;
  String? village;
  String? localityName;
  String? lastStreet;
  String? secondLastStreet;
  String? alley;
  int? plaque;
  int? unit;
  int? postalCode;
  double? longitude;
  double? latitude;
  String? description;

  factory BPMSAddressValue.fromJson(Map<String, dynamic> json) => BPMSAddressValue(
      province: json['province'],
      township: json['township'],
      city: json['city'],
      village: json['village'],
      localityName: json['localityName'],
      lastStreet: json['lastStreet'],
      secondLastStreet: json['secondLastStreet'],
      alley: json['alley'],
      plaque: json['plaque'],
      unit: json['unit'],
      postalCode: json['postalCode'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      description: json['description']);

  Map<String, dynamic> toJson() => {
        'province': province,
        'township': township,
        'city': city,
        'village': village,
        'localityName': localityName,
        'lastStreet': lastStreet,
        'secondLastStreet': secondLastStreet,
        'alley': alley,
        'plaque': plaque,
        'unit': unit,
        'postalCode': postalCode,
        'longitude': longitude,
        'latitude': latitude,
        'description': description
      };
}
