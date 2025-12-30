import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ispect/ispect.dart';
import '../extensions/context.dart';
import '../utils/copy_clipboard.dart';
import 'gap.dart';
import '../screens/navigation_flow.dart';

part 'collapsed_body.dart';

class LogCard extends StatelessWidget {
  const LogCard({
    required this.icon,
    required this.color,
    required this.data,
    required this.index,
    required this.isExpanded,
    required this.onTap,
    this.observer,
    this.onCopyTap,
    super.key,
  });

  final ISpectLogData data;
  final IconData icon;
  final Color color;
  final int index;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback? onCopyTap;
  final ISpectNavigatorObserver? observer;

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: Container(
          // Removed AnimatedContainer - causes jank during scrolling
          color:
              isExpanded ? color.withValues(alpha: 0.08) : Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LogCardHeader(
                icon: icon,
                color: color,
                data: data,
                isExpanded: isExpanded,
                onTap: onTap,
                onCopyTap: onCopyTap,
                observer: observer,
              ),
              if (isExpanded) ...[
                _ExpandedContent(
                  data: data,
                  color: color,
                ),
              ],
            ],
          ),
        ),
      );
}

class _LogCardHeader extends StatelessWidget {
  const _LogCardHeader({
    required this.icon,
    required this.color,
    required this.data,
    required this.isExpanded,
    required this.onTap,
    required this.observer,
    this.onCopyTap,
  });

  final IconData icon;
  final Color color;
  final ISpectLogData data;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback? onCopyTap;
  final ISpectNavigatorObserver? observer;

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: CollapsedBody(
              icon: icon,
              color: color,
              title: data.key,
              dateTime: data.formattedTime,
              onCopyTap: onCopyTap,
              onRouteTap: data.isRouteLog && observer != null
                  ? () => ISpectNavigationFlowScreen(
                        observer: observer!,
                        log: data as RouteLog,
                      ).push(context)
                  : null,
              onExpandTap: () => JsonScreen(
                data: data.toJson(),
                truncatedData: data.toJson(truncated: true),
              ).push(context),
              message: data.textMessage,
              errorMessage: data.httpLogText,
              expanded: isExpanded,
              isHTTP: data.key == ISpectLogType.httpRequest.key,
              onCopyCurlTap: () {
                final curl = data.curlCommand;
                if (curl != null) {
                  copyClipboard(context, value: curl);
                }
              },
            ),
          ),
        ),
      );
}

class _ExpandedContent extends StatelessWidget {
  const _ExpandedContent({
    required this.data,
    required this.color,
  });

  final ISpectLogData data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final hasStackTrace = data.stackTraceLogText?.isNotEmpty ?? false;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 1,
          color: context.ispectTheme.dividerColor,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LazyExpandedBody(
                data: data,
                color: color,
                hasStackTrace: hasStackTrace,
              ),
              if (hasStackTrace)
                _LazyStackTraceBody(
                  color: color,
                  stackTrace: data.stackTraceLogText!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Displays expanded content for log entries with conditional styling and text sections
class _LazyExpandedBody extends StatelessWidget {
  const _LazyExpandedBody({
    required this.data,
    required this.color,
    required this.hasStackTrace,
  });

  final ISpectLogData data;
  final Color color;
  final bool hasStackTrace;

  @override
  Widget build(BuildContext context) => _LogContentContainer(
        hasStackTrace: hasStackTrace,
        color: color,
        child: _LogTextContent(
          message: data.textMessage,
          type: data.typeText,
          errorMessage: data.httpLogText,
          isHTTP: data.isHttpLog,
          textStyle: TextStyle(
            color: color,
            fontSize: 12,
          ),
        ),
      );
}

class _LazyStackTraceBody extends StatelessWidget {
  const _LazyStackTraceBody({
    required this.color,
    required this.stackTrace,
  });

  final String stackTrace;
  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: SizedBox(
          width: double.maxFinite,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: color),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: SelectableText(
                stackTrace,
                maxLines: 50,
                minLines: 1,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      );
}

/// Container widget that handles decoration based on stack trace presence
class _LogContentContainer extends StatelessWidget {
  const _LogContentContainer({
    required this.hasStackTrace,
    required this.color,
    required this.child,
  });

  final bool hasStackTrace;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.maxFinite,
        child: DecoratedBox(
          decoration: hasStackTrace
              ? BoxDecoration(
                  border: Border.all(color: color),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                )
              : const BoxDecoration(),
          child: Padding(
            padding: hasStackTrace ? const EdgeInsets.all(6) : EdgeInsets.zero,
            child: child,
          ),
        ),
      );
}

class _LogTextContent extends StatelessWidget {
  const _LogTextContent({
    required this.message,
    required this.type,
    required this.errorMessage,
    required this.isHTTP,
    required this.textStyle,
  });

  final String? message;
  final String? type;
  final String? errorMessage;
  final bool isHTTP;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show message only if conditions are met
          if (message != null && !isHTTP && errorMessage == null)
            _buildFormattedContent(message!, textStyle),

          // Show type if available
          if (type != null) SelectableText(type!, style: textStyle),

