import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/card_to_card/shaparak_hub_submit_controller.dart';
import '../../util/app_util.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';
import '../common/custom_app_bar.dart';

class ShaparakHubSubmitScreen extends StatelessWidget {
  const ShaparakHubSubmitScreen({
    super.key,
    this.cardNumber,
    this.hasPublicKey,
    this.isReactivation,
  });

  final String? cardNumber;
  final bool? hasPublicKey;
  final bool? isReactivation;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<ShaparakHubSubmitController>(
          init: ShaparakHubSubmitController(
            cardNumber: cardNumber,
            hasPublicKey: hasPublicKey,
            isReactivation: isReactivation,
          ),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString:locale.register_card_in_shapark_title,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              locale.attention,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                            locale.shaparak_attention_text,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Card(
                              elevation: Get.isDarkMode ? 1 : 0,
                              margin: EdgeInsets.zero,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Text(
                                          locale.card_number,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Text(
                                          AppUtil.splitCardNumber(controller.cardNumber!, ' - '),
                                          textDirection: TextDirection.ltr,
                                          style: const TextStyle(
                                            fontFamily: 'IranYekan',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            ContinueButtonWidget(
                              callback: () {
                                controller.submit();
                              },
                              isLoading: controller.isLoading,
                              buttonTitle: controller.hasError ? locale.try_again : locale.save_card,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
