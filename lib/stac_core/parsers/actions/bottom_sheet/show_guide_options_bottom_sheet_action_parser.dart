import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../../core/helpers/logger.dart';
import '../custom_navigate_action_parser.dart';

class GuideBottomSheetOptionModel {
  final String title;
  final String iconAsset;
  final Map<String, dynamic>? onTap;

  const GuideBottomSheetOptionModel({
    required this.title,
    required this.iconAsset,
    this.onTap,
  });

  factory GuideBottomSheetOptionModel.fromJson(Map<String, dynamic> json) {
    final rawAction = json['onTap'];
    return GuideBottomSheetOptionModel(
      title: json['title'] as String? ?? '',
      iconAsset: json['iconAsset'] as String? ?? '',
      onTap: rawAction is Map<String, dynamic>
          ? rawAction
          : rawAction is Map
          ? Map<String, dynamic>.from(rawAction)
          : null,
    );
  }
}

class ShowGuideOptionsBottomSheetActionModel {
  final String title;
  final List<GuideBottomSheetOptionModel> options;

  const ShowGuideOptionsBottomSheetActionModel({
    required this.title,
    required this.options,
  });

  factory ShowGuideOptionsBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawOptions = json['options'] as List<dynamic>? ?? const [];
    return ShowGuideOptionsBottomSheetActionModel(
      title: json['title'] as String? ?? 'راهنما',
      options: rawOptions
          .whereType<Map>()
          .map((item) => GuideBottomSheetOptionModel.fromJson(
                Map<String, dynamic>.from(item),
              ))
          .toList(),
    );
  }
}

class ShowGuideOptionsBottomSheetActionParser
    extends StacActionParser<ShowGuideOptionsBottomSheetActionModel> {
  const ShowGuideOptionsBottomSheetActionParser();

  @override
  String get actionType => 'showGuideOptionsBottomSheet';

  @override
  ShowGuideOptionsBottomSheetActionModel getModel(Map<String, dynamic> json) {
    return ShowGuideOptionsBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGuideOptionsBottomSheetActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'bottomSheet', 'guide_options');
    if (model.options.isEmpty || !context.mounted) {
      return;
    }

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final tappedOption = await showModalBottomSheet<GuideBottomSheetOptionModel>(
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
              padding: EdgeInsets.fromLTRB(16, 10, 16, bottomInset + 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 4,),
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.20),
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      model.title,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 17
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ..._buildOptionTiles(
                    bottomSheetContext: bottomSheetContext,
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                    options: model.options,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (!context.mounted || tappedOption?.onTap == null) return;

    await Future<void>.delayed(const Duration(milliseconds: 180));
    if (!context.mounted) return;

    try {
      await Stac.onCallFromJson(tappedOption!.onTap!, context);
    } catch (e, stackTrace) {
      AppLogger.e('Error executing guide bottom sheet option', e, stackTrace);
    }
  }

  List<Widget> _buildOptionTiles({
    required BuildContext bottomSheetContext,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required List<GuideBottomSheetOptionModel> options,
  }) {
    final widgets = <Widget>[];

    for (var i = 0; i < options.length; i++) {
      final option = options[i];
      widgets.add(
        GestureDetector(
          onTap: () => Navigator.of(bottomSheetContext).pop(option),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.20),
                width: 1.1,
              ),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      option.iconAsset,
                      width: 22,
                      height: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option.title,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      if (i != options.length - 1) {
        widgets.add(const SizedBox(height: 12));
      }
    }

    return widgets;
  }
}

void registerShowGuideOptionsBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGuideOptionsBottomSheetActionParser(),
  );
}
