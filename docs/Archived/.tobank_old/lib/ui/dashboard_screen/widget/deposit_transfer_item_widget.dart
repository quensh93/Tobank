import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/transfer/response/transfer_history_response_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class DepositTransferItemWidget extends StatelessWidget {
  const DepositTransferItemWidget({
    required this.transaction,
    required this.returnDataFunction,
    required this.checkTransactionStatusFunction,
    required this.selectedTransaction,
    required this.isLoading,
    super.key,
  });

  final Transaction transaction;
  final Transaction? selectedTransaction;
  final Function(Transaction transaction) returnDataFunction;
  final Function(Transaction transaction) checkTransactionStatusFunction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        onTap: () {
          returnDataFunction(transaction);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgIcon(
                    _getIcon(),
                    size: 28.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getTransferType(),
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            _getDestinationCustomer(),
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _getAmount(),
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTransferType() {
    return AppUtil.transferMethodDataList().where((element) => element.id == transaction.transferType).first.title;
  }

  String _getDestinationCustomer() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String customer = '${locale.transfer_to}'
        '${transaction.receiverFirstName!} ${transaction.receiverLastName!}';
    return customer;
  }

  SvgIcons _getIcon() {
    if (transaction.financialTransactionStatus == 1) {
      return Get.isDarkMode ? SvgIcons.transactionItemSuccessDark : SvgIcons.transactionItemSuccess;
    } else if (transaction.financialTransactionStatus == 0) {
      return Get.isDarkMode ? SvgIcons.transactionItemFailedDark : SvgIcons.transactionItemFailed;
    } else {
      return Get.isDarkMode ? SvgIcons.transactionItemPendingDark : SvgIcons.transactionItemPending;
    }
  }

  String _getAmount() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    return locale.amount_format(AppUtil.formatMoney(transaction.amount));
  }
}
