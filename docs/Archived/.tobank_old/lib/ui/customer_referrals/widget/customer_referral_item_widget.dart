import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/customer_referrals/response/customer_referrals_response_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';

class CustomerReferralItemWidget extends StatelessWidget {
  const CustomerReferralItemWidget({
    required this.customerReferral,
    super.key,
  });

  final Referral customerReferral;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${customerReferral.firstName!} ${customerReferral.lastName!}',
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    height: 1.4,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.invitation_date,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        customerReferral.referenceDate != null
                            ? DateConverterUtil.getJalaliFromTimestamp(customerReferral.referenceDate!)
                            : locale.pending_status,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.gift_amount_label,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        customerReferral.rewardAmount != null
                            ? locale.amount_format(AppUtil.formatMoney(customerReferral.rewardAmount!))
                            : locale.pending_status,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
