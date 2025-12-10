import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/camera_capture/camera_capture_controller.dart';
import '../../widget/svg/svg_icon.dart';

class CameraCaptureScreen extends StatelessWidget {
  const CameraCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CameraCaptureController>(
          init: CameraCaptureController(),
          builder: (controller) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: FutureBuilder<void>(
                              future: controller.initializeControllerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  // If the Future is complete, display the preview.
                                  return CameraPreview(controller.cameraController!);
                                } else {
                                  // Otherwise, display a loading indicator.
                                  return const Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 24,
                        child: SizedBox(
                          width: Get.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.takePicture();
                                    },
                                    child: const SvgIcon(
                                      SvgIcons.capture,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 24.0,
                        left: 16,
                        right: 16,
                        child: Container(
                          width: Get.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    SvgIcons.close,
                                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                    size: 32.0,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.toggleFlash();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    SvgIcons.flash,
                                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                    size: 32.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
