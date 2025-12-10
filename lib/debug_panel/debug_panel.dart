// Debug Panel Package Exports
// This file provides a clean API for the debug panel package

// Main debug panel widget
export 'debug_panel_widget.dart';

// State management
export 'state/debug_panel_state.dart';
export 'state/device_preview_state.dart';
// Note: logs_state.dart removed - now using ISpect's LogsScreen directly
export 'state/accessibility_state.dart';

// Theme
export 'themes/debug_panel_theme.dart';

// Models
export 'models/device_info.dart';
export 'models/widget_node.dart';

// Widgets (if needed for external customization)
export 'widgets/device_preview_tab.dart';
export 'widgets/logs_tab.dart';
export 'widgets/accessibility_tab.dart';
export 'widgets/component_palette.dart';
export 'widgets/editor_canvas.dart';
export 'widgets/property_editor.dart';
// Note: widget_tree_view.dart is disabled

// Screens
export 'screens/json_playground_screen.dart';
// Note: visual_editor_screen.dart is disabled

// Data
export 'data/playground_templates.dart';