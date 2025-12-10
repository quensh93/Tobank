import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../model/safe_box/response/branch_list_response_data.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/key_value_widget.dart';

class SafeBoxItemWidget extends StatelessWidget {
  const SafeBoxItemWidget({
    required this.fund,
    required this.returnDataFunction,
    super.key,
    this.selectedFund,
  });

  final Fund? selectedFund;
  final Function(Fund fund) returnDataFunction;
  final Fund fund;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    final bool enabled = fund.count != 0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: selectedFund != null && selectedFund!.id == fund.id
              ? context.theme.colorScheme.secondary
              : context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        onTap: () {
          if (enabled) {
            returnDataFunction(fund);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Card(
                    elevation: Get.isDarkMode ? 1 : 0,
                    margin: EdgeInsets.zero,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgIcon(
                        Get.isDarkMode ? SvgIcons.safeBoxDark : SvgIcons.safeBox,
                        colorFilter: enabled
                            ? null
                            : ColorFilter.mode(context.theme.iconTheme.color!.withOpacity(0.4), BlendMode.srcIn),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: enabled ? 1 : 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fund.type!.titleFa!,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            locale.empty_capacity_funds(fund.count.toString()),
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!enabled)
                    Container(
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                        child: Text(
                          locale.capacity_filled,
                          style: TextStyle(
                            color: context.theme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    )
                  else
                    Transform.scale(
                      scale: 1.2,
                      child: Radio(
                          activeColor: context.theme.colorScheme.secondary,
                          value: fund,
                          groupValue: selectedFund,
                          onChanged: (dynamic value) {
                            returnDataFunction(value);
                          }),
                    )
                ],
              ),
              const SizedBox(height: 16.0),
              const Divider(thickness: 1),
              const SizedBox(height: 16.0),
              Opacity(
                opacity: enabled ? 1 : 0.4,
                child: Column(
                  children: [
                    KeyValueWidget(
                      keyString: locale.volume,
                      valueString: fund.volume ?? '',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.rent,
                      valueString: locale.amount_format(AppUtil.formatMoney(fund.rent)),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: '${locale.trusteeship_deposit}: ',
                      valueString: locale.amount_format(AppUtil.formatMoney(fund.trust)),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    KeyValueWidget(
                      keyString: locale.value_added_services,
                      valueString: locale.amount_format(AppUtil.formatMoney(fund.fee)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
