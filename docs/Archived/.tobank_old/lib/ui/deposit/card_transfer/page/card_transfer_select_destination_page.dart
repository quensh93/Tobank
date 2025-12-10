import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/transfer/card_transfer_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/button_with_icon.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../common/card_item_widget.dart';
import '../../../common/card_text_field_clear_symbol_icon_widget.dart';

class CardTransferSelectDestinationPage extends StatelessWidget {
  const CardTransferSelectDestinationPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardTransferController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              locale.destination_card_number,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: controller.destinationCardController,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              onChanged: (value) {
                controller.detectDestinationBank(value);
              },
              inputFormatters: <TextInputFormatter>[TextInputMask(mask: '9999-9999-9999-9999')],
              decoration: InputDecoration(
                filled: false,
                border: InputBorder.none,
                hintText: locale.enter_or_select_destination_card,
                errorText: controller.isDestinationCardValid ? null :locale.enter_card_number,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                suffixIcon: CardTextFieldClearSymbolIconWidget(
                  isVisible: controller.destinationCardController.text.isNotEmpty,
                  clearFunction: () {
                    controller.clearDestinationCardTextField();
                  },
                  cardSymbol: controller.destinationCardSymbol,
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: controller.destinationCustomerCardList.isEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 16.0,
                          ),
                          Image.asset(
                            Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                            height: 140,
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Text(
                            locale.no_number_saved,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: controller.destinationCustomerCardList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardItemWidget(
                          customerCard: controller.destinationCustomerCardList[index],
                          bankInfoList: controller.bankInfoList,
                          isSourceCustomerCard: false,
                          selectCardDataFunction: (customerCard) {
                            controller.setSelectedDestinationCustomerCard(customerCard);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                    ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            if (controller.destinationCardController.text.isEmpty)
              if (!kIsWeb)
              ButtonWithIcon(
                buttonTitle: locale.scan_card,
                buttonIcon: SvgIcons.scanner,
                onPressed: controller.showScannerScreen,
              )
            else
              ContinueButtonWidget(
                callback: () {
                  controller.validateDestinationCard();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
              ),
          ],
        ),
      );
    });
  }
}
