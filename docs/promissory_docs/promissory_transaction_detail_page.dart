import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/l10n/gen/app_localizations.dart';
import '../../../../../controller/promissory/promissory_transaction_detail_page_controller.dart';
import '../../../../../model/transaction/response/transaction_data.dart';
import '../../../../../util/app_theme.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';

class PromissoryTransactionDetailPage extends StatelessWidget {
  const PromissoryTransactionDetailPage({
    required this.transactionData,
    required this.screenName,
    super.key,
    this.cardOwnerName,
    this.isDepositMoney,
    this.multiSignPath,
  });

  final TransactionData? transactionData;
  final String? cardOwnerName;
  final bool? isDepositMoney;
  final String screenName;
  final String? multiSignPath;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryTransactionDetailPageController>(
        init: PromissoryTransactionDetailPageController(),
        builder: (controller) {
          controller.setValues(
            transactionData!,
            multiSignPath,
          );
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            SvgIcon(
                              controller.transactionData.trStatus == locale.success_ENG
                                  ? SvgIcons.transactionSuccess
                                  : controller.transactionData.trStatus == locale.error_ENG
                                      ? SvgIcons.transactionFailed
                                      : SvgIcons.transactionPending,
                              size: 56,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              controller.transactionData.trStatus == locale.success_ENG
                                  ? locale.payment_successful
                                  : controller.transactionData.trStatus == locale.error_ENG
                                      ? locale.payment_unsuccessful
                                      : locale.payment_unknown,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: controller.transactionData.trStatus == locale.success_ENG
                                    ? AppTheme.successColor
                                    : controller.transactionData.trStatus == locale.error_ENG
                                        ? AppTheme.failColor
                                        : AppTheme.warningColor,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            if (controller.transactionData.message != null &&
                                controller.transactionData.message!.isNotEmpty)
                              Text(
                                controller.transactionData.message ?? '',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  height: 1.6,
                                ),
                              )
                            else
                              Container(),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Card(
                          elevation: Get.isDarkMode ? 1 : 0,
                          margin: EdgeInsets.zero,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                KeyValueWidget(
                                  keyString: locale.paid_amount,
                                  valueString: '${controller.amount}',
                                ),
                                const SizedBox(height: 16.0),
                                MySeparator(color: context.theme.dividerColor),
                                const SizedBox(height: 16.0),
                                KeyValueWidget(
                                  keyString: locale.transaction_type,
                                  valueString: controller.transactionData.service ?? '',
                                ),
                                const SizedBox(height: 16.0),
                                MySeparator(color: context.theme.dividerColor),
                                const SizedBox(height: 16.0),
                                KeyValueWidget(
                                  keyString: locale.transaction_time,
                                  valueString: controller.persianDateString ?? '',
                                ),
                                const SizedBox(height: 16.0),
                                MySeparator(color: context.theme.dividerColor),
                                const SizedBox(height: 16.0),
                                KeyValueWidget(
                                  keyString: locale.paid_via,
                                  valueString: controller.transactionData.trTypeFa ?? '',
                                ),
                                const SizedBox(height: 16.0),
                                MySeparator(color: context.theme.dividerColor),
                                const SizedBox(height: 16.0),
                                KeyValueWidget(
                                  keyString: locale.tracking_number,
                                  valueString: controller.trackingNumber ?? '-',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: context.theme.dividerColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SvgIcon(
                                SvgIcons.pdfFile,
                                size: 32,
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                 locale.promissory,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8.0),
                                onTap: () {
                                  controller.showPreviewScreen();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    SvgIcons.showPassword,
                                    colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                    size: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              InkWell(
                                borderRadius: BorderRadius.circular(8.0),
                                onTap: () {
                                  controller.sharePromissoryPdf();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    SvgIcons.share,
                                    colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(height: 8.0),
                           Text(
                            locale.promissory_download_message,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
