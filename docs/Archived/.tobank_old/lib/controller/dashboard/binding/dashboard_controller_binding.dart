import 'package:get/get.dart';

import '../../../util/automate_auth/automation_controller.dart';
import '../dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController(), permanent: true);
    Get.put(AutomationController(), permanent: true);
  }
}