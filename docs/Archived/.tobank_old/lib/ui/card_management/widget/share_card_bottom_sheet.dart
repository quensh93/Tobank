import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_management/card_management_controller.dart';
import '../../../model/card/response/customer_card_response_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class ShareCardBottomSheet extends StatelessWidget {
  const ShareCardBottomSheet({
    required this.cardData,
    super.key,
  });

  final CustomerCard cardData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardManagementController>(
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
                Text(locale.sharing, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Card(
                          elevation: Get.isDarkMode ? 1 : 0,
                          margin: EdgeInsets.zero,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              Get.isDarkMode ? SvgIcons.shareCardDark : SvgIcons.shareCard,
                              size: 24.0,
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
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(AppUtil.splitCardNumber(cardData.cardNumber ?? '', ' '),
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.copyText(cardData.cardNumber ?? '');
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.copy,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.shareText(cardData.cardNumber ?? '');
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.share,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (cardData.gardeshgaryCardData == null)
                  Container()
                else
                  Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: context.theme.dividerColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Card(
                                elevation: Get.isDarkMode ? 1 : 0,
                                margin: EdgeInsets.zero,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    Get.isDarkMode ? SvgIcons.shareDepositDark : SvgIcons.shareDeposit,
                                    size: 24.0,
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
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(cardData.gardeshgaryCardData!.depositNumber ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.copyText(cardData.gardeshgaryCardData!.depositNumber ?? '');
                                },
                                borderRadius: BorderRadius.circular(20.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    SvgIcons.copy,
                                    colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.shareText(cardData.gardeshgaryCardData!.depositNumber ?? '');
                                },
                                borderRadius: BorderRadius.circular(20.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    SvgIcons.share,
                                    colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 16.0,
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8.0),
                      //     border:
                      //         Border.all(color: context.theme.dividerColor),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(16.0),
                      //     child: Row(
                      //       children: [
                      //         Card(
                      //           elevation: Get.isDarkMode ? 1 : 0,
                      //           margin: EdgeInsets.zero,
                      //           shadowColor: Colors.transparent,
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius:
                      //                   BorderRadius.circular(40)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: SvgIcon(
                      //                 Get.isDarkMode
                      //             ? 'assets/icons/ic_share_iban_dark.svg'
                      //              : 'assets/icons/ic_share_iban.svg',
                      //              size: 24.0,
                      //           ),
                      //         ),
                      //         const SizedBox(
                      //           width: 8.0,
                      //         ),
                      //         const Expanded(
                      //           child: Column(
                      //             crossAxisAlignment:
                      //                 CrossAxisAlignment.start,
                      //             children: [
                      //               Text("شماره شبا",
                      //                   style: TextStyle(
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.w400,
                      //                   )),
                      //               SizedBox(
                      //                 height: 8.0,
                      //               ),
                      //               Text("IR۱۲ ۳۴۵۶ ۷۸۹۰ ۱۲۳۴ ۵۶۷۸۹",
                      //                   textDirection: TextDirection.ltr,
                      //                   style: TextStyle(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w500,
                      //                   ))
                      //             ],
                      //           ),
                      //         ),
                      //         InkWell(
                      //           onTap: () {
                      //             // TODO:
                      //           },
                      //           borderRadius: BorderRadius.circular(20.0),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: SvgIcon(
                      //               SvgIcons.copy,
                      //               colorFilter: ColorFilter.mode(
                      //                   context.theme.iconTheme.color!,
                      //                   BlendMode.srcIn),
                      //             ),
                      //           ),
                      //         ),
                      //         InkWell(
                      //           onTap: () {
                      //             // TODO:
                      //           },
                      //           borderRadius: BorderRadius.circular(20.0),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: SvgIcon(
                      //               SvgIcons.share,
                      //               colorFilter: ColorFilter.mode(
                      //                   context.theme.iconTheme.color!,
                      //                   BlendMode.srcIn),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
