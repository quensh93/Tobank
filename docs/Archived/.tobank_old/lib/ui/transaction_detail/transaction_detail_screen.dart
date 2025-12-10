import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/transaction_detail/transaction_detail_controller.dart';
import '../../model/transaction/response/transaction_data.dart';
import '../../util/app_theme.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/button_with_icon.dart';
import '../../widget/svg/svg_icon.dart';
import '../../widget/ui/dotted_separator_widget.dart';
import '../common/custom_app_bar.dart';
import '../common/key_value_widget.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({
    required this.transactionData,
    super.key,
  });

  final TransactionData transactionData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<TransactionDetailController>(
        init: TransactionDetailController(),
        builder: (controller) {
          controller.init(passedTransactionData: transactionData);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.transaction_report,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: RepaintBoundary(
                          key: controller.globalKey,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Get.isDarkMode ? const Color(0xff1c222e) : const Color(0xffffffff),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            SvgIcon(
                                              controller.transactionData.trStatus == 'success'
                                                  ? SvgIcons.transactionSuccess
                                                  : controller.transactionData.trStatus == 'error'
                                                      ? SvgIcons.transactionFailed
                                                      : SvgIcons.transactionPending,
                                              size: 56,
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              controller.transactionData.trStatus == 'success'
                                                  ?locale.payment_successful
                                                  : controller.transactionData.trStatus == 'error'
                                                      ? locale.payment_unsuccessful
                                                      : locale.payment_unknown,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: controller.transactionData.trStatus == 'success'
                                                    ? AppTheme.successColor
                                                    : controller.transactionData.trStatus == 'error'
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
                                                style: TextStyle(
                                                  color: ThemeUtil.textSubtitleColor,
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
                                      Card(
                                        elevation: 0,
                                        margin: EdgeInsets.zero,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              KeyValueWidget(
                                                keyString:locale.paid_amount,
                                                valueString: '${controller.amount}',
                                              ),
                                              const DottedSeparatorWidget(),
                                              KeyValueWidget(
                                                keyString: locale.transaction_type,
                                                valueString: controller.transactionData.service,
                                              ),
                                              const DottedSeparatorWidget(),
                                              KeyValueWidget(
                                                keyString: locale.transaction_time,
                                                valueString: controller.persianDateString,
                                              ),
                                              const DottedSeparatorWidget(),
                                              KeyValueWidget(
                                                keyString: locale.paid_via,
                                                valueString: controller.transactionData.trTypeFa,
                                              ),
                                              const DottedSeparatorWidget(),
                                              if (controller.transactionData.extraField!=null && controller.transactionData.extraField!.destMobile!=null)
                                                KeyValueWidget(
                                                  keyString: locale.mobile_number,
                                                  valueString: '${controller.transactionData.extraField!.destMobile!}',
                                                )
                                              else
                                                Container(),
                                              if (controller.transactionData.extraField!=null && controller.transactionData.extraField!.destMobile!=null)
                                                const DottedSeparatorWidget()
                                              else
                                                Container(),
                                              if (controller.hasSource)
                                                controller.getSourceUser()
                                              else
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                              if (controller.hasDest)
                                                controller.getDestUser()
                                              else
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                              if (controller.isCardToCard)
                                                controller.getCardToCardDetail()
                                              else
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                              if (controller.isBill)
                                                controller.getBillDataWidget()
                                              else
                                                const SizedBox(height: 0),
                                              if (controller.isInternetPlan)
                                                controller.getInternetPlanWidget()
                                              else
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                              if (controller.isCharity)
                                                controller.getCharityWidget()
                                              else
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                              if (controller.isCharge)
                                                controller.getChargeWidget()
                                              else
                                                const SizedBox(
                                                  height: 0,
                                                ),
                                              if (controller.transactionData.discountPrice != null)
                                                KeyValueWidget(
                                                  keyString: locale.discounted_amount,
                                                  valueString: '${controller.discountPrice}',
                                                )
                                              else
                                                Container(),
                                              if (controller.transactionData.discountPrice != null)
                                                const DottedSeparatorWidget()
                                              else
                                                Container(),
                                              KeyValueWidget(
                                                keyString: locale.tracking_number,
                                                valueString: controller.trackingNumber,
                                              ),
                                              if (controller.isCardToCard || controller.isWalletTransfer)
                                                const DottedSeparatorWidget()
                                              else
                                                Container(),
                                              if (controller.isCardToCard || controller.isWalletTransfer)
                                                KeyValueWidget(
                                                  keyString: locale.description,
                                                  valueString: controller.transactionData.srcComment ?? '-',
                                                )
                                              else
                                                const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SvgIcon(
                                        SvgIcons.tobank,
                                        size: 48.0,
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Container(
                                          width: 1,
                                          height: 42,
                                          decoration: BoxDecoration(
                                            color: context.theme.dividerColor,
                                          )),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            locale.virtual_branch_with_you,
                                            style: TextStyle(
                                              color: ThemeUtil.textTitleColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(locale.website,
                                              style: TextStyle(
                                                color: ThemeUtil.textSubtitleColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (controller.isCardToCard &&
                        controller.transactionData.isShaparakHub &&
                        controller.transactionData.trStatus == 'pending')
                      const SizedBox(
                        height: 12.0,
                      )
                    else
                      Container(),
                    if (controller.isCardToCard &&
                        controller.transactionData.isShaparakHub &&
                        controller.transactionData.trStatus == 'pending')
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!controller.isLoading) {
                                controller.shaparakHubTransferInquiryRequest();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppTheme.warningColor,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppTheme.warningColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              child: controller.isLoading
                                  ? SpinKitFadingCircle(
                                      itemBuilder: (_, int index) {
                                        return const DecoratedBox(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                      size: 24.0,
                                    )
                                  :  Text(
                                      locale.re_inquiry_transfer,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      )
                    else
                      Container(),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: (kIsWeb || Platform.isIOS)
                            ? Row(
                                children: [
                                  Expanded(
                                    child: ButtonWithIcon(
                                      buttonTitle: locale.receipt_image,
                                      buttonIcon: SvgIcons.shareImage,
                                      onPressed: controller
                                          .captureAndShareTransactionImage,
                                      isLoading: controller.shareLoading,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Expanded(
                                    child: ButtonWithIcon(
                                      buttonTitle: locale.receipt_text,
                                      buttonIcon: SvgIcons.shareText,
                                      onPressed:
                                          controller.shareTransactionText,
                                      isLoading: controller.storeLoading,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: ButtonWithIcon(
                                      buttonTitle: locale.sharing,
                                      buttonIcon: SvgIcons.share,
                                      onPressed: controller
                                          .showShareTransactionBottomSheet,
                                      isLoading: controller.shareLoading,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Expanded(
                                    child: ButtonWithIcon(
                                      buttonTitle: locale.save_to_gallery,
                                      buttonIcon: SvgIcons.download,
                                      onPressed: controller
                                          .captureAndSaveTransactionImage,
                                      isLoading: controller.storeLoading,
                                    ),
                                  ),
                                ],
                              )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
