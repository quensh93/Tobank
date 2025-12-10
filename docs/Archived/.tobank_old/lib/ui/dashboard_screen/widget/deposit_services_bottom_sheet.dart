import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/deposit_main_page_controller.dart';
import '../../../model/common/menu_data.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import 'deposit_service_item_widget.dart';

class DepositServicesBottomSheet extends StatelessWidget {
  const DepositServicesBottomSheet({
    required this.deposit,
    super.key,
  });

  final Deposit deposit;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    final List<MenuData> depositServices = AppUtil.getDepositServices(
        hasCard: deposit.cardInfo != null || deposit.depositeKind == 3 || deposit.depositeKind == 4);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<DepositMainPageController>(
        builder: (controller) {
          return Padding(
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
                  height: 16.0,
                ),
                Text(locale.deposit_services, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DepositServiceItemWidget(
                        virtualBranchMenuData: depositServices[index],
                        returnDataFunction: (virtualBranchMenuData) {
                          controller.handleCardServiceItemClick(virtualBranchMenuData, deposit);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16.0);
                    },
                    itemCount: depositServices.length),
              ],
            ),
          );
        },
      ),
    );
  }
}
