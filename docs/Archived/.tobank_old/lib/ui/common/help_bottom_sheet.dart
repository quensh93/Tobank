import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';
import '../../widget/svg/svg_icon.dart';

class HelpBottomSheet extends StatelessWidget {
  const HelpBottomSheet({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 36,
                      height: 4,
                      decoration:
                          BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                ],
              ),
              const SizedBox(
                height: 36.0,
              ),
              Row(
                children: [
                  SvgIcon(
                    SvgIcons.info,
                    colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(title, style: ThemeUtil.titleStyle),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Flexible(
                child: Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(
                height: 28.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  Get.back();
                },
                isLoading: false,
                buttonTitle: locale.close,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
