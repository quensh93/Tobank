import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/safe_box/response/user_visit_list_response_data.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';

class VisitItemWidget extends StatelessWidget {
  const VisitItemWidget({
    required this.visitTime,
    required this.address,
    super.key,
  });

  final VisitTime visitTime;
  final String? address;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0), bottom: Radius.circular(8.0)),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  locale.visit_date_,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
                Flexible(
                  child: Text(
                    getDate(),
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
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
                  locale.visit_time_range,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
                Flexible(
                  child: Text(
                    getTime(),
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
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
                  locale.address,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    height: 1.6,
                  ),
                ),
                Flexible(
                  child: Text(
                    address ?? '',
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getDate() {
    return DateConverterUtil.getDateJalaliWithDayName(
      gregorianDate: visitTime.date!,
    );
  }

  String getTime() {
    return '${visitTime.fromHour} تا ${visitTime.toHour}';
  }
}
