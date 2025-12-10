import 'package:flutter/material.dart';

/// A debug tool item widget with a toggle switch.
///
/// Displays an icon, title, subtitle, and a switch widget in a row layout.
/// Used for debug tools that have on/off states.
class DebugToolItemWithSwitch extends StatelessWidget {
  /// Creates a [DebugToolItemWithSwitch].
  const DebugToolItemWithSwitch({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    super.key,
  });

  /// The icon to display on the left
  final IconData icon;

  /// The title text
  final String title;

  /// The subtitle/description text displayed below the title
  final String subtitle;

  /// The current switch state
  final bool value;

  /// Callback when the switch state changes
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: colorScheme.primary,
            activeTrackColor: colorScheme.primary.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}
