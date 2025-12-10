import 'package:get/get.dart';

import '../../ui/cbs/cbs_screen.dart';
import '../../util/storage_util.dart';

class CBSIntroductionController extends GetxController {
  bool isShowCBSIntroduction = true;

  void setChecked(bool isChecked) {
    isShowCBSIntroduction = !isChecked;
    update();
  }

  void getToCBSScreen() {
    StorageUtil.setShowCBSIntroduction(isShowCBSIntroduction);
    Get.off(() => const CBSScreen());
  }
}
