import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/services/theme/theme_controller_provider.dart';

import '../../../registry/custom_component_registry.dart';

class ShowThemeSelectorBottomSheetActionModel {
  final String title;
  final String lightLabel;
  final String darkLabel;
  final String systemLabel;

  const ShowThemeSelectorBottomSheetActionModel({
    required this.title,
    required this.lightLabel,
    required this.darkLabel,
    required this.systemLabel,
  });

  factory ShowThemeSelectorBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShowThemeSelectorBottomSheetActionModel(
      title: json['title'] as String? ?? 'ظاهر برنامه را انتخاب کنید',
      lightLabel: json['lightLabel'] as String? ?? 'حالت روز',
      darkLabel: json['darkLabel'] as String? ?? 'حالت شب',
      systemLabel:
          json['systemLabel'] as String? ?? 'پیش‌فرض سیستم عامل',
    );
  }
}

class ShowThemeSelectorBottomSheetActionParser
    extends StacActionParser<ShowThemeSelectorBottomSheetActionModel> {
  const ShowThemeSelectorBottomSheetActionParser();

  @override
  String get actionType => 'showThemeSelectorBottomSheet';

  @override
  ShowThemeSelectorBottomSheetActionModel getModel(Map<String, dynamic> json) {
    return ShowThemeSelectorBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowThemeSelectorBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    final container = ProviderScope.containerOf(context);
    var selectedMode = container
        .read(themeControllerProvider)
        .maybeWhen(data: (mode) => mode, orElse: () => ThemeMode.system);

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final bottomInset = MediaQuery.of(bottomSheetContext).padding.bottom;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: StatefulBuilder(
              builder: (statefulContext, setModalState) {
                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, bottomInset + 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: 44,
                            height: 5,
                            decoration: BoxDecoration(
                              color: colorScheme.outlineVariant.withValues(
                                alpha: 0.35,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _themeItem(
                          title: model.lightLabel,
                          mode: ThemeMode.light,
                          selectedMode: selectedMode,
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                          onTap: () async {
                            setModalState(() {
                              selectedMode = ThemeMode.light;
                            });
                            await container
                                .read(themeControllerProvider.notifier)
                                .setMode(ThemeMode.light);
                          },
                        ),
                        const SizedBox(height: 16),
                        _themeItem(
                          title: model.darkLabel,
                          mode: ThemeMode.dark,
                          selectedMode: selectedMode,
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                          onTap: () async {
                            setModalState(() {
                              selectedMode = ThemeMode.dark;
                            });
                            await container
                                .read(themeControllerProvider.notifier)
                                .setMode(ThemeMode.dark);
                          },
                        ),
                        const SizedBox(height: 16),
                        _themeItem(
                          title: model.systemLabel,
                          mode: ThemeMode.system,
                          selectedMode: selectedMode,
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                          onTap: () async {
                            setModalState(() {
                              selectedMode = ThemeMode.system;
                            });
                            await container
                                .read(themeControllerProvider.notifier)
                                .setMode(ThemeMode.system);
                          },
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
  }

  Widget _themeItem({
    required String title,
    required ThemeMode mode,
    required ThemeMode selectedMode,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedMode == mode;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              size: 22,
              color: isSelected
                  ? colorScheme.secondary
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void registerShowThemeSelectorBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowThemeSelectorBottomSheetActionParser(),
  );
}
