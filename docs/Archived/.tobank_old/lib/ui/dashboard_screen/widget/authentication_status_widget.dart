import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/home_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';

class AuthenticationStatusWidget extends StatelessWidget {
  const AuthenticationStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<HomeController>(builder: (controller) {
      // ignore: prefer_final_locals
      var authenticationStatusItem = controller.getAuthenticationStatusItem();
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: controller.mainController.appEKycProvider == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SvgIcon(SvgIcons.tobankLogo),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              locale.bank_services_message,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                const SvgIcon(SvgIcons.checkCircle),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Flexible(
                                  child: Text(locale.identity_verification,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                const SvgIcon(SvgIcons.checkCircle),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Flexible(
                                  child: Text(locale.account_opening,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                const SvgIcon(SvgIcons.checkCircle),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Flexible(
                                  child: Text(locale.free_card_delivery,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1.6,
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                const SvgIcon(SvgIcons.checkCircle),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Flexible(
                                  child: Text(locale.online_loans,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SvgIcon(SvgIcons.tobankLogo),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              authenticationStatusItem.description,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                isLoading: false,
                callback: () {
                  controller.handleAuthenticationStatusButton(eventCode: authenticationStatusItem.eventCode);
                },
                buttonTitle: authenticationStatusItem.buttonTitle,
              )
            ],
          ),
        ),
      );
    });
  }
}
