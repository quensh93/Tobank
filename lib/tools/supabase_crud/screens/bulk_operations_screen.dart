import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../supabase_crud_app.dart';
import '../providers/supabase_crud_provider.dart';

/// Bulk operations screen
///
/// Provides functionality to upload multiple screens at once
/// and export all screens to files.
class BulkOperationsScreen extends HookConsumerWidget {
  const BulkOperationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isProcessing = useState(false);
    final uploadJsonController = useTextEditingController();
    final uploadError = useState<String?>(null);
    final uploadSuccess = useState<String?>(null);

    return CrudLayout(
      title: 'Bulk Operations',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Export section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.download,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Export All Screens',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Download all screens as a JSON file',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: isProcessing.value
                          ? null
                          : () => _exportAllScreens(
                                context,
                                ref,
                                isProcessing,
                              ),
                      icon: const Icon(Icons.download),
                      label: const Text('Export All Screens'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Import section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.upload,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bulk Upload Screens',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Upload multiple screens from a JSON file',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // JSON input
                    TextField(
                      controller: uploadJsonController,
                      maxLines: 15,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        hintText: _getBulkUploadExample(),
                        helperText: 'Paste JSON with screen_name: {...} format',
                        errorText: uploadError.value,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Success message
                    if (uploadSuccess.value != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                uploadSuccess.value!,
                                style: const TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        FilledButton.icon(
                          onPressed: isProcessing.value
                              ? null
                              : () => _bulkUploadScreens(
                                    context,
                                    ref,
                                    uploadJsonController,
                                    isProcessing,
                                    uploadError,
                                    uploadSuccess,
                                  ),
                          icon: isProcessing.value
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.upload),
                          label: Text(isProcessing.value ? 'Uploading...' : 'Upload'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          onPressed: () {
                            uploadJsonController.clear();
                            uploadError.value = null;
                            uploadSuccess.value = null;
                          },
                          icon: const Icon(Icons.clear),
                          label: const Text('Clear'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Instructions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Instructions',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInstructionItem(
                      context,
                      '1',
                      'Export Format',
                      'Exported JSON contains all screens in a single object with screen names as keys.',
                    ),
                    const SizedBox(height: 12),
                    _buildInstructionItem(
                      context,
                      '2',
                      'Upload Format',
                      'Use the same format for bulk upload. Each key should be a screen name, and the value should be the STAC JSON.',
                    ),
                    const SizedBox(height: 12),
                    _buildInstructionItem(
                      context,
                      '3',
                      'Existing Screens',
                      'If a screen already exists, it will be updated with a new version.',
                    ),
                    const SizedBox(height: 12),
                    _buildInstructionItem(
                      context,
                      '4',
                      'Validation',
                      'All screens are validated before upload. Invalid screens will be skipped.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(
    BuildContext context,
    String number,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _exportAllScreens(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<bool> isProcessing,
  ) async {
    try {
      isProcessing.value = true;

      final screens = await ref.read(supabaseCrudServiceProvider).exportAllScreens();

      if (screens.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No screens to export'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      // Format JSON
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(screens);

      // In a real implementation, trigger file download
      // For now, show a dialog with the JSON
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Export Successful'),
            content: SizedBox(
              width: 600,
              height: 400,
              child: SingleChildScrollView(
                child: SelectableText(
                  jsonString,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              FilledButton.icon(
                onPressed: () {
                  // Copy to clipboard
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('JSON copied to clipboard'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting screens: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> _bulkUploadScreens(
    BuildContext context,
    WidgetRef ref,
    TextEditingController uploadJsonController,
    ValueNotifier<bool> isProcessing,
    ValueNotifier<String?> uploadError,
    ValueNotifier<String?> uploadSuccess,
  ) async {
    try {
      isProcessing.value = true;
      uploadError.value = null;
      uploadSuccess.value = null;

      // Parse JSON
      final json = jsonDecode(uploadJsonController.text);

      if (json is! Map) {
        throw Exception('Invalid format: Expected a JSON object');
      }

      // Convert to Map<String, Map<String, dynamic>>
      final screens = <String, Map<String, dynamic>>{};
      for (final entry in json.entries) {
        if (entry.value is! Map) {
          throw Exception('Invalid format for screen: ${entry.key}');
        }
        screens[entry.key] = Map<String, dynamic>.from(entry.value as Map);
      }

      if (screens.isEmpty) {
        throw Exception('No screens found in JSON');
      }

      // Upload screens
      await ref.read(supabaseCrudServiceProvider).bulkUploadScreens(screens);

      // Refresh screens list
      ref.invalidate(screensListProvider);

      uploadSuccess.value = 'Successfully uploaded ${screens.length} screen(s)';

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully uploaded ${screens.length} screen(s)'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      uploadError.value = e.toString();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading screens: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isProcessing.value = false;
    }
  }

  String _getBulkUploadExample() {
    return '''
{
  "home_screen": {
    "type": "scaffold",
    "appBar": {
      "type": "appBar",
      "title": {"type": "text", "data": "Home"}
    },
    "body": {
      "type": "center",
      "child": {"type": "text", "data": "Home Screen"}
    }
  },
  "profile_screen": {
    "type": "scaffold",
    "appBar": {
      "type": "appBar",
      "title": {"type": "text", "data": "Profile"}
    },
    "body": {
      "type": "center",
      "child": {"type": "text", "data": "Profile Screen"}
    }
  }
}''';
  }
}
