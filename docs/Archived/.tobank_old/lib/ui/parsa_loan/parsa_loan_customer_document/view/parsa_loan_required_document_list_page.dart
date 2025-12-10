import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../util/theme/theme_util.dart';
import '../../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../controller/parsa_loan/parsa_loan_customer_document_controller.dart';

class ParsaLoanRequiredDocumentListPage extends StatelessWidget {
  const ParsaLoanRequiredDocumentListPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanCustomerDocumentController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.required_documents,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    border: Border.all(
                      color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 1,
                        shadowColor: Colors.transparent,
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            locale.identity_documents,
                            style: ThemeUtil.titleStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_success.svg',
                              colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              locale.pages_of_birth_certificate,
                              style: ThemeUtil.hintStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    border: Border.all(
                      color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 1,
                        shadowColor: Colors.transparent,
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            locale.applicant_residence_info,
                            style: ThemeUtil.titleStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_success.svg',
                                  colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  locale.postal_code,
                                  style: ThemeUtil.hintStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_success.svg',
                                  colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  locale.hint_text_property_document,
                                  style: ThemeUtil.hintStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    border: Border.all(
                      color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 1,
                        shadowColor: Colors.transparent,
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            locale.occupation_documents,
                            style: ThemeUtil.titleStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_success.svg',
                                  colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: Text(
                                    locale.employee_documents,
                                    style: ThemeUtil.hintStyle,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_success.svg',
                                  colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: Text(
                                    locale.retiree_documents,
                                    style: ThemeUtil.hintStyle,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_success.svg',
                                  colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: Text(
                                   locale.self_employed_documents,
                                    style: ThemeUtil.hintStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                ContinueButtonWidget(
                  callback: () {
                    controller.confirmRequiredDocumentList();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle:locale.continue_label,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
