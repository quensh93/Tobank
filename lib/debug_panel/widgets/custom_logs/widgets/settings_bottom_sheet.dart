import 'package:flutter/material.dart';
import 'package:ispect/ispect.dart' hide ISpectColumnBuilder;
import '../controllers/ispect_view_controller.dart';
import '../extensions/context.dart';
import '../utils/screen_size.dart';
import 'base_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/helpers/log_category.dart';
import '../../../../core/helpers/logger.dart';
import '../../../state/debug_panel_settings_state.dart';
import 'column_builder.dart';

/// Bottom sheet for configuring log viewer settings.
/// Matches the original ISpect settings bottom sheet style exactly.
/// Bottom sheet for configuring log viewer settings.
/// Matches the original ISpect settings bottom sheet style exactly.
class CustomISpectSettingsBottomSheet extends ConsumerStatefulWidget {
  const CustomISpectSettingsBottomSheet({
    required this.iSpectLogger,
    required this.options,
    required this.actions,
    required this.controller,
    super.key,
  });

  /// ISpectLogger implementation
  final ValueNotifier<ISpectLogger> iSpectLogger;

  /// Options for `ISpect`
  final ISpectOptions options;

  /// Actions to display in the settings bottom sheet
  final List<ISpectActionItem> actions;

  /// Controller for the ISpect view
  final ISpectViewController controller;

  Future<void> show(BuildContext context) async {
    await context.screenSizeMaybeWhen(
      phone: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        routeSettings: const RouteSettings(name: 'ISpect Logs Settings Sheet'),
        builder: (_) => this,
      ),
      orElse: () => showDialog<void>(
        context: context,
        useRootNavigator: false,
        routeSettings: const RouteSettings(name: 'ISpect Logs Settings Dialog'),
        builder: (_) => this,
      ),
    );
  }

  @override
  ConsumerState<CustomISpectSettingsBottomSheet> createState() =>
      _CustomISpectSettingsBottomSheetState();
}

