import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../../util/constants.dart';

class LocationPickerController extends GetxController with WidgetsBindingObserver {
  final MapController mapController = MapController();
  late Function(LatLng latLng) returnDataFunction;

  final Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;
  bool _isFirstTime = false;
  Set<Marker> markers = <Marker>{};
  Rx<LatLng> latLng = const LatLng(35.70097414351701, 51.338063590228565).obs;
  LatLng? _currentLocation;

  @override
  void onInit() {
    Timer(Constants.duration200, () {
      listenLocation();
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _stopListen();
  }

  /// Updates the current location and moves the map camera to the new location.
  Future<void> listenLocation() async {
    await _checkPermissions();
    if (_permissionGranted == PermissionStatus.granted) {
      locationSubscription = location.onLocationChanged.handleError((dynamic err) {
        locationSubscription!.cancel();
      }).listen((LocationData currentLocation) {
        _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        if (!_isFirstTime) {
          latLng.value = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          mapController.move(latLng.value, 15);
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

  void selectLocation() {
    returnDataFunction(latLng.value);
    Get.back();
  }

  void onPositionChanged(MapCamera mapCamera, bool hasGesture) {
    latLng.value = mapCamera.center;
  }
}
