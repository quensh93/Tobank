import 'package:universal_io/io.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/settings/settings_controller.dart';
import '../../util/data_constants.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';
import '../common/custom_app_bar.dart';
import 'widget/settings_item_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.setting,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 16,
                            ),
                            if (controller.canAuthenticate && (controller.hasFaceDetect || controller.hasFingerPrint))
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: context.theme.dividerColor),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                  child: Row(
                                    children: [
                                      SvgIcon(
                                        Get.isDarkMode ? SvgIcons.fingerprintDark : SvgIcons.fingerprint,
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          ((Platform.isIOS && controller.hasFaceDetect)
                                              ? locale.face_id_activate
                                              : locale.fingerprint_activation),
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        width: 36.0,
                                        height: 24.0,
                                        child: Transform.scale(
                                          scale: 0.7,
                                          transformHitTests: false,
                                          child: CupertinoSwitch(
                                            activeColor: context.theme.colorScheme.secondary,
                                            value: controller.isSecurityEnable,
                                            onChanged: (bool value) {
                                              controller.toggleActive(value);
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            else
                              Container(),
                            const SizedBox(
                              height: 16,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(8.0),
                              onTap: () {
                                controller.showThemeSelectorBottomSheet();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: context.theme.dividerColor),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                  child: Row(
                                    children: [
                                      SvgIcon(
                                        Get.isDarkMode ? SvgIcons.themeDark : SvgIcons.theme,
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          locale.app_appearance,
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        controller.getCurrentTheme(),
                                        style: TextStyle(
                                          color: ThemeUtil.textSubtitleColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      SvgIcon(
                                        SvgIcons.arrowLeft,
                                        colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SettingsItemWidget(
                                    settingItemData: DataConstants.getSettingItems()[index],
                                    returnDataFunction: (settingItemData) {
                                      controller.handleItemClick(settingItemData);
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 16.0,
                                  );
                                },
                                itemCount: DataConstants.getSettingItems().length),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
