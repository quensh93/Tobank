import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../controller/launcher/launcher_controller.dart';
import '../../new_structure/core/app_config/app_config.dart';
import '../../new_structure/core/injection/injection.dart';
import '../../util/application_info_util.dart';
import '../../util/enums_constants.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // locale
    final locale = AppLocalizations.of(context)!;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Get.isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: context.theme.colorScheme.surface,
              statusBarIconBrightness: Brightness.light,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.grey.withOpacity(0.01),
              statusBarIconBrightness: Brightness.dark,
            ),
      child: Scaffold(
        body: GetBuilder<LauncherController>(
            init: LauncherController(),
            builder: (controller) {
              return SafeArea(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            flex: 4,
                            child: Get.isDarkMode
                                ? const SvgIcon(
                                    SvgIcons.tobankWhite,
                                    size: 32.0,
                                  )
                                : const SvgIcon(
                                    SvgIcons.tobankRed,
                                    size: 32.0,
                                  ),
                          ),
                          Expanded(
                            flex: 8,
                            child: controller.getMainWidget(),
                          ),
                        ],
                      ),
                      if (controller.currentLauncherState == LauncherState.loading)
                        Positioned(
                          bottom: 24.0,
                          left: 0,
                          right: 0,
                          child: Text(

                            MediaQuery.of(context).viewInsets.bottom > 0
                                ? ''
                                : locale.app_version(kIsWeb ? getIt<AppConfigService>().config.webVersion : ApplicationInfoUtil().appVersion),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else
                        Container(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
