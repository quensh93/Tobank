import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../../core/helpers/logger.dart';

class ShowBottomSheetActionModel {
  final Map<String, dynamic>? sheet;
  final String? title;
  final List<Map<String, dynamic>>? items;
  final bool? isScrollControlled;
  final bool? useSafeArea;
  final bool? isDismissible;
  final bool? enableDrag;
  final String? backgroundColor;
  final String? barrierColor;

  const ShowBottomSheetActionModel({
    this.sheet,
    this.title,
    this.items,
    this.isScrollControlled,
    this.useSafeArea,
    this.isDismissible,
    this.enableDrag,
    this.backgroundColor,
    this.barrierColor,
  });

  factory ShowBottomSheetActionModel.fromJson(Map<String, dynamic> json) {
    final rawSheet = json['sheet'];
    final rawItems = json['items'];

    return ShowBottomSheetActionModel(
      sheet: rawSheet is Map<String, dynamic>
          ? rawSheet
          : rawSheet is Map
          ? Map<String, dynamic>.from(rawSheet)
          : null,
      title: json['title'] as String?,
      items: rawItems is List
          ? rawItems
                .whereType<Map>()
                .map((item) => Map<String, dynamic>.from(item))
                .toList()
          : null,
      isScrollControlled: json['isScrollControlled'] as bool?,
      useSafeArea: json['useSafeArea'] as bool?,
      isDismissible: json['isDismissible'] as bool?,
      enableDrag: json['enableDrag'] as bool?,
      backgroundColor: json['backgroundColor'] as String?,
      barrierColor: json['barrierColor'] as String?,
    );
  }
}

class ShowBottomSheetActionParser
    extends StacActionParser<ShowBottomSheetActionModel> {
  const ShowBottomSheetActionParser();

  @override
  String get actionType => 'showBottomSheet';

  @override
  ShowBottomSheetActionModel getModel(Map<String, dynamic> json) {
    return ShowBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    try {
      final result = await showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: model.isScrollControlled ?? true,
        useSafeArea: model.useSafeArea ?? false,
        isDismissible: model.isDismissible ?? true,
        enableDrag: model.enableDrag ?? true,
        backgroundColor:
            _parseColor(model.backgroundColor) ?? Colors.transparent,
        barrierColor: _parseColor(model.barrierColor) ?? Colors.black54,
        builder: (bottomSheetContext) {
          final sheetJson = model.sheet;
          if (sheetJson != null) {
            return Stac.fromJson(sheetJson, bottomSheetContext) ??
                const SizedBox.shrink();
          }
          return _buildLegacyFallbackSheet(bottomSheetContext, model);
        },
      );

      if (!context.mounted || result == null) return;

      final resultAction = result is Map<String, dynamic>
          ? result
          : result is Map
          ? Map<String, dynamic>.from(result)
          : null;

      if (resultAction != null) {
        await Stac.onCallFromJson(resultAction, context);
      }
    } catch (e, stackTrace) {
      AppLogger.e('Error executing showBottomSheet action: $e', e, stackTrace);
    }
  }

  Widget _buildLegacyFallbackSheet(
    BuildContext context,
    ShowBottomSheetActionModel model,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final title = model.title ?? 'Bottom Sheet';
    final items = model.items ?? const <Map<String, dynamic>>[];
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, bottomInset + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 46,
                  height: 6,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              if (items.isEmpty)
                Text(
                  'No sheet widget or items were provided.',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                )
              else
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: colorScheme.outlineVariant,
                          width: 1,
                        ),
                      ),
                      title: Text(
                        (item['title'] as String?) ?? 'Item',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                      onTap: () => Navigator.of(context).pop(item['onTap']),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Color? _parseColor(String? colorString) {
  if (colorString == null) return null;
  try {
    final hex = colorString.replaceAll('#', '');
    if (hex.length == 6) return Color(int.parse('FF$hex', radix: 16));
    if (hex.length == 8) return Color(int.parse(hex, radix: 16));
    return null;
  } catch (_) {
    return null;
  }
}

void registerShowBottomSheetActionParser() {
  final registry = CustomComponentRegistry.instance;
  registry.registerAction(const ShowBottomSheetActionParser());
}
