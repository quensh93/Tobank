import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../util/app_util.dart';
import '../../util/theme/theme_util.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    required this.customerCard,
    required this.bankInfoList,
    required this.isSourceCustomerCard,
    required this.selectCardDataFunction,
    super.key,
  });

  final CustomerCard customerCard;
  final Function(CustomerCard customerCard) selectCardDataFunction;
  final List<BankInfo> bankInfoList;
  final bool isSourceCustomerCard;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      onTap: () {
        selectCardDataFunction(customerCard);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.theme.dividerColor,
          ),
        ),
        child: Opacity(
          opacity: isSourceCustomerCard && bankInfo?.isTransfer == false ? 0.5 : 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: <Widget>[
                    Card(
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: bankInfo != null
                            ? SvgPicture.network(
                                AppUtil.baseUrlStatic() + bankInfo.symbol!,
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
                            : const SizedBox(height: 24.0, width: 24.0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppUtil.splitCardNumber(customerCard.cardNumber!, '  '),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            customerCard.title ?? '',
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isSourceCustomerCard && bankInfo!.inShaparakHub == true && customerCard.hubCardData == null)
                  Text(
                    locale.shaparak_register,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                else
                  Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
