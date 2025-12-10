import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/pichak/shaparak_hub_submit_pichak_controller.dart';
import '../../../model/card/response/customer_card_response_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../common/custom_app_bar.dart';

class ShaparakHubSubmitPichakScreen extends StatelessWidget {
  const ShaparakHubSubmitPichakScreen({
    required this.hasPublicKey,
    required this.isReactivation,
    required this.sourceDataList,
    super.key,
  });

  final bool hasPublicKey;
  final bool isReactivation;
  final List<CustomerCard> sourceDataList;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<ShaparakHubSubmitPichakController>(
          init: ShaparakHubSubmitPichakController(
            hasPublicKey: hasPublicKey,
            isReactivation: isReactivation,
            sourceCustomerCardList: sourceDataList,
          ),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.register_card_in_shapark_title,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
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
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                height: 1.6,
                              ),
                            ),
                            if (!controller.isReactivation!)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  Text(
                                    locale.bank_card_label,
                                    style: ThemeUtil.titleStyle,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.showSelectCardScreen();
                                    },
                                    child: IgnorePointer(
                                      child: TextField(
                                        enabled: true,
                                        readOnly: true,
                                        controller: controller.cardNumberController,
                                        textDirection: TextDirection.ltr,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                          fontFamily: 'IranYekan',
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          TextInputMask(mask: '9999-9999-9999-9999')
                                        ],
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          filled: false,
                                          hintText:locale.card_placeholder,
                                          hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                          ),
                                          errorText:
                                              controller.isCardNumberValid ? null : locale.invalid_card_number_error,
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                            vertical: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                ],
                              )
                            else
                              Container(),
                            Expanded(child: Container()),
                            ContinueButtonWidget(
                              callback: () {
                                controller.submit();
                              },
                              isLoading: controller.isLoading,
                              buttonTitle: controller.hasError ? locale.try_again : locale.save_card,
                            ),
                            const SizedBox(
                              height: 16.0,
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
