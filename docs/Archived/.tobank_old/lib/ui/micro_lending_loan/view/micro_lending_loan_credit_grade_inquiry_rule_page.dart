import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/model/other/response/other_item_data.dart';
import '/util/app_util.dart';
import '/util/theme/theme_util.dart';
import '/widget/button/continue_button_widget.dart';

class MicroLendingLoanCreditGradeInquiryRulePage extends StatelessWidget {
  final Function callback;
  final Function(bool) setChecked;
  final String title;
  final String checkTitle;
  final String checkTopTitle;
  final ScrollController scrollbarController;
  final OtherItemData? otherItemData;
  final bool isRuleChecked;
  final bool isLoading;

  const MicroLendingLoanCreditGradeInquiryRulePage({
    required this.callback,
    required this.setChecked,
    required this.title,
    required this.checkTitle,
    required this.checkTopTitle,
    required this.scrollbarController,
    required this.otherItemData,
    required this.isRuleChecked,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    if (otherItemData == null) return Container();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              elevation: Get.isDarkMode ? 1 : 0,
              margin: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: context.theme.dividerColor, width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: ThemeUtil.titleStyle,
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Expanded(
                    child: Scrollbar(
                      controller: scrollbarController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: scrollbarController,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                              child: Text(
                                AppUtil.getContents(otherItemData!.data!.data!.content!),
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  height: 1.6,
                                  fontFamily: 'IranYekan',
                                ),
                              ),
                            ),
                          ],
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border:
                  Border.all(color: isRuleChecked ? context.theme.colorScheme.secondary : context.theme.dividerColor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    checkTopTitle,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.transparent,
                        width: 20.0,
                        height: 20.0,
                        child: Transform.scale(
                          scale: 1,
                          transformHitTests: false,
                          child: Checkbox(
                            activeColor: context.theme.colorScheme.secondary,
                            fillColor: WidgetStateProperty.resolveWith((states) {
                              if (!states.contains(WidgetState.selected)) {
                                return Colors.transparent;
                              }
                              return null;
                            }),
                            value: isRuleChecked,
                            onChanged: (v) => setChecked(v!),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: Text(
                          checkTitle,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ContinueButtonWidget(
            callback: callback,
            isLoading: isLoading,
            buttonTitle: locale.continue_label,
            isEnabled: isRuleChecked,
          ),
        ],
      ),
    );
  }
}
