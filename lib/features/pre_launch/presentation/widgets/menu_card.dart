import 'package:flutter/material.dart';

/// A reusable card widget for main menu items in the Pre Launch Screen.
///
/// Displays a horizontal button-like card with icon and title.
class MenuCard extends StatelessWidget {
  /// Creates a [MenuCard].
  const MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  /// The icon to display at the top of the card
  final IconData icon;

  /// The title text displayed in the card
  final String title;

  /// Unused legacy field kept to avoid changing call sites.
  final String subtitle;

  /// Callback when the card is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 12),
              Icon(icon, size: 22, color: colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
