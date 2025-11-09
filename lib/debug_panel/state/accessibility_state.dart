import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'debug_panel_settings_state.dart';

/// Accessibility issue severity levels
enum AccessibilitySeverity {
  low,
  medium,
  high,
}

/// Types of accessibility issues
enum AccessibilityIssueType {
  colorContrast,
  semanticLabel,
  touchTarget,
  navigation,
  textScaling,
  focusManagement,
}

/// Accessibility issue model
class AccessibilityIssue {
  const AccessibilityIssue({
    required this.title,
    required this.description,
    required this.type,
    required this.severity,
    this.details = '',
    this.suggestedFix = '',
    this.widgetId,
  });

  final String title;
  final String description;
  final AccessibilityIssueType type;
  final AccessibilitySeverity severity;
  final String details;
  final String suggestedFix;
  final String? widgetId;
}

/// Accessibility state
class AccessibilityState {
  const AccessibilityState({
    required this.issues,
    required this.filteredIssues,
    required this.isAuditing,
    required this.selectedFilter,
    required this.searchFilter,
  });

  final List<AccessibilityIssue> issues;
  final List<AccessibilityIssue> filteredIssues;
  final bool isAuditing;
  final AccessibilityIssueType? selectedFilter;
  final String searchFilter;

  AccessibilityState copyWith({
    List<AccessibilityIssue>? issues,
    List<AccessibilityIssue>? filteredIssues,
    bool? isAuditing,
    AccessibilityIssueType? selectedFilter,
    String? searchFilter,
  }) {
    return AccessibilityState(
      issues: issues ?? this.issues,
      filteredIssues: filteredIssues ?? this.filteredIssues,
      isAuditing: isAuditing ?? this.isAuditing,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchFilter: searchFilter ?? this.searchFilter,
    );
  }
}

/// Accessibility controller
class AccessibilityController extends Notifier<AccessibilityState> {
  @override
  AccessibilityState build() {
    // WATCH the settings provider so we rebuild when settings are loaded
    final settings = ref.watch(debugPanelSettingsProvider);
    
    // Convert string to AccessibilityIssueType
    AccessibilityIssueType? initialFilter;
    if (settings.accessibilitySelectedFilter != null) {
      try {
        initialFilter = AccessibilityIssueType.values.firstWhere(
          (e) => e.name == settings.accessibilitySelectedFilter,
        );
      } catch (e) {
        initialFilter = null;
      }
    }
    
    return AccessibilityState(
      issues: [],
      filteredIssues: [],
      isAuditing: false,
      selectedFilter: initialFilter,
      searchFilter: '',
    );
  }

