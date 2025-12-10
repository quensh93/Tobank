import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/about_us/about_us_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AboutUsController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32.0,
              ),
              if (Get.isDarkMode)
                const SvgIcon(
                  SvgIcons.tobankWhite,
                  size: 26.0,
                )
              else
                const SvgIcon(
                  SvgIcons.tobankRed,
                  size: 26.0,
                ),
              const SizedBox(
                height: 16.0,
              ),
              Text(locale.virtual_branch_with_you,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 32,
              ),
              Card(
                color: Colors.transparent,
                elevation: Get.isDarkMode ? 1 : 0,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
            ],
          ),
        ),
      );
    });
  }
}
