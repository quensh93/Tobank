import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/pichak/response/credit_inquiry_response.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';

class OwnerItemWidget extends StatelessWidget {
  const OwnerItemWidget({
    required this.accountOwner,
    super.key,
  });

  final AccountOwner accountOwner;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    Color statusColor = Colors.white;
    if (accountOwner.status == locale.status_white) {
      statusColor = const Color(0xffebebeb);
    } else if (accountOwner.status == locale.status_yellow) {
      statusColor = const Color(0xffe8e13b);
    } else if (accountOwner.status == locale.status_orange) {
      statusColor = const Color(0xffffa200);
    } else if (accountOwner.status == locale.status_brown) {
      statusColor = const Color(0xff845f1e);
    } else if (accountOwner.status == locale.status_red) {
      statusColor = const Color(0xffdb3434);
    }
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: context.theme.dividerColor),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  accountOwner.fullName!,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                MySeparator(color: context.theme.dividerColor),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        locale.status,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SvgIcon(
                      SvgIcons.status,
                      colorFilter: ColorFilter.mode(statusColor, BlendMode.srcIn),
                      size: 32.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      accountOwner.status ?? '',
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                MySeparator(color: context.theme.dividerColor),
                const SizedBox(height: 16.0),
                KeyValueWidget(
                  keyString: locale.returned_cheques_count_label,
                  valueString:
                      accountOwner.returnedChequeCount != null ? accountOwner.returnedChequeCount.toString() : ' - ',
                ),
                const SizedBox(height: 16.0),
                MySeparator(color: context.theme.dividerColor),
                const SizedBox(height: 16.0),
                KeyValueWidget(
                  keyString: locale.last_update_label,
                  valueString: DateConverterUtil.getJalaliFromTimestamp(accountOwner.lastUpdate!),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
