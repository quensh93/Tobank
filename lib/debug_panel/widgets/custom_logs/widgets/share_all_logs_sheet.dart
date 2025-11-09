import 'package:flutter/material.dart';
import 'package:ispect/ispect.dart';
import '../controllers/ispect_view_controller.dart';

/// Bottom sheet for sharing all logs as a file.
class ShareAllLogsSheet extends StatelessWidget {
  const ShareAllLogsSheet({
    required this.controller,
    required this.logs,
    super.key,
  });

  final ISpectViewController controller;
  final List<ISpectLogData> logs;

  Future<void> show(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Share All Logs',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Export all ${logs.length} log entries as a JSON file.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () async {
                  await controller.shareAllLogsAsJsonFile(logs);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Share'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

