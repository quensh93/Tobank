import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/debug_panel_settings_state.dart';
import '../themes/debug_panel_theme.dart';
import '../../core/helpers/logger.dart';

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
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          settings.debugPanelEnabled
                              ? 'Panel is currently visible'
                              : 'Panel is hidden',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: settings.debugPanelEnabled,
                    onChanged: (enabled) {
                      controller.setDebugPanelEnabled(enabled);
                      AppLogger.i('🔧 Debug panel ${enabled ? "enabled" : "disabled"} from Settings');
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
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          settings.ispectDraggablePanelEnabled
                              ? 'Floating panel is visible'
                              : 'Floating panel is hidden',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: settings.ispectDraggablePanelEnabled,
                    onChanged: (enabled) {
                      controller.setIspectDraggablePanelEnabled(enabled);
                      AppLogger.i('🔧 ISpect draggable panel ${enabled ? "enabled" : "disabled"} from Settings');
                    },
                  ),
                ],
              ),
            ),
          ),

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
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
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
                    onSelectionChanged: (Set<DebugPanelLayoutMode> selection) {
                      final newMode = selection.first;
                      AppLogger.i('🔄 Layout mode selection changed: ${newMode.name} (previous: ${settings.layoutMode.name})');
                      controller.setLayoutMode(newMode);
                      AppLogger.i('📝 Layout mode change request sent');
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Choose between side-by-side or top-bottom panel layout.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
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

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
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

