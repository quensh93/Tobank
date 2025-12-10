import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../util/enums_constants.dart';

class TakePersonalVideoSampleController extends GetxController {
  final File userFile;
  final Function(File? file) returnCallback;

  String get sampleUrl => HelperTypeSample.personalVideo.url;

  ChewieController? chewieController;
  ChewieController? sampleChewieController;
  late VideoPlayerController videoPlayerController;
  late VideoPlayerController sampleVideoPlayerController;

  TakePersonalVideoSampleController({required this.userFile, required this.returnCallback});

  /// Initializes video players for both a user-provided video file anda sample video URL.
  @override
  Future<void> onInit() async {
    super.onInit();
    /// todo: add later to pwa (cropper web)
    print("🔴");
    print("video file : ${userFile.path}");
    if(kIsWeb){
      // Get the original blob URL string
      String videoUrl = userFile.uri.toString();

      // If the URL is encoded (contains %3A), decode it first
      if (videoUrl.contains('%3A')) {
        videoUrl = Uri.decodeFull(videoUrl);
      }

      videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(videoUrl),
          videoPlayerOptions: VideoPlayerOptions()
      );
    }else{
      videoPlayerController =
          VideoPlayerController.file(userFile, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    }
    /*videoPlayerController =
        VideoPlayerController.file(userFile, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));*/

    sampleVideoPlayerController = VideoPlayerController.networkUrl(Uri.parse(sampleUrl),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));

    print("🔴🔴");
    await videoPlayerController.initialize();
    print("🔴🔴🔴");

    await videoPlayerController.setVolume(0.0);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      showOptions: false,
      showControls: false,
      placeholder: Container(
        color: Colors.transparent,
      ),
      autoInitialize: true,
    );
    update();

    await sampleVideoPlayerController.initialize();
    await sampleVideoPlayerController.setVolume(0.0);
    sampleChewieController = ChewieController(
      videoPlayerController: sampleVideoPlayerController,
      autoPlay: true,
      looping: true,
      showOptions: false,
      showControls: false,
      isLive: true,
      placeholder: Container(
        color: Colors.transparent,
      ),
      autoInitialize: true,
    );
    update();
  }

  @override
  Future<void> onClose() async {
    await sampleVideoPlayerController.dispose();
    await videoPlayerController.dispose();
    chewieController?.dispose();
    sampleChewieController?.dispose();
    super.onClose();
  }

  /// Handles the back button press, executing a callback and popping the current screen.
  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    returnCallback(null);
    final NavigatorState navigator = Navigator.of(Get.context!);
    navigator.pop();
  }

  void reloadSamples() {
    update();
  }

  void submitFile() {
    returnCallback(userFile);
    Get.back();
  }
}
