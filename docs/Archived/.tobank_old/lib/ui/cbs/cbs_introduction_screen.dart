import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/cbs/cbs_introduction_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../common/custom_app_bar.dart';

class CBSIntroductionScreen extends StatelessWidget {
  const CBSIntroductionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CBSIntroductionController>(
          init: CBSIntroductionController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.credit_check,
                context: context,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 88.0),
                        child: Image.asset(
                          'assets/images/cbs.png',
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0),
                        child: Text(
                          locale.credit_check_description,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: context.theme.textTheme.bodyMedium!.color,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              activeColor: context.theme.colorScheme.secondary,
                              fillColor: WidgetStateProperty.resolveWith((states) {
                                if (!states.contains(WidgetState.selected)) {
                                  return Colors.transparent;
                                }
                                return null;
                              }),
                              value: !controller.isShowCBSIntroduction,
                              onChanged: (isCheck) {
                                controller.setChecked(isCheck!);
                              }),
                          Flexible(
                            child: Text(
                              locale.dont_show_page_again,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28.0),
                      ContinueButtonWidget(
                        callback: () {
                          controller.getToCBSScreen();
                        },
                        isLoading: false,
                        buttonTitle: locale.continue_label,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
