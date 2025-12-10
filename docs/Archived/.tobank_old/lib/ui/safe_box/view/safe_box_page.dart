import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/safe_box/safe_box_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../safe_box_item_widget.dart';

class SafeBoxPage extends StatelessWidget {
  const SafeBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<SafeBoxController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: controller.safeBoxDataList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                        height: 200,
                      ),
                      Text(
                        locale.no_safe_box_registered,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    itemBuilder: (context, index) {
                      return SafeBoxItemWidget(
                        safeBoxData: controller.safeBoxDataList[index],
                        visitFunction: (safeBoxData) {
                          controller.showVisitListScreen(safeBoxData);
                        },
                        requestVisitFunction: (safeBoxData) {
                          controller.showRequestVisitScreen(safeBoxData);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16.0,
                      );
                    },
                    itemCount: controller.safeBoxDataList.length),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 56.0,
                child: ElevatedButton(
                  onPressed: () {
                    controller.showAddSafeBoxScreen();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ThemeUtil.primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SvgIcon(
                        SvgIcons.add,
                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        size: 24,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        locale.rent_safe_box,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      );
    });
  }
}
