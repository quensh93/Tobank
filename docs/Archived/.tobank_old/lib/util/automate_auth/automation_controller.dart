import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../new_structure/core/app_config/app_config.dart';
import '../../new_structure/core/injection/injection.dart';
import '../app_util.dart';
import 'automate_auth.dart';
import 'automation_step_model.dart';
import 'user_model.dart';
import 'users_data.dart';

class AutomationController extends GetxController {
  /// Your injected or default AutomateAuth service
  final AutomateAuth _auth;

  /// The list of steps; each has its own `status` Rx inside.
  final RxList<AutomationStepModel> steps = <AutomationStepModel>[].obs;

  /// A reactive flag to disable a "Run All" button while it's running.
  final RxBool isRunningAll = false.obs;

  final RxList<UserData> users = <UserData>[aliSinaee,mjp,sjd].obs;
  final Rx<UserData> selectedUser =  aliSinaee.obs;

  final RxBool downloadUserBigDataToTextFile = false.obs;

  VoidCallback? onAutomationStopped;

  /// Optionally cancel a long‐running `runAll()`.
  /// You’d check this inside runAll if you want cancel-in-the-middle behavior.
  bool _stopRequested = false;

  void requestStop() => _stopRequested = true;

  /// Create with either your own `AutomateAuth` (for tests) or default.
  AutomationController({AutomateAuth? auth}) : _auth = auth ?? AutomateAuth() {
    // seed your steps here
    steps.addAll([
      AutomationStepModel(
        title: 'Fill Test Fields',
        action: AutomateAuth.fillTestData,
      ),
      AutomationStepModel(
        title: 'Call OTP Request',
        action: AutomateAuth.callOtpRequest,
      ),
      AutomationStepModel(
        title: 'Show OTP Dialog',
        action: () async {
          final ctx = Get.context;
          if (ctx == null) {
            throw Exception('No BuildContext for OTP dialog');
          }
          await AutomateAuth.showOtpDialog(ctx);
        },
      ),
      AutomationStepModel(
        title: 'Submit OTP',
        action: AutomateAuth.submitOtp,
      ),
      AutomationStepModel(
        title: 'Set Password ["12345]',
        action: AutomateAuth.setPassword,
      ),
      AutomationStepModel(
        title: 'pre register Request',
        action: AutomateAuth.preRegisterRequest,
      ),
      AutomationStepModel(
        title: 'get EKYC OTP Request',
        action: AutomateAuth.getEkysOtp,
      ),
      AutomationStepModel(
        title: 'Show OTP Dialog Ekys',
        action: () async {
          final ctx = Get.context;
          if (ctx == null) {
            throw Exception('No BuildContext for OTP dialog');
          }
          await AutomateAuth.showOtpForEkysDialog(ctx);
        },
      ),
      AutomationStepModel(
        title: 'Submit EKYC OTP',
        action: AutomateAuth.submitEkycOtp,
      ),
      AutomationStepModel(
        title: 'Upload front NC',
        action: AutomateAuth.uploadNationalCodeFront,
      ),
      AutomationStepModel(
        title: 'Upload back NC',
        action: AutomateAuth.uploadNationalCodeBack,
      ),
      AutomationStepModel(
        title: 'verify personal I/V',
        action: AutomateAuth.verifyPersonalImageRequest,
      ),
      AutomationStepModel(
        title: 'verify User address',
        action: AutomateAuth.getAddressInfoRequest,
      ),
      AutomationStepModel(
        title: 'register Signature Image',
        action: AutomateAuth.registerSignatureImage,
      ),
      AutomationStepModel(
        title: 'validate User Form Data',
        action: AutomateAuth.validateUserFormData,
      ),
      AutomationStepModel(
        title: 'validate registration final',
        action: AutomateAuth.validateRegistration,
      ),
      AutomationStepModel(
        title: 'get Customer Info',
        action: AutomateAuth.getCustomerInfoRequest,
      ),
    ]);
  }

  /// Run a single step by index.
  Future<void> runStep(int index) async {
    final step = steps[index];
    step.status.value = StepStatus.inProgress;
    try {
      await step.action();
      step.status.value = StepStatus.success;
    } catch (err, st) {
      debugPrint('Step "${step.title}" failed: $err\n$st');
      step.status.value = StepStatus.failure;
      rethrow; // Propagate error for caller to handle
    }
  }

  /// Run all steps in order.
  /// While running, `isRunningAll` is true so your UI button can disable itself.
  Future<void> runAll() async {
    await cleanAllData(needToClearRoute: false);
    isRunningAll.value = true;
    for (var i = 0; i < steps.length; i++) {
      if (_stopRequested || AutomateAuth.isCancelled) {
        debugPrint('🚦 AutomationController: runAll stopped at step $i');
        break;
      }
      await runStep(i);
    }
    isRunningAll.value = false;
  }

  /// Reset all steps to pending status
  Future<void> resetAllSteps() async{
    await cleanAllData(needToClearRoute: false);
    for (final step in steps) {
      step.status.value = StepStatus.pending;
    }
    _stopRequested = false;
    isRunningAll.value = false;
    AutomateAuth.resetAutomation();
  }

  /// Stop automation, then trigger the callback if set
  void stopAutomation() {
    requestStop();
    if (onAutomationStopped != null) {
      isRunningAll.value = false;
      onAutomationStopped!();
    }
  }

  Future<void> cleanAllData({required bool needToClearRoute}) async {
    final AppEnvironment env = await getIt<AppConfigService>().getSavedEnvironment();
    try{
      await AppUtil.logoutFromApp(needToClearRoute: needToClearRoute);
    }catch(e){}

    await Future.delayed(const Duration(milliseconds: 200));

    await getIt<AppConfigService>().setEnvironment(env);
    print("⭕ Environment is on  '${env.name.toUpperCase()}' Now Restart App");
  }
}
