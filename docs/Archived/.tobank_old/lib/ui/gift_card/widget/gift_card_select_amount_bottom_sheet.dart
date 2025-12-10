import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';
import '../../../controller/gift_card/gift_card_controller.dart';
import '../../../model/gift_card/request/gift_card_data_request.dart';
import '../../../model/gift_card/response/costs_data.dart';
import '../../../new_structure/core/theme/main_theme.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';
import 'gift_card_amount_item_widget.dart';

class GiftCardSelectAmountBottomSheet extends StatefulWidget {
   GiftCardSelectAmountBottomSheet({
    required this.cardInfo,
    required this.mainIndex,
    super.key,
  });

  final CardInfo cardInfo;
  final int mainIndex;

  @override
  State<GiftCardSelectAmountBottomSheet> createState() => _GiftCardSelectAmountBottomSheetState();
}

class _GiftCardSelectAmountBottomSheetState extends State<GiftCardSelectAmountBottomSheet> {
  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<GiftCardController>(
        builder: (controller) {
          return SingleChildScrollView(
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
                    height: 24.0,
                  ),
                  Text(locale.select_gift_card_amount, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      controller.validateAmountValue(value, widget.mainIndex);

                      },
                    controller: widget.cardInfo.amountController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      fontFamily: 'IranYekan',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(Constants.amountLength),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textDirection: TextDirection.ltr,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (term) {
                      controller.validateAmountValue(term, widget.mainIndex);
                      controller.toggleShowListAmount(widget.mainIndex);
                    },
                    decoration: InputDecoration(

                      // error: controller.validateSecondPageBool()
                      //     ? null
                      //     : Column(
                      //       children: [
                      //         Row(
                      //           children: [
                      //             SvgIcon(
                      //               SvgIcons.info,
                      //               size: 19,
                      //               colorFilter: ColorFilter.mode(
                      //                 MainTheme.of(context).primary,
                      //                 BlendMode.srcIn,
                      //               ),
                      //             ),
                      //             const SizedBox(width: 4),
                      //             Expanded(
                      //               child: Text(
                      //                 locale.min_max_desired_amount(
                      //                   AppUtil.formatMoney(
                      //                       controller.costsData!.data!.maxPayableAmount),
                      //                   AppUtil.formatMoney(
                      //                       controller.costsData!.data!.minPayableAmount),
                      //                 ),
                      //                 textDirection: TextDirection.rtl,
                      //                 style: MainTheme.of(context)
                      //                     .textTheme
                      //                     .bodyMedium
                      //                     .copyWith(color: MainTheme.of(context).primary),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                     // errorText: controller.validateSecondPageBool() ? null :locale.min_max_desired_amount(AppUtil.formatMoney(controller.costsData!.data!.maxPayableAmount) , AppUtil.formatMoney(controller.costsData!.data!.minPayableAmount)),
                      filled: false,
                      hintText: locale.gift_card_amount_to_rial,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: controller.validateSecondPageBool(widget.cardInfo.amountController.text)?MainTheme.of(context).surfaceContainer : MainTheme.of(context).primary),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ) ,
                      border:  const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      suffixIcon: TextFieldClearIconWidget(
                        isVisible: widget.cardInfo.amountController.text.isNotEmpty,
                        clearFunction: () {
                          widget.cardInfo.amountController.clear();
                          controller.update();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),

                  Row(
                    children: [
                      SvgIcon(
                        SvgIcons.info,
                        size:19 ,
                        colorFilter: ColorFilter.mode(controller.validateSecondPageBool(widget.cardInfo.amountController.text) ? ThemeUtil.textSubtitleColor : MainTheme.of(context).primary , BlendMode.srcIn),
                      ),
                      const SizedBox(width: 4,),
                       Text(
                         locale.min_max_desired_amount(AppUtil.formatMoney(controller.costsData!.data!.maxPayableAmount) , AppUtil.formatMoney(controller.costsData!.data!.minPayableAmount)),
                        textDirection: TextDirection.rtl,
                        style: MainTheme.of(context).textTheme.bodyMedium.copyWith(
                          color: controller.validateSecondPageBool(widget.cardInfo.amountController.text) ? null : MainTheme.of(context).primary
                        ),
                      )
                    ],
                  ) ,
                  const SizedBox(
                    height: 24.0,
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                    ),
                    children: List<Widget>.generate(controller.giftCardAmountItemList.length, (index) {
                      return GiftCardAmountItemWidget(
                        physicalGiftCardAmount: controller.giftCardAmountItemList[index],
                        selectedAmount: widget.cardInfo.amountController.text.replaceAll(',', ''),
                        returnDataFunction: (physicalGiftCardAmount, int mainIndex) {
                          widget.cardInfo.amountController.text =
                              AppUtil.formatMoney(physicalGiftCardAmount.balance.toString());
                          controller.setSelectedAmount(mainIndex, physicalGiftCardAmount.balance);
                        },
                        mainIndex: widget.mainIndex,
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  ContinueButtonWidget(
                    isEnabled: controller.validateSecondPageBool(widget.cardInfo.amountController.text) ,
                    callback: () {
                      Get.back();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle:locale.confirmation,
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
