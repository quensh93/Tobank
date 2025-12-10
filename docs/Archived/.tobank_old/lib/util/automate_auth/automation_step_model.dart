import 'package:get/get.dart';

/// The possible states of a single automation step.
enum StepStatus { pending, inProgress, success, failure }

/// A model that represents one step in the automation flow.
class AutomationStepModel {
  final String title;

  /// The asynchronous action to perform when this step is triggered.
  final Future<void> Function() action;

  /// Reactive status; updates to this will re-render the UI.
  final Rx<StepStatus> status;

  AutomationStepModel({
    required this.title,
    required this.action,
    StepStatus initialStatus = StepStatus.pending,
  }) : status = initialStatus.obs;
}
