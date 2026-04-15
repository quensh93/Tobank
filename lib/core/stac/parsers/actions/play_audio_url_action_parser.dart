import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stac/stac.dart';

import '../../../helpers/logger.dart';

class PlayAudioUrlActionModel {
  final String url;
  final bool stopPrevious;

  const PlayAudioUrlActionModel({
    required this.url,
    this.stopPrevious = true,
  });

  factory PlayAudioUrlActionModel.fromJson(Map<String, dynamic> json) {
    return PlayAudioUrlActionModel(
      url: json['url'] as String? ?? '',
      stopPrevious: json['stopPrevious'] as bool? ?? true,
    );
  }
}

/// Parser for playing remote audio URLs directly in-app without navigation.
class PlayAudioUrlActionParser extends StacActionParser<PlayAudioUrlActionModel> {
  const PlayAudioUrlActionParser();

  static final AudioPlayer _player = AudioPlayer();

  static Future<void> stopPlayback() async {
    try {
      await _player.stop();
    } catch (_) {
      // Ignore stop failures to keep flow resilient.
    }
  }

  @override
  String get actionType => 'playAudioUrl';

  @override
  PlayAudioUrlActionModel getModel(Map<String, dynamic> json) {
    return PlayAudioUrlActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    PlayAudioUrlActionModel model,
  ) async {
    if (model.url.isEmpty) {
      AppLogger.w('playAudioUrl: url is empty');
      return;
    }

    final uri = Uri.tryParse(model.url);
    if (uri == null) {
      AppLogger.w('playAudioUrl: invalid url "${model.url}"');
      return;
    }

    try {
      if (model.stopPrevious) {
        await _player.stop();
      }
      await _player.setAudioSource(AudioSource.uri(uri));
      await _player.play();
    } catch (e, stackTrace) {
      AppLogger.e(
        'playAudioUrl: failed for "${model.url}"',
        e,
        stackTrace,
      );
      if (!context.mounted) return;
      _showPlaybackError(context);
    }
  }

  void _showPlaybackError(BuildContext context) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('پخش راهنمای صوتی با خطا مواجه شد'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class StopAudioUrlActionParser extends StacActionParser<Map<String, dynamic>> {
  const StopAudioUrlActionParser();

  @override
  String get actionType => 'stopAudioUrl';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  FutureOr<void> onCall(BuildContext context, Map<String, dynamic> model) async {
    await PlayAudioUrlActionParser.stopPlayback();
  }
}
