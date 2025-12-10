import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';

class TutorialBottomSheet extends StatelessWidget {
  const TutorialBottomSheet({
    required this.voiceTutorial,
    required this.visualTutorial,
    super.key,
  });

  final VoidCallback voiceTutorial;
  final VoidCallback visualTutorial;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  Text(
                    locale.guide,
                    textAlign: TextAlign.start,
                    style: ThemeUtil.titleStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  onTap: () {
                    Get.back();
                    visualTutorial();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.theme.dividerColor,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Card(
                            elevation: 1,
                            shadowColor: Colors.transparent,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.visualTutorialDark : SvgIcons.visualTutorial,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          locale.image_guide,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  onTap: () {
                    Get.back();
                    voiceTutorial();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.theme.dividerColor,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Card(
                            elevation: 1,
                            shadowColor: Colors.transparent,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.voiceTutorialDark : SvgIcons.voiceTutorial,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          locale.audio_guide,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
