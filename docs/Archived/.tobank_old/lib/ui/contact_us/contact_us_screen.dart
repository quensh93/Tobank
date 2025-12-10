import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/contact_us/contact_us_controller.dart';
import '../../util/app_util.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';
import '../common/custom_app_bar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<ContactUsController>(
          init: ContactUsController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString:locale.contact_us,
                context: context,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
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
                                locale.address,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                               locale.address_farhang,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                locale.postal_code,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  height: 1.6,
                                ),
                              ),
                              Text(
                                '1997734537',
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                 locale.branch_support,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  AppUtil.launchInBrowser(url: locale.tobank_phone);
                                },
                                borderRadius: BorderRadius.circular(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    locale.phone_number_dakheli3,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  locale.tourism_bank_instagram,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  AppUtil.launchInBrowser(url: locale.tobank_instagram);
                                },
                                borderRadius: BorderRadius.circular(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    locale.instagram_handle,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      height: 1.6,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Text(locale.contact_tobank,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              AppUtil.launchInBrowser(url: locale.tobank_phone);
                            },
                            borderRadius: BorderRadius.circular(40.0),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                  height: 48.0,
                                  width: 48.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xfffdf3f4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: SvgIcon(
                                      SvgIcons.call,
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          InkWell(
                            onTap: () {
                              AppUtil.launchInBrowser(url: locale.tobank_email);
                            },
                            borderRadius: BorderRadius.circular(40.0),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 48.0,
                                width: 48.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xfffdf3f4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: SvgIcon(SvgIcons.email),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          InkWell(
                            onTap: () {
                              AppUtil.launchInBrowser(url: locale.tobank_website);
                            },
                            borderRadius: BorderRadius.circular(40.0),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 48.0,
                                width: 48.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xfffdf3f4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: SvgIcon(SvgIcons.website),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              AppUtil.launchInBrowser(url:locale.tobank_instagram);
                            },
                            borderRadius: BorderRadius.circular(40.0),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 48.0,
                                width: 48.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xfffdf3f4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: SvgIcon(SvgIcons.instagram),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          InkWell(
                            onTap: () {
                              AppUtil.launchInBrowser(url:locale.tobank_linkedin);
                            },
                            borderRadius: BorderRadius.circular(40.0),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 48.0,
                                width: 48.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xfffdf3f4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: SvgIcon(SvgIcons.linkedin),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          InkWell(
                            onTap: () {
                              AppUtil.launchInBrowser(url:locale.tobank_aparat);
                            },
                            borderRadius: BorderRadius.circular(40.0),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 48.0,
                                width: 48.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xfffdf3f4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: SvgIcon(SvgIcons.aparat),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
