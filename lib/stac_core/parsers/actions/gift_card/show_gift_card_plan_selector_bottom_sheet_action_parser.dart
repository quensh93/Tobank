import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';
import '../custom_navigate_action_parser.dart';

class ShowGiftCardPlanSelectorBottomSheetActionModel {
  final String title;
  final String selectedPlanIdKey;
  final String selectedPlanTitleKey;
  final String selectedCategoryKey;
  final String? categoryTitle;
  final Map<String, dynamic>? onPlanSelectedAction;
  final List<GiftCardPlanBottomSheetItemModel> plans;

  const ShowGiftCardPlanSelectorBottomSheetActionModel({
    required this.title,
    required this.selectedPlanIdKey,
    required this.selectedPlanTitleKey,
    required this.selectedCategoryKey,
    this.categoryTitle,
    this.onPlanSelectedAction,
    required this.plans,
  });

  factory ShowGiftCardPlanSelectorBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawPlans = json['plans'];
    final plans = <GiftCardPlanBottomSheetItemModel>[];
    if (rawPlans is List) {
      for (final item in rawPlans) {
        if (item is Map<String, dynamic>) {
          plans.add(GiftCardPlanBottomSheetItemModel.fromJson(item));
        } else if (item is Map) {
          plans.add(
            GiftCardPlanBottomSheetItemModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          );
        }
      }
    }

    final rawOnSelect = json['onPlanSelectedAction'];
    return ShowGiftCardPlanSelectorBottomSheetActionModel(
      title: json['title'] as String? ?? 'لطفا طرح کارت هدیه را انتخاب کنید',
      selectedPlanIdKey:
          json['selectedPlanIdKey'] as String? ?? 'giftCardRealSelectedPlanId',
      selectedPlanTitleKey:
          json['selectedPlanTitleKey'] as String? ??
          'giftCardRealSelectedPlanTitle',
      selectedCategoryKey:
          json['selectedCategoryKey'] as String? ??
          'giftCardRealSelectedCategory',
      categoryTitle: json['categoryTitle'] as String?,
      onPlanSelectedAction: rawOnSelect is Map<String, dynamic>
          ? rawOnSelect
          : rawOnSelect is Map
          ? Map<String, dynamic>.from(rawOnSelect)
          : null,
      plans: plans,
    );
  }
}

class GiftCardPlanBottomSheetItemModel {
  final String id;
  final String title;
  final String primaryColor;
  final String secondaryColor;
  final String accentColor;
  final String? imageUrl;

  const GiftCardPlanBottomSheetItemModel({
    required this.id,
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    this.imageUrl,
  });

  factory GiftCardPlanBottomSheetItemModel.fromJson(Map<String, dynamic> json) {
    return GiftCardPlanBottomSheetItemModel(
      id: (json['id'] as String?)?.trim().isNotEmpty == true
          ? (json['id'] as String).trim()
          : DateTime.now().microsecondsSinceEpoch.toString(),
      title: json['title'] as String? ?? '',
      primaryColor: json['primaryColor'] as String? ?? '#A8D96A',
      secondaryColor: json['secondaryColor'] as String? ?? '#5DB7A8',
      accentColor: json['accentColor'] as String? ?? '#45A0A5',
      imageUrl: json['imageUrl'] as String?,
    );
  }
}

