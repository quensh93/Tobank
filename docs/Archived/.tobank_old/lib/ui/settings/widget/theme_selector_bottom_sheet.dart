import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/settings/settings_controller.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';

class ThemeSelectorBottomSheet extends StatelessWidget {
  const ThemeSelectorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<SettingsController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 36,
                          height: 4,
                          decoration:
                              BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    locale.select_app_appearance,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.setSelectedTheme(DataConstants.getThemeDataList()[index].code);
                          },
                          child: Container(
                            height: 64.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: context.theme.dividerColor),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  activeColor: context.theme.colorScheme.secondary,
                                  value: DataConstants.getThemeDataList()[index].code,
                                  groupValue: controller.selectedTheme,
                                  onChanged: (String? value) {
                                    controller.setSelectedTheme(DataConstants.getThemeDataList()[index].code);
                                  },
                                ),
                                Text(DataConstants.getThemeDataList()[index].title,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16.0);
                      },
                      itemCount: DataConstants.getThemeDataList().length),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
