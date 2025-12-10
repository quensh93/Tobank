import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../model/wallet/response/wallet_balance_response_data.dart';
import '../../../../../service/core/api_exception.dart';
import '../../../../../service/core/api_result_model.dart';
import '../../../../../service/wallet_services.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/snack_bar_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../core/theme/main_theme.dart';

class WalletPaymentWidget extends StatefulWidget {
  final int amount;
  final Function onTap;
  final bool isFromWallet;

  const WalletPaymentWidget({
    required this.amount,
    required this.onTap,
    required this.isFromWallet,
    super.key,
  });

  @override
  State<WalletPaymentWidget> createState() => _WalletPaymentWidgetState();
}

class _WalletPaymentWidgetState extends State<WalletPaymentWidget> {
  bool walletLoading = true;
  int currentAmount = 0;

  @override
  void initState() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    WalletServices.getWalletBalance().then(
      (result) {
        setState(() {
          walletLoading = false;
        });
        switch (result) {
          case Success(value: (final WalletBalanceResponseData response, int _)):
            // walletBalanceResponseData = response;
            setState(() {
              currentAmount = response.data!.amount ?? 0;
            });
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (currentAmount >= widget.amount) {
          setState(() {
            widget.onTap(currentAmount);
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: (widget.isFromWallet && (currentAmount < widget.amount))
              ? MainTheme.of(context).primary.withAlpha(20)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: widget.isFromWallet
                    ? currentAmount >= widget.amount
                        ? MainTheme.of(context).secondary
                        : MainTheme.of(context).primary
                    : MainTheme.of(context).onSurfaceVariant),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: ShapeDecoration(
                color: const Color(0xfff2f4f7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Center(
                child: SvgIcon(SvgIcons.chargeWalletIcon,
                    size: 24.0,
                    color: (currentAmount >= widget.amount) ? null : MainTheme.of(context).surfaceContainer),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locale.wallet,
                  textAlign: TextAlign.right,
                  style: MainTheme.of(context).textTheme.titleSmall.copyWith(
                      color: (currentAmount >= widget.amount)
                          ? MainTheme.of(context).black
                          : MainTheme.of(context).surfaceContainer.withOpacity(0.3)),
                )
              ],
            ),
            const Spacer(),
            Text(
              locale.amount_format(AppUtil.formatMoney(currentAmount.toString())),
              textAlign: TextAlign.center,
              style: MainTheme.of(context).textTheme.titleLarge.copyWith(
                  color:
                      (currentAmount >= widget.amount) ? MainTheme.of(context).black : MainTheme.of(context).surfaceContainer.withOpacity(0.3)),
            ),
          ],
        ),
      ),
    );
  }
}
