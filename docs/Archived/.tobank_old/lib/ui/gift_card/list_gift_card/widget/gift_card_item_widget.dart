import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/gift_card/response/list_gift_card_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/persian_date.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class GiftCardItemWidget extends StatelessWidget {
  const GiftCardItemWidget({
    required this.physicalGiftCardData,
    required this.showDetailFunction,
    super.key,
  });

  final PhysicalGiftCardData physicalGiftCardData;
  final Function(PhysicalGiftCardData physicalGiftCardData) showDetailFunction;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    String persianDateString;
    if (physicalGiftCardData.createdAt != null) {
      final PersianDate persianDate = PersianDate();
      persianDateString =
          persianDate.parseToFormat(physicalGiftCardData.createdAt!.split('+')[0].split('.')[0], 'd MM yyyy - HH:nn');
    } else {
      persianDateString = ' ';
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () {
          showDetailFunction(physicalGiftCardData);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      locale.gift_card,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
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
              Container(
                decoration: BoxDecoration(
                  color: AppUtil.colorHexConvert(physicalGiftCardData.statusColor).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppUtil.colorHexConvert(physicalGiftCardData.statusColor)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    physicalGiftCardData.statusFa ?? '-',
                    style: TextStyle(
                      color: AppUtil.colorHexConvert(physicalGiftCardData.statusColor),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                height: 16.0,
                width: 2.0,
                decoration: BoxDecoration(color: context.theme.dividerColor),
              ),
              const SizedBox(width: 8.0),
              SvgIcon(
                SvgIcons.arrowLeft,
                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
