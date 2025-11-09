import 'package:flutter/material.dart';

/// A reusable list item widget for debug tools in the Pre Launch Screen.
///
/// Displays an icon, title, optional subtitle, and chevron in a row layout
/// with tap feedback and conditional border radius.
class DebugToolItem extends StatelessWidget {
  /// Creates a [DebugToolItem].
  const DebugToolItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.isLast = false,
    super.key,
  });

  /// The icon to display on the left
  final IconData icon;

  /// The title text
  final String title;

  /// Optional subtitle text displayed below the title
  final String? subtitle;

  /// Callback when the item is tapped
  final VoidCallback onTap;

  /// Whether this is the last item in the list (affects border radius)
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            )
          : BorderRadius.zero,
      child: Padding(
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
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
