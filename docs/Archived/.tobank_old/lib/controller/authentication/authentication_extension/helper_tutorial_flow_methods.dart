import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../ui/authentication/helper/helper_screen.dart';
import '../../../ui/authentication/register/views/tutorial_bottom_sheet.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/dialog_util.dart';
import '../../../util/enums_constants.dart';
import '../authentication_register_controller.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
extension HelperTutorialFlowMethods on AuthenticationRegisterController {
  /// Shows the helper screen for a specific helper type.
  /// Stops any playing audio before showing the screen.
  Future<void> showHelperScreen({required HelperType helperType}) async {
    print('🎓 Showing helper screen for type: $helperType');
    await stopPlayer();
    Get.to(() => HelperScreen(helperType: helperType));
  }

  /// Shows a bottom sheet with voice and visual tutorial options.
  /// The bottom sheet is customized based on the current theme.
  void showBottomSheet({
    required Future<void> Function() voiceTutorial,
    required void Function() visualTutorial
  }) {
    print('🎓 Opening tutorial bottom sheet');

    if (isClosed) {
      print('🎓 Controller is closed, skipping bottom sheet');
      return;
    }

    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => TutorialBottomSheet(
        voiceTutorial: voiceTutorial,
        visualTutorial: visualTutorial,
      ),
    );
  }

  /// Shows a confirmation dialog for closing the authentication process.
  /// Provides options to confirm or cancel the action.
  void showCloseDialog() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    print('🎓 Showing close confirmation dialog');

    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.sure_to_exit_auth,
        description: '',
        positiveMessage: locale.yes,
        negativeMessage: locale.no,
        positiveFunction: () async {
          print('🎓 User confirmed closing');
          Get.back();
          final NavigatorState navigator = Navigator.of(Get.context!);
          navigator.pop();
          Future.delayed(Constants.duration500, () {
            Get.delete<AuthenticationRegisterController>(force: true);
          });
        },
        negativeFunction: () {
          print('🎓 User cancelled closing');
          Get.back();
        }
    );
  }

  /// Initializes and plays a sound based on the specified helper voice type.
  /// Handles player initialization and audio playback.
  Future<void> playSound({required HelperVoiceType helperVoiceType}) async {
    print('🔊 Playing sound for helper type: $helperVoiceType');

    if (!audioPlayerIsInitialized) {
      print('🔊 Initializing audio player');
      assetsAudioPlayer = FlutterSoundPlayer(
          logLevel: AppUtil.isProduction() ? Level.nothing : Level.debug
      );
      await assetsAudioPlayer.openPlayer();
      audioPlayerIsInitialized = true;
    }

    await stopPlayer();

    assetsAudioPlayer.startPlayer(
        fromURI: helperVoiceType.assetUrl,
        codec: Codec.mp3,
        whenFinished: () {
          print('🔊 Audio playback completed');
          isPlayingAudio = false;
        }
    );
    isPlayingAudio = true;
  }

  /// Stops any currently playing audio.
  /// Safe to call even if no audio is playing.
  Future<void> stopPlayer() async {
    print('🔊 Attempting to stop audio player');

    if (isPlayingAudio) {
      print('🔊 Stopping active audio playback');
      await assetsAudioPlayer.stopPlayer();
      isPlayingAudio = false;
    }
  }
}