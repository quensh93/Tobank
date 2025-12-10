import '../../../service/core/api_request_model.dart';

class UpdateAddressRequestData extends ApiRequestModel {
  UpdateAddressRequestData({
    this.trackingNumber,
    this.customerNumber,
    this.postalCode,
    this.landLineNumber,
    this.province,
    this.city,
    this.lastStreet,
    this.secondLastStreet,
    this.plaque,
    this.buildingName,
    this.floor,
    this.floorSide,
  });

  String? trackingNumber;
  String? customerNumber;
  String? postalCode;
  String? landLineNumber;
  String? province;
  String? city;
  String? lastStreet; // خیابان اصلی
  String? secondLastStreet; // خیابان فرعی
  int? plaque;
  String? buildingName;
  int? floor;
  int? floorSide;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'postalCode': postalCode,
        'landLineNumber': landLineNumber,
        'province': province,
        'city': city,
        'lastStreet': lastStreet,
        'secondLastStreet': secondLastStreet,
        'plaque': plaque,
        'buildingName': buildingName,
        'floor': floor,
        'floorSide': floorSide,
      };
}
