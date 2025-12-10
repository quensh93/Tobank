import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../supabase_crud_app.dart';
import '../providers/supabase_crud_provider.dart';
import '../widgets/json_editor.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_display.dart';
import '../models/screen_metadata.dart';

/// Screen edit screen
///
/// Provides a JSON editor with syntax highlighting and real-time validation.
/// Allows saving changes to Supabase.
class ScreenEditScreen extends HookConsumerWidget {
  final String screenName;

  const ScreenEditScreen({
    super.key,
    required this.screenName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final routeController = useTextEditingController();
    final authorController = useTextEditingController();
    final tagsController = useTextEditingController();

    final isSaving = useState(false);
    final hasChanges = useState(false);
    final validationError = useState<String?>(null);

    // Watch screen data
    final screenMetadataAsync = ref.watch(screenProvider(screenName));
    final screenJsonAsync = ref.watch(screenJsonProvider(screenName));

    // Initialize controllers when data loads
    useEffect(() {
      screenMetadataAsync.whenData((metadata) {
        if (metadata != null) {
          descriptionController.text = metadata.description ?? '';
          routeController.text = metadata.route ?? '';
          authorController.text = metadata.author ?? '';
          tagsController.text = metadata.tags.join(', ');
        }
      });

      screenJsonAsync.whenData((json) {
        if (json != null) {
          jsonController.text = _formatJson(json);
        }
      });

      return null;
    }, [screenMetadataAsync, screenJsonAsync]);

    // Track changes
    useEffect(() {
      void listener() {
        hasChanges.value = true;
      }

      jsonController.addListener(listener);
      descriptionController.addListener(listener);
      routeController.addListener(listener);
      authorController.addListener(listener);
      tagsController.addListener(listener);

      return () {
        jsonController.removeListener(listener);
        descriptionController.removeListener(listener);
        routeController.removeListener(listener);
        authorController.removeListener(listener);
        tagsController.removeListener(listener);
      };
    }, []);

    return WillPopScope(
      onWillPop: () async {
        if (hasChanges.value) {
          final shouldPop = await _showUnsavedChangesDialog(context);
          return shouldPop ?? false;
        }
        return true;
      },
      child: CrudLayout(
        title: 'Edit: $screenName',
        actions: [
          // Version history button
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Version History',
            onPressed: () => _showVersionHistory(context, ref),
          ),
          // Save button
          FilledButton.icon(
            onPressed: isSaving.value
                ? null
                : () => _saveScreen(
                      context,
                      ref,
                      jsonController,
                      descriptionController,
                      routeController,
                      authorController,
                      tagsController,
                      isSaving,
                      hasChanges,
                      validationError,
                    ),
            icon: isSaving.value
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            label: Text(isSaving.value ? 'Saving...' : 'Save'),
          ),
          const SizedBox(width: 8),
        ],
        body: screenMetadataAsync.when(
          data: (metadata) {
            final meta = metadata;
            if (meta == null) {
              return const CrudErrorDisplay(
                error: 'Screen metadata not found',
              );
            }
            return screenJsonAsync.when(
              data: (json) => _buildEditor(
                context,
                meta,
                jsonController,
                descriptionController,
                routeController,
                authorController,
                tagsController,
                validationError,
              ),
              loading: () => const CrudLoadingIndicator(
                message: 'Loading screen data...',
              ),
              error: (error, stack) => CrudErrorDisplay(
                error: error,
                onRetry: () {
                  ref.invalidate(screenJsonProvider(screenName));
                },
              ),
            );
          },
          loading: () => const CrudLoadingIndicator(
            message: 'Loading screen metadata...',
          ),
          error: (error, stack) => CrudErrorDisplay(
            error: error,
            onRetry: () {
              ref.invalidate(screenProvider(screenName));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEditor(
    BuildContext context,
    ScreenMetadata metadata,
    TextEditingController jsonController,
    TextEditingController descriptionController,
    TextEditingController routeController,
    TextEditingController authorController,
    TextEditingController tagsController,
    ValueNotifier<String?> validationError,
  ) {
    final createdAt = metadata.createdAt;
    return Row(
      children: [
        // Metadata panel
        SizedBox(
          width: 300,
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Metadata',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter screen description',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: routeController,
                      decoration: const InputDecoration(
                        labelText: 'Route',
                        hintText: '/screen-route',
                        prefixIcon: Icon(Icons.route),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: authorController,
                      decoration: const InputDecoration(
                        labelText: 'Author',
                        hintText: 'Enter author name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: tagsController,
                      decoration: const InputDecoration(
                        labelText: 'Tags',
                        hintText: 'tag1, tag2, tag3',
                        prefixIcon: Icon(Icons.label),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      context,
                      'Version',
                      'v${metadata.version}',
                      Icons.numbers,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      context,
                      'Updated',
                      _formatDate(metadata.updatedAt),
                      Icons.access_time,
                    ),
                    ...[
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      context,
                      'Created',
                      _formatDate(createdAt),
                      Icons.calendar_today,
                    ),
                  ],
                  ],
                ),
              ),
            ),
          ),
        ),

        // JSON editor
        Expanded(
          child: JsonEditor(
            controller: jsonController,
            onValidationError: (error) {
              validationError.value = error;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveScreen(
    BuildContext context,
    WidgetRef ref,
    TextEditingController jsonController,
    TextEditingController descriptionController,
    TextEditingController routeController,
    TextEditingController authorController,
    TextEditingController tagsController,
    ValueNotifier<bool> isSaving,
    ValueNotifier<bool> hasChanges,
    ValueNotifier<String?> validationError,
  ) async {
    // Validate JSON
    try {
      final json = jsonDecode(jsonController.text) as Map<String, dynamic>;

      isSaving.value = true;
      validationError.value = null;

      // Parse tags
      final tags = tagsController.text
          .split(',')
          .map((t) => t.trim())
          .where((t) => t.isNotEmpty)
          .toList();

      // Update screen
      await ref.read(supabaseCrudServiceProvider).updateScreen(
            id: screenName,
            jsonData: json,
            description: descriptionController.text.isEmpty
                ? null
                : descriptionController.text,
            author: authorController.text.isEmpty ? null : authorController.text,
            tags: tags,
          );

      // Invalidate providers to refresh data
      ref.invalidate(screenProvider(screenName));
      ref.invalidate(screenJsonProvider(screenName));
      ref.invalidate(screensListProvider);

      hasChanges.value = false;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Screen saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      validationError.value = e.toString();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving screen: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> _showVersionHistory(BuildContext context, WidgetRef ref) async {
    final versionsAsync = ref.read(versionHistoryProvider(screenName));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Version History'),
        content: SizedBox(
          width: 500,
          height: 400,
          child: versionsAsync.when(
            data: (versions) {
              if (versions.isEmpty) {
                return const Center(
                  child: Text('No version history available'),
                );
              }

              return ListView.builder(
                itemCount: versions.length,
                itemBuilder: (context, index) {
                  final version = versions[index];
                  final versionNumber = version['version'] as int? ?? index + 1;
                  final timestamp = version['timestamp'] as DateTime? ?? DateTime.now();
                  final description = version['description'] as String?;
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('v$versionNumber'),
                    ),
                    title: Text(_formatDate(timestamp)),
                    subtitle: description != null ? Text(description) : null,
                    trailing: FilledButton(
                      onPressed: () async {
                        final confirmed = await _showRollbackConfirmation(
                          context,
                          versionNumber,
                        );
                        if (confirmed == true && context.mounted) {
                          await ref
                              .read(supabaseCrudServiceProvider)
                              .rollbackToVersion(screenName, versionNumber);
                          ref.invalidate(screenProvider(screenName));
                          ref.invalidate(screenJsonProvider(screenName));
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Rollback'),
                    ),
                  );
                },
              );
            },
            loading: () => const CrudLoadingIndicator(),
            error: (error, stack) => CrudErrorDisplay(error: error),
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

  Future<bool?> _showRollbackConfirmation(
    BuildContext context,
    int version,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rollback to Version'),
        content: Text(
          'Are you sure you want to rollback to version $version?\n\n'
          'This will create a new version with the content from version $version.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Rollback'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showUnsavedChangesDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsaved Changes'),
        content: const Text(
          'You have unsaved changes. Are you sure you want to leave?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Stay'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  String _formatJson(Map<String, dynamic> json) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(json);
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
