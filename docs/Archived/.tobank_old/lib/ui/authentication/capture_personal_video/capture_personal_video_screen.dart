import 'package:universal_io/io.dart';
import 'dart:math' as math;
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/authentication/capture_personal_video_controller.dart';
import '../../../../widget/svg/svg_icon.dart';

class CapturePersonalVideoScreen extends StatelessWidget {
  const CapturePersonalVideoScreen({
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
      child: GetBuilder<CapturePersonalVideoController>(
        init: CapturePersonalVideoController(
          returnDataFunction: returnDataFunction,
        ),
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
                            CameraPreview(controller.cameraController),
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
                                        ),
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
                            SizedBox(
                              width: Get.width * 0.6,
                              height: Get.height * 0.37,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Align(
                                      alignment: FractionalOffset.center,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned.fill(
                                            child: CustomPaint(
                                                painter: CustomTimerPainter(
                                              animation: controller.animationController,
                                              backgroundColor: context.theme.colorScheme.secondary,
                                              color: Colors.white,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Column(
                                children: [
                                  if (controller.cameraController.value.isRecordingVideo)
                                    Container(
                                      constraints: const BoxConstraints(minWidth: 90.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.white70,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 14.0,
                                                height: 14.0,
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 16.0),
                                              Text(
                                                controller.getCurrentTime(),
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: () async {
                                            await stopAudioPlayer();
                                            controller.takeVideo();
                                          },
                                          borderRadius: BorderRadius.circular(40),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(width: 2.0, color: Colors.white),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                width: 42.0,
                                                height: 42.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.red.withOpacity(0.8),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          )),
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
                                              onPressed: () {
                                                if (!controller.cameraController.value.isRecordingVideo) {
                                                  stopAudioPlayer();
                                                  visualTutorialFunction();
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: Colors.white24,
                                              ),
                                              child:  Row(
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
                                                if (!controller.cameraController.value.isRecordingVideo) {
                                                  audioTutorialFunction();
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: Colors.white24,
                                              ),
                                              child:  Row(
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
                                        locale.upload_video_instruction2,
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
        },
      ),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final progress = animation.value;

    if (progress == 1.0) paint.color = Colors.greenAccent;

    canvas.drawArc(Offset.zero & size, 1.5 * math.pi, progress * 2 * math.pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
