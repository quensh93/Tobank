import 'package:flutter/material.dart';
import 'package:tobank_sdui/debug_panel/screens/json_playground_screen.dart';
import 'package:tobank_sdui/debug_panel_extensions/widgets/stac_logs_tab.dart';

/// Full-screen STAC Logs Screen
///
/// This screen displays the STAC logs tab in a full-screen view
/// that can be navigated to from the debug panel's Tools tab.
class StacLogsScreen extends StatelessWidget {
  const StacLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STAC Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const JsonPlaygroundScreen(),
                ),
              );
            },
            tooltip: 'Open JSON Playground',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showInfoDialog(context);
            },
            tooltip: 'About STAC Logs',
          ),
        ],
      ),
      body: const StacLogsTab(),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About STAC Logs'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'STAC Logs provides comprehensive visibility into all STAC (Server-Driven UI) operations.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Features:'),
              SizedBox(height: 8),
              Text('• Real-time log monitoring'),
              Text('• Filter by operation type and API source'),
              Text('• Search by screen name or component'),
              Text('• Detailed log viewer with JSON data'),
              Text('• Performance metrics tracking'),
              SizedBox(height: 16),
              Text(
                'Use the filters and search to find specific logs, and click on any log entry to view detailed information.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
