import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_balance/card_balance_controller.dart';
import '../../../util/app_theme.dart';
import '../../../util/app_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../../widget/ui/dotted_line_widget.dart';
import '../../common/key_value_widget.dart';

class CardBalanceResultPage extends StatelessWidget {
  const CardBalanceResultPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardBalanceController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (Get.isDarkMode)
                const SvgIcon(
                  SvgIcons.tobankWhite,
                  size: 32.0,
                )
              else
                const SvgIcon(
                  SvgIcons.tobankRed,
                  size: 32.0,
                ),
              RepaintBoundary(
                key: controller.globalKey,
                child: Card(
                  elevation: 1,
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
                         Row(
                          children: [
                            const SvgIcon(
                              SvgIcons.transactionSuccess,
                              colorFilter: ColorFilter.mode(AppTheme.successColor, BlendMode.srcIn),
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              locale.operation_done_successful,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppTheme.successColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        MySeparator(
                          color: context.theme.iconTheme.color,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.balance_amount,
                          valueString:
                              locale.amount_format(AppUtil.formatMoney(controller.cardBalanceResponseModel.data!.result!.availableBalance)),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.transaction_time,
                          valueString: controller.getNowDateTime(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.captureAndSharePng();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.inventory_sharing,
              ),
            ],
          ),
        );
      },
    );
  }
}
