import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/branch_map/branch_map_controller.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class BranchMapScreen extends StatelessWidget {
  const BranchMapScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<BranchMapController>(
        init: BranchMapController(),
        builder: (controller) {
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
                        initialZoom: 11.0,
                        maxZoom: 18.0,
                        keepAlive: true,
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.gardeshpay.app',
                        ),
                        MarkerLayer(
                          markers: controller.getMarkers(),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 24.0,
                    left: 24.0,
                    child: Platform.isIOS || kIsWeb
                        ? Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.close_rounded,
                          ),
                        ),
                      ),
                    )
                        : Container(),
                  ),
                  Positioned(
                    top: 24.0,
                    right: 24.0,
                    child: Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(24.0),
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Row(
                                children: [
                                  const SvgIcon(
                                    SvgIcons.marker,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(locale.branch,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        // InkWell(
                        //   borderRadius: BorderRadius.circular(24.0),
                        //   onTap: () {
                        //     controller.selectAtm();
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       color: controller.currentMapMarkerType == MapMarkerType.atm
                        //           ? context.theme.colorScheme.secondary
                        //           : context.theme.colorScheme.surface,
                        //       borderRadius: BorderRadius.circular(24.0),
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        //       child: Text(
                        //         'خودپرداز',
                        //         style: TextStyle(
                        //           color: controller.currentMapMarkerType == MapMarkerType.atm
                        //               ? Colors.white
                        //               : ThemeUtil.textTitleColor,
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 18.0,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 48.0,
                    right: 24.0,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          backgroundColor: Get.isDarkMode ? context.theme.iconTheme.color! : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          heroTag: 'btn1',
                          onPressed: () {
                            controller.showSearchScreen();
                          },
                          child: const SvgIcon(
                            SvgIcons.mapSearch,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        FloatingActionButton(
                          backgroundColor: ThemeUtil.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          heroTag: 'btn2',
                          onPressed: () {
                            controller.goToCurrentLocation();
                          },
                          child: const SvgIcon(SvgIcons.mapLocationGps),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}