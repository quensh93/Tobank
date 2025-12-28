import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../features/stac_test_app/data/services/entry_point_discovery_service.dart';
import '../../features/stac_test_app/data/services/stac_json_file_service.dart';
import '../../features/stac_test_app/presentation/providers/stac_test_app_providers.dart';
import '../../features/stac_test_app/data/utils/stac_error_handler.dart';
import '../../features/stac_test_app/domain/models/entry_point_config.dart';
import '../widgets/json_editor.dart';
import '../../core/helpers/logger.dart';

/// Represents a JSON file that can be edited in the playground
class EditableJsonFile {
  final String path;
  final String displayName;
  final String type; // 'entry_point', 'template', 'data'
  final String? screenName; // For template/data files

  EditableJsonFile({
    required this.path,
    required this.displayName,
    required this.type,
    this.screenName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EditableJsonFile &&
        other.path == path &&
        other.displayName == displayName &&
        other.type == type &&
        other.screenName == screenName;
  }

  @override
  int get hashCode {
    return Object.hash(path, displayName, type, screenName);
  }
}

/// STAC Test App Playground Screen
///
/// Provides an interface for editing entry point JSON files and
/// controlling the STAC test app (hot reload, restart, etc.)
class StacTestAppPlaygroundScreen extends ConsumerStatefulWidget {
  const StacTestAppPlaygroundScreen({super.key});

