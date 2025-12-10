import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/card_management/card_wallet_controller.dart';
import '../../util/app_util.dart';
import '../../widget/svg/svg_icon.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardWalletController>(
        init: CardWalletController(),
        builder: (controller) {
          //locale
          final locale = AppLocalizations.of(context)!;
          return Container(
            height: 178,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Color(0x141b1f44), offset: Offset(0, 16), blurRadius: 30)],
              gradient: const LinearGradient(begin: Alignment(0, 1), colors: [Color(0xff15a0a0), Color(0xff50e8e8)]),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SvgIcon(SvgIcons.tobankLogo),
                      Text(locale.tobank_wallet,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
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
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: SvgIcon(
                                    SvgIcons.refresh,
                                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                             Text(
                              locale.try_again,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
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
                                AppUtil.formatMoney(controller.currentAmount).toString(),
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            const SizedBox(
                              width: 6.0,
                            ),
                             Text(
                              locale.rial,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
