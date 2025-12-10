import 'dart:async';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_io/io.dart';

import '../../../../widget/svg/svg_icon.dart';

class CameraAwesomeCaptureVideo extends StatelessWidget {
  const CameraAwesomeCaptureVideo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CameraAwesomeBuilder.custom(
          saveConfig: SaveConfig.video(
            videoOptions: VideoOptions(
              quality: VideoRecordingQuality.sd,
              enableAudio: false,
              ios: CupertinoVideoOptions(
                fps: 25,
              ),
              android: AndroidVideoOptions(
                fallbackStrategy: QualityFallbackStrategy.lower,
              ),
            ),
          ),
          sensorConfig: SensorConfig.single(
            sensor: Sensor.position(SensorPosition.front),
          ),
          previewFit: CameraPreviewFit.fitWidth,
          builder: (CameraState cameraState, Preview preview) {
            return cameraState.when(
              onPreparingCamera: (state) => const Center(child: CircularProgressIndicator()),
              onVideoMode: (state) => RecordVideoUI(state, recording: false),
              onVideoRecordingMode: (state) => RecordVideoUI(state, recording: true),
            );
          },
        ),
      ),
    );
  }
}

class RecordVideoUI extends StatefulWidget {
  final CameraState state;
  final bool recording;

  const RecordVideoUI(this.state, {required this.recording, super.key});

  @override
  State<RecordVideoUI> createState() => _RecordVideoUIState();
}

class _RecordVideoUIState extends State<RecordVideoUI> {
  int _counter = 0;
  Timer? timer;

  void _startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (_counter >= 4) {
        timer.cancel();
      } else {
        _counter = _counter + 1;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Positioned(
          bottom: 24.0,
          left: 0.0,
          right: 0.0,
          child: Column(
            children: [
               Text(
               locale.upload_video_instruction,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              InkWell(
                onTap: () {
                  if (widget.recording == false) {
                    startRecording();
                  }
                },
                child: SvgIcon(
                  widget.recording ? SvgIcons.recording : SvgIcons.capture,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                getCurrentTime(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void startRecording() {
    widget.state.when(
      onVideoMode: (videoState) {
        videoState.startRecording();
        _startTimer();
        if (widget.recording == false) {
          Timer(const Duration(seconds: 4), () {
            startRecording();
          });
        }
      },
      onVideoRecordingMode: (videoState) {
        videoState.stopRecording();
        videoState.captureState?.captureRequest.when(single: (single) {
          Get.back(result: File(single.file!.path));
        });
      },
    );
  }

  String getCurrentTime() {
    final DateTime time = DateTime(2022);
    final timer = intl.DateFormat('mm:ss').format(time.add(Duration(seconds: _counter)));
    return timer;
  }
}
