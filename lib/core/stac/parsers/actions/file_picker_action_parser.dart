import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:stac/stac.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'file_picker_action_model.dart';
import '../../registry/custom_component_registry.dart';
import '../../../helpers/logger.dart';

enum _FilePreviewDecision { confirm, retry, cancel }

/// File Picker Action Parser
///
/// A custom STAC action parser that handles file picking using file_picker package.
/// Supports different file types and handles platform differences (web vs desktop).
///
/// On web: Converts file bytes to base64 data URL for display
/// On desktop/mobile: Uses file path directly
class FilePickerActionParser extends StacActionParser<FilePickerActionModel> {
  const FilePickerActionParser();

  @override
  String get actionType => 'pickFile';

  @override
  FilePickerActionModel getModel(Map<String, dynamic> json) =>
      FilePickerActionModel.fromJson(json);

  @override
  FutureOr<void> onCall(
    BuildContext context,
    FilePickerActionModel model,
  ) async {
    AppLogger.dc(
      LogCategory.action,
      'FilePickerAction: Picking file with type=${model.fileType}, targetKey=${model.targetKey}',
    );

    try {
      // Determine file type
      final fileType = _getFileType(model.fileType);

      // Pick file
      final result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: model.allowedExtensions,
        allowMultiple: model.allowMultiple,
        withData: true, // Always get bytes for web compatibility
      );

      if (result == null || result.files.isEmpty) {
        AppLogger.dc(
          LogCategory.action,
          'FilePickerAction: User cancelled file picker',
        );
        return;
      }

      if (!context.mounted) return;

      final file = result.files.first;
      String? fileData;

      if (kIsWeb) {
        // On web, convert bytes to base64 data URL
        if (file.bytes != null) {
          final mimeType = _getMimeType(file.extension);
          final base64 = base64Encode(file.bytes!);
          fileData = 'data:$mimeType;base64,$base64';
          AppLogger.dc(
            LogCategory.action,
            'FilePickerAction: Web - Created base64 data URL (${file.bytes!.length} bytes)',
          );
        }
      } else {
        // On desktop/mobile, use file path
        fileData = file.path;
        AppLogger.dc(
          LogCategory.action,
          'FilePickerAction: Desktop/Mobile - Using file path: $fileData',
        );
      }

      if (fileData != null) {
        if (model.previewBeforeConfirm) {
          final decision = await _showImagePreviewSheet(
            context: context,
            model: model,
            file: file,
          );

          if (decision == _FilePreviewDecision.retry) {
            if (context.mounted) {
              await Future<void>.delayed(const Duration(milliseconds: 220));
              if (!context.mounted) return;
              await onCall(context, model);
            }
            return;
          }

          if (decision != _FilePreviewDecision.confirm) {
            AppLogger.dc(
              LogCategory.action,
              'FilePickerAction: Preview dismissed before confirmation',
            );
            return;
          }
        }

        // Store in STAC state using setValue
        final setValueAction = {
          'actionType': 'setValue',
          'values': [
            {'key': model.targetKey, 'value': fileData},
            {'key': model.hasValueKey ?? 'hasImage', 'value': true},
            if (model.fileNameKey != null)
              {'key': model.fileNameKey, 'value': file.name},
          ],
        };

        if (context.mounted) {
          await Stac.onCallFromJson(setValueAction, context);
          AppLogger.ic(
            LogCategory.action,
            'FilePickerAction: Stored image in state with key="${model.targetKey}"',
          );
        }
      }
    } catch (e, stack) {
      AppLogger.ec(
        LogCategory.action,
        'FilePickerAction: Error picking file: $e',
        e,
        stack,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا در انتخاب فایل: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<_FilePreviewDecision> _showImagePreviewSheet({
    required BuildContext context,
    required FilePickerActionModel model,
    required PlatformFile file,
  }) async {
    final colorScheme = Theme.of(context).colorScheme;
    final isVideo = model.fileType.toLowerCase() == 'video';

    final result = await showModalBottomSheet<_FilePreviewDecision>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (bottomSheetContext) {
        final bottomInset = MediaQuery.of(bottomSheetContext).padding.bottom;
        return SafeArea(
          top: false,
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, bottomInset + 17),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 4),
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.outlineVariant.withValues(
                          alpha: 0.20,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.previewSheetTitle ??
                              (isVideo
                                  ? 'ویدیوی گرفته شده مورد تایید شما است؟'
                                  : 'عکس گرفته شده مورد تایید شما است؟'),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.sizeOf(context).height * 0.3,
                        minHeight: 200,
                      ),
                      color: colorScheme.surfaceContainerHighest,
                      child: _buildPreviewContent(
                        file: file,
                        isVideo: isVideo,
                        colorScheme: colorScheme,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(
                            bottomSheetContext,
                          ).pop(_FilePreviewDecision.retry),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(55),
                            side: BorderSide(color: colorScheme.outline),
                            foregroundColor: colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                          child: Text(model.retryButtonText ?? 'بازگشت'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.of(
                            bottomSheetContext,
                          ).pop(_FilePreviewDecision.confirm),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(55),
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                          child: Text(
                            model.confirmButtonText ??
                                (isVideo ? 'تایید ویدیو' : 'تایید عکس'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return result ?? _FilePreviewDecision.cancel;
  }

  Widget _buildPreviewContent({
    required PlatformFile file,
    required bool isVideo,
    required ColorScheme colorScheme,
  }) {
    if (isVideo) {
      final videoSource = _resolveVideoSource(file);
      if (videoSource != null && videoSource.isNotEmpty) {
        return _LoopVideoPreview(source: videoSource);
      }
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'پیش‌نمایش ویدیو در دسترس نیست.',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    if (file.bytes != null) {
      return Image.memory(
        file.bytes!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'پیش نمایش این تصویر در دسترس نیست.',
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String? _resolveVideoSource(PlatformFile file) {
    if (file.bytes != null && file.bytes!.isNotEmpty) {
      final mimeType = _getMimeType(file.extension, isVideo: true);
      final base64 = base64Encode(file.bytes!);
      return 'data:$mimeType;base64,$base64';
    }

    if (!kIsWeb && file.path != null && file.path!.isNotEmpty) {
      return Uri.file(file.path!).toString();
    }

    return null;
  }

  FileType _getFileType(String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return FileType.image;
      case 'video':
        return FileType.video;
      case 'audio':
        return FileType.audio;
      case 'media':
        return FileType.media;
      case 'custom':
        return FileType.custom;
      default:
        return FileType.any;
    }
  }

  String _getMimeType(String? extension, {bool isVideo = false}) {
    if (extension == null) {
      return isVideo ? 'video/mp4' : 'application/octet-stream';
    }

    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'bmp':
        return 'image/bmp';
      case 'svg':
        return 'image/svg+xml';
      case 'mp4':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      case 'webm':
        return 'video/webm';
      case 'mkv':
        return 'video/x-matroska';
      case 'avi':
        return 'video/x-msvideo';
      default:
        return isVideo ? 'video/$extension' : 'image/$extension';
    }
  }
}

class _LoopVideoPreview extends StatelessWidget {
  const _LoopVideoPreview({required this.source});

  final String source;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _LoopVideoHtmlPreview(source: source);
    }

    if (WebViewPlatform.instance != null) {
      return _LoopVideoWebView(source: source);
    }

    return const _VideoLoadingPlaceholder();
  }
}

class _LoopVideoHtmlPreview extends StatefulWidget {
  const _LoopVideoHtmlPreview({required this.source});

  final String source;

  @override
  State<_LoopVideoHtmlPreview> createState() => _LoopVideoHtmlPreviewState();
}

class _LoopVideoHtmlPreviewState extends State<_LoopVideoHtmlPreview> {
  bool _isReady = false;
  Timer? _fallbackTimer;

  @override
  void initState() {
    super.initState();
    _fallbackTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted || _isReady) return;
      setState(() => _isReady = true);
    });
  }

  @override
  void dispose() {
    _fallbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        HtmlElementView.fromTagName(
          tagName: 'video',
          onElementCreated: (Object element) {
            final dynamic el = element;
            el.src = widget.source;
            el.controls = false;
            el.autoplay = true;
            el.loop = true;
            el.muted = true;
            el.playsInline = true;
            el.style.width = '100%';
            el.style.height = '100%';
            el.style.objectFit = 'cover';
            el.style.backgroundColor = 'white';

            void onReady(_) {
              if (!mounted || _isReady) return;
              setState(() => _isReady = true);
            }

            el.onloadeddata = onReady;
            el.oncanplay = onReady;
            el.onplaying = onReady;
            el.onwaiting = (_) {
              if (!mounted || !_isReady) return;
              setState(() => _isReady = false);
            };
            el.onstalled = (_) {
              if (!mounted || _isReady) return;
              setState(() => _isReady = false);
            };
          },
        ),
        if (!_isReady) const _VideoLoadingPlaceholder(),
      ],
    );
  }
}

class _LoopVideoWebView extends StatefulWidget {
  const _LoopVideoWebView({required this.source});

