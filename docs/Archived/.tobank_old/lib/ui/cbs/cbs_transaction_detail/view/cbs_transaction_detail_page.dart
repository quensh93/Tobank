import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/cbs/cbs_transaction_detail/cbs_transaction_detail_controller.dart';
import '../../../../../model/transaction/response/transaction_data.dart';
import '../../../../../util/app_theme.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';

class CBSTransactionDetailPage extends StatelessWidget {
  const CBSTransactionDetailPage({
    required this.transactionData,
    required this.displayDescription,
    super.key,
  });

  final TransactionData transactionData;
  final bool displayDescription;

  @override

  Widget build(BuildContext context) {//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CBSTransactionDetailController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (displayDescription)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
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
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            KeyValueWidget(
                              keyString: locale.payment_amount,
                              valueString: '${controller.amount}',
                            ),
                            const SizedBox(height: 16.0),
                            MySeparator(color: context.theme.dividerColor),
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.payment_date,
                              valueString: controller.persianDateString,
                            ),
                            const SizedBox(height: 16.0),
                            MySeparator(color: context.theme.dividerColor),
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.tracking_code_peygiri,
                              valueString: controller.cbsFetchDocumentResponse!.data!.referenceCode,
                              ltrDirection: true,
                            ),
                            const SizedBox(height: 16.0),
                            MySeparator(color: context.theme.dividerColor),
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.applicant_title,
                              valueString: controller.cbsFetchDocumentResponse!.data!.fullName,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: context.theme.dividerColor),
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
                            locale.credit_evaluation_report,
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
                            controller.showPreview();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.showPassword,
                              size: 24,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            controller.shareCBSPdf();
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
                    const SizedBox(
                      height: 16.0,
                    ),
                    Column(
                      children: [
                        const Divider(thickness: 1),
                        const SizedBox(height: 16.0),
                        Text(
                          displayDescription
                              ? locale.credit_report_message
                              : locale.view_credit_report,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
