import 'package:universal_io/io.dart';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/sample/birth_certificate_second_sample_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/main_header_widget.dart';

class BirthCertificateSecondSampleScreen extends StatelessWidget {
  const BirthCertificateSecondSampleScreen({required this.returnCallback, required this.userFile, super.key});

  final File userFile;
  final Function(File? file) returnCallback;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<BirthCertificateSecondSampleController>(
      init: BirthCertificateSecondSampleController(userFile: userFile, returnCallback: returnCallback),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    MainHeaderWidget(
                      title: locale.authentication_title,
                      returnFunction: () => controller.onBackPress(false),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                               Text(
                               locale.registered_image_title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                  height: 230,
                                  decoration: BoxDecoration(
                                    color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    border: Border.all(
                                      color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: FileImage(
                                          controller.userFile,
                                        ),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  )),
                              const SizedBox(
                                height: 24.0,
                              ),
                               Text(
                               locale.acceptable_image_sample_new_id,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: 230,
                                decoration: BoxDecoration(
                                  color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  border: Border.all(
                                    color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  child: FastCachedImage(
                                    url: controller.sampleUrl,
                                    fit: BoxFit.contain,
                                    loadingBuilder: (context, progress) => const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(child: CircularProgressIndicator()),
                                    ),
                                    errorBuilder: (context, url, error) {
                                      return Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.reloadSamples();
                                              },
                                              child: const SvgIcon(
                                                SvgIcons.imageLoadError,
                                                size: 32,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                               Text(
                                locale.acceptable_image_sample_old_id,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: 230,
                                decoration: BoxDecoration(
                                  color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  border: Border.all(
                                    color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  child: FastCachedImage(
                                    url: controller.sampleOldUrl,
                                    fit: BoxFit.contain,
                                    loadingBuilder: (context, progress) => const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(child: CircularProgressIndicator()),
                                    ),
                                    errorBuilder: (context, url, error) {
                                      return Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.reloadSamples();
                                              },
                                              child: const SvgIcon(
                                                SvgIcons.imageLoadError,
                                                size: 32,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ContinueButtonWidget(
                              callback: () => controller.submitFile(),
                              isLoading: false,
                              buttonTitle:locale.confirm_continue,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () => controller.onBackPress(false),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: context.theme.colorScheme.surface,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: context.theme.iconTheme.color!),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    8.0,
                                  ),
                                  child: Text(
                                    locale.try_again,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
