import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/card/response/customer_card_response_data.dart';
import '../../../util/app_util.dart';
import '../../../widget/svg/svg_icon.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    required this.customerCard,
    required this.bankInfoList,
    required this.showCardDetailBottomSheet,
    required this.shareCardInfo,
    required this.isCardBalanceLoading,
    required this.balanceFunction,
    required this.isLock,
    super.key,
  });

  final CustomerCard customerCard;
  final List<BankInfo> bankInfoList;
  final Function(CustomerCard customerCard) showCardDetailBottomSheet;
  final Function(CustomerCard customerCard) shareCardInfo;
  final bool isCardBalanceLoading;
  final Function(CustomerCard customerCard) balanceFunction;
  final bool isLock;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    Color startColor = const Color(0xffb01117);
    Color endColor = const Color(0xffdd6c70);
    String logo = '';
    final BankInfo? bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    if (bankInfo != null) {
      startColor = AppUtil.colorHexConvert(bankInfo.startColor);
      endColor = AppUtil.colorHexConvert(bankInfo.endColor);
      logo = AppUtil.baseUrlStatic() + bankInfo.logo!;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Color(0x141b1f44), offset: Offset(0, 16), blurRadius: 30)],
        gradient: LinearGradient(
          begin: const Alignment(0, 1),
          colors: [startColor, endColor],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (customerCard.gardeshgaryCardData == null || (customerCard.cardNumber ?? '').startsWith('50541660')) const SizedBox(height: 16.0) else Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.network(
                      logo,
                      width: 24.0,
                      height: 24.0,
                    ),
                    if (customerCard.gardeshgaryCardData == null || (customerCard.cardNumber ?? '').startsWith('50541660'))
                      Container()
                    else
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              balanceFunction(customerCard);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: isCardBalanceLoading
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
                                  : const SvgIcon(
                                      SvgIcons.refresh,
                                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                    ),
                            ),
                          ),
                          Text(
                              customerCard.gardeshgaryCardData!.balance != null
                                  ? AppUtil.formatMoney(customerCard.gardeshgaryCardData!.balance)
                                  : '-',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                           Text(locale.rial,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        customerCard.title ?? '',
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                     Text(AppUtil.splitCardNumber(customerCard.cardNumber ?? '', ' '),
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                        const SizedBox(
                          width: 8.0,
                        ),
                        if (customerCard.isDefault!)
                          const SvgIcon(
                            SvgIcons.cardCheck,
                          )
                        else
                          Container(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showCardDetailBottomSheet(customerCard);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.menu,
                              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            shareCardInfo(customerCard);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.share,
                              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                        customerCard.cardExpMonth == null || customerCard.cardExpYear == null
                            ? '${locale.expiration_date}: --/--'
                            : '${locale.expiration_date}: ${customerCard.cardExpYear}/${customerCard.cardExpMonth}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ))
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: isLock,
            child: Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Blur(
                    blur: 3.5,
                    blurColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12.0),
                    colorOpacity: 0.2,
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.transparent,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SvgIcon(
                            SvgIcons.lock,
                            size: 32,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            locale.banned,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Text(AppUtil.splitCardNumber(customerCard.cardNumber ?? '', ' '),
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
