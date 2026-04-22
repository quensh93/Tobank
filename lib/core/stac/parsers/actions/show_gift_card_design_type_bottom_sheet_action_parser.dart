import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';

class ShowGiftCardDesignTypeBottomSheetActionModel {
  final String title;
  final String readyDesignTitle;
  final String customDesignTitle;
  final String readyDesignIconAsset;
  final String customDesignIconAsset;
  final Map<String, dynamic>? readyDesignAction;
  final Map<String, dynamic>? customDesignAction;

  const ShowGiftCardDesignTypeBottomSheetActionModel({
    required this.title,
    required this.readyDesignTitle,
    required this.customDesignTitle,
    required this.readyDesignIconAsset,
    required this.customDesignIconAsset,
    this.readyDesignAction,
    this.customDesignAction,
  });

  factory ShowGiftCardDesignTypeBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawReadyAction = json['readyDesignAction'];
    final rawCustomAction = json['customDesignAction'];
    return ShowGiftCardDesignTypeBottomSheetActionModel(
      title: json['title'] as String? ?? 'طرح کارت را انتخاب کنید',
      readyDesignTitle: json['readyDesignTitle'] as String? ?? 'طرح‌های آماده',
      customDesignTitle: json['customDesignTitle'] as String? ?? 'طرح سفارشی',
      readyDesignIconAsset:
          json['readyDesignIconAsset'] as String? ??
          'assets/icons/ic_gift_card_prepared.svg',
      customDesignIconAsset:
          json['customDesignIconAsset'] as String? ??
          'assets/icons/ic_gift_card_custom.svg',
      readyDesignAction: rawReadyAction is Map<String, dynamic>
          ? rawReadyAction
          : rawReadyAction is Map
          ? Map<String, dynamic>.from(rawReadyAction)
          : null,
      customDesignAction: rawCustomAction is Map<String, dynamic>
          ? rawCustomAction
          : rawCustomAction is Map
          ? Map<String, dynamic>.from(rawCustomAction)
          : null,
    );
  }
}

class ShowGiftCardDesignTypeBottomSheetActionParser
    extends StacActionParser<ShowGiftCardDesignTypeBottomSheetActionModel> {
  const ShowGiftCardDesignTypeBottomSheetActionParser();

  @override
  String get actionType => 'showGiftCardDesignTypeBottomSheet';

  @override
  ShowGiftCardDesignTypeBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardDesignTypeBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGiftCardDesignTypeBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final selectedAction = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16, safeBottom + 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 62,
                        height: 6,
                        decoration: BoxDecoration(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.45,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      model.title,
                      textAlign: TextAlign.right,
                      style: textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTypeItem(
                      context: bottomSheetContext,
                      title: model.readyDesignTitle,
                      iconAsset: _resolveIconAsset(
                        context,
                        lightAsset: model.readyDesignIconAsset,
                        darkAsset:
                            'assets/icons/ic_gift_card_prepared_dark.svg',
                      ),
                      onTap: () {
                        Navigator.of(
                          bottomSheetContext,
                        ).pop(model.readyDesignAction);
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTypeItem(
                      context: bottomSheetContext,
                      title: model.customDesignTitle,
                      iconAsset: _resolveIconAsset(
                        context,
                        lightAsset: model.customDesignIconAsset,
                        darkAsset: 'assets/icons/ic_gift_card_custom_dark.svg',
                      ),
                      onTap: () {
                        Navigator.of(
                          bottomSheetContext,
                        ).pop(model.customDesignAction);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if (selectedAction == null || !context.mounted) return;

    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (!context.mounted) return;
    await Stac.onCallFromJson(selectedAction, context);
  }

  Widget _buildTypeItem({
    required BuildContext context,
    required String title,
    required String iconAsset,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.30),
            width: 1,
          ),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(iconAsset, width: 30, height: 30),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _resolveIconAsset(
    BuildContext context, {
    required String lightAsset,
    required String darkAsset,
  }) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkAsset : lightAsset;
  }
}

void registerShowGiftCardDesignTypeBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGiftCardDesignTypeBottomSheetActionParser(),
  );
}
