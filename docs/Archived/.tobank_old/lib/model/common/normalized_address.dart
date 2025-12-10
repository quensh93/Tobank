import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../address/response/address_inquiry_response_data.dart';

class NormalizedAddress {
  String province;
  String city;
  String? street;
  String? sideStreet;
  int? plaque;
  int? floor;
  int? sideFloor;
  String? buildingName;

  NormalizedAddress({
    required this.province,
    required this.city,
    required this.street,
    required this.sideStreet,
    required this.plaque,
    required this.floor,
    required this.sideFloor,
    required this.buildingName,
  });

  factory NormalizedAddress.fromAddressInquiry({required AddressDetail addressDetail}) {
    final String province;
    final String city;
    String? street; // خیابان اصلی
    String? sideStreet; // خیابان فرعی
    int? plaque;
    int? floor;
    int? sideFloor;
    String? buildingName;

    province = addressDetail.province!;
    if (addressDetail.townShip != null) {

      //locale
      final locale = AppLocalizations.of(Get.context!)!;
      // ASB-1000
      // City
      city = addressDetail.townShip!;

      // Street
      final localityName = addressDetail.localityName?.trim() ?? '';
      final lastStreet = addressDetail.street?.trim() ?? '';
      street = '$localityName $lastStreet'.trim();

      // Side Street
      sideStreet = addressDetail.street2?.trim() ?? '';

      // Plaque
      plaque = addressDetail.houseNumber ?? 0;

      // Floor

      floor = int.tryParse(addressDetail.floor?.replaceAll(locale.ground_floor, '0') ?? '0') ?? 0;

      // Side floor
      sideFloor = int.tryParse(addressDetail.sideFloor ?? '0') ?? 0;

      // Building name
      buildingName = addressDetail.buildingName ?? '';
    } else {
      // ASB-1004

      city = addressDetail.localityName!;
    }

    return NormalizedAddress(
      province: province,
      city: city,
      street: street,
      sideStreet: sideStreet,
      plaque: plaque,
      floor: floor,
      sideFloor: sideFloor,
      buildingName: buildingName,
    );
  }
}
