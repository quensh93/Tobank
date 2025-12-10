import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'automate_auth.dart';
import 'automation_controller.dart';
import 'automation_step_model.dart';

/// The Automation Dashboard page.
/// Provide it with an AutomationController that has a list of steps.
class AutomationPage extends StatelessWidget {
  AutomationPage({super.key});

  final AutomationController controller = Get.find<AutomationController>();

  void _stopAutomation() {
    AutomateAuth.stopAutomation();
    // If controller contains more state, update it here as well
    controller.onAutomationStopped?.call();
  }

  void _refreshAutomation() {
    AutomateAuth.resetAutomation();
    controller.resetAllSteps();
    // Any UI reactive updates
  }

  @override
  Widget build(BuildContext context) {
    // For best UX, wrap the UI in Obx so that UI updates as AutomateAuth.currentStep changes!
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automation Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Obx(
                 () {
                  return Row(
                    children: [
                      Text(
                        'Step ${AutomateAuth.currentStep} of ${AutomateAuth.totalSteps}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: (controller.isRunningAll.value ||
                            AutomateAuth.isCancelled)
                            ? null
                            : controller.runAll,
                      ),
                      const SizedBox(width: 8,),
                      IconButton(
                        icon: const Icon(Icons.stop),
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red),
                        onPressed:
                        AutomateAuth.isCancelled ? null : _stopAutomation,
                      ),
                      const SizedBox(width: 8,),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _refreshAutomation,
                      )
                    ],
                  );
                }
              ),
            ),
            const SizedBox(height: 16),
            // The step list
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: controller.steps.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final step = controller.steps[index];
                    return _StepTile(
                      step: step,
                      onRun: () => controller.runStep(index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single line item representing one automation step.
class _StepTile extends StatelessWidget {
  final AutomationStepModel step;
  final VoidCallback onRun;

  const _StepTile({
    Key? key,
    required this.step,
    required this.onRun,
  }) : super(key: key);

  Widget _buildStatusIcon(StepStatus status) {
    switch (status) {
      case StepStatus.pending:
        return const Icon(Icons.radio_button_unchecked, color: Colors.grey);
      case StepStatus.inProgress:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case StepStatus.success:
        return const Icon(Icons.check_circle, color: Colors.green);
      case StepStatus.failure:
        return const Icon(Icons.error, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final status = step.status.value;
      final isRunning = status == StepStatus.inProgress;

      return ListTile(
        leading: _buildStatusIcon(status),
        title: Text(step.title),
        trailing: ElevatedButton(
          onPressed: isRunning ? null : onRun,
          child: Text(status == StepStatus.failure ? 'Retry' : 'Run'),
        ),
      );
    });
  }
}
