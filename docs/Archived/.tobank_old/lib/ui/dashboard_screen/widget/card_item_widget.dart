import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../model/card/response/customer_card_response_data.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    required this.scale,
    required this.itemHeight,
    required this.customerCard,
    required this.bankInfoList,
    required this.returnDataFunction,
    super.key,
  });

  final double scale;
  final double itemHeight;
  final CustomerCard customerCard;
  final Function(CustomerCard customerCard) returnDataFunction;
  final List<BankInfo> bankInfoList;

  @override
  Widget build(BuildContext context) {
    Color startColor = const Color(0xffb01117);
    Color endColor = const Color(0xffdd6c70);
    String logo = '';
    final BankInfo? bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    if (bankInfo != null) {
      startColor = AppUtil.colorHexConvert(bankInfo.startColor);
      endColor = AppUtil.colorHexConvert(bankInfo.endColor);
      logo = AppUtil.baseUrlStatic() + bankInfo.logo!;
    }
    return Align(
      heightFactor: Constants.cardHeightFactor,
      child: Container(
        color: Colors.transparent,
        height: itemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  returnDataFunction(customerCard);
                },
                child: Opacity(
                  opacity: scale > (3 / 4)
                      ? 1
                      : scale > (1 / 4)
                          ? (4 * scale - 1) / 2
                          : 0,
                  child: SizedBox(
                    height: itemHeight * scale,
                    width: (Get.width - 48) * scale,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Get.isDarkMode ? Colors.black.withOpacity(0.2) : Colors.transparent,
                              offset: const Offset(0, -2),
                              blurRadius: 30)
                        ],
                        gradient: LinearGradient(begin: const Alignment(0, 1), colors: [startColor, endColor]),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.white12, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Opacity(
                          opacity: scale,
                          child: scale < 0.4
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0 * scale, vertical: 24.0 * scale),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.network(
                                            logo,
                                            height: 24.0 * scale,
                                            width: 24.0 * scale,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(AppUtil.splitCardNumber(customerCard.cardNumber ?? '', ' '),
                                                    textDirection: TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 20.0 * scale,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    )),
                                                Text(customerCard.title ?? '',
                                                    textDirection: TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontSize: 16.0 * scale,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
