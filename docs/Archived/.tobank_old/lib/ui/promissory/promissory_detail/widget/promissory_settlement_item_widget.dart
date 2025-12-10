import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../model/promissory/promissory_single_info.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/key_value_widget.dart';

class PromissorySettlementItemWidget extends StatelessWidget {
  const PromissorySettlementItemWidget({
    required this.settlement,
    required this.isLoading,
    required this.showFilePdfCallback,
    super.key,
  });

  final Settlement settlement;
  final bool isLoading;
  final Function(Settlement settlement) showFilePdfCallback;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            border: Border.all(
              color: context.theme.dividerColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        locale.settlement_info,
                        style: ThemeUtil.titleStyle,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showFilePdfCallback(settlement);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isLoading
                            ? SpinKitFadingCircle(
                                itemBuilder: (_, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  );
                                },
                                size: 24.0,
                              )
                            :  Row(
                                children: [
                                  const SvgIcon(
                                    SvgIcons.promissoryShow,
                                    size: 24.0,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    locale.view_promissory_note,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                const Divider(thickness: 1),
                const SizedBox(height: 8.0),
                KeyValueWidget(
                  keyString: locale.registration_date,
                  valueString: settlement.creationDate ?? '',
                ),
                const SizedBox(
                  height: 16.0,
                ),
                KeyValueWidget(
                  keyString: locale.settlement_type,
                  valueString: settlement.docType == PromissoryDocType.settlement ? locale.full : locale.installment,
                ),
                const SizedBox(
                  height: 16,
                ),
                KeyValueWidget(
                  keyString: locale.settlement_amount,
                  valueString: locale.amount_format(AppUtil.formatMoney(settlement.settlementAmount!)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
