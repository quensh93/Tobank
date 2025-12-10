import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/register/register_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';
import '../../common/text_field_error_widget.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
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
                              Text(
                                controller.mainController.authInfoData!.customerNumber != null
                                    ? locale.existing_customer_message
                                    :locale.new_customer_message,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (!controller.authorizedApiTokenResponse!.data!.digitalBankingCustomer!) ...<Widget>[
                                const SizedBox(height: 16.0),
                                Text(
                                  locale.referral_code_prompt,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        locale.activity_field_title,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      InkWell(
                        onTap: () {
                          controller.showSelectJobBottomSheet();
                        },
                        child: Container(
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.surface,
                            border:
                                Border.all(color: Get.isDarkMode ? const Color(0xff77839b) : const Color(0xffd0d5dd)),
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    controller.selectedJob == null
                                        ? locale.select_activity_field_prompt
                                        : controller.selectedJob!.faTitle ?? '',
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: controller.selectedJob == null
                                            ? ThemeUtil.textSubtitleColor
                                            : ThemeUtil.textTitleColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                  ),
                                ),
                                if (controller.isLoading)
                                  SpinKitFadingCircle(
                                    itemBuilder: (_, int index) {
                                      return const DecoratedBox(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                    size: 24.0,
                                  )
                                else
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: context.theme.iconTheme.color,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextFieldErrorWidget(
                        isValid: controller.isJobValid,
                        errorText: locale.job_field_error_message,
                      ),
                      if (controller.selectedJob?.needsDescription ?? false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                             Text(
                              locale.job_title_label,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextField(
                              controller: controller.jobDescriptionController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                filled: false,
                                hintText: locale.enter_job_title_placeholder,
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                                errorText: controller.isJobDescriptionValid ? null : locale.enter_job_title_placeholder,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 16.0,
                                ),
                                suffixIcon: TextFieldClearIconWidget(
                                  isVisible: controller.jobDescriptionController.text.isNotEmpty,
                                  clearFunction: () {
                                    controller.jobDescriptionController.clear();
                                    controller.update();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (!controller.authorizedApiTokenResponse!.data!.digitalBankingCustomer!)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 32.0,
                            ),
                            Text(
                              locale.optional_invitation_code_label,
                              style: ThemeUtil.titleStyle,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextField(
                              keyboardType: TextInputType.text,
                              controller: controller.referrerLoyaltyCodeController,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.right,
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                fontFamily: 'IranYekan',
                              ),
                              onChanged: (value) {
                                controller.update();
                              },
                              decoration: InputDecoration(
                                filled: false,
                                hintText: locale.enter_invitation_code_placeholder,
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 16.0,
                                ),
                                suffixIcon: TextFieldClearIconWidget(
                                  isVisible: controller.referrerLoyaltyCodeController.text.isNotEmpty,
                                  clearFunction: () {
                                    controller.referrerLoyaltyCodeController.clear();
                                    controller.update();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButtonWidget(
                callback: () {
                  controller.validateRegistrationPage();
                },
                isLoading: controller.isRegistrationLoading,
                buttonTitle: locale.continue_label,
                isEnabled: controller.selectedJob != null,
              ),
            ),
          ],
        );
      },
    );
  }
}
