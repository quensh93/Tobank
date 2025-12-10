import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/deposit/deposit_transaction_controller.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../model/deposit/response/deposit_statement_response_data.dart';
import '../../../util/enums_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../common/custom_app_bar.dart';
import 'widget/deposit_transaction_item_widget.dart';

class DepositTransactionScreen extends StatelessWidget {
  const DepositTransactionScreen({
    required this.deposit,
    required this.turnOvers,
    required this.selectedDateRange,
    required this.depositTransactionFilterType,
    super.key,
  });

  final Deposit deposit;
  final List<TurnOver> turnOvers;
  final JalaliRange selectedDateRange;
  final DepositTransactionFilterType depositTransactionFilterType;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DepositTransactionController>(
      init: DepositTransactionController(deposit, turnOvers, selectedDateRange, depositTransactionFilterType),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: depositTransactionFilterType == DepositTransactionFilterType.byTime
                    ? locale.deposit_turn_over
                    : locale.last_10_transactions,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            child: Card(
                              elevation: 1,
                              margin: EdgeInsets.zero,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      locale.deposit_number,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        height: 1.4,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      controller.deposit.depositNumber ?? '',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: ThemeUtil.textTitleColor,
                                        height: 1.4,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                                child: controller.hasError && controller.page == 1
                                    ? Container()
                                    : controller.turnOversList.isEmpty && controller.page == 1 && !controller.isLoading
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                            child: Column(
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
                                                  locale.no_items_found,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: ThemeUtil.textSubtitleColor,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView.separated(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 16.0,
                                            ),
                                            controller: controller.scrollControllerTransaction,
                                            itemBuilder: (context, index) {
                                              return DepositTransactionItemWidget(
                                                turnOver: controller.turnOversList[index],
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(
                                                height: 12.0,
                                              );
                                            },
                                            itemCount: controller.turnOversList.length,
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
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
