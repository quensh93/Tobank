import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/sample/national_card_back_sample_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/custom_app_bar.dart';

class NationalCardBackSampleScreen extends StatelessWidget {
  const NationalCardBackSampleScreen(
      {required this.returnCallback, required this.userFile, super.key});

  final File userFile;
  final Function(File? file) returnCallback;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<NationalCardBackSampleController>(
      init: NationalCardBackSampleController(
          userFile: userFile, returnCallback: returnCallback),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
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
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  border: Border.all(
                                    color: context.theme.dividerColor,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Card(
                                      elevation: 1,
                                      shadowColor: Colors.transparent,
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(8.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          locale.registered_image_title,
                                          style: ThemeUtil.titleStyle,
                                        ),
                                      ),
                                    ),

                                    /// todo: add later to pwa (cropper web)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: (kIsWeb)
                                                ? Image.network(
                                                    controller.userFile.path,
                                                    height: 48.0,
                                                  ).image
                                                : Image.file(
                                                    controller.userFile,
                                                    height: 48.0,
                                                  ).image,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        child: Image.asset(
                                          'assets/images/back_national_card_frame.png',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  border: Border.all(
                                    color: context.theme.dividerColor,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Card(
                                      elevation: 1,
                                      shadowColor: Colors.transparent,
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(8.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          locale.acceptable_image_sample,
                                          style: ThemeUtil.titleStyle,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FastCachedImage(
                                        url: controller.sampleUrl,
                                        fit: BoxFit.contain,
                                        loadingBuilder: (context, progress) =>
                                            const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                        errorBuilder: (context, url, error) {
                                          return Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
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
                                    side: BorderSide(
                                        color: context.theme.iconTheme.color!),
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
                    ),
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
