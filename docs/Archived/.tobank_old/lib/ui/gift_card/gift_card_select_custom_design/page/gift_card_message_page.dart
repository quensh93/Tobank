import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/gift_card/gift_card_select_design_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../common/gift_card_item_label.dart';

class GiftCardMessagePage extends StatelessWidget {
  const GiftCardMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardSelectDesignController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: Text(
                          locale.select_text_for_card_message,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Text(
                          locale.default_replacement_text,
                          style: ThemeUtil.titleStyle,
                        ),
                        Text(
                          locale.required_field_star,
                          style: TextStyle(
                            color: ThemeUtil.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.messageGiftCardList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GiftCardItemLabelWidget(
                          messageData: controller.messageGiftCardList[index],
                          selectedMessageData: controller.selectedMessageData,
                          returnDataFunction: (messageData) {
                            controller.setSelectedMessageData(messageData);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12.0,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ContinueButtonWidget(
              callback: () {
                controller.validateAlternative();
              },
              isLoading: controller.isLoading,
              buttonTitle:locale.continue_label,
              isEnabled: controller.selectedMessageData != null,
            ),
          ],
        ),
      );
    });
  }
}
