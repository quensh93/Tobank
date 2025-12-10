import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/menu_data.dart';
import '../../util/app_util.dart';
import '../../util/theme/theme_util.dart';
import '../transaction_detail/widget/share_services_item.dart';

class ShareTransactionBottomSheet extends StatelessWidget {
  const ShareTransactionBottomSheet({
    required this.returnDataFunction,
    super.key,
  });

  final Function(MenuData virtualBranchMenuData) returnDataFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
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
            Text(locale.sharing, style: ThemeUtil.titleStyle),
            const SizedBox(
              height: 16.0,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ShareServicesItem(
                    virtualBranchMenuData: AppUtil.getShareServices()[index],
                    returnDataFunction: (virtualBranchMenuData) {
                      returnDataFunction(virtualBranchMenuData);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16.0);
                },
                itemCount: AppUtil.getShareServices().length),
          ],
        ),
      ),
    );
  }
}
