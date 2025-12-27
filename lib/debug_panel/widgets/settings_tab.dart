import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/debug_panel_settings_state.dart';
import '../themes/debug_panel_theme.dart';
import '../../core/helpers/logger.dart';
import '../../core/helpers/log_category.dart';

/// Settings tab for debug panel customization
class SettingsTab extends ConsumerWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(debugPanelSettingsProvider);
    final controller = ref.read(debugPanelSettingsProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Debug Panel Enable/Disable Section
            _buildSectionHeader(context, 'Debug Panel', Icons.bug_report),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Debug Panel',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            settings.debugPanelEnabled
                                ? 'Panel is currently visible'
                                : 'Panel is hidden',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: settings.debugPanelEnabled,
                      onChanged: (enabled) {
                        controller.setDebugPanelEnabled(enabled);
                        AppLogger.i(
                            '🔧 Debug panel ${enabled ? "enabled" : "disabled"} from Settings');
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ISpect Draggable Panel Toggle
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ISpect Draggable Panel',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            settings.ispectDraggablePanelEnabled
                                ? 'Floating panel is visible'
                                : 'Floating panel is hidden',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: settings.ispectDraggablePanelEnabled,
                      onChanged: (enabled) {
                        controller.setIspectDraggablePanelEnabled(enabled);
                        AppLogger.i(
                            '🔧 ISpect draggable panel ${enabled ? "enabled" : "disabled"} from Settings');
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Logging Section
            _buildSectionHeader(context, 'Logging', Icons.terminal),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Master Log Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enable Logs',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                settings.masterLogsEnabled
                                    ? 'All logging is enabled (STAC + App)'
                                    : 'All logging is disabled (STAC + App)',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: settings.masterLogsEnabled,
                          onChanged: (enabled) {
                            controller.setMasterLogsEnabled(enabled);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Enable All / Disable All buttons row
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              controller.enableAllCategories();
                            },
                            icon: const Icon(Icons.check_circle_outline,
                                size: 18),
                            label: const Text('Enable Categories'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.tonalIcon(
                            onPressed: () {
                              controller.disableAllCategories();
                            },
                            icon: const Icon(Icons.block, size: 18),
                            label: const Text('Disable Categories'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Reset Log Settings button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          controller.resetLogSettings();
                        },
                        icon: const Icon(Icons.restore, size: 18),
                        label: const Text('Reset Log Settings'),
                      ),
                    ),
                    const Divider(height: 24),
                    // Compact category list header
                    Text(
                      'Log Categories (AppLogger only)',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      'STAC framework logs are controlled by the master switch',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                    const SizedBox(height: 8),
                    // Responsive grid layout for categories
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Calculate columns based on width: 2 cols for <300, 3 for <500, 4 for wider
                        final cols = constraints.maxWidth < 300
                            ? 2
                            : (constraints.maxWidth < 500 ? 3 : 4);
                        final itemWidth =
                            (constraints.maxWidth - (cols - 1) * 4) / cols;
                        return Wrap(
                          spacing: 4,
                          runSpacing: 2,
                          children: LogCategory.values.map((category) {
                            final categorySettings =
                                settings.logCategorySettings[category] ??
                                    const LogCategorySettings();
                            return SizedBox(
                              width: itemWidth,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 32,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Switch(
                                        value: categorySettings.enabled,
                                        onChanged: (enabled) {
                                          controller.setLogCategorySettings(
                                            category,
                                            categorySettings.copyWith(
                                                enabled: enabled),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      category.name[0].toUpperCase() +
                                          category.name.substring(1),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: categorySettings.enabled
                                            ? null
                                            : Theme.of(context).disabledColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Truncate Settings - collapsible
                    ExpansionTile(
                      title: Text(
                        'Truncate Settings',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: const EdgeInsets.only(top: 8),
                      children: LogCategory.values.map((category) {
                        final categorySettings =
                            settings.logCategorySettings[category] ??
                                const LogCategorySettings();
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              // Category name
                              SizedBox(
                                width: 70,
                                child: Text(
                                  category.name[0].toUpperCase() +
                                      category.name.substring(1),
                                  style: const TextStyle(fontSize: 11),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Truncate toggle
                              SizedBox(
                                height: 28,
                                width: 36,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Switch(
                                    value: categorySettings.truncateEnabled,
                                    onChanged: (truncate) {
                                      controller.setLogCategorySettings(
                                        category,
                                        categorySettings.copyWith(
                                            truncateEnabled: truncate),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              // Max length control (compact)
                              Expanded(
                                child: categorySettings.truncateEnabled
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // Decrease button
                                          InkWell(
                                            onTap: () {
                                              final newValue =
                                                  (categorySettings.maxLength -
                                                          100)
                                                      .clamp(100, 5000);
                                              controller.setLogCategorySettings(
                                                category,
                                                categorySettings.copyWith(
                                                    maxLength: newValue),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .outline),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: const Icon(Icons.remove,
                                                  size: 12),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          // Value display
                                          SizedBox(
                                            width: 40,
                                            child: Text(
                                              '${categorySettings.maxLength}',
                                              style:
                                                  const TextStyle(fontSize: 10),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          // Increase button
                                          InkWell(
                                            onTap: () {
                                              final newValue =
                                                  (categorySettings.maxLength +
                                                          100)
                                                      .clamp(100, 5000);
                                              controller.setLogCategorySettings(
                                                category,
                                                categorySettings.copyWith(
                                                    maxLength: newValue),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .outline),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: const Icon(Icons.add,
                                                  size: 12),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        'No truncation',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color:
                                              Theme.of(context).disabledColor,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Data Source Section
            _buildSectionHeader(context, 'Data Source', Icons.cloud),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Use Supabase',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            settings.supabaseEnabled
                                ? 'Fetching data from Supabase'
                                : 'Using local mock JSON data',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: settings.supabaseEnabled,
                      onChanged: (enabled) {
                        controller.setSupabaseEnabled(enabled);
                        AppLogger.i(
                            '🔧 Data source switched to ${enabled ? "Supabase" : "Local Mock"}');
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (settings.supabaseEnabled) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Supabase Configuration',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Supabase credentials are configured via compile-time flags.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'To run with Supabase, use:',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '.\\run_with_supabase.ps1',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontFamily: 'monospace',
                                    ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Check the logs tab to verify the connection.',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Theme Mode Section
            _buildSectionHeader(context, 'Theme', Icons.palette),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appearance',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    SegmentedButton<DebugPanelThemeMode>(
                      segments: const [
                        ButtonSegment<DebugPanelThemeMode>(
                          value: DebugPanelThemeMode.light,
                          label: Text('Light'),
                          icon: Icon(Icons.light_mode),
                        ),
                        ButtonSegment<DebugPanelThemeMode>(
                          value: DebugPanelThemeMode.dark,
                          label: Text('Dark'),
                          icon: Icon(Icons.dark_mode),
                        ),
                        ButtonSegment<DebugPanelThemeMode>(
                          value: DebugPanelThemeMode.system,
                          label: Text('System'),
                          icon: Icon(Icons.brightness_auto),
                        ),
                      ],
                      selected: {settings.themeMode},
                      onSelectionChanged: (Set<DebugPanelThemeMode> selection) {
                        controller.setThemeMode(selection.first);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Text Scale Section
            _buildSectionHeader(context, 'Text Scale', Icons.text_fields),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Text Scale Factor: ${settings.textScaleFactor.toStringAsFixed(2)}x',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _SliderWithOverlay(
                      value: settings.textScaleFactor,
                      min: 0.8,
                      max: 2.0,
                      divisions: 12,
                      onChanged: (value) {
                        controller.setTextScaleFactor(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0.8x',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '2.0x',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // UI Size Section
            _buildSectionHeader(context, 'UI Size', Icons.aspect_ratio),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Panel Element Size',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    SegmentedButton<DebugPanelUISize>(
                      segments: const [
                        ButtonSegment<DebugPanelUISize>(
                          value: DebugPanelUISize.small,
                          label: Text('Small'),
                          icon: Icon(Icons.text_decrease),
                        ),
                        ButtonSegment<DebugPanelUISize>(
                          value: DebugPanelUISize.medium,
                          label: Text('Medium'),
                          icon: Icon(Icons.text_fields),
                        ),
                        ButtonSegment<DebugPanelUISize>(
                          value: DebugPanelUISize.large,
                          label: Text('Large'),
                          icon: Icon(Icons.text_increase),
                        ),
                      ],
                      selected: {settings.uiSize},
                      onSelectionChanged: (Set<DebugPanelUISize> selection) {
                        controller.setUISize(selection.first);
                      },
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Preview: Buttons, icons, and spacing will adjust based on selected size.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Layout Mode Section
            _buildSectionHeader(context, 'Layout Mode', Icons.view_quilt),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Panel Layout Orientation',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    SegmentedButton<DebugPanelLayoutMode>(
                      segments: const [
                        ButtonSegment<DebugPanelLayoutMode>(
                          value: DebugPanelLayoutMode.horizontal,
                          label: Text('Left-Right'),
                          icon: Icon(Icons.view_column),
                        ),
                        ButtonSegment<DebugPanelLayoutMode>(
                          value: DebugPanelLayoutMode.vertical,
                          label: Text('Top-Bottom'),
                          icon: Icon(Icons.view_array),
                        ),
                      ],
                      selected: {settings.layoutMode},
                      onSelectionChanged:
                          (Set<DebugPanelLayoutMode> selection) {
                        final newMode = selection.first;
                        AppLogger.i(
                            '🔄 Layout mode selection changed: ${newMode.name} (previous: ${settings.layoutMode.name})');
                        controller.setLayoutMode(newMode);
                        AppLogger.i('📝 Layout mode change request sent');
                      },
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Choose between side-by-side or top-bottom panel layout.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Reset Button
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  controller.setDebugPanelEnabled(true);
                  controller.setIspectDraggablePanelEnabled(true);
                  controller.setTextScaleFactor(1.0);
                  controller.setUISize(DebugPanelUISize.medium);
                  controller.setLayoutMode(DebugPanelLayoutMode.horizontal);
                  controller.setThemeMode(DebugPanelThemeMode.system);
                  controller.setSupabaseEnabled(false);
                },
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset to Defaults'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }
}

/// Widget that wraps a Slider in an Overlay context
class _SliderWithOverlay extends StatelessWidget {
  const _SliderWithOverlay({
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    // Navigator provides an Overlay context automatically
    return Navigator(
      pages: [
        MaterialPage<void>(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
      onPopPage: (route, result) => false,
    );
  }
}
