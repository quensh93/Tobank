import 'package:universal_io/io.dart';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/sample/take_personal_video_sample_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/custom_app_bar.dart';

class TakePersonalVideoSampleScreen extends StatelessWidget {
  const TakePersonalVideoSampleScreen({required this.returnCallback, required this.userFile, super.key});

  final File userFile;
  final Function(File? file) returnCallback;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<TakePersonalVideoSampleController>(
      init: TakePersonalVideoSampleController(userFile: userFile, returnCallback: returnCallback),
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvoked: controller.onBackPress,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.authentication_title,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  locale.authentication_instruction,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
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
                                          locale.registered_video_title,
                                          style: ThemeUtil.titleStyle,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: controller.videoPlayerController.value.isInitialized
                                          ? Chewie(
                                              controller: controller.chewieController!,
                                            )
                                          : const Center(child: CircularProgressIndicator()),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
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
                                          locale.acceptable_video_sample,
                                          style: ThemeUtil.titleStyle,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: controller.sampleVideoPlayerController.value.isInitialized
                                          ? Chewie(controller: controller.sampleChewieController!)
                                          : const Center(child: CircularProgressIndicator()),
                                    ),
                                  ],
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
                              buttonTitle: locale.confirm_continue,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 56,
                              child: OutlinedButton(
                                onPressed: () => controller.onBackPress(false),
                                style: ElevatedButton.styleFrom(
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
