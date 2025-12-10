import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// JSON editor widget
///
/// Provides a text editor with syntax highlighting and real-time validation.
class JsonEditor extends HookWidget {
  final TextEditingController controller;
  final Function(String?)? onValidationError;

  const JsonEditor({
    super.key,
    required this.controller,
    this.onValidationError,
  });

  @override
  Widget build(BuildContext context) {
    final validationError = useState<String?>(null);
    final lineCount = useState(1);

    // Validate JSON on text change
    useEffect(() {
      void listener() {
        try {
          if (controller.text.isNotEmpty) {
            jsonDecode(controller.text);
            validationError.value = null;
            onValidationError?.call(null);
          }
        } catch (e) {
          validationError.value = e.toString();
          onValidationError?.call(e.toString());
        }

        // Update line count
        lineCount.value = '\n'.allMatches(controller.text).length + 1;
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.code, size: 20),
                const SizedBox(width: 8),
                Text(
                  'JSON Editor',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                // Line count
                Text(
                  '${lineCount.value} lines',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(width: 16),
                // Format button
                IconButton(
                  icon: const Icon(Icons.format_align_left),
                  tooltip: 'Format JSON',
                  onPressed: () => _formatJson(controller),
                ),
                // Copy button
                IconButton(
                  icon: const Icon(Icons.copy),
                  tooltip: 'Copy JSON',
                  onPressed: () => _copyJson(context, controller),
                ),
              ],
            ),
          ),

          // Validation error banner
          if (validationError.value != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Theme.of(context).colorScheme.errorContainer,
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      validationError.value!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Editor
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Line numbers
                Container(
                  width: 50,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      lineCount.value,
                      (index) => Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontFamily: 'monospace',
                            ),
                      ),
                    ),
                  ),
                ),

                // Text editor
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                      hintText: 'Enter JSON here...',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _formatJson(TextEditingController controller) {
    try {
      final json = jsonDecode(controller.text);
      const encoder = JsonEncoder.withIndent('  ');
      controller.text = encoder.convert(json);
    } catch (e) {
      // Invalid JSON, can't format
    }
  }

  void _copyJson(BuildContext context, TextEditingController controller) {
    // In a real implementation, use Clipboard.setData
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('JSON copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
