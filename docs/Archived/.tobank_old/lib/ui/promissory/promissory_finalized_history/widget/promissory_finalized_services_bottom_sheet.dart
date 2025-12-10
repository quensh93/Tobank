import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../model/promissory/promissory_list_info.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/theme/theme_util.dart';
import 'promissory_finalized_service_item_widget.dart';

class PromissoryFinalizedServicesBottomSheet extends StatelessWidget {
  const PromissoryFinalizedServicesBottomSheet({
    required this.promissoryInfo,
    required this.handleEventClick,
    super.key,
  });

  final PromissoryListInfo promissoryInfo;
  final Function(int eventId) handleEventClick;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    final serviceList = AppUtil.getPromissoryFinalizedServicesList(
      promissoryRoleType: promissoryInfo.role!,
      stateType: promissoryInfo.state,
      isTransfable: promissoryInfo.transferable ?? true,
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.theme.dividerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              locale.select_service,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 24.0,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PromissoryFinalizedServiceItemWidget(
                  promissoryFinalizedItemData: serviceList[index],
                  returnDataFunction: (promissoryItemData) {
                    handleEventClick(promissoryItemData.eventId);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16.0,
                );
              },
              itemCount: serviceList.length,
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
