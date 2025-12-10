import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/operator_data.dart';
import '../../model/contact_match/list_stored_contact_data.dart';
import '../../util/data_constants.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class FavContactItem extends StatelessWidget {
  const FavContactItem({
    required this.storedContactData,
    required this.returnDataFunction,
    required this.removeDataFunction,
    super.key,
  });

  final StoredContactData storedContactData;
  final Function(StoredContactData storedContactData) returnDataFunction;
  final Function(StoredContactData storedContactData) removeDataFunction;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    final String? operatorName = DataConstants.simCardData[storedContactData.phoneNumber!.substring(0, 4)];
    OperatorData? operatorData;
    if (operatorName == locale.mtn) {
      operatorData = DataConstants.getOperatorDataList()[0];
    } else if (operatorName == locale.mci) {
      operatorData = DataConstants.getOperatorDataList()[1];
    } else if (operatorName == locale.rightel) {
      operatorData = DataConstants.getOperatorDataList()[2];
    } else if (operatorName == locale.shatel) {
      operatorData = DataConstants.getOperatorDataList()[3];
    }
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        returnDataFunction(storedContactData);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.theme.dividerColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: operatorData != null
                      ? Image.asset(
                          operatorData.icon!,
                          height: 24.0,
                        )
                      : const SizedBox(height: 24.0, width: 24.0),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      operatorData != null ? operatorData.title ?? '' : '',
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      storedContactData.phoneNumber ?? '',
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  removeDataFunction(storedContactData);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgIcon(
                    SvgIcons.delete,
                    colorFilter: ColorFilter.mode(ThemeUtil.primaryColor, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
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
