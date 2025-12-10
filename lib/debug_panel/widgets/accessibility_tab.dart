import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/accessibility_state.dart';

/// Accessibility tab for testing and validation
class AccessibilityTab extends ConsumerWidget {
  const AccessibilityTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accessibilityStateProvider);
    final controller = ref.read(accessibilityStateProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Accessibility Audit Section
          _buildSectionHeader(context, 'Accessibility Audit'),
          const SizedBox(height: 8),
          _buildAuditControls(context, state, controller),
          
          const SizedBox(height: 16),
          
          // Audit Results Section
          _buildSectionHeader(context, 'Audit Results'),
          const SizedBox(height: 8),
          SizedBox(
            height: 300, // Fixed height for audit results
            child: _buildAuditResults(context, state),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildAuditControls(BuildContext context, AccessibilityState state, AccessibilityController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Audit Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: state.isAuditing ? null : () => controller.startAudit(),
                    icon: state.isAuditing 
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.search),
                    label: Text(state.isAuditing ? 'Auditing...' : 'Start Audit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: state.issues.isEmpty ? null : controller.clearResults,
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear Results'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<AccessibilityIssueType>(
                    initialValue: state.selectedFilter,
                    decoration: const InputDecoration(
                      labelText: 'Filter by Type',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: AccessibilityIssueType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_getIssueTypeIcon(type), size: 16),
                            const SizedBox(width: 8),
                            Text(_getIssueTypeName(type)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.setFilter(value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Search Issues',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: controller.setSearchFilter,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Quick Actions
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionChip(
                  label: const Text('Check Contrast'),
                  onPressed: () => controller.checkColorContrast(),
                  avatar: const Icon(Icons.palette, size: 16),
                ),
                ActionChip(
                  label: const Text('Validate Labels'),
                  onPressed: () => controller.validateSemanticLabels(),
                  avatar: const Icon(Icons.label, size: 16),
                ),
                ActionChip(
                  label: const Text('Check Touch Targets'),
                  onPressed: () => controller.checkTouchTargets(),
                  avatar: const Icon(Icons.touch_app, size: 16),
                ),
                ActionChip(
                  label: const Text('Test Navigation'),
                  onPressed: () => controller.testNavigation(),
                  avatar: const Icon(Icons.navigation, size: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditResults(BuildContext context, AccessibilityState state) {
    if (state.isAuditing) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Running accessibility audit...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'This may take a few moments',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    if (state.filteredIssues.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.accessibility_new,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              state.issues.isEmpty ? 'No audit results' : 'No issues found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.issues.isEmpty 
                  ? 'Run an accessibility audit to check your app'
                  : 'Great! No accessibility issues detected',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: state.filteredIssues.length,
        itemBuilder: (context, index) {
          final issue = state.filteredIssues[index];
          return _buildIssueItem(context, issue);
        },
      ),
    );
  }

  Widget _buildIssueItem(BuildContext context, AccessibilityIssue issue) {
    final severityColor = _getSeverityColor(context, issue.severity);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Issue header
          Row(
            children: [
              Icon(
                _getIssueTypeIcon(issue.type),
                size: 16,
                color: severityColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  issue.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: severityColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  issue.severity.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: severityColor,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Issue description
          Text(
            issue.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          
          // Issue details
          if (issue.details.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                issue.details,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
          
          // Suggested fix
          if (issue.suggestedFix.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Suggested fix: ${issue.suggestedFix}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  IconData _getIssueTypeIcon(AccessibilityIssueType type) {
    switch (type) {
      case AccessibilityIssueType.colorContrast:
        return Icons.palette;
      case AccessibilityIssueType.semanticLabel:
        return Icons.label;
      case AccessibilityIssueType.touchTarget:
        return Icons.touch_app;
      case AccessibilityIssueType.navigation:
        return Icons.navigation;
      case AccessibilityIssueType.textScaling:
        return Icons.text_fields;
      case AccessibilityIssueType.focusManagement:
        return Icons.center_focus_strong;
    }
  }

  String _getIssueTypeName(AccessibilityIssueType type) {
    switch (type) {
      case AccessibilityIssueType.colorContrast:
        return 'Color Contrast';
      case AccessibilityIssueType.semanticLabel:
        return 'Semantic Labels';
      case AccessibilityIssueType.touchTarget:
        return 'Touch Targets';
      case AccessibilityIssueType.navigation:
        return 'Navigation';
      case AccessibilityIssueType.textScaling:
        return 'Text Scaling';
      case AccessibilityIssueType.focusManagement:
        return 'Focus Management';
    }
  }

  Color _getSeverityColor(BuildContext context, AccessibilitySeverity severity) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (severity) {
      case AccessibilitySeverity.low:
        return colorScheme.secondary;
      case AccessibilitySeverity.medium:
        return colorScheme.tertiary;
      case AccessibilitySeverity.high:
        return colorScheme.error;
    }
  }
}