class _CustomISpectSettingsBottomSheetState
    extends ConsumerState<CustomISpectSettingsBottomSheet> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.iSpectLogger.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iSpect = ISpect.read(context);
    final appSettings = ref.watch(debugPanelSettingsProvider);
    final appController = ref.read(debugPanelSettingsProvider.notifier);

    final settings = <Widget>[
      // ════════════════════════════════════════════════════════════════════════
      // APP LOGGING SETTINGS
      // ════════════════════════════════════════════════════════════════════════
      // Master Log Switch (Minimal)
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Master Log Switch',
                  style: TextStyle(
                    color: context.ispectTheme.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  appSettings.masterLogsEnabled
                      ? 'All logs enabled'
                      : 'All logs disabled',
                  style: TextStyle(
                    color: context.ispectTheme.textColor.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 32,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Switch(
                  value: appSettings.masterLogsEnabled,
                  onChanged: (enabled) {
                    appController.setMasterLogsEnabled(enabled);
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 16),

      // ════════════════════════════════════════════════════════════════════════
      // GLOBAL CONTROLS - RESPONSIVE
      // ════════════════════════════════════════════════════════════════════════
      LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth > 400;

          if (isCompact) {
            // ═══ COMPACT HORIZONTAL LAYOUT (Desktop) ═══
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: context.ispectTheme.colorScheme.surface.withOpacity(
                    0.3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // Enable All
                    InkWell(
                      onTap: () => appController.enableAllCategories(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.ispectTheme.colorScheme.primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 12,
                              color: context.ispectTheme.colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Enable All',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: context.ispectTheme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Disable All
                    InkWell(
                      onTap: () => appController.disableAllCategories(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.ispectTheme.dividerColor.withOpacity(
                            0.1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.remove_circle_outline,
                              size: 12,
                              color: context.ispectTheme.textColor.withOpacity(
                                0.6,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Disable All',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: context.ispectTheme.textColor
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 20,
                      color: context.ispectTheme.dividerColor.withOpacity(0.3),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),

                    // Global Truncation
                    Text(
                      'Truncate:',
                      style: TextStyle(
                        fontSize: 10,
                        color: context.ispectTheme.textColor.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 36,
                      height: 18,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Switch(
                          value: LogCategory.values.every(
                            (c) =>
                                appSettings
                                    .logCategorySettings[c]
                                    ?.truncateEnabled ??
                                false,
                          ),
                          onChanged: (enabled) =>
                              appController.setAllLogTruncationEnabled(enabled),
                          activeColor: Colors.white,
                          activeTrackColor: Colors.teal,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade700,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Max Length controls
                    Text(
                      'Max:',
                      style: TextStyle(
                        fontSize: 10,
                        color: context.ispectTheme.textColor.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        final currentRef =
                            appSettings
                                .logCategorySettings
                                .values
                                .firstOrNull
                                ?.maxLength ??
                            1000;
                        appController.setAllLogMaxLength(
                          (currentRef - 100).clamp(100, 100000),
                        );
                      },
                      child: Icon(
                        Icons.remove,
                        size: 14,
                        color: context.ispectTheme.textColor.withOpacity(0.6),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        'ALL',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: context.ispectTheme.colorScheme.primary,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final currentRef =
                            appSettings
                                .logCategorySettings
                                .values
                                .firstOrNull
                                ?.maxLength ??
                            1000;
                        appController.setAllLogMaxLength(
                          (currentRef + 100).clamp(100, 100000),
                        );
                      },
                      child: Icon(
                        Icons.add,
                        size: 14,
                        color: context.ispectTheme.textColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // ═══ VERTICAL LAYOUT (Mobile) ═══
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Enable/Disable Buttons
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => appController.enableAllCategories(),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: context.ispectTheme.colorScheme.primary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: context.ispectTheme.colorScheme.primary
                                    .withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 16,
                                  color:
                                      context.ispectTheme.colorScheme.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Enable All',
                                  style: TextStyle(
                                    color:
                                        context.ispectTheme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () => appController.disableAllCategories(),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: context.ispectTheme.dividerColor
                                  .withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: context.ispectTheme.dividerColor
                                    .withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.remove_circle_outline,
                                  size: 16,
                                  color: context.ispectTheme.textColor
                                      .withOpacity(0.7),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Disable All',
                                  style: TextStyle(
                                    color: context.ispectTheme.textColor
                                        .withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Global Truncation
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Global Truncation',
                            style: TextStyle(
                              color: context.ispectTheme.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Apply limit to all categories',
                            style: TextStyle(
                              color: context.ispectTheme.textColor.withOpacity(
                                0.5,
                              ),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 24,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Switch(
                            value: LogCategory.values.every(
                              (c) =>
                                  appSettings
                                      .logCategorySettings[c]
                                      ?.truncateEnabled ??
                                  false,
                            ),
                            onChanged: (enabled) => appController
                                .setAllLogTruncationEnabled(enabled),
                            activeColor: Colors.white,
                            activeTrackColor: Colors.teal,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Global Max Length
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Global Max Length',
                        style: TextStyle(
                          color: context.ispectTheme.textColor.withOpacity(0.9),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.ispectTheme.cardColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: context.ispectTheme.dividerColor.withOpacity(
                              0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                final currentRef =
                                    appSettings
                                        .logCategorySettings
                                        .values
                                        .firstOrNull
                                        ?.maxLength ??
                                    1000;
                                appController.setAllLogMaxLength(
                                  (currentRef - 100).clamp(100, 100000),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Icon(
                                  Icons.remove,
                                  size: 14,
                                  color: context.ispectTheme.textColor,
                                ),
                              ),
                            ),
                            Container(
                              constraints: const BoxConstraints(minWidth: 36),
                              alignment: Alignment.center,
                              child: Text(
                                'ALL',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      context.ispectTheme.colorScheme.primary,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                final currentRef =
                                    appSettings
                                        .logCategorySettings
                                        .values
                                        .firstOrNull
                                        ?.maxLength ??
                                    1000;
                                appController.setAllLogMaxLength(
                                  (currentRef + 100).clamp(100, 100000),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Icon(
                                  Icons.add,
                                  size: 14,
                                  color: context.ispectTheme.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),

      // Categories Header
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Categories',
              style: TextStyle(
                color: context.ispectTheme.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),

      // Responsive Category List
      LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth > 400;

          if (isCompact) {
            // ═══ PROPER TABLE LAYOUT (Desktop/Debug Panel) ═══
            // Columns: [Enable 40px] [Emoji 20px] [Name EXPANDED] [ISpect 40px] [Truncate 40px] [MaxLength 70px]
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: LogCategory.values.map((category) {
                final categorySettings =
                    appSettings.logCategorySettings[category] ??
                    const LogCategorySettings();
                final isEnabled = categorySettings.enabled;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? context.ispectTheme.colorScheme.primary.withOpacity(
                            0.05,
                          )
                        : Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                        color: context.ispectTheme.dividerColor.withOpacity(
                          0.1,
                        ),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Column 1: Enable Switch (fixed width)
                      SizedBox(
                        width: 40,
                        height: 22,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Switch(
                            value: isEnabled,
                            onChanged: (val) {
                              appController.setLogCategorySettings(
                                category,
                                categorySettings.copyWith(enabled: val),
                              );
                            },
                            activeColor: Colors.white,
                            activeTrackColor: Colors.green,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Column 2: Emoji (fixed width)
                      SizedBox(
                        width: 20,
                        child: Text(
                          category.emoji,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 6),

                      // Column 3: Name (EXPANDED - fills remaining space)
                      Expanded(
                        child: Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isEnabled
                                ? context.ispectTheme.textColor
                                : context.ispectTheme.textColor.withOpacity(
                                    0.4,
                                  ),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Column 4: ISpect Switch (fixed width - ALWAYS present)
                      SizedBox(
                        width: 40,
                        height: 20,
                        child: isEnabled
                            ? FittedBox(
                                fit: BoxFit.contain,
                                child: Switch(
                                  value: categorySettings.ispectEnabled,
                                  onChanged: (val) {
                                    appController.setLogCategorySettings(
                                      category,
                                      categorySettings.copyWith(
                                        ispectEnabled: val,
                                      ),
                                    );
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.blue,
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: Colors.grey.shade700,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(width: 8),

                      // Column 5: Truncate Switch (fixed width - ALWAYS present)
                      SizedBox(
                        width: 40,
                        height: 20,
                        child: isEnabled
                            ? FittedBox(
                                fit: BoxFit.contain,
                                child: Switch(
                                  value: categorySettings.truncateEnabled,
                                  onChanged: (val) {
                                    appController.setLogCategorySettings(
                                      category,
                                      categorySettings.copyWith(
                                        truncateEnabled: val,
                                      ),
                                    );
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.teal,
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: Colors.grey.shade700,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      // Column 6: Max Length Controls (fixed width - ALWAYS reserved)
                      SizedBox(
                        width: 70,
                        child: (isEnabled && categorySettings.truncateEnabled)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      final newValue =
                                          (categorySettings.maxLength - 100)
                                              .clamp(100, 100000);
                                      appController.setLogCategorySettings(
                                        category,
                                        categorySettings.copyWith(
                                          maxLength: newValue,
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      size: 14,
                                      color: context.ispectTheme.textColor
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    child: Text(
                                      '${categorySettings.maxLength}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'monospace',
                                        color: context.ispectTheme.textColor,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final newValue =
                                          (categorySettings.maxLength + 100)
                                              .clamp(100, 100000);
                                      appController.setLogCategorySettings(
                                        category,
                                        categorySettings.copyWith(
                                          maxLength: newValue,
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 14,
                                      color: context.ispectTheme.textColor
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          } else {
            // ═══ CARD LAYOUT (Mobile/Phone) ═══
            return Column(
              children: LogCategory.values.map((category) {
                final categorySettings =
                    appSettings.logCategorySettings[category] ??
                    const LogCategorySettings();
                final isEnabled = categorySettings.enabled;

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? context.ispectTheme.colorScheme.primary.withOpacity(
                            0.08,
                          )
                        : context.ispectTheme.colorScheme.surface.withOpacity(
                            0.3,
                          ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isEnabled
                          ? context.ispectTheme.colorScheme.primary.withOpacity(
                              0.3,
                            )
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Title (left) + Enable Switch (right)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left: Emoji + Name
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  category.emoji,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  category.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isEnabled
                                        ? context.ispectTheme.textColor
                                        : context.ispectTheme.textColor
                                              .withOpacity(0.4),
                                  ),
                                ),
                              ],
                            ),
                            // Right: Enable Switch
                            SizedBox(
                              height: 28,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Switch(
                                  value: isEnabled,
                                  onChanged: (val) {
                                    appController.setLogCategorySettings(
                                      category,
                                      categorySettings.copyWith(enabled: val),
                                    );
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Row 2: ISpect + Truncate (only when enabled) - spaceBetween
                        if (isEnabled) ...[
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left: ISpect control
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: categorySettings.ispectEnabled
                                        ? Colors.blue
                                        : context.ispectTheme.textColor
                                              .withOpacity(0.4),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'ISpect',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.ispectTheme.textColor
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                    height: 24,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Switch(
                                        value: categorySettings.ispectEnabled,
                                        onChanged: (val) {
                                          appController.setLogCategorySettings(
                                            category,
                                            categorySettings.copyWith(
                                              ispectEnabled: val,
                                            ),
                                          );
                                        },
                                        activeColor: Colors.white,
                                        activeTrackColor: Colors.blue,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor:
                                            Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Right: Truncate control + Max Length
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.content_cut,
                                    size: 16,
                                    color: categorySettings.truncateEnabled
                                        ? Colors.teal
                                        : context.ispectTheme.textColor
                                              .withOpacity(0.4),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Truncate',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.ispectTheme.textColor
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                    height: 24,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Switch(
                                        value: categorySettings.truncateEnabled,
                                        onChanged: (val) {
                                          appController.setLogCategorySettings(
                                            category,
                                            categorySettings.copyWith(
                                              truncateEnabled: val,
                                            ),
                                          );
                                        },
                                        activeColor: Colors.white,
                                        activeTrackColor: Colors.teal,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor:
                                            Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  // Max Length inline when truncate enabled
                                  if (categorySettings.truncateEnabled) ...[
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () {
                                        final newValue =
                                            (categorySettings.maxLength - 100)
                                                .clamp(100, 100000);
                                        appController.setLogCategorySettings(
                                          category,
                                          categorySettings.copyWith(
                                            maxLength: newValue,
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        size: 16,
                                        color: context.ispectTheme.textColor
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      child: Text(
                                        '${categorySettings.maxLength}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'monospace',
                                          color: context.ispectTheme.textColor,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        final newValue =
                                            (categorySettings.maxLength + 100)
                                                .clamp(100, 100000);
                                        appController.setLogCategorySettings(
                                          category,
                                          categorySettings.copyWith(
                                            maxLength: newValue,
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 16,
                                        color: context.ispectTheme.textColor
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),

      // ════════════════════════════════════════════════════════════════════════
      // INFO ABOUT LOGS (Filter by Type/Key) - RESPONSIVE
      // ════════════════════════════════════════════════════════════════════════
      const SizedBox(height: 24),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Log Types',
              style: TextStyle(
                color: context.ispectTheme.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                final allKeys = [
                  'error',
                  'critical',
                  'info',
                  'debug',
                  'verbose',
                  'warning',
                ];
                for (var key in allKeys) {
                  if (widget.controller.isLogKeyEnabled(key)) {
                    widget.controller.toggleLogKey(key);
                  }
                }
              },
              child: Text(
                'Deselect All',
                style: TextStyle(
                  color: context.ispectTheme.colorScheme.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),

      // Responsive Log Types
      LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth > 400;
          final logTypes = [
            'error',
            'critical',
            'info',
            'debug',
            'verbose',
            'warning',
          ];

          if (isCompact) {
            // ═══ COMPACT GRID LAYOUT (Desktop) ═══
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: logTypes.map((key) {
                  final isEnabled = widget.controller.isLogKeyEnabled(key);
                  IconData icon;
                  Color color;

                  switch (key) {
                    case 'error':
                      icon = Icons.error_outline;
                      color = Colors.red;
                      break;
                    case 'critical':
                      icon = Icons.report_problem_outlined;
                      color = Colors.deepOrange;
                      break;
                    case 'warning':
                      icon = Icons.warning_amber_rounded;
                      color = Colors.orange;
                      break;
                    case 'info':
                      icon = Icons.info_outline;
                      color = Colors.blue;
                      break;
                    case 'debug':
                      icon = Icons.bug_report_outlined;
                      color = Colors.grey;
                      break;
                    case 'verbose':
                      icon = Icons.short_text;
                      color = Colors.grey.shade400;
                      break;
                    default:
                      icon = Icons.circle_outlined;
                      color = Colors.grey;
                  }

                  return InkWell(
                    onTap: () => widget.controller.toggleLogKey(key),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isEnabled
                            ? color.withOpacity(0.2)
                            : context.ispectTheme.colorScheme.surface
                                  .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isEnabled
                              ? color.withOpacity(0.6)
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 14,
                            color: isEnabled ? color : color.withOpacity(0.4),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            key.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isEnabled ? color : color.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            // ═══ VERTICAL LIST (Mobile) ═══
            return Column(
              children: logTypes.map((key) {
                final isEnabled = widget.controller.isLogKeyEnabled(key);
                IconData icon;
                Color color;

                switch (key) {
                  case 'error':
                    icon = Icons.error_outline;
                    color = Colors.red;
                    break;
                  case 'critical':
                    icon = Icons.report_problem_outlined;
                    color = Colors.deepOrange;
                    break;
                  case 'warning':
                    icon = Icons.warning_amber_rounded;
                    color = Colors.orange;
                    break;
                  case 'info':
                    icon = Icons.info_outline;
                    color = Colors.blue;
                    break;
                  case 'debug':
                    icon = Icons.bug_report_outlined;
                    color = Colors.grey;
                    break;
                  case 'verbose':
                    icon = Icons.short_text;
                    color = Colors.grey.shade400;
                    break;
                  default:
                    icon = Icons.circle_outlined;
                    color = Colors.grey;
                }

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? color.withOpacity(0.1)
                        : context.ispectTheme.colorScheme.surface.withOpacity(
                            0.3,
                          ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isEnabled
                          ? color.withOpacity(0.4)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(icon, size: 14, color: color),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        key.toUpperCase(),
                        style: TextStyle(
                          color: isEnabled ? color : color.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 22,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Switch(
                            value: isEnabled,
                            onChanged: (_) =>
                                widget.controller.toggleLogKey(key),
                            activeColor: Colors.white,
                            activeTrackColor: color,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }
        },
      ),

      const SizedBox(height: 24),

      // ════════════════════════════════════════════════════════════════════════
      // ISPECT SETTINGS (Existing)
      // ════════════════════════════════════════════════════════════════════════
      ISpectSettingsCardItem(
        title: context.ispectL10n.enabled,
        enabled: widget.iSpectLogger.value.options.enabled,
        backgroundColor: context.ispectTheme.cardColor,
        onChanged: (enabled) {
          (enabled
                  ? widget.iSpectLogger.value.enable
                  : widget.iSpectLogger.value.disable)
              .call();
          // Trigger UI update by calling setState
          setState(() {});
        },
      ),
      ISpectSettingsCardItem(
        canEdit: widget.iSpectLogger.value.options.enabled,
        title: context.ispectL10n.useConsoleLogs,
        backgroundColor: context.ispectTheme.cardColor,
        enabled: widget.iSpectLogger.value.options.useConsoleLogs,
        onChanged: (enabled) {
          widget.iSpectLogger.value.configure(
            options: widget.iSpectLogger.value.options.copyWith(
              useConsoleLogs: enabled,
            ),
          );
          // Trigger UI update by calling setState
          setState(() {});
        },
      ),
      ISpectSettingsCardItem(
        canEdit: widget.iSpectLogger.value.options.enabled,
        title: context.ispectL10n.useHistory,
        backgroundColor: context.ispectTheme.cardColor,
        enabled: widget.iSpectLogger.value.options.useHistory,
        onChanged: (enabled) {
          widget.iSpectLogger.value.configure(
            options: widget.iSpectLogger.value.options.copyWith(
              useHistory: enabled,
            ),
          );
          // Trigger UI update by calling setState
          setState(() {});
        },
      ),
    ];

    return context.screenSizeMaybeWhen(
      phone: () => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => _SettingsBody(
          iSpect: iSpect,
          settings: settings,
          scrollController: scrollController,
          actions: widget.actions,
        ),
      ),
      orElse: () => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: context.ispectTheme.scaffoldBackgroundColor,
        content: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.7,
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: _SettingsBody(
            iSpect: iSpect,
            settings: settings,
            scrollController: _scrollController,
            actions: widget.actions,
          ),
        ),
      ),
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody({
    required this.iSpect,
    required this.settings,
    required this.scrollController,
    required this.actions,
  });

  final ISpectScopeModel iSpect;
  final List<Widget> settings;
  final ScrollController scrollController;
  final List<ISpectActionItem> actions;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: context.ispectTheme.scaffoldBackgroundColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      interactive: true,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            sliver: SliverToBoxAdapter(
              child: _Header(title: context.ispectL10n.settings),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              child: Column(children: settings),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(bottom: 16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.ispectTheme.cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  border: Border.fromBorderSide(
                    BorderSide(color: context.ispectTheme.dividerColor),
                  ),
                ),
                child: ISpectColumnBuilder(
                  itemCount: actions.length,
                  itemBuilder: (_, index) {
                    final action = actions[index];
                    return _ActionTile(
                      action: action,
                      showDivider: index != actions.length - 1,
                    );
                  },
                ),
              ),
            ),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: _HowToReachMeWidget(),
            ),
          ),
        ],
      ),
    ),
  );
}

class _HowToReachMeWidget extends StatelessWidget {
  const _HowToReachMeWidget();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Flexible(
        child: Text.rich(
          TextSpan(
            text: 'ISpect',
            style: context.ispectTheme.textTheme.titleLarge?.copyWith(
              color: context.ispectTheme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.ispectTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.textColor,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          visualDensity: VisualDensity.compact,
          icon: Icon(Icons.close_rounded, color: theme.textColor),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.action, this.showDivider = true});

  final ISpectActionItem action;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: ListTile(
            onTap: () => _onTap(context),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            dense: true,
            title: Text(
              action.title,
              style: context.ispectTheme.textTheme.bodyMedium,
            ),
            leading: Icon(action.icon, color: context.ispectTheme.textColor),
          ),
        ),
        if (showDivider)
          Divider(color: context.ispectTheme.dividerColor, height: 1),
      ],
    );
  }

  void _onTap(BuildContext context) {
    Navigator.pop(context);
    action.onTap?.call(context);
  }
}

class ISpectSettingsCardItem extends StatelessWidget {
  const ISpectSettingsCardItem({
    required this.title,
    required this.enabled,
    required this.onChanged,
    super.key,
    this.canEdit = true,
    this.subtitle,
    this.backgroundColor = const Color.fromARGB(255, 49, 49, 49),
  });

  final String title;
  final String? subtitle;
  final bool enabled;
  final Function(bool enabled) onChanged;
  final bool canEdit;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: canEdit ? 1 : 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: ISpectBaseCard(
          padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(right: 4),
          color: context.ispectTheme.dividerColor,
          backgroundColor: backgroundColor,
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              dense: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                title,
                style: TextStyle(
                  color: context.ispectTheme.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: TextStyle(
                        color: context.ispectTheme.textColor.withValues(
                          alpha: 0.7,
                        ),
                        fontSize: 12,
                      ),
                    )
                  : null,
              trailing: Switch(
                value: enabled,
                onChanged: canEdit ? onChanged : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
