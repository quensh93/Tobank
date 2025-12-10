import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/bank_branch_list_data.dart';
import '../../ui/branch_map/map_search_screen.dart';
import '../../ui/branch_map/widget/branch_detail_bottom_sheet.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../../widget/svg/svg_icon.dart';

class BranchMapController extends GetxController {
  final MapController mapController = MapController();

  final Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;
  bool _isFirstTime = false;
  Rx<LatLng> latLng = const LatLng(35.70097414351701, 51.338063590228565).obs;
  LatLng? _currentLocation;
  MapMarkerType currentMapMarkerType = MapMarkerType.branch;

  int openBottomSheets = 0;

  List<BankBranchListData> bankBranchListData = [];

  @override
  void onInit() {
    _getBankBranches();
    super.onInit();
  }

  Future<void> _getBankBranches() async {
    final String data = await DefaultAssetBundle.of(Get.context!).loadString('assets/json/bank_branches.json');
    bankBranchListData = bankBranchListDataFromJson(data);
    update();
  }

  @override
  void onClose() {
    super.onClose();
    _stopListen();
  }

  /// Starts listening to location updates and updates the map accordingly.
  Future<void> listenLocation() async {
    await _checkPermissions();
    if (_permissionGranted == PermissionStatus.granted) {
      locationSubscription = location.onLocationChanged.handleError((dynamic err) {
        locationSubscription!.cancel();
      }).listen((LocationData currentLocation) {
        _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        if (!_isFirstTime) {
          latLng.value = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          mapController.move(latLng.value, 14);
          _isFirstTime = true;
        }
        update();
      });
    } else {
      await _requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        listenLocation();
      }
    }
  }

  void goToCurrentLocation() {
    Timer(Constants.duration200, () {
      listenLocation();
    });
    if (_currentLocation != null) {
      latLng.value = LatLng(_currentLocation!.latitude, _currentLocation!.longitude);
      mapController.move(latLng.value, mapController.camera.zoom);
    }
  }

  Future<void> _stopListen() async {
    locationSubscription?.cancel();
  }

  PermissionStatus? _permissionGranted;

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult = await location.hasPermission();

    _permissionGranted = permissionGrantedResult;
    update();
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult = await location.requestPermission();

      _permissionGranted = permissionRequestedResult;
      update();
    }
  }

  void closeScreen() {
    _stopListen();
    Get.back();
  }

  void onPositionChanged(MapCamera mapCamera, bool hasGesture) {
    latLng.value = mapCamera.center;
  }

  void selectAtm() {
    currentMapMarkerType = MapMarkerType.atm;
    update();
  }

  void selectBranch() {
    currentMapMarkerType = MapMarkerType.branch;
    update();
  }

  Future<void> _showBranchDetailBottomSheet(BankBranchListData bankBranch) async {
    openBottomSheets++;
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: BranchDetailBottomSheet(bankBranch: bankBranch),
      ),
    );
    openBottomSheets--;
  }

  List<Marker> getMarkers() {
    final List<Marker> markers = [];
    for (final bankBranch in bankBranchListData) {
      markers.add(
        Marker(
          height: 48.0,
          width: 48.0,
          point: LatLng(bankBranch.lat!, bankBranch.long!),
          child: InkWell(
            onTap: () {
              _showBranchDetailBottomSheet(bankBranch);
            },
            child: const SvgIcon(SvgIcons.marker),
          ),
        ),
      );
    }
    return markers;
  }


  Future<void> direction(BankBranchListData bankBranch) async {
    final double? lat = bankBranch.lat;
    final double? lng = bankBranch.long;
    Uri uri;
    if (Platform.isAndroid) {
      uri = Uri.parse('google.navigation:q=$lat,$lng&mode=d');
      if (!await launchUrl(uri)) {
        uri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isIOS) {
      uri = Uri.parse('https://maps.apple.com/?daddr=$lat,$lng&dirflg=d');
      if (!await launchUrl(uri)) {
        uri = Uri.parse('comgooglemaps://?daddr=$lat,$lng&directionsmode=driving');
        if (!await launchUrl(uri)) {
          uri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    } else {
      uri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }


  //old direction method

  // void direction(BankBranchListData bankBranch) {
  //   final String googleUrl = 'https://www.google.com/maps/dir/?api=1&destination=${bankBranch.lat},${bankBranch.long}';
  //   AppUtil.launchInBrowser(url: googleUrl);
  // }

  void share(BankBranchListData bankBranch) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    String text = '';
    text += '${bankBranch.faTitle!} - ${bankBranch.code}\n';
    text += '${bankBranch.address!}\n';
    text += bankBranch.phones!.join('\n');
    Share.share(text, subject: locale.share_bank_branch);
  }

  Future<void> showSearchScreen() async {
    final BankBranchListData? result = await Get.to(() => MapSearchScreen(bankBranchListData: bankBranchListData));
    if (result != null) {
      _showBranchDetailBottomSheet(result);
      mapController.move(LatLng(result.lat!, result.long!), 15);
    }
  }

// Future<void> _showAtmDetailBottomSheet() async {
//   openBottomSheets++;
//   await showModalBottomSheet(
//     context: Get.context!,
//     isScrollControlled: true,
//     backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
//     constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(12),
//       ),
//     ),
//     builder: (context) => Padding(
//       padding: MediaQuery.of(context).viewInsets,
//       child: const AtmDetailBottomSheet(),
//     ),
//   );
//   openBottomSheets--;
// }
}
