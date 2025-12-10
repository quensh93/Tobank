import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/rule/rule_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RuleController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Card(
            elevation: Get.isDarkMode ? 1 : 0,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
              child: Text(
                AppUtil.getContents(controller.otherItemData!.data!.data!.content!),
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
