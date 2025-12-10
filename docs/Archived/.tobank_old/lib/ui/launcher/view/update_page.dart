import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/launcher/launcher_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<LauncherController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
            if (controller.isForceUpdate())
              Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                   locale.force_update_message,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      height: 1.6,
                    ),
                  ),
                ],
              )
            else
              Container(),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 56.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: context.theme.iconTheme.color!),
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
                onPressed: () {
                  controller.launchURL();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.getUpdateButtonText(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: ThemeUtil.textTitleColor,
                    ),
                  ),
                ),
              ),
            ),
            if (controller.isForceUpdate())
              Container()
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.checkToken();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.login_to_tobank,
                  ),
                ],
              ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      );
    });
  }
}
