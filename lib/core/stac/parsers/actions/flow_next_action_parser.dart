import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../flow/flow_manager.dart';

/// Action to advance to the next step in a flow.
///
/// If a [FlowManager] is found in the context (via [FlowProvider]),
/// it calls [FlowManager.nextStep].
///
/// If no [FlowManager] is found (standalone mode), it executes the
/// [fallbackAction] if provided.
class FlowNextActionParser extends StacActionParser<StacFlowNextAction> {
  const FlowNextActionParser();

  @override
  String get actionType => 'flowNext';

  @override
  StacFlowNextAction getModel(Map<String, dynamic> json) {
    return StacFlowNextAction.fromJson(json);
  }

  @override
  FutureOr onCall(BuildContext context, StacFlowNextAction model) async {
    debugPrint(
      '🔵 FlowNextAction: Called with fallback: ${model.fallbackAction}',
    );

    // Check if context is still valid/mounted before accessing providers
    // This prevents "deactivated widget" errors during flow completion
    if (!context.mounted) {
      debugPrint('⚠️ FlowNextAction: Context not mounted, skipping...');
      return;
    }

    // Try to find the FlowProvider in the context
    final flowProvider = context
        .dependOnInheritedWidgetOfExactType<FlowProvider>();

    debugPrint(
      '🔍 FlowProvider lookup result: ${flowProvider != null ? "FOUND" : "NOT FOUND"}',
    );

    if (flowProvider != null) {
      debugPrint(
        '✅ FlowNextAction: Found FlowProvider! Current: ${flowProvider.manager.currentIndex}/${flowProvider.manager.totalSteps}',
      );
      // We are in a flow! Advance to next step
      final isLastStep = flowProvider.manager.isLastStep;

      if (isLastStep) {
        debugPrint('🏁 FlowNextAction: Last step, completing flow...');
        // If it's the last step, we might want to complete the flow or run a specific action
        // For now, nextStep() on the manager handles completion logic (setting isCompleted)
        // calling navigate back etc.
        flowProvider.manager.nextStep();

        // If a completion action is defined in the step, the FlowManagerWidget handles it,
        // but strictly speaking the manager just updates state.
        // We might need to manually trigger the complete callback if the widget doesn't react fast enough?
        // Actually FlowManagerWidget listens to state changes.
      } else {
        debugPrint('➡️ FlowNextAction: Advancing to next step...');
        flowProvider.manager.nextStep();
      }
    } else {
      debugPrint('⚠️ FlowNextAction: No FlowProvider found!');
      debugPrint('   Widget type: ${context.widget.runtimeType}');
      // Standalone mode (not in a flow)
      // Execute fallback action if provided
      if (model.fallbackAction != null) {
        debugPrint('🔄 FlowNextAction: Using fallback action...');
        // Simple fallback handling for common actions
        final actionType = model.fallbackAction!['actionType'];

        if (actionType == 'navigate') {
          // Handle navigation fallback
          // We can't use onCall of another parser easily, but we can call StacNavigationService directly
          // We need access to StacWidgetResolver which is imported in CustomNavigateActionParser...
          // For now, let's just log it. In a real app, we'd duplicate the logic or expose a helper.
          debugPrint(
            'FlowNextAction: Executing generic fallback logic is limited. Please use navigate action directly if not in flow.',
          );
        } else if (actionType == 'pop') {
          Navigator.of(context).pop();
        } else {
          debugPrint(
            'FlowNextAction: Unsupported fallback action type: $actionType',
          );
        }
      }
    }
  }
}

class StacFlowNextAction {
  final Map<String, dynamic>? fallbackAction;

  StacFlowNextAction({this.fallbackAction});

  factory StacFlowNextAction.fromJson(Map<String, dynamic> json) {
    return StacFlowNextAction(
      fallbackAction: json['fallback'] as Map<String, dynamic>?,
    );
  }
}
