import 'package:universal_io/io.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/authentication/capture_personal_picture_controller.dart';
import '../../../../widget/svg/svg_icon.dart';

class CapturePersonalPictureScreen extends StatelessWidget {
  const CapturePersonalPictureScreen({
    required this.returnDataFunction,
    required this.visualTutorialFunction,
    required this.audioTutorialFunction,
    required this.stopAudioPlayer,
    super.key,
  });

  final Function(File file) returnDataFunction;
  final Function() visualTutorialFunction;
  final Function() audioTutorialFunction;
  final Function() stopAudioPlayer;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
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
                              SafeCameraPreview(controller: controller.cameraController),
                              Stack(
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
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                            child: ClipOval(
                                              child: Container(
                                                width: Get.width * 0.6,
                                                height: Get.height * 0.37,
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                ),
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
                                    Container(
                                      width: Get.width,
                                      decoration: const BoxDecoration(color: Colors.blueGrey),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: Get.height / 36),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  await stopAudioPlayer();
                                                  visualTutorialFunction();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  elevation: 0,
                                                  backgroundColor: Colors.white24,
                                                ),
                                                child:  Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const SvgIcon(
                                                      SvgIcons.captureVisualTutorial,
                                                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                      size: 24.0,
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    Text(
                                                      locale.image_guide,
                                                      style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12.0),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  audioTutorialFunction();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  elevation: 0,
                                                  backgroundColor: Colors.white24,
                                                ),
                                                child:  Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const SvgIcon(
                                                      SvgIcons.captureVoiceTutorial,
                                                      size: 24.0,
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    Text(
                                                      locale.audio_guide,
                                                      style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.white,
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
                                      const SizedBox(height: 32.0),
                                       Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text(
                                          locale.instruction_text,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white70,
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


class SafeCameraPreview extends StatelessWidget {
  final CameraController? controller;

  const SafeCameraPreview({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return CameraPreview(controller!);
  }
}