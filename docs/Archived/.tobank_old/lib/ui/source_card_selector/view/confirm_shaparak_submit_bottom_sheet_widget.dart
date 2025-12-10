import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/source_card_selector/source_card_selector_controller.dart';
import '../../../model/card/response/customer_card_response_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class ConfirmShaparakSubmitBottomSheetWidget extends StatelessWidget {
  const ConfirmShaparakSubmitBottomSheetWidget({
    required this.customerCard,
    required this.bankInfo,
    super.key,
  });

  final CustomerCard customerCard;
  final BankInfo bankInfo;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<SourceCardSelectorController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 36,
                    height: 4,
                    decoration:
                        BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.isDarkMode
                        ? context.theme.colorScheme.surface
                        : context.theme.textTheme.displayLarge!.color!.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgIcon(
                      SvgIcons.cardBalance,
                      colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  locale.register_selected_card,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                 locale.card_not_registered,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? context.theme.colorScheme.surface
                        : context.theme.colorScheme.surface.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                customerCard.title ?? '',
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Text(
                              AppUtil.splitCardNumber(customerCard.cardNumber!, ' - '),
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            SvgPicture.network(
                              AppUtil.baseUrlStatic() + bankInfo.symbol!,
                              semanticsLabel: '',
                              height: 30.0,
                              width: 30.0,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 56.0,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.submitShaparakCard(customerCard);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          child:  Text(
                            locale.yes,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: context.theme.iconTheme.color!),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Center(
                                child: Text(
                                  locale.no,
                                  style: TextStyle(
                                    color: context.theme.iconTheme.color,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
