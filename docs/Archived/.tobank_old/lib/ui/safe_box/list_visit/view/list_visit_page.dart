import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/safe_box/list_visit_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../visit_item_widget.dart';

class ListVisitPage extends StatelessWidget {
  const ListVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ListVisitController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: controller.userVisitListResponseData!.data!.visitTimes!.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                        height: 200,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        locale.no_record_yet,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    itemBuilder: (BuildContext context, int index) {
                      return VisitItemWidget(
                        visitTime: controller.userVisitListResponseData!.data!.visitTimes![index],
                        address: controller.userVisitListResponseData!.data!.fund!.branch!.address,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 16.0,
                      );
                    },
                    itemCount: controller.userVisitListResponseData!.data!.visitTimes!.length,
                  ),
          ),
        ],
      );
    });
  }
}
