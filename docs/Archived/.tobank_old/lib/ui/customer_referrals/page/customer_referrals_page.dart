import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/customer_referrals/customer_referrals_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../widget/customer_referral_item_widget.dart';

class CustomerReferralsPage extends StatelessWidget {
  const CustomerReferralsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CustomerReferralsController>(
      init: CustomerReferralsController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (controller.customerReferralsResponse!.data!.referrals!.isEmpty)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                      height: 200,
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
            else
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      itemBuilder: (context, index) {
                        final customerReferral = controller.customerReferralsResponse!.data!.referrals![index];
                        return CustomerReferralItemWidget(
                          customerReferral: customerReferral,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16,
                        );
                      },
                      itemCount: controller.customerReferralsResponse!.data!.referrals!.length),
                ),
              ),
            const SizedBox(
              height: 12,
            ),
          ],
        );
      },
    );
  }
}
