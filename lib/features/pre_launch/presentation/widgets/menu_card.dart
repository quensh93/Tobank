import 'package:flutter/material.dart';

/// A reusable card widget for main menu items in the Pre Launch Screen.
///
/// Displays an icon, title, and subtitle in a card with rounded corners,
/// subtle border, and tap feedback.
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

  /// The title text displayed below the icon
  final String title;

  /// The subtitle/description text displayed below the title
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 24,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
