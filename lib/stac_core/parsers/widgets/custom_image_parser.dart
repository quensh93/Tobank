import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';
import 'package:universal_io/io.dart' show File;
import '../../../core/helpers/logger.dart';
import '../../../core/helpers/log_category.dart';

class CustomStacImage {
  const CustomStacImage({
    required this.src,
    this.registryKey,
    this.width,
    this.height,
    this.fit,
    this.errorBuilder,
    this.color,
  });

  final String src;

  /// If set, the image src will be read fresh from StacRegistry at render time.
  /// This bypasses STAC's template caching and ensures the latest value is used.
  final String? registryKey;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Map<String, dynamic>? errorBuilder;
  final String? color;

  factory CustomStacImage.fromJson(Map<String, dynamic> json) {
    return CustomStacImage(
      src: json['src']?.toString() ?? '',
      registryKey: json['registryKey']?.toString(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      fit: json['fit'] != null
          ? BoxFit.values.firstWhere(
              (e) => e.name == json['fit'],
              orElse: () => BoxFit.cover,
            )
          : null,
      errorBuilder: json['errorBuilder'] as Map<String, dynamic>?,
      color: json['color']?.toString(),
    );
  }
}

class CustomImageParser extends StacParser<CustomStacImage> {
  const CustomImageParser();

  @override
  String get type => 'image';

  @override
  CustomStacImage getModel(Map<String, dynamic> json) =>
      CustomStacImage.fromJson(json);

  @override
  Widget parse(BuildContext context, CustomStacImage model) {
    // CRITICAL FIX: If registryKey is set, read fresh value from registry
    // This bypasses STAC's template caching issue where {{selectedImage}} is resolved once and cached
    String effectiveSrc = model.src;
    if (model.registryKey != null && model.registryKey!.isNotEmpty) {
      final freshValue = StacRegistry.instance.getValue(model.registryKey!);
      effectiveSrc = freshValue?.toString() ?? '';
      AppLogger.dc(
        LogCategory.stacWidget,
        'CustomImageParser: Using registryKey="${model.registryKey}" -> effectiveSrc="$effectiveSrc"',
      );
    }

    // 0. Check for SVG
    final isSvg = effectiveSrc.toLowerCase().endsWith('.svg');

    final imageKey = ValueKey<String>(effectiveSrc);

    final isLocalFilePath =
        !kIsWeb &&
        effectiveSrc.isNotEmpty &&
        !effectiveSrc.startsWith('assets/') &&
        !effectiveSrc.startsWith('http') &&
        !effectiveSrc.startsWith('data:') &&
        (effectiveSrc.startsWith('/') ||
            RegExp(r'^[a-zA-Z]:\\').hasMatch(effectiveSrc));

    AppLogger.dc(
      LogCategory.stacWidget,
      'CustomImageParser: src="${model.src}" effectiveSrc="$effectiveSrc" registryKey="${model.registryKey}" local=$isLocalFilePath svg=$isSvg color=${model.color}',
    );
    // Also log the resolved value from registry for debugging
    final resolved = StacRegistry.instance.getValue('selectedImage');
    AppLogger.dc(
      LogCategory.stacWidget,
      'CustomImageParser: registry[selectedImage]="$resolved"',
    );

    // Resolve color
    final color = _parseColor(model.color);
    // Default blend mode for icons
    final blendMode = color != null ? BlendMode.srcIn : null;

    // 1. Check for Data URI (Base64) - Common on Web
    if (effectiveSrc.startsWith('data:')) {
      try {
        final uri = Uri.parse(effectiveSrc);
        if (uri.data != null) {
          // Cannot easily support SVG data URIs here without more logic, assuming raster for data URIs for now
          // or we could check mime type in data uri
          return Image.memory(
            key: imageKey,
            uri.data!.contentAsBytes(),
            width: model.width,
            height: model.height,
            fit: model.fit,
            color: color,
            colorBlendMode: blendMode,
            errorBuilder: _buildErrorBuilder(context, model),
          );
        }

        final commaIndex = effectiveSrc.indexOf(',');
        if (commaIndex > 0) {
          final base64Str = effectiveSrc.substring(commaIndex + 1);
          final bytes = base64Decode(base64Str.trim());
          return Image.memory(
            key: imageKey,
            bytes,
            width: model.width,
            height: model.height,
            fit: model.fit,
            color: color,
            colorBlendMode: blendMode,
            errorBuilder: _buildErrorBuilder(context, model),
          );
        }
      } catch (e) {
        AppLogger.e('Error parsing data URI image: $e');
      }
      return _buildErrorWidget(context, model);
    }

    // 2. Check for Asset
    if (effectiveSrc.startsWith('assets/')) {
      if (isSvg) {
        return _SafeSvgAsset(
          key: imageKey,
          src: effectiveSrc,
          width: model.width,
          height: model.height,
          fit: model.fit ?? BoxFit.contain,
          color: color,
        );
      }
      return Image.asset(
        key: imageKey,
        effectiveSrc,
        width: model.width,
        height: model.height,
        fit: model.fit,
        color: color,
        colorBlendMode: blendMode,
        errorBuilder: _buildErrorBuilder(context, model),
      );
    }

    // 3. Check for Local File (Android/iOS/Desktop)
    if (isLocalFilePath) {
      if (isSvg) {
        // Local SVG rendering would require reading bytes; not supported here.
        return _buildErrorWidget(context, model);
      }

      return Image.file(
        key: imageKey,
        File(effectiveSrc),
        width: model.width,
        height: model.height,
        fit: model.fit,
        color: color,
        colorBlendMode: blendMode,
        errorBuilder: _buildErrorBuilder(context, model),
      );
    }

    // 4. Fallback to Network
    if (effectiveSrc.startsWith('http')) {
      if (isSvg) {
        return _SafeSvgNetwork(
          key: imageKey,
          src: effectiveSrc,
          width: model.width,
          height: model.height,
          fit: model.fit ?? BoxFit.contain,
          color: color,
        );
      }
      return Image.network(
        key: imageKey,
        effectiveSrc,
        width: model.width,
        height: model.height,
        fit: model.fit,
        color: color,
        colorBlendMode: blendMode,
        errorBuilder: _buildErrorBuilder(context, model),
      );
    }

    // 5. Invalid source
    return _buildErrorWidget(context, model);
  }

