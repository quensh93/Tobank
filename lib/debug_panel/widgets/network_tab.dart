import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/network_simulator_state.dart';
import '../../core/helpers/logger.dart';

/// Network tab for debug panel - network simulator controls
class NetworkTab extends ConsumerWidget {
  const NetworkTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(networkSimulatorProvider);
    final controller = ref.read(networkSimulatorProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Network Simulator Section
            _buildSectionHeader(
                context, 'Network Simulator', Icons.network_check),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enable/Disable Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Network Simulator',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                settings.isEnabled
                                    ? 'Simulating network conditions'
                                    : 'Disabled - Normal network speed',
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
                          value: settings.isEnabled,
                          onChanged: (enabled) {
                            controller.setEnabled(enabled);
                            AppLogger.i(
                                '🔄 Network simulator ${enabled ? "enabled" : "disabled"}');
                          },
                        ),
                      ],
                    ),

                    // Settings are only visible when enabled
                    if (settings.isEnabled) ...[
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Network Speed Selection
                      Text(
                        'Network Speed',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 12),
                      SegmentedButton<NetworkSpeedOption>(
                        segments: const [
                          ButtonSegment<NetworkSpeedOption>(
                            value: NetworkSpeedOption.gprs2G,
                            label: Text('GPRS'),
                          ),
                          ButtonSegment<NetworkSpeedOption>(
                            value: NetworkSpeedOption.edge2G,
                            label: Text('EDGE'),
                          ),
                          ButtonSegment<NetworkSpeedOption>(
                            value: NetworkSpeedOption.hspa3G,
                            label: Text('HSPA'),
                          ),
                          ButtonSegment<NetworkSpeedOption>(
                            value: NetworkSpeedOption.lte4G,
                            label: Text('LTE'),
                          ),
                        ],
                        selected: {settings.networkSpeed},
                        onSelectionChanged:
                            (Set<NetworkSpeedOption> selection) {
                          controller.setNetworkSpeed(selection.first);
                          AppLogger.i(
                              '🔄 Network speed changed to: ${selection.first.displayName}');
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Current: ${settings.networkSpeed.displayName}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.6),
                            ),
                      ),
                      const SizedBox(height: 24),

                      // Failure Probability Slider
                      Text(
                        'Failure Probability: ${(settings.failureProbability * 100).toStringAsFixed(0)}%',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 12),
                      _SliderWithOverlay(
                        value: settings.failureProbability,
                        min: 0.0,
                        max: 1.0,
                        divisions: 20,
                        onChanged: (value) {
                          controller.setFailureProbability(value);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0%',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '100%',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Probability of network request failures for testing error handling.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.6),
                            ),
                      ),
                    ] else ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Enable network simulator to test your app under different network conditions.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Info Section
            _buildSectionHeader(context, 'About', Icons.info),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Network Simulator Features',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoItem(
                      context,
                      Icons.speed,
                      'Simulate different network speeds',
                      'Test your app behavior under 2G, 3G, or 4G conditions',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoItem(
                      context,
                      Icons.error_outline,
                      'Test failure scenarios',
                      'Configure failure probability to test error handling',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoItem(
                      context,
                      Icons.toggle_on,
                      'Easy to disable',
                      'When disabled, all network requests bypass simulation',
                    ),
                  ],
                ),
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

  Widget _buildInfoItem(
      BuildContext context, IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
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
      onDidRemovePage: (page) {},
    );
  }
}
