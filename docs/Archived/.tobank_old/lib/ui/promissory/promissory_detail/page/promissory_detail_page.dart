import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_detail_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';

class PromissoryDetailPage extends StatelessWidget {
  const PromissoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryDetailController>(
      builder: (controller) {
        final isIndividual = controller.promissoryInfo!.recipientType == PromissoryCustomerType.individual;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.theme.dividerColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                locale.issued_promissory_file,
                                style: ThemeUtil.titleStyle,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.fetchPublishPdfDocument();
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: controller.isLoading
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
                                            locale.view,
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
                        const SizedBox(
                          height: 16.0,
                        ),
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
                                Text(locale.promissory_note_info, style: ThemeUtil.titleStyle),
                                const SizedBox(height: 8.0),
                                const Divider(thickness: 1),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      locale.unique_identifier,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.copyPromissoryId();
                                          },
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgIcon(
                                              SvgIcons.copy,
                                              colorFilter:
                                                  ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          controller.promissoryInfo!.promissoryId!,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                KeyValueWidget(
                                  keyString: locale.registration_date,
                                  valueString: controller.promissoryInfo!.creationDate!,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                KeyValueWidget(
                                  keyString: locale.commitment_amount,
                                  valueString: locale.amount_format(AppUtil.formatMoney(controller.promissoryInfo!.amount!)),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                if (controller.promissoryInfo!.state != PromissoryStateType.settled) ...[
                                  KeyValueWidget(
                                    keyString: locale.remaining_commitment,
                                    valueString:
                                        locale.amount_format(AppUtil.formatMoney(max(0, controller.promissoryInfo!.remainingAmount!))), // Max because negative number!!
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                ],
                                KeyValueWidget(
                                  keyString: locale.payment_date,
                                  valueString: controller.promissoryInfo!.dueDate!,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  locale.process_detail,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  controller.promissoryInfo!.description ?? '-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    height: 1.6,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  locale.pay_location,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                // TODO: Add isTransfable
                                // TODO: Add current owner based on endorsement list
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  controller.promissoryInfo!.paymentPlace!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                MySeparator(
                                  color: context.theme.dividerColor,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  locale.issuer_information,
                                  style: ThemeUtil.titleStyle,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                KeyValueWidget(
                                  keyString: locale.national_code_title,
                                  valueString: controller.promissoryInfo!.issuerNn!,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                KeyValueWidget(
                                  keyString: locale.issuer_mobile_number,
                                  valueString: '0${controller.promissoryInfo!.issuerCellphone}',
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                KeyValueWidget(
                                  keyString: locale.full_name,
                                  valueString: controller.promissoryInfo!.issuerFullName ?? '',
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                KeyValueWidget(
                                  keyString:locale.deposit,
                                  valueString: controller.promissoryInfo!.issuerAccountNumber ?? '-',
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                // TODO: issuer address UI
                                Text(
                                  locale.address_of_residence,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  controller.promissoryInfo!.issuerAddress ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                MySeparator(
                                  color: context.theme.dividerColor,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  locale.recipient_information,
                                  style: ThemeUtil.titleStyle,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                KeyValueWidget(
                                  keyString: isIndividual ? locale.national_code_title : locale.recipient_national_id_title,
                                  valueString: controller.promissoryInfo!.recipientNn ?? '',
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                KeyValueWidget(
                                  keyString: isIndividual ?  locale.mobile_number : locale.contact_number,
                                  valueString: isIndividual
                                      ? '0${controller.promissoryInfo!.recipientCellphone}'
                                      : controller.promissoryInfo!.recipientCellphone,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                KeyValueWidget(
                                  keyString: isIndividual ? locale.full_name : locale.name,
                                  valueString: controller.promissoryInfo!.recipientFullName ?? '',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
