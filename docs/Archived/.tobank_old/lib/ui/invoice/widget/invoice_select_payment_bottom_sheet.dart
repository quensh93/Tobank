import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/invoice/invoice_controller.dart';
import '../../../model/invoice/invoice_data.dart';
import '../../../util/app_util.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../../widget/ui/dotted_line_widget.dart';
import '../../common/key_value_widget.dart';
import '../../common/payment_method_widget.dart';

class InvoiceSelectPaymentBottomSheet extends StatelessWidget {
  const InvoiceSelectPaymentBottomSheet({
    required this.invoiceData,
    super.key,
  });

  final InvoiceData invoiceData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<InvoiceController>(
        builder: (controller) {
          String? billName = '';
          SvgIcons billLogo = SvgIcons.nullIcon;
          if (controller.selectedBillData != null) {
            final list = DataConstants.getBllTypeDataListMinify()
                .where((element) => element.id == controller.selectedBillData!.typeId)
                .toList();
            if (list.length == 1) {
              billName = list[0].title;
              billLogo = Get.isDarkMode ? list[0].iconDark : list[0].icon;
            }
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 36,
                        height: 4,
                        decoration:
                            BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Column(
                  children: [
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          billLogo,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      billName,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          locale.payable_amount,
                          style: TextStyle(
                              color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w500, fontSize: 14.0),
                        ),
                        Row(
                          children: [
                            Text(
                              !controller.useDiscount
                                  ? AppUtil.formatMoney(invoiceData.amount)
                                  : AppUtil.formatMoney(
                                      controller.customerClubDiscountEffectResponse!.data!.newAmount.toString()),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              locale.rial,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if (controller.useDiscount)
                  const SizedBox(
                    height: 28.0,
                  )
                else
                  Container(),
                if (controller.useDiscount)
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
                        children: [
                          KeyValueWidget(
                            keyString: locale.total_points,
                            valueString: '${controller.customerClubDiscountEffectResponse!.data!.lastPoint} ${locale.point}',
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          KeyValueWidget(
                            keyString: locale.points_spent,
                            valueString: '${controller.customerClubDiscountEffectResponse!.data!.pointsLost} ${locale.point}',
                          ),
                          const SizedBox(height: 16.0),
                          MySeparator(color: context.theme.dividerColor),
                          const SizedBox(height: 16.0),
                          KeyValueWidget(
                            keyString: locale.discount_amount,
                            valueString:
                                locale.amount_format(AppUtil.formatMoney(controller.customerClubDiscountEffectResponse!.data!.discount.toString())),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(),
                const SizedBox(
                  height: 16.0,
                ),
                Text(locale.payment_method, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                PaymentMethodWidget(
                  currentPaymentType: controller.currentPaymentType,
                  currentAmount: controller.walletAmount,
                  setCurrentPaymentTypeFunction: (paymentType) {
                    controller.setCurrentPaymentType(paymentType);
                  },
                  canPayWithDeposit: false,
                  canPayWithWallet: true,
                  canPayWithGateway: true,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      locale.use_club_discount,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 40.0,
                      height: 20.0,
                      child: Transform.scale(
                        scale: 0.7,
                        transformHitTests: false,
                        child: CupertinoSwitch(
                          activeColor: context.theme.colorScheme.secondary,
                          value: controller.useDiscount,
                          onChanged: controller.isDiscountEnabled()
                              ? (bool value) {
                                  controller.setUseDiscount(value);
                                }
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validatePayment();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.payment_button,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
