import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/deposit/transfer/deposit_transfer_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/enums_constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

class DepositTransferConfirmPage extends StatelessWidget {
  const DepositTransferConfirmPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DepositTransferController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          controller.selectedTransferMethodData!.title,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            locale.payable_amount,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 24.0,
                          ),
                          Row(
                            children: [
                              Text(
                                AppUtil.formatMoney(controller.amount),
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                locale.rial,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.from_origin,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: context.theme.dividerColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    width: 36.0,
                                    height: 36.0,
                                    child: const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: SvgIcon(
                                        SvgIcons.gardeshgari,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${controller.mainController.authInfoData!.firstName!} ${controller.mainController.authInfoData!.lastName!}',
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          controller.deposit!.depositNumber ?? '',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Divider(thickness: 1),
                              const SizedBox(height: 8.0),
                              Text(
                                locale.to_destination,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: context.theme.dividerColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: controller.currentTransferType == TransferTypeEnum.deposit
                                          ? const SvgIcon(
                                              SvgIcons.gardeshgari,
                                              size: 24.0,
                                            )
                                          : controller.ibanInquiryResponseData!.data!.bankInfo != null
                                              ? SvgPicture.network(
                                                  AppUtil.baseUrlStatic() +
                                                      controller.ibanInquiryResponseData!.data!.bankInfo!.symbol!,
                                                  semanticsLabel: '',
                                                  height: 24.0,
                                                  width: 24.0,
                                                  placeholderBuilder: (BuildContext context) => SpinKitFadingCircle(
                                                    itemBuilder: (_, int index) {
                                                      return DecoratedBox(
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: context.theme.iconTheme.color,
                                                        ),
                                                      );
                                                    },
                                                    size: 24.0,
                                                  ),
                                                )
                                              : Container(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.getDestinationCustomer(),
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          controller.destinationDeposit,
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (controller.localDescriptionController.text.isEmpty)
                                Container()
                              else
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 8.0),
                                    const Divider(thickness: 1),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      locale.from_description,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        height: 1.6,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      controller.localDescriptionController.text,
                                      style: TextStyle(
                                        color: ThemeUtil.textTitleColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                        height: 1.6,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              if (controller.transactionDescriptionController.text.isEmpty)
                                Container()
                              else
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 8.0),
                                    const Divider(thickness: 1),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      locale.transaction_description,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        height: 1.6,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      controller.transactionDescriptionController.text,
                                      style: TextStyle(
                                        color: ThemeUtil.textTitleColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                        height: 1.6,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButtonWidget(
                callback: () {
                  controller.validateDepositConfirmPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.final_confirmation_and_transfer,
              ),
            ),
          ],
        );
      },
    );
  }
}
