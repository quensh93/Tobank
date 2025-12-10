import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/location_picker/location_picker_controller.dart';
import '../../widget/svg/svg_icon.dart';

class LocationPickerScreen extends StatelessWidget {
  const LocationPickerScreen({
    required this.returnDataFunction,
    super.key,
  });

  final Function(LatLng latLng) returnDataFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<LocationPickerController>(
      init: LocationPickerController(),
      builder: (controller) {
        controller.returnDataFunction = returnDataFunction;
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: SafeArea(
            child: Stack(
              children: [
                Obx(
                  () => FlutterMap(
                    mapController: controller.mapController,
                    options: MapOptions(
                      onPositionChanged: controller.onPositionChanged,
                      initialCenter: controller.latLng.value,
                      initialZoom: 10.0,
                      maxZoom: 18.0,
                      keepAlive: true,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.gardeshpay.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: controller.latLng.value,
                            width: 32,
                            height: 32,
                            child: const SvgIcon(
                              SvgIcons.mapMarker,
                              size: 32.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 12,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                      iconSize: 26,
                      onPressed: () {
                        controller.closeScreen();
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 48.0,
                  left: 24.0,
                  child: FloatingActionButton(
                    heroTag: 'btn1',
                    onPressed: () {
                      controller.goToCurrentLocation();
                    },
                    child: const Icon(Icons.gps_fixed_sharp),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: FloatingActionButton.extended(
              heroTag: 'btn2',
              onPressed: () {
                controller.selectLocation();
              },
              label:  Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  locale.position_selection,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              icon: const Icon(Icons.done),
            ),
          ),
        );
      },
    );
  }
}
