import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/transfer/deposit_transfer_list_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../widget/deposit_transfer_item_widget.dart';

class DepositTransferListPage extends StatelessWidget {
  const DepositTransferListPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DepositTransferListController>(
        init: DepositTransferListController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    EasyRefresh(
                      controller: controller.refreshController,
                      header: MaterialHeader(
                        color: ThemeUtil.textTitleColor,
                      ),
                      onRefresh: () {
                        controller.onRefresh();
                      },
                      child: controller.hasError && controller.page == 0
                          ? Container()
                          : controller.transactions.isEmpty && controller.page == 0 && !controller.isLoading
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Image.asset(
                                      Get.isDarkMode
                                          ? 'assets/images/empty_list_dark.png'
                                          : 'assets/images/empty_list.png',
                                      height: 180,
                                    ),
                                    const SizedBox(
                                      height: 24.0,
                                    ),
                                    Text(
                                      locale.no_transaction_recorded,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.separated(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                  controller: controller.scrollControllerTransaction,
                                  itemBuilder: (context, index) {
                                    return DepositTransferItemWidget(
                                      transaction: controller.transactions[index],
                                      returnDataFunction: (transaction) {
                                        controller.showTransferDetailScreen(transaction);
                                      },
                                      checkTransactionStatusFunction: (transaction) {
                                        controller.checkTransactionStatusRequest(transaction);
                                      },
                                      isLoading: controller.isLoading,
                                      selectedTransaction: controller.selectedTransaction,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 16,
                                    );
                                  },
                                  itemCount: controller.transactions.length),
                    ),
                    if (controller.isLoading)
                      SpinKitFadingCircle(
                        itemBuilder: (_, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.theme.iconTheme.color,
                            ),
                          );
                        },
                        size: 40.0,
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
