import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../controller/bpms/close_long_term_deposit/close_long_term_deposit_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/key_value_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../close_deposit_type_item_widget.dart';

class CloseLongTermDepositSelectorPage extends StatelessWidget {
  const CloseLongTermDepositSelectorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {   //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CloseLongTermDepositController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        KeyValueWidget(
                          keyString: '${locale.deposit_number}:',
                          valueString: controller.depositNumber ?? '',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: '${locale.deposit_inventory}:',
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.getBalance())),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                 locale.select_deposit_closing_type,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CloseDepositTypeItemWidget(
                        closeDepositTypeItemData: AppUtil.getCloseTypeItems()[index],
                        selectedCloseDepositTypeItemData: controller.selectedCloseDepositTypeItemData,
                        returnDataFunction: (closeDepositTypeItemData) {
                          controller.setSelectedCloseDepositType(closeDepositTypeItemData);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16.0,
                      );
                    },
                    itemCount: AppUtil.getCloseTypeItems().length),
                if (controller.showAmountLayout())
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        locale.withdrawal_amount_from_deposit,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: [
                          Container(
                            height: 48.0,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: InkWell(
                              onTap: () {
                                controller.toggleShowListAmount();
                              },
                              child: Container(
                                height: 48.0,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                    border: Border.all(
                                      color: context.theme.dividerColor,
                                      width: 2,
                                    )),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          controller.amount != 0
                                              ? locale.amount_format(AppUtil.formatMoney(controller.amount))
                                              : locale.select_requested_amount,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: controller.amount != 0
                                                ? ThemeUtil.textTitleColor
                                                : ThemeUtil.textSubtitleColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                            fontFamily: 'IranYekan',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                      child: controller.isShow
                                          ? const Icon(Icons.keyboard_arrow_up)
                                          : const Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          if (controller.isShow)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                  bottom: Radius.circular(8),
                                ),
                                border: controller.isShow
                                    ? Border.all(
                                        color: context.theme.dividerColor,
                                        width: 2,
                                      )
                                    : Border.all(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                              ),
                              constraints: const BoxConstraints(maxHeight: 200),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    child: Column(
                                      children: <Widget>[
                                        TextField(
                                          onChanged: (value) {
                                            controller.validateAmountValue(value);
                                          },
                                          controller: controller.amountController,
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
                                            controller.toggleShowListAmount();
                                          },
                                          decoration: InputDecoration(
                                            filled: false,
                                            hintText: locale.enter_requested_amount,
                                            hintStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                            ),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 16.0,
                                            ),
                                            suffixIcon: TextFieldClearIconWidget(
                                              isVisible: controller.amountController.text.isNotEmpty,
                                              clearFunction: () {
                                                controller.clearAmountTextField();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      physics: const AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: AppUtil.getAmountList(controller.getBalance()).length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.setSelectedAmount(
                                                AppUtil.getAmountList(controller.getBalance())[index]);
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.vertical(),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 16.0,
                                              ),
                                              child: Text(
                                                locale.amount_format(AppUtil.formatMoney(AppUtil.getAmountList(controller.getBalance())[index])),
                                                style: TextStyle(
                                                  color: ThemeUtil.textTitleColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider(
                                          thickness: 1,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container(),
                        ],
                      ),
                      Text(
                        locale.requested_amount_multiple(AppUtil.formatMoney(controller.depositPart)),
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          height: 1.6,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                else
                  Container(),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateSelectorPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_close_deposit_request,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
