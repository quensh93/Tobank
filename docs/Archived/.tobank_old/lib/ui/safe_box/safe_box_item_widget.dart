import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/safe_box/response/user_safe_box_list_response_data.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/persian_date.dart';
import '../../../util/theme/theme_util.dart';
import '../common/key_value_widget.dart';

class SafeBoxItemWidget extends StatelessWidget {
  const SafeBoxItemWidget({
    required this.safeBoxData,
    required this.visitFunction,
    required this.requestVisitFunction,
    super.key,
  });

  final SafeBoxData safeBoxData;
  final Function(SafeBoxData safeBoxData) visitFunction;
  final Function(SafeBoxData safeBoxData) requestVisitFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: const Radius.circular(8.0),
                bottom: Radius.circular(safeBoxData.status != 'confirmed' ? 8.0 : 0.0)),
            border: Border.all(
              color: context.theme.dividerColor,
            ),
          ),
          child: Column(
            children: [
              Card(
                elevation: Get.isDarkMode ? 1 : 0,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${safeBoxData.fund!.title!} - ${locale.code} ${safeBoxData.fund!.code}',
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      KeyValueWidget(
                        keyString: locale.branch,
                        valueString: '${safeBoxData.fund!.branch!.title} - ${safeBoxData.fund!.branch!.code}',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      KeyValueWidget(
                        keyString: locale.box_type,
                        valueString: safeBoxData.fund!.type!.titleFa ?? '',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      KeyValueWidget(
                        keyString: locale.safe_box_status,
                        valueString: safeBoxData.statusFa!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (safeBoxData.status == locale.canceled_ENG)
                        Container()
                      else
                        safeBoxData.status == locale.confirmed_ENG
                            ? KeyValueWidget(
                                keyString: locale.confirmed_box_date,
                                valueString: getConfirmDate(),
                              )
                            : KeyValueWidget(
                                keyString: locale.first_visit_date,
                                valueString: getDate(),
                              ),
                      if (safeBoxData.status != locale.canceled_ENG) const SizedBox(height: 16.0) else Container(),
                      KeyValueWidget(
                        keyString: locale.tracking_code_peygiri,
                        valueString: safeBoxData.trackingCode.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              if (safeBoxData.status == locale.confirmed_ENG)
                SizedBox(
                  height: 48.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                            onTap: () {
                              requestVisitFunction(safeBoxData);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                locale.visit_request,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: context.theme.dividerColor,
                        width: 2,
                        height: 32.0,
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8.0)),
                            onTap: () {
                              visitFunction(safeBoxData);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                locale.visits_list,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(),
            ],
          ),
        ),
      ],
    );
  }

  String getDate() {
    return DateConverterUtil.getDateJalaliWithDayName(
      gregorianDate: safeBoxData.referDate!.date!,
    );
  }

  String getTime() {
    return '${safeBoxData.referDate!.fromHour} تا ${safeBoxData.referDate!.toHour}';
  }

  String getConfirmDate() {
    final PersianDate persianDate = PersianDate();
    final String date = safeBoxData.confirmationDate.toString().split('+')[0];
    return persianDate.parseToFormat(date, 'd MM yyyy');
  }
}
