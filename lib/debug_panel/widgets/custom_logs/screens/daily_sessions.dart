import 'package:flutter/material.dart';
import 'package:ispect/ispect.dart';
import '../controllers/ispect_view_controller.dart';
import '../widgets/log_card.dart';

/// Screen that displays logs grouped by daily sessions.
class DailySessionsScreen extends StatelessWidget {
  const DailySessionsScreen({
    required this.controller,
    required this.logs,
    super.key,
  });

  final ISpectViewController controller;
  final List<ISpectLogData> logs;

  @override
  Widget build(BuildContext context) {
    final groupedLogs = _groupLogsByDay(logs);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Sessions'),
      ),
      body: groupedLogs.isEmpty
          ? Center(
              child: Text(
                'No logs available',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              itemCount: groupedLogs.length,
              itemBuilder: (context, index) {
                final entry = groupedLogs[index];
                return _buildDaySection(context, entry.key, entry.value);
              },
            ),
    );
  }

  Widget _buildDaySection(
    BuildContext context,
    String date,
    List<ISpectLogData> dayLogs,
  ) {
    return ExpansionTile(
      title: Text(date),
      subtitle: Text('${dayLogs.length} logs'),
      children: dayLogs.map((log) {
        final icon = _getIconForLog(log);
        final color = _getColorForLog(log);
        final index = dayLogs.indexOf(log);
        final isExpanded = controller.activeData?.hashCode == log.hashCode;

        return LogCard(
          icon: icon,
          color: color,
          data: log,
          index: index,
          isExpanded: isExpanded,
          onTap: () => controller.handleLogItemTap(log),
          observer: null, // [TODO]: Add observer if needed
          onCopyTap: () => controller.copyLogEntryText(
            context,
            log,
            (ctx, {required value}) {
              // Copy to clipboard
            },
          ),
        );
      }).toList(),
    );
  }

  List<MapEntry<String, List<ISpectLogData>>> _groupLogsByDay(
    List<ISpectLogData> logs,
  ) {
    final Map<String, List<ISpectLogData>> grouped = {};

    for (final log in logs) {
      final date = log.formattedTime.split(' ').first; // Extract date part
      grouped.putIfAbsent(date, () => []).add(log);
    }

    return grouped.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key)); // Sort by date descending
  }

  IconData _getIconForLog(ISpectLogData log) {
    final key = log.key;
    if (key == ISpectLogType.httpRequest.key) return Icons.http;
    final keyLower = key?.toLowerCase() ?? '';
    if (keyLower.contains('error')) return Icons.error;
    if (keyLower.contains('warning')) return Icons.warning;
    return Icons.info;
  }

  Color _getColorForLog(ISpectLogData log) {
    final key = log.key;
    if (key == ISpectLogType.httpRequest.key) return Colors.blue;
    final keyLower = key?.toLowerCase() ?? '';
    if (keyLower.contains('error')) return Colors.red;
    if (keyLower.contains('warning')) return Colors.orange;
    return Colors.green;
  }
}
