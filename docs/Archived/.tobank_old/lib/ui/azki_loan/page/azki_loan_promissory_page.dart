import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../controller/azki_loan/azki_loan_controller.dart';
import '../../../../util/theme/theme_util.dart';

class AzkiLoanPromissoryPage extends StatelessWidget {
  const AzkiLoanPromissoryPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AzkiLoanController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: context.theme.dividerColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locale.select_electronic_promissory_note, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.collateralPromissoryPublishResultData != null
                                ? controller.showPromissoryPreviewScreen()
                                : controller.showSelectCollateralPromissoryBottomSheet();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: context.theme.colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: ThemeUtil.primaryColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                controller.collateralPromissoryPublishResultData != null ? locale.show_promissory_note : locale.complete,
                                style: TextStyle(
                                  color: ThemeUtil.primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  controller.validateCollateralPromissory();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.register_guarantee,
                isEnabled: controller.collateralPromissoryPublishResultData != null,
              ),
            ],
          ),
        );
      },
    );
  }
}
