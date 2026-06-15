import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';
import '../custom_navigate_action_parser.dart';

class ShowGiftCardLocationSelectorBottomSheetActionModel {
  final String title;
  final String selectedKey;
  final List<String> options;

  const ShowGiftCardLocationSelectorBottomSheetActionModel({
    required this.title,
    required this.selectedKey,
    required this.options,
  });

  factory ShowGiftCardLocationSelectorBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawOptions = json['options'];
    final options = <String>[];
    if (rawOptions is List) {
      for (final item in rawOptions) {
        if (item == null) continue;
        final value = item.toString().trim();
        if (value.isNotEmpty) options.add(value);
      }
    }

    return ShowGiftCardLocationSelectorBottomSheetActionModel(
      title: json['title'] as String? ?? 'انتخاب',
      selectedKey: json['selectedKey'] as String? ?? 'giftCardLocationValue',
      options: options,
    );
  }
}

class ShowGiftCardLocationSelectorBottomSheetActionParser
    extends
        StacActionParser<ShowGiftCardLocationSelectorBottomSheetActionModel> {
  const ShowGiftCardLocationSelectorBottomSheetActionParser();

  @override
  String get actionType => 'showGiftCardLocationSelectorBottomSheet';

  @override
  ShowGiftCardLocationSelectorBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardLocationSelectorBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGiftCardLocationSelectorBottomSheetActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'bottomSheet', 'gift_card_location_selector');
    if (!context.mounted || model.options.isEmpty) return;

    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (bottomSheetContext) {
        final colorScheme = Theme.of(bottomSheetContext).colorScheme;
        final textTheme = Theme.of(bottomSheetContext).textTheme;
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;
        final screenHeight = MediaQuery.sizeOf(bottomSheetContext).height;

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
              child: SizedBox(
                height: screenHeight * 0.75,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12, 10, 12, safeBottom + 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 44,
                          height: 5,
                          decoration: BoxDecoration(
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.45,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: model.options.length,
                          separatorBuilder: (_, _) => Divider(
                            height: 1,
                            thickness: 1,
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.22,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            final option = model.options[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(bottomSheetContext).pop(option);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 16,
                                ),
                                child: Text(
                                  option,
                                  textAlign: TextAlign.right,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (selected == null || selected.trim().isEmpty) return;

    StacRegistry.instance.setValue(model.selectedKey, selected.trim());
    RegistryNotifier.instance.notify();
  }
}

void registerShowGiftCardLocationSelectorBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGiftCardLocationSelectorBottomSheetActionParser(),
  );
}
