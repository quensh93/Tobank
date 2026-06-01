import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/app_util.dart';
import '../../util/enums_constants.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    required this.currentPaymentType,
    required this.currentAmount,
    required this.canPayWithDeposit,
    required this.canPayWithWallet,
    required this.canPayWithGateway,
    required this.setCurrentPaymentTypeFunction,
    super.key,
  });

  final PaymentType currentPaymentType;
  final Function(PaymentType paymentType) setCurrentPaymentTypeFunction;
  final int currentAmount;
  final bool canPayWithDeposit;
  final bool canPayWithWallet;
  final bool canPayWithGateway;

  Color _itemBorderColor(BuildContext context, PaymentType type) {
    if (currentPaymentType == type) {
      return context.theme.colorScheme.secondary;
    }
    return Get.isDarkMode ? const Color(0xFF344054) : const Color(0xFF98A2B3);
  }

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (canPayWithWallet) ...[
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setCurrentPaymentTypeFunction(PaymentType.wallet);
                  },
                  child: Container(
                    height: 64.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: currentPaymentType == PaymentType.wallet
                          ? context.theme.colorScheme.secondary.withOpacity(0.15)
                          : Colors.transparent,
                      border: Border.all(
                        color: _itemBorderColor(context, PaymentType.wallet),
                        width: 1.3,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            elevation: Get.isDarkMode ? 1 : 0,
                            shadowColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.walletDark : SvgIcons.wallet,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Text(
                              locale.wallet,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(AppUtil.formatMoney(currentAmount),
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(
                                locale.rial,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ],
        if (canPayWithGateway) ...[
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setCurrentPaymentTypeFunction(PaymentType.gateway);
                  },
                  child: Container(
                    height: 64.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: currentPaymentType == PaymentType.gateway
                          ? context.theme.colorScheme.secondary.withOpacity(0.15)
                          : Colors.transparent,
                      border: Border.all(
                        color: _itemBorderColor(context, PaymentType.gateway),
                        width: 1.3,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            elevation: Get.isDarkMode ? 1 : 0,
                            shadowColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.gatewayDark : SvgIcons.gateway,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            locale.bank_portal,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ],
        if (canPayWithDeposit) ...[
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setCurrentPaymentTypeFunction(PaymentType.deposit);
                  },
                  child: Container(
                    height: 64.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: currentPaymentType == PaymentType.deposit
                          ? context.theme.colorScheme.secondary.withOpacity(0.15)
                          : Colors.transparent,
                      border: Border.all(
                        color: _itemBorderColor(context, PaymentType.deposit),
                        width: 1.3,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            elevation: Get.isDarkMode ? 1 : 0,
                            shadowColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.gatewayDark : SvgIcons.gateway,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            locale.deposit,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ],
    );
  }
}