class ShowGiftCardPlanSelectorBottomSheetActionParser
    extends StacActionParser<ShowGiftCardPlanSelectorBottomSheetActionModel> {
  const ShowGiftCardPlanSelectorBottomSheetActionParser();

  @override
  String get actionType => 'showGiftCardPlanSelectorBottomSheet';

  @override
  ShowGiftCardPlanSelectorBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardPlanSelectorBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGiftCardPlanSelectorBottomSheetActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'bottomSheet', 'gift_card_plan_selector');
    if (!context.mounted || model.plans.isEmpty) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final selectedPlanId =
        (StacRegistry.instance.getValue(model.selectedPlanIdKey) ?? '')
            .toString();

    String currentSelectedId = selectedPlanId;
    final result = await showModalBottomSheet<GiftCardPlanBottomSheetItemModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;
        final maxHeight = MediaQuery.of(bottomSheetContext).size.height * 0.82;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: StatefulBuilder(
              builder: (statefulContext, setModalState) {
                return Container(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, safeBottom + 14),
                    child: Column(
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
                        const SizedBox(height: 28),
                        Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: GridView.builder(
                            itemCount: model.plans.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.84,
                                ),
                            itemBuilder: (context, index) {
                              final item = model.plans[index];
                              final isSelected = currentSelectedId == item.id;
                              return InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  setModalState(() {
                                    currentSelectedId = item.id;
                                  });
                                  Navigator.of(bottomSheetContext).pop(item);
                                },
                                child: _GiftCardPlanBottomSheetItem(
                                  item: item,
                                  isSelected: isSelected,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    if (result == null) return;

    StacRegistry.instance.setValue(model.selectedPlanIdKey, result.id);
    StacRegistry.instance.setValue(model.selectedPlanTitleKey, result.title);
    StacRegistry.instance.setValue(
      'giftCardRealSelectedPlanPrimaryColor',
      result.primaryColor,
    );
    StacRegistry.instance.setValue(
      'giftCardRealSelectedPlanSecondaryColor',
      result.secondaryColor,
    );
    StacRegistry.instance.setValue(
      'giftCardRealSelectedPlanAccentColor',
      result.accentColor,
    );
    StacRegistry.instance.setValue(
      'giftCardRealSelectedPlanImageUrl',
      result.imageUrl ??
          'https://picsum.photos/seed/gift-plan-${result.id}/1200/560',
    );
    if (model.categoryTitle != null && model.categoryTitle!.trim().isNotEmpty) {
      StacRegistry.instance.setValue(
        model.selectedCategoryKey,
        model.categoryTitle!.trim(),
      );
    }
    RegistryNotifier.instance.notify();

    if (!context.mounted || model.onPlanSelectedAction == null) return;
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (!context.mounted) return;
    await Stac.onCallFromJson(model.onPlanSelectedAction!, context);
  }
}

class _GiftCardPlanBottomSheetItem extends StatelessWidget {
  const _GiftCardPlanBottomSheetItem({
    required this.item,
    required this.isSelected,
  });

  final GiftCardPlanBottomSheetItemModel item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.8)
              : colorScheme.outlineVariant.withValues(alpha: 0.32),
          width: isSelected ? 1.3 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: SizedBox(
              height: 88,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      item.imageUrl ??
                          'https://picsum.photos/seed/gift-plan-${item.id}/900/420',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                _parseHexColor(item.primaryColor),
                                _parseHexColor(item.secondaryColor),
                                _parseHexColor(item.accentColor),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: const Color(0xFFF7FAFD),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/shetab.svg',
                            width: 58,
                            height: 18,
                            fit: BoxFit.contain,
                          ),
                          SvgPicture.asset(
                            'assets/icons/gardeshgary.svg',
                            width: 56,
                            height: 16,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  size: 26,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface.withValues(alpha: 0.8),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.title,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Color _parseHexColor(String hexColor) {
    final normalized = hexColor.trim();
    final hasHash = normalized.startsWith('#');
    final value = hasHash ? normalized.substring(1) : normalized;
    try {
      if (value.length == 6) {
        return Color(int.parse('FF$value', radix: 16));
      }
      if (value.length == 8) {
        return Color(int.parse(value, radix: 16));
      }
    } catch (_) {
      // Keep fallback color when payload color is invalid.
    }
    return const Color(0xFF7CBF7D);
  }
}

void registerShowGiftCardPlanSelectorBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGiftCardPlanSelectorBottomSheetActionParser(),
  );
}
