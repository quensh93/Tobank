import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/card_management/card_wallet_controller.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../widget/svg/svg_icon.dart';

class CardWalletWidget extends StatelessWidget {
  const CardWalletWidget({
    required this.scale,
    required this.itemHeight,
    required this.callback,
    required this.showScrollIcon,
    super.key,
  });

  final double scale;
  final double itemHeight;
  final VoidCallback callback;
  final bool showScrollIcon;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardWalletController>(
        init: CardWalletController(),
        builder: (controller) {
          return Align(
            heightFactor: Constants.cardHeightFactor,
            child: Container(
              color: Colors.transparent,
              height: itemHeight + (28 * scale),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        callback();
                      },
                      child: Column(
                        children: [
                          if (showScrollIcon)
                            Opacity(
                              opacity: scale * scale * scale * scale,
                              child: scale > 0.5
                                  ? SvgIcon(
                                      SvgIcons.scroll,
                                      size: 28 * scale,
                                    )
                                  : SizedBox(height: 28.0 * scale),
                            )
                          else
                            Container(),
                          Opacity(
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
                                  boxShadow: const [
                                    BoxShadow(color: Color(0x141b1f44), offset: Offset(0, 16), blurRadius: 30)
                                  ],
                                  gradient: const LinearGradient(
                                      begin: Alignment(0, 1), colors: [Color(0xff15a0a0), Color(0xff50e8e8)]),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: Colors.white12, width: 2),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Opacity(
                                    opacity: scale,
                                    child: scale < 0.5
                                        ? Container()
                                        : Padding(
                                            padding: EdgeInsets.all(16.0 * scale),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SvgIcon(
                                                      SvgIcons.tobankLogo,
                                                      size: 32.0 * scale,
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text(locale.tobank_wallet,
                                                              textDirection: TextDirection.ltr,
                                                              style: TextStyle(
                                                                fontSize: 20.0 * scale,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.white,
                                                              )),
                                                          SizedBox(height: 16.0 * scale),
                                                          if (controller.hasWalletError)
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Material(
                                                                  color: Colors.transparent,
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      controller.getWalletDetailRequest();
                                                                    },
                                                                    borderRadius: BorderRadius.circular(40),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(4.0),
                                                                      child: SvgIcon(
                                                                        SvgIcons.refresh,
                                                                        size: 24.0 * scale,
                                                                        colorFilter: const ColorFilter.mode(
                                                                            Colors.white, BlendMode.srcIn),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 4.0 * scale),
                                                                Text(
                                                                  locale.try_again,
                                                                  style: TextStyle(
                                                                    fontSize: 16.0 * scale,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          else
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: <Widget>[
                                                                if (controller.isWalletLoading)
                                                                  SpinKitFadingCircle(
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
                                                                else
                                                                  Text(
                                                                    AppUtil.formatMoney(controller.currentAmount)
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontSize: 20.0 * scale,
                                                                      fontWeight: FontWeight.w600,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                SizedBox(
                                                                  width: 6.0 * scale,
                                                                ),
                                                                Text(
                                                                  locale.rial,
                                                                  style: TextStyle(
                                                                    fontSize: 16.0 * scale,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
