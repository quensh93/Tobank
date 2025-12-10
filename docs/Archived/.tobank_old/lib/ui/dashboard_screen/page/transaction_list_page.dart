import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/transaction_list_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';
import '../widget/transaction_item_widget.dart';

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<TransactionListController>(
        init: TransactionListController(),
        builder: (controller) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        controller.showTransactionFilterScreen();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(color: context.theme.dividerColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                          child: Row(
                            children: <Widget>[
                              SvgIcon(
                                SvgIcons.filter,
                                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                locale.filters,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      height: 24.0,
                      width: 1,
                      decoration: BoxDecoration(color: context.theme.dividerColor),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          onTap: () {
                            controller.filterAll();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              color: controller.filterTypeValue == 0
                                  ? context.theme.colorScheme.secondary.withOpacity(0.10)
                                  : Colors.transparent,
                              border: Border.all(
                                  color: controller.filterTypeValue == 0
                                      ? context.theme.colorScheme.secondary
                                      : context.theme.dividerColor),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                  horizontal: 12.0,
                                ),
                                child: Text(
                                  locale.all,
                                  style: TextStyle(
                                      color: controller.filterTypeValue == 0
                                          ? context.theme.colorScheme.secondary
                                          : ThemeUtil.textTitleColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          onTap: () {
                            controller.filterWallet();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: controller.filterTypeValue == 1
                                    ? context.theme.colorScheme.secondary.withOpacity(0.10)
                                    : Colors.transparent,
                                border: Border.all(
                                    color: controller.filterTypeValue == 1
                                        ? context.theme.colorScheme.secondary
                                        : context.theme.dividerColor)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                  horizontal: 12.0,
                                ),
                                child: Text(
                                  locale.wallet_transactions,
                                  style: TextStyle(
                                      color: controller.filterTypeValue == 1
                                          ? context.theme.colorScheme.secondary
                                          : ThemeUtil.textTitleColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    EasyRefresh(
                      header: MaterialHeader(
                        color: ThemeUtil.textTitleColor,
                      ),
                      refreshOnStart: true,
                      controller: controller.refreshController,
                      onRefresh: () {
                        controller.onRefresh();
                      },
                      child: controller.isEmptyTransaction()
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                                  height: 180,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  locale.no_transaction_recorded,
                                  style: TextStyle(
                                      color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                                ),
                              ],
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              controller: controller.scrollControllerTransaction,
                              itemCount: controller.transactionDataList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TransactionItemWidget(
                                    transactionData: controller.transactionDataList[index],
                                    returnDataFunction: (transactionItem) {
                                      controller.showTransactionDetail(transactionItem);
                                    });
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 12.0,
                                );
                              },
                            ),
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
