import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/register/register_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RegisterController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Card(
                      elevation: Get.isDarkMode ? 1 : 0,
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              height: 48,
                            ),
                            const SizedBox(height: 16.0),
                            Text(locale.user_instruction,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                SvgIcon(
                                  SvgIcons.checkCircle,
                                  colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 8.0),
                                Text(locale.required_documents_for_verification,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(locale.national_card,
                                      style: TextStyle(
                                        color: ThemeUtil.textTitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(locale.identity_card,
                                      style: TextStyle(
                                        color: ThemeUtil.textTitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                SvgIcon(
                                  SvgIcons.checkCircle,
                                  colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 8.0),
                                Text(locale.security_activation_instruction,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(locale.phone_password,
                                      style: TextStyle(
                                        color: ThemeUtil.textTitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(locale.phone_pin,
                                      style: TextStyle(
                                        color: ThemeUtil.textTitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(locale.fingerprint,
                                      style: TextStyle(
                                        color: ThemeUtil.textTitleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButtonWidget(
                callback: () {
                  controller.runAuthorization();
                },
                isLoading: controller.isLoading,
                buttonTitle:locale.continue_label,
              ),
            ),
          ],
        );
      },
    );
  }
}