  final String source;

  @override
  State<_LoopVideoWebView> createState() => _LoopVideoWebViewState();
}

class _LoopVideoWebViewState extends State<_LoopVideoWebView> {
  late final WebViewController _controller;
  bool _isReady = false;
  Timer? _fallbackTimer;

  @override
  void initState() {
    super.initState();
    final src = jsonEncode(widget.source);
    final html =
        '''
<!doctype html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <style>
      html, body {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        background: #ffffff;
        overflow: hidden;
      }
      video {
        width: 100%;
        height: 100%;
        object-fit: cover;
        background: #ffffff;
      }
    </style>
  </head>
  <body>
    <video id="v" autoplay loop muted playsinline></video>
    <script>
      const src = $src;
      const v = document.getElementById('v');
      function markReady() {
        if (window.VideoPreviewState && window.VideoPreviewState.postMessage) {
          window.VideoPreviewState.postMessage('ready');
        }
      }
      function markWaiting() {
        if (window.VideoPreviewState && window.VideoPreviewState.postMessage) {
          window.VideoPreviewState.postMessage('waiting');
        }
      }
      v.addEventListener('loadeddata', markReady);
      v.addEventListener('canplay', markReady);
      v.addEventListener('playing', markReady);
      v.addEventListener('waiting', markWaiting);
      v.addEventListener('stalled', markWaiting);
      v.src = src;
      v.play().then(markReady).catch(() => {
        setTimeout(() => {
          v.play().then(markReady).catch(() => {});
        }, 250);
      });
      setTimeout(markReady, 3000);
    </script>
  </body>
</html>
''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..addJavaScriptChannel(
        'VideoPreviewState',
        onMessageReceived: (message) {
          if (!mounted) return;
          if (message.message == 'ready') {
            if (_isReady) return;
            setState(() => _isReady = true);
          } else if (message.message == 'waiting') {
            if (!_isReady) return;
            setState(() => _isReady = false);
          }
        },
      )
      ..loadHtmlString(html);

    _fallbackTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted || _isReady) return;
      setState(() => _isReady = true);
    });
  }

  @override
  void dispose() {
    _fallbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        WebViewWidget(controller: _controller),
        if (!_isReady) const _VideoLoadingPlaceholder(),
      ],
    );
  }
}

class _VideoLoadingPlaceholder extends StatelessWidget {
  const _VideoLoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color(0x80FFFFFF),
      child: Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(strokeWidth: 2.4),
        ),
      ),
    );
  }
}

/// Register the file picker action parser
void registerFilePickerActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const FilePickerActionParser(),
  );
  AppLogger.dc(LogCategory.registry, 'Registered FilePickerActionParser');
}
