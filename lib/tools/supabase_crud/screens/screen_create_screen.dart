import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../supabase_crud_app.dart';
import '../providers/supabase_crud_provider.dart';
import '../widgets/json_editor.dart';

/// Screen create screen
///
/// Provides a form for creating a new STAC screen with JSON editor.
/// Validates and saves to Supabase.
class ScreenCreateScreen extends HookConsumerWidget {
  const ScreenCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenNameController = useTextEditingController();
    final jsonController = useTextEditingController(
      text: _getDefaultJson(),
    );
    final descriptionController = useTextEditingController();
    final routeController = useTextEditingController();
    final authorController = useTextEditingController();
    final tagsController = useTextEditingController();

    final isCreating = useState(false);
    final validationError = useState<String?>(null);
    final screenNameError = useState<String?>(null);

    return CrudLayout(
      title: 'Create New Screen',
      actions: [
        FilledButton.icon(
          onPressed: isCreating.value
              ? null
              : () => _createScreen(
                    context,
                    ref,
                    screenNameController,
                    jsonController,
                    descriptionController,
                    routeController,
                    authorController,
                    tagsController,
                    isCreating,
                    validationError,
                    screenNameError,
                  ),
          icon: isCreating.value
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add),
          label: Text(isCreating.value ? 'Creating...' : 'Create'),
        ),
        const SizedBox(width: 8),
      ],
      body: Row(
        children: [
          // Form panel
          SizedBox(
            width: 350,
            child: Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Screen Details',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),

                      // Screen name (required)
                      TextField(
                        controller: screenNameController,
                        decoration: InputDecoration(
                          labelText: 'Screen Name *',
                          hintText: 'home_screen',
                          helperText: 'Unique identifier for the screen',
                          errorText: screenNameError.value,
                          prefixIcon: const Icon(Icons.badge),
                        ),
                        onChanged: (value) {
                          // Clear error on change
                          screenNameError.value = null;
                          // Auto-generate route if empty
                          if (routeController.text.isEmpty) {
                            routeController.text = '/${value.replaceAll('_screen', '')}';
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Description
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter screen description',
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // Route
                      TextField(
                        controller: routeController,
                        decoration: const InputDecoration(
                          labelText: 'Route',
                          hintText: '/screen-route',
                          helperText: 'Navigation route for the screen',
                          prefixIcon: Icon(Icons.route),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Author
                      TextField(
                        controller: authorController,
                        decoration: const InputDecoration(
                          labelText: 'Author',
                          hintText: 'Enter author name',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Tags
                      TextField(
                        controller: tagsController,
                        decoration: const InputDecoration(
                          labelText: 'Tags',
                          hintText: 'tag1, tag2, tag3',
                          helperText: 'Comma-separated tags',
                          prefixIcon: Icon(Icons.label),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Templates section
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        'Templates',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      _buildTemplateButton(
                        context,
                        'Basic Screen',
                        Icons.phone_android,
                        () => jsonController.text = _getBasicScreenTemplate(),
                      ),
                      const SizedBox(height: 8),
                      _buildTemplateButton(
                        context,
                        'Form Screen',
                        Icons.edit_note,
                        () => jsonController.text = _getFormScreenTemplate(),
                      ),
                      const SizedBox(height: 8),
                      _buildTemplateButton(
                        context,
                        'List Screen',
                        Icons.list,
                        () => jsonController.text = _getListScreenTemplate(),
                      ),
                      const SizedBox(height: 8),
                      _buildTemplateButton(
                        context,
                        'Empty Screen',
                        Icons.crop_square,
                        () => jsonController.text = _getDefaultJson(),
                      ),
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
      ),
    );
  }

  Widget _buildTemplateButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }

  Future<void> _createScreen(
    BuildContext context,
    WidgetRef ref,
    TextEditingController screenNameController,
    TextEditingController jsonController,
    TextEditingController descriptionController,
    TextEditingController routeController,
    TextEditingController authorController,
    TextEditingController tagsController,
    ValueNotifier<bool> isCreating,
    ValueNotifier<String?> validationError,
    ValueNotifier<String?> screenNameError,
  ) async {
    // Validate screen name
    final screenName = screenNameController.text.trim();
    if (screenName.isEmpty) {
      screenNameError.value = 'Screen name is required';
      return;
    }

    if (!RegExp(r'^[a-z0-9_]+$').hasMatch(screenName)) {
      screenNameError.value = 'Use only lowercase letters, numbers, and underscores';
      return;
    }

    // Validate JSON
    try {
      final json = jsonDecode(jsonController.text) as Map<String, dynamic>;

      isCreating.value = true;
      validationError.value = null;
      screenNameError.value = null;

      // Parse tags
      final tags = tagsController.text
          .split(',')
          .map((t) => t.trim())
          .where((t) => t.isNotEmpty)
          .toList();

      // Create screen
      await ref.read(supabaseCrudServiceProvider).createScreen(
            name: screenName,
            jsonData: json,
            description: descriptionController.text.isEmpty
                ? null
                : descriptionController.text,
            route: routeController.text.isEmpty ? null : routeController.text,
            author: authorController.text.isEmpty ? null : authorController.text,
            tags: tags,
          );

      // Invalidate providers to refresh data
      ref.invalidate(screensListProvider);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Screen created successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back to list
        CrudNavigation.toScreenList(context);
      }
    } catch (e) {
      if (e.toString().contains('already exists')) {
        screenNameError.value = 'Screen name already exists';
      } else {
        validationError.value = e.toString();
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating screen: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isCreating.value = false;
    }
  }

  String _getDefaultJson() {
    return const JsonEncoder.withIndent('  ').convert({
      'type': 'scaffold',
      'appBar': {
        'type': 'appBar',
        'title': {'type': 'text', 'data': 'New Screen'}
      },
      'body': {
        'type': 'center',
        'child': {'type': 'text', 'data': 'Hello World'}
      }
    });
  }

  String _getBasicScreenTemplate() {
    return const JsonEncoder.withIndent('  ').convert({
      'type': 'scaffold',
      'appBar': {
        'type': 'appBar',
        'title': {'type': 'text', 'data': 'Basic Screen'}
      },
      'body': {
        'type': 'padding',
        'padding': {'all': 16},
        'child': {
          'type': 'column',
          'mainAxisAlignment': 'center',
          'crossAxisAlignment': 'center',
          'children': [
            {
              'type': 'text',
              'data': 'Welcome',
              'style': {'fontSize': 24, 'fontWeight': 'bold'}
            },
            {'type': 'sizedBox', 'height': 16},
            {
              'type': 'text',
              'data': 'This is a basic screen template',
              'textAlign': 'center'
            },
            {'type': 'sizedBox', 'height': 24},
            {
              'type': 'elevatedButton',
              'child': {'type': 'text', 'data': 'Get Started'},
              'onPressed': {
                'actionType': 'showDialog',
                'title': 'Hello',
                'message': 'Button clicked!'
              }
            }
          ]
        }
      }
    });
  }

  String _getFormScreenTemplate() {
    return const JsonEncoder.withIndent('  ').convert({
      'type': 'scaffold',
      'appBar': {
        'type': 'appBar',
        'title': {'type': 'text', 'data': 'Form Screen'}
      },
      'body': {
        'type': 'padding',
        'padding': {'all': 16},
        'child': {
          'type': 'column',
          'children': [
            {
              'type': 'textField',
              'decoration': {
                'labelText': 'Name',
                'hintText': 'Enter your name'
              }
            },
            {'type': 'sizedBox', 'height': 16},
            {
              'type': 'textField',
              'decoration': {
                'labelText': 'Email',
                'hintText': 'Enter your email'
              }
            },
            {'type': 'sizedBox', 'height': 24},
            {
              'type': 'elevatedButton',
              'child': {'type': 'text', 'data': 'Submit'},
              'onPressed': {
                'actionType': 'showDialog',
                'title': 'Success',
                'message': 'Form submitted!'
              }
            }
          ]
        }
      }
    });
  }

  String _getListScreenTemplate() {
    return const JsonEncoder.withIndent('  ').convert({
      'type': 'scaffold',
      'appBar': {
        'type': 'appBar',
        'title': {'type': 'text', 'data': 'List Screen'}
      },
      'body': {
        'type': 'listView',
        'children': [
          {
            'type': 'listTile',
            'leading': {'type': 'icon', 'icon': 'home'},
            'title': {'type': 'text', 'data': 'Home'},
            'subtitle': {'type': 'text', 'data': 'Go to home screen'}
          },
          {
            'type': 'listTile',
            'leading': {'type': 'icon', 'icon': 'settings'},
            'title': {'type': 'text', 'data': 'Settings'},
            'subtitle': {'type': 'text', 'data': 'Configure app settings'}
          },
          {
            'type': 'listTile',
            'leading': {'type': 'icon', 'icon': 'person'},
            'title': {'type': 'text', 'data': 'Profile'},
            'subtitle': {'type': 'text', 'data': 'View your profile'}
          }
        ]
      }
    });
  }
}