  List<AccessibilityIssue> _applyFilters(List<AccessibilityIssue> issues) {
    var filtered = issues;

    // Apply type filter
    if (state.selectedFilter != null) {
      filtered = filtered.where((issue) {
        return issue.type == state.selectedFilter;
      }).toList();
    }

    // Apply search filter
    if (state.searchFilter.isNotEmpty) {
      filtered = filtered.where((issue) {
        return issue.title.toLowerCase().contains(state.searchFilter.toLowerCase()) ||
               issue.description.toLowerCase().contains(state.searchFilter.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  /// Start accessibility audit
  Future<void> startAudit() async {
    state = state.copyWith(isAuditing: true);
    
    // Simulate audit process
    await Future.delayed(const Duration(seconds: 2));
    
    // Generate sample issues for demonstration
    final sampleIssues = _generateSampleIssues();
    
    state = state.copyWith(
      issues: sampleIssues,
      filteredIssues: _applyFilters(sampleIssues),
      isAuditing: false,
    );
  }

  /// Clear audit results
  void clearResults() {
    state = state.copyWith(
      issues: [],
      filteredIssues: [],
    );
  }

  /// Set filter type
  void setFilter(AccessibilityIssueType? filter) {
    state = state.copyWith(
      selectedFilter: filter,
      filteredIssues: _applyFilters(state.issues),
    );
    // Save to centralized settings
    final settingsController = ref.read(debugPanelSettingsProvider.notifier);
    settingsController.setAccessibilitySelectedFilter(filter?.name);
  }

  /// Set search filter
  void setSearchFilter(String search) {
    state = state.copyWith(
      searchFilter: search,
      filteredIssues: _applyFilters(state.issues),
    );
  }

  /// Check color contrast
  void checkColorContrast() {
    final contrastIssues = [
      const AccessibilityIssue(
        title: 'Low Color Contrast',
        description: 'Text color does not meet WCAG AA contrast requirements',
        type: AccessibilityIssueType.colorContrast,
        severity: AccessibilitySeverity.high,
        details: 'Contrast ratio: 2.8:1 (Required: 4.5:1)',
        suggestedFix: 'Use darker text color or lighter background',
      ),
    ];
    
    _addIssues(contrastIssues);
  }

  /// Validate semantic labels
  void validateSemanticLabels() {
    final labelIssues = [
      const AccessibilityIssue(
        title: 'Missing Semantic Label',
        description: 'Button lacks semantic label for screen readers',
        type: AccessibilityIssueType.semanticLabel,
        severity: AccessibilitySeverity.medium,
        details: 'Widget: ElevatedButton at line 45',
        suggestedFix: 'Add Semantics widget or tooltip',
      ),
    ];
    
    _addIssues(labelIssues);
  }

  /// Check touch targets
  void checkTouchTargets() {
    final touchIssues = [
      const AccessibilityIssue(
        title: 'Small Touch Target',
        description: 'Touch target is smaller than recommended 44x44 dp',
        type: AccessibilityIssueType.touchTarget,
        severity: AccessibilitySeverity.medium,
        details: 'Current size: 32x32 dp',
        suggestedFix: 'Increase padding or minimum size',
      ),
    ];
    
    _addIssues(touchIssues);
  }

  /// Test navigation
  void testNavigation() {
    final navigationIssues = [
      const AccessibilityIssue(
        title: 'Missing Focus Order',
        description: 'Navigation elements lack proper focus order',
        type: AccessibilityIssueType.navigation,
        severity: AccessibilitySeverity.high,
        details: 'Focus jumps unexpectedly between elements',
        suggestedFix: 'Implement proper focus management',
      ),
    ];
    
    _addIssues(navigationIssues);
  }

  void _addIssues(List<AccessibilityIssue> newIssues) {
    final updatedIssues = [...state.issues, ...newIssues];
    state = state.copyWith(
      issues: updatedIssues,
      filteredIssues: _applyFilters(updatedIssues),
    );
  }

  List<AccessibilityIssue> _generateSampleIssues() {
    return [
      const AccessibilityIssue(
        title: 'Low Color Contrast',
        description: 'Text color does not meet WCAG AA contrast requirements',
        type: AccessibilityIssueType.colorContrast,
        severity: AccessibilitySeverity.high,
        details: 'Contrast ratio: 2.8:1 (Required: 4.5:1)',
        suggestedFix: 'Use darker text color or lighter background',
      ),
      const AccessibilityIssue(
        title: 'Missing Semantic Label',
        description: 'Button lacks semantic label for screen readers',
        type: AccessibilityIssueType.semanticLabel,
        severity: AccessibilitySeverity.medium,
        details: 'Widget: ElevatedButton at line 45',
        suggestedFix: 'Add Semantics widget or tooltip',
      ),
      const AccessibilityIssue(
        title: 'Small Touch Target',
        description: 'Touch target is smaller than recommended 44x44 dp',
        type: AccessibilityIssueType.touchTarget,
        severity: AccessibilitySeverity.medium,
        details: 'Current size: 32x32 dp',
        suggestedFix: 'Increase padding or minimum size',
      ),
      const AccessibilityIssue(
        title: 'Missing Focus Order',
        description: 'Navigation elements lack proper focus order',
        type: AccessibilityIssueType.navigation,
        severity: AccessibilitySeverity.high,
        details: 'Focus jumps unexpectedly between elements',
        suggestedFix: 'Implement proper focus management',
      ),
      const AccessibilityIssue(
        title: 'Text Scaling Issue',
        description: 'Text does not scale properly with system font size',
        type: AccessibilityIssueType.textScaling,
        severity: AccessibilitySeverity.low,
        details: 'Fixed font size prevents accessibility scaling',
        suggestedFix: 'Use relative font sizes or MediaQuery.textScaleFactor',
      ),
    ];
  }
}

/// Accessibility state provider
final accessibilityStateProvider = NotifierProvider<AccessibilityController, AccessibilityState>(
  AccessibilityController.new,
);
