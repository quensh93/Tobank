import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../model/promissory/promissory_list_info.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/key_value_widget.dart';

class PromissoryFinalizedHistoryItemWidget extends StatelessWidget {
  const PromissoryFinalizedHistoryItemWidget({
    required this.promissoryInfo,
    required this.returnDataFunction,
    super.key,
  });

  final PromissoryListInfo promissoryInfo;
  final Function(PromissoryListInfo promissoryInfo) returnDataFunction;

  String get requestTitle {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    switch (promissoryInfo.role) {
      case PromissoryRoleType.issuer:
        return locale.issuer;
      case PromissoryRoleType.currentOwner:
        return locale.current_owner;
      case PromissoryRoleType.guarantor:
        return locale.guarantor ;
      case PromissoryRoleType.previousOwner:
        return locale.transmitter ;
      case null:
        return locale.unknown ;
    }
  }

  String get stateTitle {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    switch (promissoryInfo.state) {
      case PromissoryStateType.published:
        return locale.published;
      case PromissoryStateType.partialSettled:
        return locale.partial_settled;
      case PromissoryStateType.settled:
        return locale.settled;
      case PromissoryStateType.demanded:
        return locale.demanded;
      case PromissoryStateType.canceled:
        return locale.canceled;
      case null:
        return locale.state_unknown;
    }
  }

  String get amount {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return locale.amount_format(AppUtil.formatMoney(promissoryInfo.amount));
  }

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        requestTitle,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      KeyValueWidget(
                        keyString: locale.issuer_name,
                        valueString: promissoryInfo.issuerFullName!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      KeyValueWidget(
                        keyString: locale.recipient_name_,
                        valueString: promissoryInfo.recipientFullName!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      KeyValueWidget(
                        keyString: locale.commitment_amount,
                        valueString: amount,
                      ),
                      if (promissoryInfo.state != PromissoryStateType.settled) ...[
                        const SizedBox(
                          height: 16,
                        ),
                        KeyValueWidget(
                          keyString: locale.remaining_commitment,
                          valueString:
                              locale.amount_format(AppUtil.formatMoney(max(0, promissoryInfo.remainingAmount!))), // Max because negative number!!
                        ),
                      ],
                      const SizedBox(
                        height: 16,
                      ),
                      KeyValueWidget(
                        keyString: locale.unique_promissory_id,
                        valueString: promissoryInfo.promissoryId!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // TODO: Add other data
                      KeyValueWidget(
                        keyString: locale.role,
                        valueString: requestTitle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      KeyValueWidget(
                        keyString: locale.status,
                        valueString: stateTitle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      KeyValueWidget(
                        keyString: locale.payment_date,
                        valueString: promissoryInfo.dueDate!.trim(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        locale.process_detail,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        promissoryInfo.description ?? '-',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  returnDataFunction(promissoryInfo);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        SvgIcons.promissoryFinalizedServices,
                        colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        size: 24.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                       Text(
                        locale.promissory_services,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
