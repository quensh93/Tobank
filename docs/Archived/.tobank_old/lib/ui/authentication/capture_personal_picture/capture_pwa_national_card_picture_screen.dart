import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_io/io.dart';

import '../../../../controller/authentication/capture_personal_picture_controller.dart';
import '../../../../widget/svg/svg_icon.dart';
import 'capture_personal_picture_screen.dart';

class CapturePwaNationalCardPictureScreen extends StatelessWidget {
  const CapturePwaNationalCardPictureScreen({
    required this.returnDataFunction,
    required this.stopAudioPlayer,
    super.key,
  });

  final Function(File file) returnDataFunction;
  final Function() stopAudioPlayer;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CapturePersonalPictureController>(
          init: CapturePersonalPictureController(returnDataFunction: returnDataFunction),
          builder: (controller) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder<void>(
                      future: controller.initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the Future is complete, display the preview.
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              SafeCameraPreview(controller: controller.cameraController),                              Stack(
                                fit: StackFit.expand,
                                children: [
                                  ColorFiltered(
                                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOut),
                                    // This one will create the magic
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black12,
                                          ), // This one will handle background + difference out
                                        ),
                                        Align(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                            child: Container(

                                              width: Get.width * 0.8,
                                              height: Get.width * 0.8 *9/16,

                                              decoration:  BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0.0,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await stopAudioPlayer();
                                        controller.takePicture();
                                      },
                                      child: const SvgIcon(
                                        SvgIcons.capture,
                                        size: 80.0,
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0.0,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Get.width,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
                                          color: Colors.blueGrey,
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(bottom: 20.0, top: 44.0, left: 24.0, right: 24.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    borderRadius: BorderRadius.circular(40),
                                                    child: const Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: SvgIcon(
                                                        SvgIcons.closeBold,
                                                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Add switch camera button here
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      controller.switchCamera();
                                                    },
                                                    borderRadius: BorderRadius.circular(40),
                                                    child: const Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: SvgIcon(
                                                        SvgIcons.switchCard, // You'll need to add this SVG icon
                                                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          // Otherwise, display a loading indicator.
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}