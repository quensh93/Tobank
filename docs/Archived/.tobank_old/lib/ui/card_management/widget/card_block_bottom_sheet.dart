import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_management/card_management_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import 'card_block_reason_item_widget.dart';

class CardBlockBottomSheet extends StatelessWidget {
  const CardBlockBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardManagementController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
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
                    height: 16.0,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgIcon(
                        SvgIcons.warningRed,
                        size: 48.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(locale.block_card_title, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(locale.block_card_warning_message,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: ThemeUtil.textSubtitleColor,
                      ),
                      textAlign: TextAlign.right),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    locale.select_block_reason,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: AppUtil.getCardBlockReasonList().length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16.0);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return CardBlockReasonItemWidget(
                        cardBlockReasonData: AppUtil.getCardBlockReasonList()[index],
                        selectedCardBlockReasonData: controller.selectedCardBlockReasonData!,
                        returnDataFunction: (cardBlockReasonData) {
                          controller.setSelectedCardBlockReasonData(cardBlockReasonData);
                        },
                        borderColor: context.theme.dividerColor,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateCardBlock();
                    },
                    isLoading: false,
                    buttonTitle: locale.block_card_title,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
