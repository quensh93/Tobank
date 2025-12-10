import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraCaptureController extends GetxController {
  late List<CameraDescription> cameras;
  CameraDescription? selectedCamera;
  CameraController? cameraController;
  Future<void>? initializeControllerFuture;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initCamera();
  }

  /// Initializes the camera functionality, including selecting a camera,
  /// creating a CameraController, and initializing it.
  Future<void> initCamera() async {
    cameras = await availableCameras();
    selectedCamera = cameras.first;
    cameraController = CameraController(
      selectedCamera!,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    initializeControllerFuture = cameraController?.initialize();
    initializeControllerFuture?.then((value) {
      cameraController?.setFlashMode(FlashMode.off);
    });
    update();
  }

  @override
  Future<void> onClose() async {
    await cameraController?.setFlashMode(FlashMode.off);
    await cameraController?.dispose();
    super.onClose();
  }

  Future<void> takePicture() async {
    await initializeControllerFuture;
    final image = await cameraController?.takePicture();
    if (image != null) {
      Get.back(result: File(image.path));
    }
  }

  /// Toggles the camera's flash between on(torch) and off.
  void toggleFlash() {
    if (cameraController?.value.flashMode == FlashMode.off) {
      cameraController?.setFlashMode(FlashMode.torch);
    } else {
      cameraController?.setFlashMode(FlashMode.off);
    }
  }
}
