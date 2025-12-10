import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../../../core/widgets/buttons/main_button.dart';
import '../select_sim_type/select_sim_type_bottom_sheet.dart';
class SelectOperatorBottomSheet extends StatefulWidget {
  const SelectOperatorBottomSheet({required this.phone,required this.chargeAndPackageType, super.key});

  final String phone;
  final ChargeAndPackageType chargeAndPackageType;

  @override
  State<SelectOperatorBottomSheet> createState() => _SelectOperatorBottomSheetState();
}

class _SelectOperatorBottomSheetState extends State<SelectOperatorBottomSheet> {
  OperatorType operatorType = OperatorType.RIGHTEL;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: MainTheme.of(context).onSurfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              locale.operator,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
            locale.porting_operator_instruction,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                operatorItemWidget(
                  title: locale.mci_fa,
                  iconData: SvgIcons.icHamrahAval,
                  type: OperatorType.MCI,
                  isDisable: true,

                ),
                const SizedBox(height: 16),
                operatorItemWidget(
                  title:locale.iran_cell,
                  iconData: SvgIcons.icIrancell,
                  type: OperatorType.MTN,
                  isDisable: true,
                ),
                const SizedBox(height: 16),
                operatorItemWidget(
                  title: locale.rightel_fa,
                  iconData: SvgIcons.icRightel,
                  type: OperatorType.RIGHTEL,
                ),
              ],
            ),
            MainButton(
              title: locale.confirm_continue,
              onTap: () {
                Get.back();
                showMainBottomSheet(
                    context: context,
                    bottomSheetWidget:  SelectSimTypeBottomSheet(
                      phone: widget.phone,
                      operatorType: operatorType, chargeAndPackageType: widget.chargeAndPackageType,
                    ));
              },
              disable: false,
            )
          ],
        ),
      ),
    );
  }

  Widget operatorItemWidget({
    required String title,
    required OperatorType type,
    required SvgIcons iconData,
    bool isDisable = false,
  }) {
    return InkWell(
      onTap: () {
        if(!isDisable){
          setState(() {
            operatorType = type;
          });
        }
      },
      child: Opacity(
        opacity: isDisable ? 0.5 : 1,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: type == operatorType ? MainTheme.of(context).secondary : MainTheme.of(context).surfaceContainerLowest,
              )),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: MainTheme.of(context).white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: MainTheme.of(context).surfaceContainerLowest)),
                padding: const EdgeInsets.all(8),
                child: SvgIcon(
                  iconData,
                  size: 17.0,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                textAlign: TextAlign.right,
                style: MainTheme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              if (type == operatorType)
                Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: type == operatorType ? MainTheme.of(context).secondary : MainTheme.of(context).surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.check , color: Colors.white,size: 15,),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