  Widget Function(BuildContext, Object, StackTrace?)? _buildErrorBuilder(
    BuildContext context,
    CustomStacImage model,
  ) {
    if (model.errorBuilder == null) return null;
    return (ctx, error, stack) {
      AppLogger.e('Image load error: $error');
      return Stac.fromJson(model.errorBuilder!, ctx) ?? const SizedBox();
    };
  }

  Widget _buildErrorWidget(BuildContext context, CustomStacImage model) {
    if (model.errorBuilder != null) {
      return Stac.fromJson(model.errorBuilder!, context) ?? const SizedBox();
    }
    return const SizedBox();
  }

  Color? _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;
    try {
      var hex = colorString.replaceAll('#', '');
      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
    } catch (e) {
      AppLogger.w('Failed to parse color: $colorString');
    }
    return null;
  }
}


/// Wraps [SvgPicture.asset] in an error boundary so that missing SVG assets
/// don't crash the rendering pipeline / freeze the app.
class _SafeSvgAsset extends StatelessWidget {
  const _SafeSvgAsset({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
  });

  final String src;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return _SvgErrorBoundary(
      fallbackWidth: width,
      fallbackHeight: height,
      child: SvgPicture.asset(
        src,
        width: width,
        height: height,
        fit: fit,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}

/// Wraps [SvgPicture.network] in an error boundary so that failed network SVGs
/// don't crash the rendering pipeline / freeze the app.
class _SafeSvgNetwork extends StatelessWidget {
  const _SafeSvgNetwork({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
  });

  final String src;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return _SvgErrorBoundary(
      fallbackWidth: width,
      fallbackHeight: height,
      child: SvgPicture.network(
        src,
        width: width,
        height: height,
        fit: fit,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}

/// A widget-level error boundary that catches rendering errors from child widgets
/// (like SvgPicture throwing on missing assets) and shows a fallback instead of crashing.
class _SvgErrorBoundary extends StatefulWidget {
  const _SvgErrorBoundary({
    required this.child,
    this.fallbackWidth,
    this.fallbackHeight,
  });

  final Widget child;
  final double? fallbackWidth;
  final double? fallbackHeight;

  @override
  State<_SvgErrorBoundary> createState() => _SvgErrorBoundaryState();
}

class _SvgErrorBoundaryState extends State<_SvgErrorBoundary> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return SizedBox(width: widget.fallbackWidth, height: widget.fallbackHeight);
    }

    // Override ErrorWidget.builder temporarily within this widget's subtree
    return _ErrorCatcher(
      onError: () {
        if (mounted && !_hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _hasError = true);
          });
        }
      },
      fallbackWidth: widget.fallbackWidth,
      fallbackHeight: widget.fallbackHeight,
      child: widget.child,
    );
  }
}

class _ErrorCatcher extends StatelessWidget {
  const _ErrorCatcher({
    required this.child,
    required this.onError,
    this.fallbackWidth,
    this.fallbackHeight,
  });

  final Widget child;
  final VoidCallback onError;
  final double? fallbackWidth;
  final double? fallbackHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fallbackWidth,
      height: fallbackHeight,
      child: Builder(
        builder: (context) {
          // Wrap in a custom error widget builder scope
          final originalBuilder = ErrorWidget.builder;
          ErrorWidget.builder = (FlutterErrorDetails details) {
            // Restore original builder immediately
            ErrorWidget.builder = originalBuilder;
            onError();
            return SizedBox(width: fallbackWidth, height: fallbackHeight);
          };
          return child;
        },
      ),
    );
  }
}