  @override
  ConsumerState<StacTestAppPlaygroundScreen> createState() =>
      _StacTestAppPlaygroundScreenState();
}

class _StacTestAppPlaygroundScreenState
    extends ConsumerState<StacTestAppPlaygroundScreen> {
  List<String> _entryPoints = [];
  String? _selectedEntryPoint;
  EntryPointConfig? _entryPointConfig;
  List<EditableJsonFile> _editableFiles = [];
  EditableJsonFile? _selectedFile;
  String _jsonContent = '';
  bool _hasUnsavedChanges = false;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isMenuOpen = false;
  bool _isFileMenuOpen = false;
  String? _statusMessage;
  bool _showUnsavedDialog = false;
  VoidCallback? _pendingAction;

  @override
  void initState() {
    super.initState();
    _loadEntryPoints();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set initial selected entry point from provider after ref is available
    if (_selectedEntryPoint == null && _entryPoints.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final currentEntryPoint =
              ref.read(currentEntryPointProvider).entryPoint;
          if (currentEntryPoint != null &&
              _entryPoints.contains(currentEntryPoint)) {
            setState(() {
              _selectedEntryPoint = currentEntryPoint;
            });
            _loadEntryPointContent();
          } else if (_entryPoints.isNotEmpty && _selectedEntryPoint == null) {
            // Auto-select first entry point if none is set
            setState(() {
              _selectedEntryPoint = _entryPoints.first;
            });
            _loadEntryPointContent();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Load list of entry point files
  Future<void> _loadEntryPoints() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final entryPoints =
          await EntryPointDiscoveryService.discoverEntryPoints();
      setState(() {
        _entryPoints = entryPoints;
        _isLoading = false;
      });

      // Auto-select first entry point if none selected and load content
      if (_selectedEntryPoint == null && entryPoints.isNotEmpty) {
        setState(() {
          _selectedEntryPoint = entryPoints.first;
        });
        // Load content after state is updated
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _loadEntryPointContent();
          }
        });
      } else if (_selectedEntryPoint != null &&
          !entryPoints.contains(_selectedEntryPoint)) {
        // If selected entry point is no longer in the list, select first one
        setState(() {
          _selectedEntryPoint =
              entryPoints.isNotEmpty ? entryPoints.first : null;
        });
        if (_selectedEntryPoint != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _loadEntryPointContent();
            }
          });
        }
      }
    } catch (e) {
      AppLogger.e('Failed to load entry points', e);
      setState(() {
        _errorMessage = 'Failed to load entry points: $e';
        _isLoading = false;
      });
    }
  }

  /// Load entry point and discover all editable files
  Future<void> _loadEntryPointContent() async {
    if (_selectedEntryPoint == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Load entry point JSON
      final json = await StacJsonFileService.loadJson(_selectedEntryPoint!);

      // Parse entry point config
      try {
        _entryPointConfig = EntryPointConfig.fromJson(json);
      } catch (e) {
        AppLogger.w('Entry point parsing warning: $e');
      }

      // Discover all editable files from entry point
      await _discoverEditableFiles();

      // Validate entry point structure (but don't block loading)
      try {
        StacErrorHandler.validateEntryPoint(json);
      } catch (e) {
        AppLogger.w('Entry point validation warning: $e');
        // Show warning but still allow editing
        setState(() {
          _errorMessage =
              'Warning: ${StacErrorHandler.getUserFriendlyMessage(e)}';
        });
      }

      // Load entry point content initially
      final formattedJson = const JsonEncoder.withIndent('  ').convert(json);

      setState(() {
        _jsonContent = formattedJson;
        _hasUnsavedChanges = false;
        _isLoading = false;
        // Select entry point file by default
        if (_editableFiles.isNotEmpty && _selectedFile == null) {
          _selectedFile = _editableFiles.firstWhere(
            (f) => f.type == 'entry_point',
            orElse: () => _editableFiles.first,
          );
        }
      });
    } catch (e) {
      AppLogger.e('Failed to load entry point content', e);
      final userMessage = StacErrorHandler.getUserFriendlyMessage(e);
      setState(() {
        _errorMessage = userMessage;
        _jsonContent = '';
        _editableFiles = [];
        _selectedFile = null;
        _isLoading = false;
      });
    }
  }

  /// Discover all editable JSON files from the entry point
  Future<void> _discoverEditableFiles() async {
    if (_selectedEntryPoint == null || _entryPointConfig == null) {
      _editableFiles = [];
      return;
    }

    final files = <EditableJsonFile>[];

    // Add entry point file itself (use absolute path)
    files.add(EditableJsonFile(
      path: _selectedEntryPoint!,
      displayName: 'Entry Point (app_entry_point.json)',
      type: 'entry_point',
    ));

    // Add all template and data files from screens
    // Store the relative path as-is, let StacJsonFileService handle resolution
    for (final entry in _entryPointConfig!.screens.entries) {
      final screenName = entry.key;
      final screenConfig = entry.value;

      // Store template path as-is (relative or absolute)
      files.add(EditableJsonFile(
        path: screenConfig.template,
        displayName: '$screenName - Template',
        type: 'template',
        screenName: screenName,
      ));

      // Store data path as-is (relative or absolute)
      files.add(EditableJsonFile(
        path: screenConfig.data,
        displayName: '$screenName - Data',
        type: 'data',
        screenName: screenName,
      ));
    }

    setState(() {
      _editableFiles = files;
    });
  }

  /// Load content of selected file
  Future<void> _loadSelectedFileContent() async {
    if (_selectedFile == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Get base directory for relative path resolution
      String? baseDir;
      if (_selectedEntryPoint != null) {
        baseDir = File(_selectedEntryPoint!).parent.path;
      }

      final json = await StacJsonFileService.loadJson(
        _selectedFile!.path,
        baseDir: baseDir,
      );

      // Validate based on file type
      if (_selectedFile!.type == 'entry_point') {
        try {
          StacErrorHandler.validateEntryPoint(json);
        } catch (e) {
          AppLogger.w('Entry point validation warning: $e');
          setState(() {
            _errorMessage =
                'Warning: ${StacErrorHandler.getUserFriendlyMessage(e)}';
          });
        }
      } else if (_selectedFile!.type == 'template' ||
          _selectedFile!.type == 'data') {
        try {
          StacErrorHandler.validateScreenJson(
            json,
            _selectedFile!.screenName ?? 'unknown',
          );
        } catch (e) {
          AppLogger.w('Screen JSON validation warning: $e');
          setState(() {
            _errorMessage =
                'Warning: ${StacErrorHandler.getUserFriendlyMessage(e)}';
          });
        }
      }

      final formattedJson = const JsonEncoder.withIndent('  ').convert(json);

      setState(() {
        _jsonContent = formattedJson;
        _hasUnsavedChanges = false;
        _isLoading = false;
      });
    } catch (e) {
      AppLogger.e('Failed to load file content', e);
      final userMessage = StacErrorHandler.getUserFriendlyMessage(e);
      setState(() {
        _errorMessage = userMessage;
        _jsonContent = '';
        _isLoading = false;
      });
    }
  }

  /// Save current JSON content to selected file
  Future<void> _saveCurrentFile() async {
    if (_selectedFile == null) {
      _showSnackBar('No file selected', isError: true);
      return;
    }

    // Check for empty content
    if (_jsonContent.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Cannot save empty JSON file';
      });
      _showSnackBar('Cannot save empty JSON', isError: true);
      return;
    }

    // Validate JSON syntax
    Map<String, dynamic> json;
    try {
      json = jsonDecode(_jsonContent) as Map<String, dynamic>;
    } catch (e) {
      final userMessage = StacErrorHandler.getUserFriendlyMessage(e);
      setState(() {
        _errorMessage = userMessage;
        _isLoading = false;
      });
      _showSnackBar('Invalid JSON syntax', isError: true);
      return;
    }

    // Validate based on file type
    try {
      if (_selectedFile!.type == 'entry_point') {
        StacErrorHandler.validateEntryPoint(json);
      } else if (_selectedFile!.type == 'template' ||
          _selectedFile!.type == 'data') {
        StacErrorHandler.validateScreenJson(
          json,
          _selectedFile!.screenName ?? 'unknown',
        );
      }
    } catch (e) {
      final userMessage = StacErrorHandler.getUserFriendlyMessage(e);
      setState(() {
        _errorMessage = userMessage;
        _isLoading = false;
      });
      _showSnackBar('Invalid JSON structure', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Get base directory for relative path resolution
      String? baseDir;
      if (_selectedEntryPoint != null) {
        baseDir = File(_selectedEntryPoint!).parent.path;
      }

      // Write to file
      await StacJsonFileService.writeJson(
        _selectedFile!.path,
        json,
        baseDir: baseDir,
      );

      setState(() {
        _hasUnsavedChanges = false;
        _isLoading = false;
      });

      _showSnackBar('File saved successfully: ${_selectedFile!.displayName}');

      // If entry point was saved, reload files and update providers
      if (_selectedFile!.type == 'entry_point') {
        await _loadEntryPointContent();
        final currentEntryPoint =
            ref.read(currentEntryPointProvider).entryPoint;
        if (currentEntryPoint == _selectedEntryPoint) {
          ref.invalidate(entryPointConfigProvider);
        }
      } else {
        // If template/data was saved, invalidate screen data provider
        ref.invalidate(screenDataProvider);
      }
    } catch (e) {
      AppLogger.e('Failed to save file', e);
      final userMessage = StacErrorHandler.getUserFriendlyMessage(e);
      setState(() {
        _errorMessage = userMessage;
        _isLoading = false;
      });
      _showSnackBar('Failed to save file', isError: true);
    }
  }

  /// Trigger hot reload in test app
  void _triggerHotReload() {
    ref.read(hotReloadTriggerProvider).triggerReload();
    _showSnackBar('Hot reload triggered');
    AppLogger.i('🔄 Hot reload triggered from playground');
  }

  /// Trigger restart in test app
  void _triggerRestart() {
    ref.read(restartTriggerProvider).triggerRestart();
    _showSnackBar('Restart triggered');
    AppLogger.i('🔄 Restart triggered from playground');
  }

  /// Handle entry point selection change
  void _onEntryPointChanged(String? value) {
    if (value == null) return;

    // Check for unsaved changes
    if (_hasUnsavedChanges) {
      _showUnsavedChangesDialog(() {
        _switchEntryPoint(value);
      });
    } else {
      _switchEntryPoint(value);
    }
  }

  /// Switch to a new entry point
  void _switchEntryPoint(String value) {
    setState(() {
      _selectedEntryPoint = value;
      _selectedFile = null; // Reset selected file
      _editableFiles = [];
    });
    _loadEntryPointContent();

    // Update test app's current entry point
    ref.read(currentEntryPointProvider).setEntryPoint(value);

    // Invalidate providers to reload with new entry point
    ref.invalidate(entryPointConfigProvider);
    ref.invalidate(screenDataProvider);

    AppLogger.i('🔄 Entry point changed to: $value');
  }

  /// Handle file selection change
  void _onFileChanged(EditableJsonFile? file) {
    if (file == null) return;

    // Check for unsaved changes
    if (_hasUnsavedChanges) {
      _showUnsavedChangesDialog(() {
        _switchFile(file);
      });
    } else {
      _switchFile(file);
    }
  }

  /// Switch to a new file
  void _switchFile(EditableJsonFile file) {
    setState(() {
      _selectedFile = file;
    });
    _loadSelectedFileContent();
    AppLogger.i('🔄 File changed to: ${file.displayName}');
  }

  /// Show dialog for unsaved changes (custom dialog, no Navigator needed)
  void _showUnsavedChangesDialog(VoidCallback onDiscard) {
    setState(() {
      _showUnsavedDialog = true;
      _pendingAction = onDiscard;
    });
  }

  /// Hide unsaved changes dialog
  void _hideUnsavedDialog() {
    setState(() {
      _showUnsavedDialog = false;
      _pendingAction = null;
    });
  }

  /// Confirm discard and execute pending action
  void _confirmDiscard() {
    final action = _pendingAction;
    _hideUnsavedDialog();
    if (action != null) {
      action();
    }
  }

  /// Show status message (using custom display instead of ScaffoldMessenger)
  void _showSnackBar(String message, {bool isError = false}) {
    setState(() {
      _statusMessage = message;
    });
    // Auto-hide after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _statusMessage = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STAC Test App Playground'),
        actions: [
          if (_hasUnsavedChanges)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _isLoading ? null : _saveCurrentFile,
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _triggerHotReload,
          ),
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: _isLoading ? null : _triggerRestart,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadEntryPoints,
          ),
        ],
      ),
      body: _isLoading && _entryPoints.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Column(
                  children: [
                    // Entry Point Selector
                    _buildEntryPointSelector(),

                    // Status Message
                    if (_statusMessage != null) _buildStatusMessage(),

                    // Error Message
                    if (_errorMessage != null) _buildErrorMessage(),

                    // JSON Editor
                    Expanded(
                      child: _buildJsonEditor(),
                    ),

                    // Action Buttons
                    _buildActionButtons(),
                  ],
                ),
                // Entry Point Dropdown Menu (shown when _isMenuOpen is true)
                if (_isMenuOpen) _buildEntryPointDropdownMenu(),

                // File Dropdown Menu (shown when _isFileMenuOpen is true)
                if (_isFileMenuOpen) _buildFileDropdownMenu(),

                // Unsaved Changes Dialog (shown when _showUnsavedDialog is true)
                if (_showUnsavedDialog) _buildUnsavedChangesDialog(),
              ],
            ),
    );
  }

  /// Build entry point selector dropdown
  Widget _buildEntryPointSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Entry Point:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildEntryPointMenu(),
              ),
              if (_hasUnsavedChanges)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Unsaved',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          // File selector (only show if entry point is loaded)
          if (_editableFiles.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'File to Edit:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFileMenu(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Build entry point menu button
  Widget _buildEntryPointMenu() {
    return GestureDetector(
      onTap: _entryPoints.isEmpty
          ? null
          : () {
              setState(() {
                _isMenuOpen = !_isMenuOpen;
                _isFileMenuOpen = false; // Close file menu if open
              });
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _selectedEntryPoint ?? 'Select entry point',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _selectedEntryPoint == null
                      ? Theme.of(context).hintColor
                      : null,
                ),
              ),
            ),
            Icon(
              _isMenuOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }

  /// Build file menu button
  Widget _buildFileMenu() {
    return GestureDetector(
      onTap: _editableFiles.isEmpty
          ? null
          : () {
              setState(() {
                _isFileMenuOpen = !_isFileMenuOpen;
                _isMenuOpen = false; // Close entry point menu if open
              });
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _selectedFile?.displayName ?? 'Select file to edit',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _selectedFile == null
                      ? Theme.of(context).hintColor
                      : null,
                ),
              ),
            ),
            Icon(
              _isFileMenuOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }

  /// Build entry point dropdown menu widget (part of widget tree, not overlay)
  Widget _buildEntryPointDropdownMenu() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMenuOpen = false;
        });
      },
      child: Container(
        color: Colors.black.withValues(alpha: 0.3),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              maxWidth: 600,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Select Entry Point',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _isMenuOpen = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // List
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _entryPoints.length,
                    itemBuilder: (context, index) {
                      final path = _entryPoints[index];
                      final isSelected = path == _selectedEntryPoint;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _isMenuOpen = false;
                          });
                          _onEntryPointChanged(path);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: 0.1)
                                : null,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  path,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build file dropdown menu widget (part of widget tree, not overlay)
  Widget _buildFileDropdownMenu() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFileMenuOpen = false;
        });
      },
      child: Container(
        color: Colors.black.withValues(alpha: 0.3),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              maxWidth: 600,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Select File to Edit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _isFileMenuOpen = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // List
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _editableFiles.length,
                    itemBuilder: (context, index) {
                      final file = _editableFiles[index];
                      final isSelected = _selectedFile?.path == file.path;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _isFileMenuOpen = false;
                          });
                          _onFileChanged(file);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: 0.1)
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getFileIcon(file.type),
                                size: 20,
                                color: _getFileIconColor(file.type),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      file.displayName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    if (file.screenName != null)
                                      Text(
                                        'Screen: ${file.screenName}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Get icon for file type
  IconData _getFileIcon(String type) {
    switch (type) {
      case 'entry_point':
        return Icons.settings;
      case 'template':
        return Icons.code;
      case 'data':
        return Icons.data_object;
      default:
        return Icons.description;
    }
  }

  /// Get icon color for file type
  Color _getFileIconColor(String type) {
    switch (type) {
      case 'entry_point':
        return Colors.blue;
      case 'template':
        return Colors.purple;
      case 'data':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// Build status message widget
  Widget _buildStatusMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.blue.shade50,
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _statusMessage!,
              style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            color: Colors.blue.shade700,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                _statusMessage = null;
              });
            },
          ),
        ],
      ),
    );
  }

  /// Build error message widget
  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.red.shade50,
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red.shade700),
            ),
          ),
        ],
      ),
    );
  }

  /// Build unsaved changes dialog (custom dialog, no Navigator needed)
  Widget _buildUnsavedChangesDialog() {
    return GestureDetector(
      onTap: _hideUnsavedDialog,
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent closing when tapping dialog content
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unsaved Changes',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'You have unsaved changes. Do you want to discard them?',
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _hideUnsavedDialog,
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: _confirmDiscard,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          child: const Text('Discard'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build JSON editor widget
  Widget _buildJsonEditor() {
    if (_selectedEntryPoint == null) {
      return const Center(
        child: Text('Please select an entry point file'),
      );
    }

    if (_selectedFile == null) {
      return const Center(
        child: Text('Please select a file to edit'),
      );
    }

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return JsonEditor(
      key: ValueKey(_selectedFile?.path), // Force rebuild when file changes
      initialJson: _jsonContent,
      onChanged: (value) {
        // Defer setState to avoid calling during build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _jsonContent = value;
              _hasUnsavedChanges = true;
            });
          }
        });
      },
      onValidationChanged: (isValid) {
        // Defer setState to avoid calling during build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              if (!isValid) {
                _errorMessage = 'Invalid JSON syntax';
              } else {
                _errorMessage = null;
              }
            });
          }
        });
      },
    );
  }

  /// Build action buttons
  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed:
                _isLoading || _selectedFile == null ? null : _saveCurrentFile,
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _triggerHotReload,
            icon: const Icon(Icons.refresh),
            label: const Text('Hot Reload'),
          ),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _triggerRestart,
            icon: const Icon(Icons.restart_alt),
            label: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
