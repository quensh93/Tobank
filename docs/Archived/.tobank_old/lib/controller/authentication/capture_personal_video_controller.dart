import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:camera/camera.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class CapturePersonalVideoController extends GetxController with GetTickerProviderStateMixin {
  CapturePersonalVideoController({required this.returnDataFunction});

  late CameraController cameraController;
  Future<void>? initializeControllerFuture;

  final Function(File file) returnDataFunction;

  int _counter = 0;

  Timer? timer;

  late AnimationController animationController;

  FlashMode flashMode = FlashMode.off;

  // Add these for camera switching
  List<CameraDescription> cameras = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    await initCamera();
    initAnimationController();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    final selectedCamera = cameras.firstWhere(
          (element) => (element.lensDirection == CameraLensDirection.front || element.lensDirection == CameraLensDirection.external),
      orElse: () => cameras.first,
    );

    cameraController = CameraController(
      selectedCamera,
      /// todo: add later to pwa (cropper web)
      ResolutionPreset.low,
      enableAudio: false,
    );
    initializeControllerFuture = cameraController.initialize();
    await initializeControllerFuture;
    flashMode = cameraController.value.flashMode;
    update();
  }

  // Add switch camera functionality
  Future<void> switchCamera() async {
    if (cameras.length < 2) {
      Get.snackbar(
        'Camera Error',
        'No alternative camera available',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Get the current camera's lens direction
    final currentLensDirection = cameraController.description.lensDirection;

    // Find camera with different lens direction
    CameraDescription? newCamera;
    if (currentLensDirection == CameraLensDirection.front) {
      newCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.firstWhere(
              (camera) => camera.lensDirection != CameraLensDirection.front,
          orElse: () => cameras.first,
        ),
      );
    } else {
      newCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.firstWhere(
              (camera) => camera.lensDirection != currentLensDirection,
          orElse: () => cameras.first,
        ),
      );
    }

    if (newCamera == null) return;

    // Dispose the current camera controller
    await cameraController.dispose();

    // Create a new controller
    cameraController = CameraController(
      newCamera,
      ResolutionPreset.low,
      enableAudio: false,
    );

    // Initialize
    initializeControllerFuture = cameraController.initialize();
    await initializeControllerFuture;
    flashMode = cameraController.value.flashMode;
    update();
  }

  void initAnimationController() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 4000000),
    );
  }

  void startProgressBorder() {
    animationController.forward();
  }

  @override
  void onClose() {
    if (cameraController.value.isRecordingVideo) {
      cameraController.stopVideoRecording();
    }

    cameraController.dispose();
    animationController.dispose();
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> takeVideo() async {
    if (!cameraController.value.isRecordingVideo) {
      _counter = 0;
      await initializeControllerFuture;
      await cameraController.startVideoRecording();
      _startTimer();
    }
  }

  String getCurrentTime() {
    final DateTime time = DateTime(2022);
    final timer = intl.DateFormat('mm:ss').format(time.add(Duration(seconds: _counter)));
    return timer;
  }

  void _startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    startProgressBorder();
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (_counter >= 4) {
        timer.cancel();
        _stopRecording();
      } else {
        _counter = _counter + 1;
      }
      update();
    });
  }

  Future<void> _stopRecording() async {
    if (cameraController.value.isRecordingVideo) {
      final recordedVideo = await cameraController.stopVideoRecording();
      Get.back();
      returnDataFunction(File(recordedVideo.path));
    }
  }

  Future<void> toggleFlash() async {
    if (cameraController.value.flashMode == FlashMode.off) {
      await cameraController.setFlashMode(FlashMode.torch);
      flashMode = FlashMode.torch;
    } else {
      await cameraController.setFlashMode(FlashMode.off);
      flashMode = FlashMode.off;
    }
    update();
  }
}