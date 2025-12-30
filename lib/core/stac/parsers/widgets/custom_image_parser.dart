import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';
import 'package:universal_io/io.dart' show File;
import '../../../helpers/logger.dart';

class CustomStacImage {
  const CustomStacImage({
    required this.src,
    this.registryKey,
    this.width,
    this.height,
    this.fit,
    this.errorBuilder,
  });

  final String src;
  /// If set, the image src will be read fresh from StacRegistry at render time.
  /// This bypasses STAC's template caching and ensures the latest value is used.
  final String? registryKey;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Map<String, dynamic>? errorBuilder;

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
        LogCategory.widget,
        'CustomImageParser: Using registryKey="${model.registryKey}" -> effectiveSrc="$effectiveSrc"',
      );
    }

    // 0. Check for SVG
    final isSvg = effectiveSrc.toLowerCase().endsWith('.svg');

    final imageKey = ValueKey<String>(effectiveSrc);

    final isLocalFilePath = !kIsWeb &&
        effectiveSrc.isNotEmpty &&
        !effectiveSrc.startsWith('assets/') &&
        !effectiveSrc.startsWith('http') &&
        !effectiveSrc.startsWith('data:') &&
        (effectiveSrc.startsWith('/') ||
            RegExp(r'^[a-zA-Z]:\\').hasMatch(effectiveSrc));

    AppLogger.dc(
      LogCategory.widget,
      'CustomImageParser: src="${model.src}" effectiveSrc="$effectiveSrc" registryKey="${model.registryKey}" local=$isLocalFilePath svg=$isSvg',
    );
    // Also log the resolved value from registry for debugging
    final resolved = StacRegistry.instance.getValue('selectedImage');
    AppLogger.dc(
      LogCategory.widget,
      'CustomImageParser: registry[selectedImage]="$resolved"',
    );

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
        return SvgPicture.asset(
          key: imageKey,
          effectiveSrc,
          width: model.width,
          height: model.height,
          fit: model.fit ?? BoxFit.contain,
          // SvgPicture doesn't support errorBuilder directly in the same way,
          // but we can wrap it or use a different loader if needed.
          // However, asset SVGs should generally exist.
        );
      }
      return Image.asset(
        key: imageKey,
        effectiveSrc,
        width: model.width,
        height: model.height,
        fit: model.fit,
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
        errorBuilder: _buildErrorBuilder(context, model),
      );
    }

    // 4. Fallback to Network
    if (effectiveSrc.startsWith('http')) {
      if (isSvg) {
        return SvgPicture.network(
          key: imageKey,
          effectiveSrc,
          width: model.width,
          height: model.height,
          fit: model.fit ?? BoxFit.contain,
          // placeholderBuilder: (context) => const CircularProgressIndicator(),
        );
      }
      return Image.network(
        key: imageKey,
        effectiveSrc,
        width: model.width,
        height: model.height,
        fit: model.fit,
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
}
