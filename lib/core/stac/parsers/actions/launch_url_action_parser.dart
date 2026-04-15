import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../helpers/logger.dart';

class LaunchUrlActionModel {
  final String url;
  final String? mode;

  const LaunchUrlActionModel({
    required this.url,
    this.mode,
  });

  factory LaunchUrlActionModel.fromJson(Map<String, dynamic> json) {
    return LaunchUrlActionModel(
      url: json['url'] as String? ?? '',
      mode: json['mode'] as String?,
    );
  }
}

/// Parser for opening external links/media files via url_launcher.
///
/// Supported `mode` values:
/// - `platformDefault` (default)
/// - `inAppWebView`
/// - `externalApplication`
/// - `externalNonBrowserApplication`
class LaunchUrlActionParser extends StacActionParser<LaunchUrlActionModel> {
  const LaunchUrlActionParser();

  @override
  String get actionType => 'launchUrl';

  @override
  LaunchUrlActionModel getModel(Map<String, dynamic> json) {
    return LaunchUrlActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(BuildContext context, LaunchUrlActionModel model) async {
    if (model.url.isEmpty) {
      AppLogger.w('launchUrl: url is empty');
      return;
    }

    final uri = Uri.tryParse(model.url);
    if (uri == null) {
      AppLogger.w('launchUrl: invalid url "${model.url}"');
      return;
    }

    final launchMode = _parseLaunchMode(model.mode);

    try {
      if (launchMode == LaunchMode.inAppWebView) {
        await _openInAppOrFallback(context, uri);
        return;
      }

      final launched = await launchUrl(uri, mode: launchMode);
      if (!launched) {
        AppLogger.w('launchUrl: could not launch "${model.url}"');
      }
    } catch (e, stackTrace) {
      AppLogger.e('launchUrl: failed for "${model.url}"', e, stackTrace);
    }
  }

  Future<void> _openInAppOrFallback(BuildContext context, Uri uri) async {
    // On Web, render inside app using HtmlElementView.
    if (kIsWeb) {
      await _openInternalWebView(context, uri);
      return;
    }

    // On mobile platforms, use native webview if available.
    final canUseNativeWebView = WebViewPlatform.instance != null;
    if (canUseNativeWebView) {
      await _openInternalWebView(context, uri);
      return;
    }

    // Last fallback for unsupported platforms.
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
    );
    if (!launched) {
      AppLogger.w('launchUrl: fallback launch failed for "$uri"');
    }
  }

  LaunchMode _parseLaunchMode(String? rawMode) {
    switch (rawMode) {
      case 'inAppWebView':
        return LaunchMode.inAppWebView;
      case 'externalApplication':
        return LaunchMode.externalApplication;
      case 'externalNonBrowserApplication':
        return LaunchMode.externalNonBrowserApplication;
      case 'platformDefault':
      default:
        return LaunchMode.platformDefault;
    }
  }

  Future<void> _openInternalWebView(BuildContext context, Uri uri) async {
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (routeContext) => _InternalWebViewPage(uri: uri),
      ),
    );
  }
}

class _InternalWebViewPage extends StatefulWidget {
  const _InternalWebViewPage({required this.uri});

  final Uri uri;

  @override
  State<_InternalWebViewPage> createState() => _InternalWebViewPageState();
}

class _InternalWebViewPageState extends State<_InternalWebViewPage> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..loadRequest(widget.uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          'راهنمای تصویری',
          textDirection: TextDirection.rtl,
        ),
      ),
      body: SafeArea(
        top: false,
        child: kIsWeb
            ? _WebEmbeddedView(uri: widget.uri)
            : (_controller != null
                  ? WebViewWidget(controller: _controller!)
                  : const SizedBox.shrink()),
      ),
    );
  }
}

class _WebEmbeddedView extends StatelessWidget {
  const _WebEmbeddedView({required this.uri});

  final Uri uri;

  bool get _isVideoUrl {
    final path = uri.path.toLowerCase();
    return path.endsWith('.mp4') || path.endsWith('.webm') || path.endsWith('.ogg');
  }

  @override
  Widget build(BuildContext context) {
    if (_isVideoUrl) {
      return HtmlElementView.fromTagName(
        tagName: 'video',
        onElementCreated: (Object element) {
          final dynamic el = element;
          el.src = uri.toString();
          el.controls = false;
          el.loop = true;
          el.autoplay = true;
          el.muted = false;
          el.playsInline = true;
          el.style.width = '100%';
          el.style.height = '100%';
          el.style.backgroundColor = 'white';
          el.style.objectFit = 'contain';
        },
      );
    }

    return HtmlElementView.fromTagName(
      tagName: 'iframe',
      onElementCreated: (Object element) {
        final dynamic el = element;
        el.src = uri.toString();
        el.style.border = '0';
        el.style.width = '100%';
        el.style.height = '100%';
        el.style.backgroundColor = 'white';
        el.setAttribute('allow', 'autoplay; fullscreen; picture-in-picture');
      },
    );
  }
}
