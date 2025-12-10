import '../../../service/core/api_request_model.dart';

class CardIssuanceRequest extends ApiRequestModel {
  CardIssuanceRequest({
    required this.trackingNumber,
    required this.customerNumber,
    required this.depositNumber,
    required this.postalCode,
    this.templateId,
    this.addressInfo,
    this.longitude,
    this.latitude,
  });

  String trackingNumber;
  String customerNumber;
  int? templateId;
  String depositNumber;
  int postalCode;
  AddressInfo? addressInfo;
  double? longitude;
  double? latitude;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'templateId': templateId,
        'depositNumber': depositNumber,
        'postalCode': postalCode,
        'addressInfo': addressInfo?.toJson(),
        'longitude': longitude,
        'latitude': latitude,
      };
}

class AddressInfo {
  AddressInfo({
    this.province,
    this.township,
    this.city,
    this.village,
    this.localityName,
    this.lastStreet,
    this.secondLastStreet,
    this.alley,
    this.plaque,
    this.unit,
    this.description,
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
  String? description;

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
        'description': description,
      };
}
