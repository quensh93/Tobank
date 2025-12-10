import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/card/response/customer_card_response_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class CardNotebookItem extends StatelessWidget {
  const CardNotebookItem({
    required this.customerCard,
    required this.bankInfoList,
    required this.isDeleteLoading,
    required this.editCardDataFunction,
    required this.deleteCardDataFunction,
    required this.copyToClipboardFunction,
    super.key,
    this.selectedCustomerCard,
  });

  final CustomerCard customerCard;
  final CustomerCard? selectedCustomerCard;
  final bool isDeleteLoading;
  final Function(CustomerCard customerCard) editCardDataFunction;
  final Function(CustomerCard customerCard) deleteCardDataFunction;
  final Function(CustomerCard customerCard) copyToClipboardFunction;
  final List<BankInfo> bankInfoList;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    final bankInfo = bankInfoList.firstWhereOrNull((element) => element.id == customerCard.bankId);
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              color: context.theme.dividerColor,
            ),
          ),
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            onLongPress: () {
              copyToClipboardFunction(customerCard);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  if (bankInfo != null)
                    Card(
                      elevation: Get.isDarkMode ? 1 : 0,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.network(
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
                        ),
                      ),
                    )
                  else
                    const SizedBox(
                      height: 24.0,
                      width: 24.0,
                    ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          customerCard.title ?? '',
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          AppUtil.splitCardNumber(customerCard.cardNumber!, ' - '),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 16.0,
                    width: 2.0,
                    decoration: BoxDecoration(color: context.theme.dividerColor),
                  ),
                  PopupMenuButton<int>(
                    onSelected: (value) {
                      if (value == 1) {
                        editCardDataFunction(customerCard);
                      } else {
                        deleteCardDataFunction(customerCard);
                      }
                    },
                    position: PopupMenuPosition.under,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(locale.edit_card,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeUtil.textTitleColor,
                                )),
                            const SizedBox(
                              width: 8.0,
                            ),
                            SvgIcon(
                              Get.isDarkMode ? SvgIcons.editDark : SvgIcons.edit,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(locale.delete_card,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeUtil.textTitleColor,
                                )),
                            const SizedBox(
                              width: 8.0,
                            ),
                            const SvgIcon(SvgIcons.delete),
                          ],
                        ),
                      ),
                    ],
                    child: AbsorbPointer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          SvgIcons.moreOptions,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
