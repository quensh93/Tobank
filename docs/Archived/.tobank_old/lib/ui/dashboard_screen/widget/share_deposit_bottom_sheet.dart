import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/deposit_main_page_controller.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class ShareDepositBottomSheet extends StatelessWidget {
  const ShareDepositBottomSheet({
    required this.deposit,
    super.key,
  });

  final Deposit deposit;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<DepositMainPageController>(
        builder: (controller) {
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
                Text(locale.deposit_detail, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 24.0,
                ),
                if (deposit.cardInfo == null)
                  Container()
                else
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: context.theme.dividerColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 16.0, top: 16.0, bottom: 16.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: Card(
                              elevation: 1,
                              margin: EdgeInsets.zero,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgIcon(
                                  Get.isDarkMode ? SvgIcons.cardNumberDark : SvgIcons.cardNumber,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(locale.card_number,
                                    style: TextStyle(
                                      color: ThemeUtil.textSubtitleColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(AppUtil.splitCardNumber(deposit.cardInfo!.pan ?? '', ' '),
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ))
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.copyText(deposit.cardInfo!.pan ?? '');
                            },
                            borderRadius: BorderRadius.circular(20.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                SvgIcons.copy,
                                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                size: 24.0,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.shareText(deposit.cardInfo!.pan ?? '');
                            },
                            borderRadius: BorderRadius.circular(20.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                SvgIcons.share,
                                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                size: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (deposit.cardInfo == null)
                  Container()
                else
                  const SizedBox(
                    height: 16.0,
                  ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 16.0, top: 16.0, bottom: 16.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Card(
                            elevation: 1,
                            margin: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.depositNumberDark : SvgIcons.depositNumber,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locale.deposit_number,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(deposit.depositNumber ?? '',
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.copyText(deposit.depositNumber ?? '');
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.copy,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              size: 24.0,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.shareText(deposit.depositNumber ?? '');
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.share,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 16.0, top: 16.0, bottom: 16.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Card(
                            elevation: 1,
                            margin: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.ibanDark : SvgIcons.iban,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locale.shaba_number,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(deposit.depositIban ?? '',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.copyText(deposit.depositIban ?? '');
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.copy,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              size: 24.0,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.shareText(deposit.depositIban ?? '');
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.share,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
