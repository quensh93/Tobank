import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../model/transaction/response/transaction_data.dart';
import '../../../../../util/persian_date.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';

class CBSTransactionItemWidget extends StatelessWidget {
  const CBSTransactionItemWidget({
    required this.transactionData,
    required this.showDataFunction,
    required this.shareDataFunction,
    super.key,
  });

  final TransactionData transactionData;
  final Function(TransactionData transactionData) showDataFunction;
  final Function(TransactionData transactionData) shareDataFunction;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    final PersianDate persianDate = PersianDate();
    final String date = transactionData.trDate!.toString().split('+')[0];
    final String persianDateString = persianDate.parseToFormat(date, 'd MM yyyy - HH:nn');
    return Column(
      children: [
        Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: context.theme.dividerColor, width: 0.5),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: context.theme.dividerColor,
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: context.theme.colorScheme.surface,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Card(
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                child: SvgIcon(
                                  Get.isDarkMode ? SvgIcons.cbsDetailDark : SvgIcons.cbsDetail,
                                  size: 24.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              locale.credit_evaluation_report,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: ThemeUtil.textTitleColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.applicant_title,
                          valueString: transactionData.extraField!.openbankingResponse!.fullname,
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(color: context.theme.dividerColor),
                        const SizedBox(height: 16.0),
                        KeyValueWidget(
                          keyString: locale.credit_evaluation_date,
                          valueString: persianDateString,
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(color: context.theme.dividerColor),
                        const SizedBox(height: 16.0),
                        KeyValueWidget(
                          keyString: locale.tracking_code_peygiri,
                          valueString: transactionData.extraField!.openbankingResponse!.referenceCode,
                          ltrDirection: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                          onTap: () {
                            showDataFunction(transactionData);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgIcon(
                                  SvgIcons.showPassword,
                                  colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                  size: 24.0,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                 Flexible(
                                  child: Text(
                                    locale.view,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   color: context.theme.dividerColor,
                    //   width: 2,
                    //   height: 32.0,
                    // ),
                    // Expanded(
                    //   child: Material(
                    //     color: Colors.transparent,
                    //     child: InkWell(
                    //       borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                    //       onTap: () {
                    //         shareDataFunction(transactionData);
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             SvgIcon(
                    //               SvgIcons.share,
                    //               size: 24.0,
                    //               colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                    //             ),
                    //             const SizedBox(
                    //               width: 8.0,
                    //             ),
                    //             const Flexible(
                    //               child: Text(
                    //                 'اشتراک‌گذاری',
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.w700,
                    //                   fontSize: 14.0,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
