import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../data/playground_templates.dart';
import '../widgets/json_editor.dart';
import '../widgets/preview_panel.dart';
import '../state/debug_panel_settings_state.dart';

/// JSON Playground screen for testing STAC JSON configurations
class JsonPlaygroundScreen extends ConsumerStatefulWidget {
  const JsonPlaygroundScreen({super.key});

  @override
  ConsumerState<JsonPlaygroundScreen> createState() => _JsonPlaygroundScreenState();
}

class _JsonPlaygroundScreenState extends ConsumerState<JsonPlaygroundScreen> {
  String _jsonString = '';
  bool _isValid = false;
  bool _showDeviceFrame = false;

  final List<PlaygroundSession> _savedSessions = [];
  BuildContext? _navigatorContext;

  BuildContext get _scaffoldContext => _navigatorContext ?? context;

  @override
  void initState() {
    super.initState();
    _loadSavedSessions();
  }

  Future<void> _loadSavedSessions() async {
    // TODO: Implement session loading when shared_preferences is available
    setState(() {
      _savedSessions.clear();
    });
  }

  Future<void> _saveSession() async {
    if (_jsonString.trim().isEmpty) {
      _showSnackBar('Cannot save empty session', isError: true);
      return;
    }

    _showSnackBar('Session saving not available (shared_preferences not configured)', isError: true);
  }

  Future<void> _loadSession(PlaygroundSession session) async {
    setState(() {
      _jsonString = session.json;
    });
  }

  Future<void> _deleteSession(PlaygroundSession session) async {
    _showSnackBar('Session deletion not available', isError: true);
  }

  void _loadTemplate(String templateKey) {
    final template = PlaygroundTemplates.getByKey(templateKey);
    if (template != null) {
      setState(() {
        _jsonString = template.json;
      });
    }
  }

  void _clearEditor() {
    setState(() {
      _jsonString = '';
    });
  }

