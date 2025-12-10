import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/deposit/transfer/transfer_amount_controller.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../util/enums_constants.dart';
import '../../common/custom_app_bar.dart';
import '../../common/selector_item_widget.dart';
import '../card_transfer/card_transfer_screen.dart';
import '../deposit_transfer/deposit_transfer_screen.dart';

class DepositAmountScreen extends StatelessWidget {
  const DepositAmountScreen({super.key, this.deposit});

  final Deposit? deposit;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<TransferAmountController>(
      init: TransferAmountController(deposit: deposit),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.transfer_money,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    if (controller.isHideTabView)
                      Container()
                    else
                      Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        shadowColor: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SelectorItemWidget(
                                title: locale.interbank,
                                isSelected: controller.currentTransferType == TransferTypeEnum.iban,
                                callBack: () {
                                  controller.setCurrentTransferType(TransferTypeEnum.iban);
                                },
                              ),
                            ),
                            Container(
                              height: 24.0,
                              width: 2.0,
                              color: context.theme.dividerColor,
                            ),
                            Expanded(
                              child: SelectorItemWidget(
                                title: locale.inbank,
                                isSelected: controller.currentTransferType == TransferTypeEnum.deposit,
                                callBack: () {
                                  controller.setCurrentTransferType(TransferTypeEnum.deposit);
                                },
                              ),
                            ),
                            if(!kIsWeb)
                            ...[Container(
                              height: 24.0,
                              width: 2.0,
                              color: context.theme.dividerColor,
                            ),
                            Expanded(
                              child: SelectorItemWidget(
                                title:locale.card,
                                isSelected: controller.currentTransferType == TransferTypeEnum.card,
                                callBack: () {
                                  controller.setCurrentTransferType(TransferTypeEnum.card);
                                },
                              ),
                            ),],
                          ],
                        ),
                      ),
                    Expanded(
                        child: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        DepositTransferScreen(
                          deposit: deposit,
                          transferType: controller.currentTransferType,
                          hideTabViewFunction: (bool isHideTabView) {
                            controller.setIsHideTabView(isHideTabView);
                          },
                        ),
                        CardTransferScreen(
                          deposit: deposit,
                          hideTabViewFunction: (bool isHideTabView) {
                            controller.setIsHideTabView(isHideTabView);
                          },
                        ),
                      ],
                    )),
                  ],
                ),
              )),
        );
      },
    );
  }
}
