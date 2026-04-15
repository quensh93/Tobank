import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../registry/custom_component_registry.dart';
import '../../../helpers/logger.dart';

class ShowPhotoTipsBottomSheetActionModel {
  final String title;
  final String? iconAsset;
  final List<String> tips;
  final String? previewAsset;
  final Map<String, dynamic>? continueAction;
  final String continueText;
  final String cancelText;

  const ShowPhotoTipsBottomSheetActionModel({
    required this.title,
    this.iconAsset,
    required this.tips,
    this.previewAsset,
    this.continueAction,
    required this.continueText,
    required this.cancelText,
  });

  factory ShowPhotoTipsBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawContinueAction = json['continueAction'];
    return ShowPhotoTipsBottomSheetActionModel(
      title: json['title'] as String? ?? '',
      iconAsset: json['iconAsset'] as String?,
      tips: (json['tips'] as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList(),
      previewAsset: json['previewAsset'] as String?,
      continueAction: rawContinueAction is Map<String, dynamic>
          ? rawContinueAction
          : rawContinueAction is Map
          ? Map<String, dynamic>.from(rawContinueAction)
          : null,
      continueText: json['continueText'] as String? ?? 'ادامه',
      cancelText: json['cancelText'] as String? ?? 'بازگشت',
    );
  }
}

enum _PhotoTipsDecision { continueFlow, cancel }

class ShowPhotoTipsBottomSheetActionParser
    extends StacActionParser<ShowPhotoTipsBottomSheetActionModel> {
  const ShowPhotoTipsBottomSheetActionParser();

  @override
  String get actionType => 'showPhotoTipsBottomSheet';

  @override
  ShowPhotoTipsBottomSheetActionModel getModel(Map<String, dynamic> json) {
    return ShowPhotoTipsBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowPhotoTipsBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final result = await showModalBottomSheet<_PhotoTipsDecision>(
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
                top: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(18, 10, 18, bottomInset + 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      if (model.iconAsset != null) ...[
                        _buildAssetIcon(model.iconAsset!, 22, 22),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          model.title,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: model.tips
                          .map(
                            (tip) => Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                '• $tip',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.onSurface,
                                  height: 1.65,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  if (model.previewAsset != null) ...[
                    const SizedBox(height: 14),
                    Center(
                      child: Container(
                        width: _isVideoPath(model.previewAsset!) ? 260 : 132,
                        height: _isVideoPath(model.previewAsset!) ? 146 : 192,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(alpha: 0.45),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: _buildPreviewAsset(model.previewAsset!),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(
                            bottomSheetContext,
                          ).pop(_PhotoTipsDecision.cancel),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            side: BorderSide(
                              color: colorScheme.outline.withValues(alpha: 0.8),
                            ),
                            foregroundColor: colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(model.cancelText),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.of(
                            bottomSheetContext,
                          ).pop(_PhotoTipsDecision.continueFlow),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(model.continueText),
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

    if (result != _PhotoTipsDecision.continueFlow ||
        model.continueAction == null ||
        !context.mounted) {
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 180));
    if (!context.mounted) return;

    try {
      await Stac.onCallFromJson(model.continueAction!, context);
    } catch (e, stackTrace) {
      AppLogger.e('Error executing photo tips continue action', e, stackTrace);
    }
  }

  Widget _buildAssetIcon(String assetPath, double width, double height) {
    final path = assetPath.trim();
    final isSvg = path.toLowerCase().endsWith('.svg');
    final isNetwork = _isNetworkPath(path);

    if (isSvg && isNetwork) {
      return SvgPicture.network(path, width: width, height: height);
    }
    if (isSvg) {
      return SvgPicture.asset(path, width: width, height: height);
    }
    if (isNetwork) {
      return Image.network(path, width: width, height: height, fit: BoxFit.contain);
    }
    return Image.asset(path, width: width, height: height, fit: BoxFit.contain);
  }

  Widget _buildPreviewAsset(String assetPath) {
    final path = assetPath.trim();
    final isSvg = path.toLowerCase().endsWith('.svg');
    final isNetwork = _isNetworkPath(path);
    final isVideo = _isVideoPath(path);

    if (isVideo) {
      return _buildVideoPreview(path);
    }
    if (isSvg && isNetwork) {
      return SvgPicture.network(path, fit: BoxFit.contain);
    }
    if (isSvg) {
      return SvgPicture.asset(path, fit: BoxFit.contain);
    }
    if (isNetwork) {
      return Image.network(path, fit: BoxFit.contain);
    }
    return Image.asset(path, fit: BoxFit.contain);
  }

  bool _isNetworkPath(String value) {
    return value.startsWith('http://') || value.startsWith('https://');
  }

  bool _isVideoPath(String value) {
    final path = value.toLowerCase();
    return path.endsWith('.mp4') ||
        path.endsWith('.webm') ||
        path.endsWith('.ogg') ||
        path.endsWith('.mov');
  }

  Widget _buildVideoPreview(String path) {
    if (kIsWeb) {
      return HtmlElementView.fromTagName(
        tagName: 'video',
        onElementCreated: (Object element) {
          final dynamic el = element;
          el.src = path;
          el.controls = false;
          el.autoplay = true;
          el.loop = true;
          el.muted = true;
          el.playsInline = true;
          el.style.width = '100%';
          el.style.height = '100%';
          el.style.objectFit = 'cover';
          el.style.backgroundColor = 'white';
        },
      );
    }

    if (WebViewPlatform.instance != null) {
      return _VideoWebViewPreview(url: path);
    }

    return const Center(
      child: Icon(Icons.videocam, size: 40, color: Colors.black54),
    );
  }
}

void registerShowPhotoTipsBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowPhotoTipsBottomSheetActionParser(),
  );
}

class _VideoWebViewPreview extends StatefulWidget {
  const _VideoWebViewPreview({required this.url});

  final String url;

  @override
  State<_VideoWebViewPreview> createState() => _VideoWebViewPreviewState();
}

class _VideoWebViewPreviewState extends State<_VideoWebViewPreview> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    final uri = Uri.tryParse(widget.url);
    if (uri == null) return;
    final html = '''
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
    <video autoplay loop muted playsinline>
      <source src="${uri.toString()}" type="video/mp4" />
    </video>
  </body>
</html>
''';
    final htmlUri = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: utf8,
    );
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(htmlUri);
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Center(
        child: Icon(Icons.videocam, size: 40, color: Colors.black54),
      );
    }
    return WebViewWidget(controller: _controller!);
  }
}
