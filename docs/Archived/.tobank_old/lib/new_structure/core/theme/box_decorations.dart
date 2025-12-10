import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'main_theme.dart';

mixin BoxDecorations {
  static BoxDecoration onSurfaceBorder = BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      border: Border.all(
          color: MainTheme.of(Get.context!).onSurface
      )
  );
  static BoxDecoration secondaryContainerFillSecondaryBorder = BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      border: Border.all(
          color: MainTheme.of(Get.context!).secondary
      ),
      color: MainTheme.of(Get.context!).secondaryContainer
  );
}