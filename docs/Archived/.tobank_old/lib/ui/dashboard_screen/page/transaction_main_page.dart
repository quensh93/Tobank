import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/transaction_main_controller.dart';
import '../../../util/enums_constants.dart';
import '../../common/selector_item_widget.dart';
import 'deposit_transfer_list_page.dart';
import 'transaction_list_page.dart';

class TransactionMainPage extends StatelessWidget {
  const TransactionMainPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<TransactionMainController>(
        init: TransactionMainController(),
        builder: (controller) {
          return Column(
            children: [
              const SizedBox(height: 16.0),
              Card(
                elevation: Get.isDarkMode ? 1 : 0,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                shadowColor: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SelectorItemWidget(
                        title: locale.tobank,
                        isSelected: controller.currentTransactionType == TransactionType.tobank,
                        callBack: () {
                          controller.setTransactionType(TransactionType.tobank);
                        },
                      ),
                    ),
                    Container(
                      height: 24.0,
                      width: 1.0,
                      color: context.theme.dividerColor,
                    ),
                    Expanded(
                      child: SelectorItemWidget(
                        title: locale.deposits,
                        isSelected: controller.currentTransactionType == TransactionType.deposit,
                        callBack: () {
                          controller.setTransactionType(TransactionType.deposit);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    TransactionListPage(),
                    DepositTransferListPage(),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
