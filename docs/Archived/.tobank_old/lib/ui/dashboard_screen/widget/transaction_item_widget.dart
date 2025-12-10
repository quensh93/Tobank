import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/transaction/response/transaction_data.dart';
import '../../../util/app_util.dart';
import '../../../util/persian_date.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class TransactionItemWidget extends StatelessWidget {
  TransactionItemWidget({
    required this.transactionData,
    required this.returnDataFunction,
    super.key,
  });

  final TransactionData transactionData;
  final Function(TransactionData transactionData) returnDataFunction;

  final successIcon = Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgIcon(
        Get.isDarkMode ? SvgIcons.transactionItemSuccessDark : SvgIcons.transactionItemSuccess,
        size: 28,
      ),
    ),
  );
  final failIcon = Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgIcon(
        Get.isDarkMode ? SvgIcons.transactionItemFailedDark : SvgIcons.transactionItemFailed,
        size: 28,
      ),
    ),
  );
  final warningIcon = Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgIcon(
        Get.isDarkMode ? SvgIcons.transactionItemPendingDark : SvgIcons.transactionItemPending,
        size: 28,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PersianDate persianDate = PersianDate();
    final String date = transactionData.trDate!.toString().split('+')[0];
    final String persianDateString = persianDate.parseToFormat(date, 'd MM yyyy - HH:nn');
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          returnDataFunction(transactionData);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 8.0),
          child: Row(
            children: <Widget>[
              if (transactionData.trStatus == 'success')
                successIcon
              else
                transactionData.trStatus == 'error' ? failIcon : warningIcon,
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            '${transactionData.service}',
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Text(
                          locale.amount_format(AppUtil.formatMoney(transactionData.trAmount)),
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      persianDateString,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