  Future<void> _exportToFile() async {
    if (_jsonString.trim().isEmpty) {
      _showSnackBar('Cannot export empty JSON', isError: true);
      return;
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory.path}/playground_$timestamp.json');
      await file.writeAsString(_jsonString);

      _showSnackBar('JSON exported to: ${file.path}');
    } catch (e) {
      _showSnackBar('Export failed: $e', isError: true);
    }
  }

  Future<void> _importFromFile() async {
    _showSnackBar('File import not available (file_picker not configured)', isError: true);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    final messenger = ScaffoldMessenger.maybeOf(_scaffoldContext);
    messenger?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
        duration: const Duration(seconds: 2),
      ),
    );
  }



  void _showTemplateSelector() {
    final modalContext = _scaffoldContext;
    showModalBottomSheet(
      context: modalContext,
      builder: (context) => _TemplateSelectorSheet(
        onTemplateSelected: (key) {
          Navigator.pop(context);
          _loadTemplate(key);
        },
      ),
    );
  }

  void _showSessionsDrawer() {
    final modalContext = _scaffoldContext;
    showModalBottomSheet(
      context: modalContext,
      builder: (context) => _SessionsDrawer(
        sessions: _savedSessions,
        onLoad: (session) {
          Navigator.pop(context);
          _loadSession(session);
        },
        onDelete: _deleteSession,
      ),
    );
  }

  void _openInVisualEditor() {
    // Switch to Visual Editor tab (index 4: Device, Logs, Tools, Playground, Visual Editor)
    ref.read(debugPanelSettingsProvider.notifier).setSelectedTabIndex(4);
    
    _showSnackBar('Switched to Visual Editor. Import your JSON there to edit visually.');
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (routeContext) => Builder(
          builder: (navigatorContext) {
            _navigatorContext = navigatorContext;
            return Scaffold(
              appBar: AppBar(
                title: const Text('JSON Playground'),
                actions: [
                  // Device frame toggle
                  IconButton(
                    icon: Icon(_showDeviceFrame ? Icons.phone_android : Icons.phone_android_outlined),
                    tooltip: 'Toggle device frame',
                    onPressed: () {
                      setState(() {
                        _showDeviceFrame = !_showDeviceFrame;
                      });
                    },
                  ),
                  // Templates
                  IconButton(
                    icon: const Icon(Icons.library_books),
                    tooltip: 'Load template',
                    onPressed: _showTemplateSelector,
                  ),
                  // Saved sessions
                  IconButton(
                    icon: const Icon(Icons.folder_open),
                    tooltip: 'Saved sessions',
                    onPressed: _showSessionsDrawer,
                  ),
                  // Save
                  IconButton(
                    icon: const Icon(Icons.save),
                    tooltip: 'Save session',
                    onPressed: _isValid ? _saveSession : null,
                  ),
                  // Open in Visual Editor
                  IconButton(
                    icon: const Icon(Icons.design_services),
                    tooltip: 'Open in Visual Editor',
                    onPressed: _isValid ? _openInVisualEditor : null,
                  ),
                  // More options
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      switch (value) {
                        case 'export':
                          _exportToFile();
                          break;
                        case 'import':
                          _importFromFile();
                          break;
                        case 'clear':
                          _clearEditor();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'export',
                        child: Row(
                          children: [
                            Icon(Icons.upload_file),
                            SizedBox(width: 8),
                            Text('Export to file'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'import',
                        child: Row(
                          children: [
                            Icon(Icons.download),
                            SizedBox(width: 8),
                            Text('Import from file'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'clear',
                        child: Row(
                          children: [
                            Icon(Icons.clear),
                            SizedBox(width: 8),
                            Text('Clear'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;

          if (isWide) {
            // Split view for wide screens
            return Row(
              children: [
                Expanded(
                  child: JsonEditor(
                    key: ValueKey(_jsonString),
                    initialJson: _jsonString,
                    onChanged: (json) {
                      setState(() {
                        _jsonString = json;
                      });
                    },
                    onValidationChanged: (isValid) {
                      setState(() {
                        _isValid = isValid;
                      });
                    },
                  ),
                ),
                Container(
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
                Expanded(
                  child: PreviewPanel(
                    jsonString: _jsonString,
                    showDeviceFrame: _showDeviceFrame,
                  ),
                ),
              ],
            );
          } else {
            // Tabbed view for narrow screens
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Editor', icon: Icon(Icons.code)),
                      Tab(text: 'Preview', icon: Icon(Icons.preview)),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        JsonEditor(
                          key: ValueKey(_jsonString),
                          initialJson: _jsonString,
                          onChanged: (json) {
                            setState(() {
                              _jsonString = json;
                            });
                          },
                          onValidationChanged: (isValid) {
                            setState(() {
                              _isValid = isValid;
                            });
                          },
                        ),
                        PreviewPanel(
                          jsonString: _jsonString,
                          showDeviceFrame: _showDeviceFrame,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
          },
        ),
      ),
    );
  }
}

/// Template selector bottom sheet
class _TemplateSelectorSheet extends StatelessWidget {
  final Function(String) onTemplateSelected;

  const _TemplateSelectorSheet({
    required this.onTemplateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = PlaygroundTemplates.categories;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Select Template',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final templates = PlaygroundTemplates.getByCategory(category);

                return ExpansionTile(
                  title: Text(category),
                  initiallyExpanded: index == 0,
                  children: templates.map((template) {
                    final key = PlaygroundTemplates.templates.entries
                        .firstWhere((e) => e.value == template)
                        .key;

                    return ListTile(
                      title: Text(template.name),
                      subtitle: Text(template.description),
                      onTap: () => onTemplateSelected(key),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Saved sessions drawer
class _SessionsDrawer extends StatelessWidget {
  final List<PlaygroundSession> sessions;
  final Function(PlaygroundSession) onLoad;
  final Function(PlaygroundSession) onDelete;

  const _SessionsDrawer({
    required this.sessions,
    required this.onLoad,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Saved Sessions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          if (sessions.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No saved sessions',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  return ListTile(
                    leading: const Icon(Icons.description),
                    title: Text(session.name),
                    subtitle: Text('${session.json.length} characters'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onDelete(session),
                    ),
                    onTap: () => onLoad(session),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

/// Model for a saved playground session
class PlaygroundSession {
  final String name;
  final String json;

  const PlaygroundSession({
    required this.name,
    required this.json,
  });
}
