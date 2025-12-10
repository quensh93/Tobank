import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/enums_constants.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';

class AppReviewBottomSheet extends StatelessWidget {
  const AppReviewBottomSheet({
    required this.returnDataFunction,
    super.key,
  });

  final Function(AppReviewState appReviewState) returnDataFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              height: 32.0,
            ),
            Row(
              children: [
                Flexible(
                  child: Text(locale.feedback_prompt,
                      textAlign: TextAlign.start, style: ThemeUtil.titleStyle),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    returnDataFunction(AppReviewState.later);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      locale.later_button,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 48.0,
                      width: 100.0,
                      child: OutlinedButton(
                        onPressed: () {
                          returnDataFunction(AppReviewState.no);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            side: BorderSide(
                              color: context.theme.dividerColor,
                            ),
                          ),
                        ),
                        child: Text(
                          locale.no,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      height: 48.0,
                      width: 100.0,
                      child: ContinueButtonWidget(
                        isLoading: false,
                        callback: () {
                          returnDataFunction(AppReviewState.yes);
                        },
                        buttonTitle: locale.submit_feedback_button,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
