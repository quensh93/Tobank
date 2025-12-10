import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/controller/tobank_services/tobank_services_controller.dart';
import '/util/theme/theme_util.dart';
import 'modern_services_item.dart';

class InternetBankServicesBottomSheet extends GetView<TobankServicesController> {
  const InternetBankServicesBottomSheet({super.key});

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
              locale.internet_bank_services,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 16.0,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.internetBankServices.length,
              itemBuilder: (context, index) {
                return ModernServicesItem(
                  virtualBranchMenuData: controller.internetBankServices[index],
                  returnDataFunction: (virtualBranchMenuData) {
                    controller.handleInternetBankServices(virtualBranchMenuData);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16.0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
