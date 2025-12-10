import 'dart:convert';

List<CityProvinceDataModel> cityProvinceDataModelFromJson(String str) =>
    List<CityProvinceDataModel>.from(json.decode(str).map((x) => CityProvinceDataModel.fromJson(x)));

String cityProvinceDataModelToJson(List<CityProvinceDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityProvinceDataModel {
  CityProvinceDataModel({
    this.city,
    this.id,
    this.name,
  });

  List<City>? city;
  int? id;
  String? name;

  factory CityProvinceDataModel.fromJson(Map<String, dynamic> json) => CityProvinceDataModel(
        city: json['city'] == null ? null : List<City>.from(json['city'].map((x) => City.fromJson(x))),
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'city': city == null ? null : List<dynamic>.from(city!.map((x) => x.toJson())),
        'id': id,
        'name': name,
      };
}

class City {
  City({
    this.id,
    this.name,
    this.province,
  });

  int? id;
  String? name;
  int? province;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'],
        name: json['name'],
        province: json['province'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'province': province,
      };
}
