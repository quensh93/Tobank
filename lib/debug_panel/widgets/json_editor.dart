import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/json.dart';
import 'package:re_highlight/styles/atom-one-dark.dart';
import 'package:re_highlight/styles/atom-one-light.dart';

/// A JSON editor widget with syntax highlighting and validation
class JsonEditor extends StatefulWidget {
  final String initialJson;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onValidationChanged;
  final bool readOnly;

  const JsonEditor({
    super.key,
    this.initialJson = '',
    this.onChanged,
    this.onValidationChanged,
    this.readOnly = false,
  });

  @override
  State<JsonEditor> createState() => _JsonEditorState();
}

class _JsonEditorState extends State<JsonEditor> {
  late CodeLineEditingController _controller;
  String? _errorMessage;
  int? _errorLine;
  bool _isValid = true;
  bool _wordWrap = false;

  @override
  void initState() {
    super.initState();
    _controller = CodeLineEditingController.fromText(widget.initialJson);
    _controller.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _validateJson(_controller.text);
    });
  }

  @override
  void didUpdateWidget(JsonEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update controller text if initialJson changed
    if (oldWidget.initialJson != widget.initialJson) {
      // Only update if the text is different to avoid cursor jumping
      if (_controller.text != widget.initialJson) {
        // Defer the update to avoid setState during build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _controller.text != widget.initialJson) {
            _controller.text = widget.initialJson;
            _validateJson(widget.initialJson);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _controller.text;
    // Defer validation to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _validateJson(text);
      }
    });
    widget.onChanged?.call(text);
  }

  void _validateJson(String text) {
    if (!mounted) return;

    if (text.trim().isEmpty) {
      setState(() {
        _errorMessage = null;
        _errorLine = null;
        _isValid = true;
      });
      widget.onValidationChanged?.call(true);
      return;
    }

    try {
      jsonDecode(text);
      setState(() {
        _errorMessage = null;
        _errorLine = null;
        _isValid = true;
      });
      widget.onValidationChanged?.call(true);
    } catch (e) {
      final errorStr = e.toString();
      int? line;

      // Try to extract line number from error message
      final lineMatch = RegExp(r'line (\d+)').firstMatch(errorStr);
      if (lineMatch != null) {
        line = int.tryParse(lineMatch.group(1) ?? '');
      }

      setState(() {
        _errorMessage = _formatErrorMessage(errorStr);
        _errorLine = line;
        _isValid = false;
      });
      widget.onValidationChanged?.call(false);
    }
  }

  String _formatErrorMessage(String error) {
    // Clean up error message
    if (error.contains('FormatException:')) {
      return error.split('FormatException:').last.trim();
    }
    return error;
  }

  void _formatJson() {
    try {
      final json = jsonDecode(_controller.text);
      final formatted = const JsonEncoder.withIndent('  ').convert(json);
      _controller.text = formatted;
    } catch (e) {
      // If JSON is invalid, don't format
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cannot format invalid JSON'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _controller.text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('JSON copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Toolbar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            children: [
              // Validation indicator
              Icon(
                _isValid ? Icons.check_circle : Icons.error,
                color: _isValid ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _isValid ? 'Valid JSON' : 'Invalid JSON',
                style: TextStyle(
                  fontSize: 12,
                  color: _isValid ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              // Word wrap button
              IconButton(
                icon: Icon(_wordWrap ? Icons.wrap_text : Icons.notes, size: 20),
                onPressed: () {
                  setState(() {
                    _wordWrap = !_wordWrap;
                  });
                },
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                tooltip: _wordWrap ? 'Disable word wrap' : 'Enable word wrap',
              ),
              const SizedBox(width: 4),
              // Format button
              IconButton(
                icon: const Icon(Icons.auto_fix_high, size: 20),
                onPressed: widget.readOnly ? null : _formatJson,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                tooltip: 'Format JSON',
              ),
              const SizedBox(width: 4),
              // Copy button
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                onPressed: _copyToClipboard,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),

        // Editor
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: _isValid
                    ? Theme.of(context).dividerColor
                    : Colors.red.withValues(alpha: 0.5),
                width: _isValid ? 1 : 2,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxHeight <= 0 ||
                    constraints.maxHeight == double.infinity) {
                  return const SizedBox.shrink();
                }
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: CodeEditor(
                    controller: _controller,
                    readOnly: widget.readOnly,
                    style: CodeEditorStyle(
                      codeTheme: CodeHighlightTheme(
                        languages: {
                          'json': CodeHighlightThemeMode(
                            mode: langJson,
                          ),
                        },
                        theme: Theme.of(context).brightness == Brightness.light
                            ? atomOneLightTheme
                            : atomOneDarkTheme,
                      ),
                      fontSize: 14,
                      fontFamily: 'monospace',
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                    ),
                    wordWrap: _wordWrap,
                    indicatorBuilder: (context, editingController,
                        chunkController, notifier) {
                      return Row(
                        children: [
                          DefaultCodeLineNumber(
                            controller: editingController,
                            notifier: notifier,
                          ),
                          DefaultCodeChunkIndicator(
                            width: 20,
                            controller: chunkController,
                            notifier: notifier,
                          ),
                        ],
                      );
                    },
                    // findBuilder: (context, controller, readOnly) {
                    //   return _CodeFindPanel(
                    //     controller: controller,
                    //     readOnly: readOnly,
                    //   );
                    // },
                    chunkAnalyzer: const DefaultCodeChunkAnalyzer(),
                  ),
                );
              },
            ),
          ),
        ),

        // Error message
        if (_errorMessage != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              border: Border(
                top: BorderSide(color: Colors.red.shade200),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _errorLine != null
                        ? 'Line $_errorLine: $_errorMessage'
                        : _errorMessage!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
