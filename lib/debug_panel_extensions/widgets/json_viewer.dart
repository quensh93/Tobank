import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

/// JSON Viewer Widget
///
/// Displays JSON data with syntax highlighting, collapsible sections,
/// and copy-to-clipboard functionality.
class JsonViewer extends StatefulWidget {
  const JsonViewer({
    super.key,
    required this.jsonData,
    this.title,
    this.showCopyButton = true,
    this.expandAll = false,
  });

  /// JSON data to display (can be Map, List, or String)
  final dynamic jsonData;

  /// Optional title for the viewer
  final String? title;

  /// Whether to show the copy button
  final bool showCopyButton;

  /// Whether to expand all nodes by default
  final bool expandAll;

  @override
  State<JsonViewer> createState() => _JsonViewerState();
}

class _JsonViewerState extends State<JsonViewer> {
  late String _formattedJson;
  late Map<String, bool> _expandedNodes;

  @override
  void initState() {
    super.initState();
    _initializeJson();
  }

  @override
  void didUpdateWidget(JsonViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.jsonData != widget.jsonData) {
      _initializeJson();
    }
  }

  void _initializeJson() {
    try {
      if (widget.jsonData is String) {
        // Try to parse string as JSON
        try {
          final parsed = jsonDecode(widget.jsonData);
          _formattedJson = const JsonEncoder.withIndent('  ').convert(parsed);
        } catch (e) {
          // If parsing fails, use as-is
          _formattedJson = widget.jsonData;
        }
      } else if (widget.jsonData is Map || widget.jsonData is List) {
        _formattedJson = const JsonEncoder.withIndent('  ').convert(widget.jsonData);
      } else {
        _formattedJson = widget.jsonData.toString();
      }
      
      _expandedNodes = {};
    } catch (e) {
      _formattedJson = 'Error formatting JSON: $e';
      _expandedNodes = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _buildHeader(context),
          const Divider(height: 1, color: Colors.white24),
          
          // JSON content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildJsonContent(context),
            ),
          ),
        ],
      ),
    );
  }

  /// Build header with title and actions
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            Icons.code,
            color: Colors.grey[300],
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title ?? 'JSON Data',
              style: TextStyle(
                color: Colors.grey[300],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          if (widget.showCopyButton)
            IconButton(
              icon: const Icon(Icons.copy, color: Colors.white70, size: 18),
              onPressed: () => _copyToClipboard(context),
              tooltip: 'Copy JSON',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          IconButton(
            icon: Icon(
              widget.expandAll ? Icons.unfold_less : Icons.unfold_more,
              color: Colors.white70,
              size: 18,
            ),
            onPressed: _toggleExpandAll,
            tooltip: widget.expandAll ? 'Collapse All' : 'Expand All',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  /// Build JSON content with syntax highlighting
  Widget _buildJsonContent(BuildContext context) {
    try {
      final parsed = widget.jsonData is String
          ? jsonDecode(widget.jsonData)
          : widget.jsonData;
      
      return _buildJsonNode(parsed, '', 0);
    } catch (e) {
      return SelectableText(
        _formattedJson,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: Colors.white,
          fontSize: 12,
        ),
      );
    }
  }

  /// Build a JSON node (recursive)
  Widget _buildJsonNode(dynamic data, String key, int depth) {
    if (data is Map) {
      return _buildMapNode(data, key, depth);
    } else if (data is List) {
      return _buildListNode(data, key, depth);
    } else {
      return _buildValueNode(data, key, depth);
    }
  }

  /// Build a map node
  Widget _buildMapNode(Map data, String key, int depth) {
    final nodeKey = '$key-$depth-map';
    final isExpanded = _expandedNodes[nodeKey] ?? widget.expandAll;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expandedNodes[nodeKey] = !isExpanded;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: depth * 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                  color: Colors.grey[400],
                  size: 20,
                ),
                if (key.isNotEmpty) ...[
                  Text(
                    '"$key": ',
                    style: const TextStyle(
                      color: Color(0xFF9CDCFE), // Light blue for keys
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ],
                Text(
                  '{',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
                Text(
                  ' ${data.length} ${data.length == 1 ? 'item' : 'items'}',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          ...data.entries.map((entry) {
            return _buildJsonNode(entry.value, entry.key, depth + 1);
          }),
          Padding(
            padding: EdgeInsets.only(left: depth * 16.0),
            child: const Text(
              '}',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ] else ...[
          Padding(
            padding: EdgeInsets.only(left: depth * 16.0 + 20),
            child: const Text(
              '...',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: depth * 16.0),
            child: const Text(
              '}',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Build a list node
  Widget _buildListNode(List data, String key, int depth) {
    final nodeKey = '$key-$depth-list';
    final isExpanded = _expandedNodes[nodeKey] ?? widget.expandAll;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expandedNodes[nodeKey] = !isExpanded;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: depth * 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                  color: Colors.grey[400],
                  size: 20,
                ),
                if (key.isNotEmpty) ...[
                  Text(
                    '"$key": ',
                    style: const TextStyle(
                      color: Color(0xFF9CDCFE), // Light blue for keys
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ],
                Text(
                  '[',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
                Text(
                  ' ${data.length} ${data.length == 1 ? 'item' : 'items'}',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          ...data.asMap().entries.map((entry) {
            return _buildJsonNode(entry.value, entry.key.toString(), depth + 1);
          }),
          Padding(
            padding: EdgeInsets.only(left: depth * 16.0),
            child: const Text(
              ']',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ] else ...[
          Padding(
            padding: EdgeInsets.only(left: depth * 16.0 + 20),
            child: const Text(
              '...',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: depth * 16.0),
            child: const Text(
              ']',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Build a value node (leaf)
  Widget _buildValueNode(dynamic data, String key, int depth) {
    final valueColor = _getValueColor(data);
    final valueText = _formatValue(data);
    
    return Padding(
      padding: EdgeInsets.only(left: depth * 16.0),
      child: SelectableText.rich(
        TextSpan(
          children: [
            if (key.isNotEmpty)
              TextSpan(
                text: '"$key": ',
                style: const TextStyle(
                  color: Color(0xFF9CDCFE), // Light blue for keys
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            TextSpan(
              text: valueText,
              style: TextStyle(
                color: valueColor,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            const TextSpan(
              text: ',',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get color for value based on type
  Color _getValueColor(dynamic value) {
    if (value == null) {
      return const Color(0xFF569CD6); // Blue for null
    } else if (value is bool) {
      return const Color(0xFF569CD6); // Blue for boolean
    } else if (value is num) {
      return const Color(0xFFB5CEA8); // Green for numbers
    } else if (value is String) {
      return const Color(0xFFCE9178); // Orange for strings
    } else {
      return Colors.white;
    }
  }

  /// Format value for display
  String _formatValue(dynamic value) {
    if (value == null) {
      return 'null';
    } else if (value is bool) {
      return value.toString();
    } else if (value is num) {
      return value.toString();
    } else if (value is String) {
      return '"$value"';
    } else {
      return value.toString();
    }
  }

  /// Toggle expand/collapse all nodes
  void _toggleExpandAll() {
    setState(() {
      if (widget.expandAll) {
        // Collapse all
        _expandedNodes.clear();
      } else {
        // Expand all - set all nodes to expanded
        _expandAllNodes(widget.jsonData, '', 0);
      }
    });
  }

  /// Recursively expand all nodes
  void _expandAllNodes(dynamic data, String key, int depth) {
    if (data is Map) {
      final nodeKey = '$key-$depth-map';
      _expandedNodes[nodeKey] = true;
      for (var entry in data.entries) {
        _expandAllNodes(entry.value, entry.key, depth + 1);
      }
    } else if (data is List) {
      final nodeKey = '$key-$depth-list';
      _expandedNodes[nodeKey] = true;
      for (var i = 0; i < data.length; i++) {
        _expandAllNodes(data[i], i.toString(), depth + 1);
      }
    }
  }

  /// Copy JSON to clipboard
  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _formattedJson));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('JSON copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

/// Simple JSON Viewer for displaying formatted JSON without collapsible sections
class SimpleJsonViewer extends StatelessWidget {
  const SimpleJsonViewer({
    super.key,
    required this.jsonData,
    this.title,
    this.showCopyButton = true,
    this.maxHeight,
  });

  final dynamic jsonData;
  final String? title;
  final bool showCopyButton;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    final formattedJson = _formatJson(jsonData);
    
    return Container(
      constraints: maxHeight != null ? BoxConstraints(maxHeight: maxHeight!) : null,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.code,
                  color: Colors.grey[300],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title ?? 'JSON Data',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (showCopyButton)
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white70, size: 18),
                    onPressed: () => _copyToClipboard(context, formattedJson),
                    tooltip: 'Copy JSON',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.white24),
          
          // JSON content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SelectableText(
                formattedJson,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatJson(dynamic data) {
    try {
      if (data is String) {
        try {
          final parsed = jsonDecode(data);
          return const JsonEncoder.withIndent('  ').convert(parsed);
        } catch (e) {
          return data;
        }
      } else if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      } else {
        return data.toString();
      }
    } catch (e) {
      return 'Error formatting JSON: $e';
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('JSON copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
