import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/core/logging/stac_logger.dart';
import 'package:tobank_sdui/core/logging/stac_log_models.dart';
import 'package:intl/intl.dart';

/// STAC Logs Tab for the debug panel
///
/// Displays STAC-specific logs including screen fetching, JSON parsing,
/// component rendering, and errors with filtering and search capabilities.
class StacLogsTab extends ConsumerStatefulWidget {
  const StacLogsTab({super.key});

  @override
  ConsumerState<StacLogsTab> createState() => _StacLogsTabState();
}

class _StacLogsTabState extends ConsumerState<StacLogsTab> {
  // Filter states
  final Set<StacOperationType> _selectedOperationTypes = StacOperationType.values.toSet();
  final Set<ApiSource> _selectedApiSources = ApiSource.values.toSet();
  String _searchQuery = '';
  DateTime? _startDate;
  DateTime? _endDate;

  // Selected log entry for detail view
  StacLogEntry? _selectedLogEntry;

  @override
  Widget build(BuildContext context) {
    final logs = _getFilteredLogs();
    final stats = StacLogger.instance.getStatistics();

    return Column(
      children: [
        // Statistics bar
        _buildStatisticsBar(stats),
        const Divider(height: 1),
        
        // Filter bar
        _buildFilterBar(),
        const Divider(height: 1),
        
        // Logs list
        Expanded(
          child: logs.isEmpty
              ? _buildEmptyState()
              : Row(
                  children: [
                    // Log list
                    Expanded(
                      flex: _selectedLogEntry == null ? 1 : 2,
                      child: _buildLogsList(logs),
                    ),
                    
                    // Detail view (if log selected)
                    if (_selectedLogEntry != null) ...[
                      const VerticalDivider(width: 1),
                      Expanded(
                        flex: 3,
                        child: _buildDetailView(_selectedLogEntry!),
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }

  /// Build statistics bar showing summary metrics
  Widget _buildStatisticsBar(Map<String, dynamic> stats) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          _buildStatChip(
            icon: Icons.list,
            label: 'Total',
            value: stats['total_logs'].toString(),
            color: Colors.blue,
          ),
          const SizedBox(width: 12),
          _buildStatChip(
            icon: Icons.download,
            label: 'Fetch',
            value: stats['fetch_count'].toString(),
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          _buildStatChip(
            icon: Icons.code,
            label: 'Parse',
            value: stats['parse_count'].toString(),
            color: Colors.orange,
          ),
          const SizedBox(width: 12),
          _buildStatChip(
            icon: Icons.brush,
            label: 'Render',
            value: stats['render_count'].toString(),
            color: Colors.purple,
          ),
          const SizedBox(width: 12),
          _buildStatChip(
            icon: Icons.error,
            label: 'Errors',
            value: stats['error_count'].toString(),
            color: Colors.red,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear all logs',
            onPressed: () {
              _showClearLogsDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// Build filter bar with operation type, API source, and search filters
  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search field
          TextField(
            decoration: InputDecoration(
              hintText: 'Search by screen name or component type...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
          const SizedBox(height: 12),
          
          // Filter chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              // Operation type filters
              ...StacOperationType.values.map((type) {
                final isSelected = _selectedOperationTypes.contains(type);
                return FilterChip(
                  label: Text(_getOperationTypeLabel(type)),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedOperationTypes.add(type);
                      } else {
                        _selectedOperationTypes.remove(type);
                      }
                    });
                  },
                  avatar: Icon(
                    _getOperationTypeIcon(type),
                    size: 16,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                );
              }),
              
              const SizedBox(width: 8),
              
              // API source filters
              ...ApiSource.values.map((source) {
                final isSelected = _selectedApiSources.contains(source);
                return FilterChip(
                  label: Text(source.name.toUpperCase()),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedApiSources.add(source);
                      } else {
                        _selectedApiSources.remove(source);
                      }
                    });
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  /// Build the logs list view
  Widget _buildLogsList(List<StacLogEntry> logs) {
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        final isSelected = _selectedLogEntry?.id == log.id;
        
        return _buildLogListItem(log, isSelected);
      },
    );
  }

  /// Build a single log list item
  Widget _buildLogListItem(StacLogEntry log, bool isSelected) {
    final color = _getOperationTypeColor(log.operationType);
    final timeFormat = DateFormat('HH:mm:ss.SSS');
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedLogEntry = isSelected ? null : log;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
              : null,
          border: Border(
            left: BorderSide(
              color: color,
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: [
            // Operation icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getOperationTypeIcon(log.operationType),
                size: 20,
                color: color,
              ),
            ),
            const SizedBox(width: 12),
            
            // Log details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        log.screenName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (log.source != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            log.source!.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        timeFormat.format(log.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: log.isSlow
                              ? Colors.orange.withValues(alpha: 0.2)
                              : Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          log.formattedDuration,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: log.isSlow ? Colors.orange[700] : Colors.green[700],
                          ),
                        ),
                      ),
                      if (log.isError) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.error,
                          size: 16,
                          color: Colors.red,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            
            // Chevron icon
            Icon(
              isSelected ? Icons.chevron_right : Icons.chevron_left,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  /// Build detail view for selected log entry
  Widget _buildDetailView(StacLogEntry log) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                _getOperationTypeIcon(log.operationType),
                color: _getOperationTypeColor(log.operationType),
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log.operationName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      log.screenName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _selectedLogEntry = null;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Metadata
          _buildDetailSection(
            'Details',
            [
              _buildDetailRow('Timestamp', DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(log.timestamp)),
              _buildDetailRow('Duration', log.formattedDuration),
              if (log.source != null)
                _buildDetailRow('Source', log.source!.name.toUpperCase()),
              _buildDetailRow('Operation ID', log.id),
            ],
          ),
          
          // Error details (if error)
          if (log.isError) ...[
            const SizedBox(height: 24),
            _buildDetailSection(
              'Error Information',
              [
                if (log.error != null)
                  _buildDetailRow('Error', log.error!, isError: true),
                if (log.suggestion != null)
                  _buildDetailRow('Suggestion', log.suggestion!, isInfo: true),
              ],
            ),
          ],
          
          // Additional metadata
          if (log.metadata.isNotEmpty) ...[
            const SizedBox(height: 24),
            _buildDetailSection(
              'Metadata',
              log.metadata.entries.map((entry) {
                return _buildDetailRow(
                  entry.key,
                  entry.value.toString(),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isError = false, bool isInfo = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isError
                    ? Colors.red
                    : isInfo
                        ? Colors.blue
                        : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty state when no logs match filters
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No STAC logs found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or perform some STAC operations',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// Get filtered logs based on current filter settings
  List<StacLogEntry> _getFilteredLogs() {
    var logs = StacLogger.instance.logEntries;

    // Filter by operation type
    logs = logs.where((log) => _selectedOperationTypes.contains(log.operationType)).toList();

    // Filter by API source
    logs = logs.where((log) {
      if (log.source == null) return true;
      return _selectedApiSources.contains(log.source);
    }).toList();

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      logs = logs.where((log) {
        return log.screenName.toLowerCase().contains(_searchQuery) ||
            log.metadata.values.any((value) =>
                value.toString().toLowerCase().contains(_searchQuery));
      }).toList();
    }

    // Filter by date range
    if (_startDate != null) {
      logs = logs.where((log) => log.timestamp.isAfter(_startDate!)).toList();
    }
    if (_endDate != null) {
      logs = logs.where((log) => log.timestamp.isBefore(_endDate!)).toList();
    }

    // Sort by timestamp (newest first)
    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return logs;
  }

  /// Show dialog to confirm clearing all logs
  void _showClearLogsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Logs'),
        content: const Text('Are you sure you want to clear all STAC logs? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              StacLogger.instance.clearLogs();
              setState(() {
                _selectedLogEntry = null;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  /// Get color for operation type
  Color _getOperationTypeColor(StacOperationType type) {
    switch (type) {
      case StacOperationType.fetch:
        return Colors.green;
      case StacOperationType.parse:
        return Colors.orange;
      case StacOperationType.render:
        return Colors.purple;
      case StacOperationType.error:
        return Colors.red;
    }
  }

  /// Get icon for operation type
  IconData _getOperationTypeIcon(StacOperationType type) {
    switch (type) {
      case StacOperationType.fetch:
        return Icons.download;
      case StacOperationType.parse:
        return Icons.code;
      case StacOperationType.render:
        return Icons.brush;
      case StacOperationType.error:
        return Icons.error;
    }
  }

  /// Get label for operation type
  String _getOperationTypeLabel(StacOperationType type) {
    switch (type) {
      case StacOperationType.fetch:
        return 'Fetch';
      case StacOperationType.parse:
        return 'Parse';
      case StacOperationType.render:
        return 'Render';
      case StacOperationType.error:
        return 'Error';
    }
  }
}
