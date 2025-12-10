import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tobank_sdui/core/logging/stac_log_models.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

/// STAC Log Viewer Widget
///
/// Displays detailed information about a STAC log entry including
/// JSON data with syntax highlighting and performance metrics.
class StacLogViewer extends StatelessWidget {
  const StacLogViewer({
    super.key,
    required this.logEntry,
    this.onClose,
  });

  final StacLogEntry logEntry;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(context),
          const Divider(height: 1),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview section
                  _buildOverviewSection(context),
                  const SizedBox(height: 24),
                  
                  // Performance metrics
                  _buildPerformanceSection(context),
                  const SizedBox(height: 24),
                  
                  // Error details (if error)
                  if (logEntry.isError) ...[
                    _buildErrorSection(context),
                    const SizedBox(height: 24),
                  ],
                  
                  // Metadata section
                  if (logEntry.metadata.isNotEmpty) ...[
                    _buildMetadataSection(context),
                    const SizedBox(height: 24),
                  ],
                  
                  // JSON data (if available)
                  if (_hasJsonData()) ...[
                    _buildJsonSection(context),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build header with title and close button
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: _getOperationColor().withValues(alpha: 0.1),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getOperationColor().withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getOperationIcon(),
              color: _getOperationColor(),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  logEntry.operationName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getOperationColor(),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  logEntry.screenName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (onClose != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onClose,
              tooltip: 'Close',
            ),
        ],
      ),
    );
  }

  /// Build overview section with basic information
  Widget _buildOverviewSection(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    
    return _buildSection(
      context,
      title: 'Overview',
      icon: Icons.info_outline,
      children: [
        _buildInfoRow(
          context,
          label: 'Timestamp',
          value: dateFormat.format(logEntry.timestamp),
          icon: Icons.access_time,
        ),
        _buildInfoRow(
          context,
          label: 'Screen Name',
          value: logEntry.screenName,
          icon: Icons.phone_android,
        ),
        if (logEntry.source != null)
          _buildInfoRow(
            context,
            label: 'API Source',
            value: logEntry.source!.name.toUpperCase(),
            icon: Icons.cloud,
            valueColor: _getSourceColor(logEntry.source!),
          ),
        _buildInfoRow(
          context,
          label: 'Operation ID',
          value: logEntry.id,
          icon: Icons.fingerprint,
          copyable: true,
        ),
      ],
    );
  }

  /// Build performance metrics section
  Widget _buildPerformanceSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Performance Metrics',
      icon: Icons.speed,
      children: [
        _buildMetricCard(
          context,
          label: 'Duration',
          value: logEntry.formattedDuration,
          icon: Icons.timer,
          color: logEntry.isSlow ? Colors.orange : Colors.green,
          subtitle: logEntry.isSlow ? 'Slow operation detected' : 'Normal performance',
        ),
        if (logEntry.metadata.containsKey('size_kb'))
          _buildMetricCard(
            context,
            label: 'Data Size',
            value: '${logEntry.metadata['size_kb']} KB',
            icon: Icons.storage,
            color: Colors.blue,
          ),
        if (logEntry.metadata.containsKey('widget_count'))
          _buildMetricCard(
            context,
            label: 'Widget Count',
            value: logEntry.metadata['widget_count'].toString(),
            icon: Icons.widgets,
            color: Colors.purple,
          ),
        if (logEntry.metadata.containsKey('property_count'))
          _buildMetricCard(
            context,
            label: 'Properties',
            value: logEntry.metadata['property_count'].toString(),
            icon: Icons.settings,
            color: Colors.teal,
          ),
      ],
    );
  }

  /// Build error section (for error logs)
  Widget _buildErrorSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Error Details',
      icon: Icons.error_outline,
      color: Colors.red,
      children: [
        if (logEntry.error != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.error, color: Colors.red, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Error Message',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        logEntry.error!,
                        style: TextStyle(
                          color: Colors.red[900],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (logEntry.suggestion != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.blue, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suggestion',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        logEntry.suggestion!,
                        style: TextStyle(
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  /// Build metadata section
  Widget _buildMetadataSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Metadata',
      icon: Icons.data_object,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: logEntry.metadata.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value.toString(),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// Build JSON section with syntax highlighting
  Widget _buildJsonSection(BuildContext context) {
    final jsonData = _getJsonData();
    if (jsonData == null) return const SizedBox.shrink();

    return _buildSection(
      context,
      title: 'JSON Data',
      icon: Icons.code,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'JSON Preview',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white70),
                    onPressed: () => _copyToClipboard(context, jsonData),
                    tooltip: 'Copy JSON',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SelectableText(
                  jsonData,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build a section with title and children
  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color ?? Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  /// Build an info row with label and value
  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
    bool copyable = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: valueColor ?? Theme.of(context).colorScheme.onSurface,
                      fontFamily: copyable ? 'monospace' : null,
                    ),
                  ),
                ),
                if (copyable)
                  IconButton(
                    icon: const Icon(Icons.copy, size: 16),
                    onPressed: () => _copyToClipboard(context, value),
                    tooltip: 'Copy',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build a metric card
  Widget _buildMetricCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    String? subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Get operation color
  Color _getOperationColor() {
    switch (logEntry.operationType) {
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

  /// Get operation icon
  IconData _getOperationIcon() {
    switch (logEntry.operationType) {
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

  /// Get source color
  Color _getSourceColor(ApiSource source) {
    switch (source) {
      case ApiSource.mock:
        return Colors.blue;
      case ApiSource.supabase:
        return Colors.orange;
      case ApiSource.custom:
        return Colors.purple;
    }
  }

  /// Check if log entry has JSON data
  bool _hasJsonData() {
    return logEntry.metadata.containsKey('json') ||
        logEntry.metadata.containsKey('widgets') ||
        logEntry.metadata.containsKey('properties');
  }

  /// Get formatted JSON data
  String? _getJsonData() {
    try {
      // Try to get JSON from metadata
      if (logEntry.metadata.containsKey('json')) {
        final json = logEntry.metadata['json'];
        if (json is Map || json is List) {
          return const JsonEncoder.withIndent('  ').convert(json);
        }
        return json.toString();
      }

      // If no direct JSON, format the metadata itself
      if (logEntry.metadata.isNotEmpty) {
        return const JsonEncoder.withIndent('  ').convert(logEntry.metadata);
      }

      return null;
    } catch (e) {
      return 'Error formatting JSON: $e';
    }
  }

  /// Copy text to clipboard
  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
