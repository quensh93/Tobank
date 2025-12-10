import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/update_app/update_app_controller.dart';
import '../../model/other/app_version_data.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';
import '../../widget/button/previous_button_widget.dart';

class UpdateAppScreen extends StatelessWidget {
  const UpdateAppScreen({
    required this.appVersionData,
    super.key,
  });

  final AppVersionData appVersionData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: PopScope(
          canPop: false,
          child: GetBuilder<UpdateAppController>(
              init: UpdateAppController(appVersionData: appVersionData),
              builder: (controller) {
                return SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        locale.new_version_available,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                       locale.update_required_message,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      ContinueButtonWidget(
                        callback: () {
                          controller.launchURL();
                        },
                        isLoading: false,
                        buttonTitle: controller.getUpdateButtonText(),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      PreviousButtonWidget(
                        callback: () {
                          exit(0);
                        },
                        buttonTitle: locale.close_app_button,
                        isLoading: false,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ));
              }),
        ),
      ),
    );
  }
}
