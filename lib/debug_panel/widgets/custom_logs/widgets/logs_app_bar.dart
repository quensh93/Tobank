import 'package:flutter/material.dart';
import 'package:ispect/ispect.dart';
import '../controllers/ispect_view_controller.dart';
import 'info_bottom_sheet.dart';
import 'share_all_logs_sheet.dart';

/// Custom AppBar for the logs screen with search and actions.
class LogsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LogsAppBar({
    required this.controller,
    required this.logs,
    this.title,
    this.onSearchChanged,
    super.key,
  });

  final ISpectViewController controller;
  final List<ISpectLogData> logs;
  final String? title;
  final ValueChanged<String>? onSearchChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null && title!.isNotEmpty
          ? Text(title!)
          : const Text('Logs'),
      actions: [
        // Search button
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearchDialog(context),
          tooltip: 'Search',
        ),
        // Info button
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => _showInfoSheet(context),
          tooltip: 'Info',
        ),
        // Share button
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () => _showShareSheet(context),
          tooltip: 'Share all logs',
        ),
        // Settings button
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => _showSettingsSheet(context),
          tooltip: 'Settings',
        ),
      ],
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Logs'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter search query',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            controller.updateFilterSearchQuery(value);
            onSearchChanged?.call(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.updateFilterSearchQuery('');
              onSearchChanged?.call('');
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const InfoBottomSheet(),
    );
  }

  void _showSettingsSheet(BuildContext context) {
    // Note: This method is not used - settings are handled via ISpectAppBar
    // If needed, use ISpectSettingsBottomSheet with proper parameters:
    // ISpectSettingsBottomSheet(
    //   ISpectLogger: ValueNotifier(ISpect.logger),
    //   options: ISpectOptions(...),
    //   controller: controller,
    //   actions: [...],
    // ).show(context);
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ShareAllLogsSheet(
        controller: controller,
        logs: logs,
      ),
    );
  }
}