          // Show error message if available
          if (errorMessage != null)
            _buildFormattedContent(errorMessage!, textStyle),
        ],
      );

  /// Build formatted content - detects JSON and formats it nicely
  Widget _buildFormattedContent(String content, TextStyle style) {
    // Try to detect and parse JSON in the content
    final result = _tryExtractJson(content);
    if (result != null) {
      final (prefix, jsonData) = result;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefix.isNotEmpty) SelectableText(prefix, style: style),
          _JsonFormattedText(data: jsonData, baseColor: style.color),
        ],
      );
    }
    return SelectableText(content, style: style);
  }

  /// Try to extract JSON from content - handles both pure JSON and embedded JSON
  /// Returns a tuple of (prefix text, parsed JSON) or null if no JSON found
  (String, dynamic)? _tryExtractJson(String content) {
    final trimmed = content.trim();

    // First try: pure JSON (starts with { or [)
    if ((trimmed.startsWith('{') && trimmed.endsWith('}')) ||
        (trimmed.startsWith('[') && trimmed.endsWith(']'))) {
      try {
        return ('', jsonDecode(trimmed));
      } catch (_) {
        // Not valid JSON, continue to embedded search
      }
    }

    // Second try: find embedded JSON (e.g., "Response: {data: ...}")
    final jsonStartIndex = _findJsonStart(trimmed);
    if (jsonStartIndex >= 0) {
      final prefix = trimmed.substring(0, jsonStartIndex).trim();
      final jsonPart = trimmed.substring(jsonStartIndex);

      // Find matching closing bracket
      final jsonString = _extractBalancedJson(jsonPart);
      if (jsonString != null) {
        try {
          return (prefix, jsonDecode(jsonString));
        } catch (_) {
          // Invalid JSON, return null
        }
      }
    }

    return null;
  }

  /// Find the start index of a JSON object or array in the string
  int _findJsonStart(String content) {
    final objectStart = content.indexOf('{');
    final arrayStart = content.indexOf('[');

    if (objectStart < 0) return arrayStart;
    if (arrayStart < 0) return objectStart;
    return objectStart < arrayStart ? objectStart : arrayStart;
  }

  /// Extract a balanced JSON string (matching braces/brackets)
  String? _extractBalancedJson(String content) {
    if (content.isEmpty) return null;

    final openChar = content[0];
    final closeChar = openChar == '{' ? '}' : ']';
    if (openChar != '{' && openChar != '[') return null;

    int depth = 0;
    bool inString = false;
    bool escape = false;

    for (int i = 0; i < content.length; i++) {
      final char = content[i];

      if (escape) {
        escape = false;
        continue;
      }

      if (char == '\\' && inString) {
        escape = true;
        continue;
      }

      if (char == '"') {
        inString = !inString;
        continue;
      }

      if (!inString) {
        if (char == openChar) {
          depth++;
        } else if (char == closeChar) {
          depth--;
          if (depth == 0) {
            return content.substring(0, i + 1);
          }
        }
      }
    }

    return null; // No balanced JSON found
  }
}

/// Widget to display JSON with syntax highlighting
class _JsonFormattedText extends StatelessWidget {
  const _JsonFormattedText({
    required this.data,
    this.baseColor,
  });

  final dynamic data;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      _buildJsonSpan(data, 0),
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: baseColor ?? Colors.white,
      ),
    );
  }

  TextSpan _buildJsonSpan(dynamic data, int indent) {
    if (data is Map) {
      return _buildMapSpan(data, indent);
    } else if (data is List) {
      return _buildListSpan(data, indent);
    } else {
      return _buildValueSpan(data);
    }
  }

  TextSpan _buildMapSpan(Map data, int indent) {
    if (data.isEmpty) {
      return const TextSpan(text: '{}');
    }

    final children = <TextSpan>[];
    children.add(const TextSpan(text: '{\n'));

    final entries = data.entries.toList();
    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final isLast = i == entries.length - 1;
      final indentStr = '  ' * (indent + 1);

      children.add(TextSpan(text: indentStr));
      children.add(TextSpan(
        text: '"${entry.key}"',
        style: const TextStyle(color: Color(0xFF9CDCFE)), // Light blue for keys
      ));
      children.add(const TextSpan(text: ': '));
      children.add(_buildJsonSpan(entry.value, indent + 1));
      if (!isLast) children.add(const TextSpan(text: ','));
      children.add(const TextSpan(text: '\n'));
    }

    children.add(TextSpan(text: '${'  ' * indent}'));
    children.add(const TextSpan(text: '}'));

    return TextSpan(children: children);
  }

  TextSpan _buildListSpan(List data, int indent) {
    if (data.isEmpty) {
      return const TextSpan(text: '[]');
    }

    final children = <TextSpan>[];
    children.add(const TextSpan(text: '[\n'));

    for (var i = 0; i < data.length; i++) {
      final isLast = i == data.length - 1;
      final indentStr = '  ' * (indent + 1);

      children.add(TextSpan(text: indentStr));
      children.add(_buildJsonSpan(data[i], indent + 1));
      if (!isLast) children.add(const TextSpan(text: ','));
      children.add(const TextSpan(text: '\n'));
    }

    children.add(TextSpan(text: '${'  ' * indent}'));
    children.add(const TextSpan(text: ']'));

    return TextSpan(children: children);
  }

  TextSpan _buildValueSpan(dynamic value) {
    if (value == null) {
      return const TextSpan(
        text: 'null',
        style: TextStyle(color: Color(0xFF569CD6)), // Blue for null
      );
    } else if (value is bool) {
      return TextSpan(
        text: value.toString(),
        style: const TextStyle(color: Color(0xFF569CD6)), // Blue for boolean
      );
    } else if (value is num) {
      return TextSpan(
        text: value.toString(),
        style: const TextStyle(color: Color(0xFFB5CEA8)), // Green for numbers
      );
    } else if (value is String) {
      return TextSpan(
        text: '"$value"',
        style: const TextStyle(color: Color(0xFFCE9178)), // Orange for strings
      );
    } else {
      return TextSpan(text: value.toString());
    }
  }
}
