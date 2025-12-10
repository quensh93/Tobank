import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/close_deposit_type_item_data.dart';
import '../../../../util/theme/theme_util.dart';

class CloseDepositTypeItemWidget extends StatelessWidget {
  const CloseDepositTypeItemWidget({
    required this.closeDepositTypeItemData,
    required this.returnDataFunction,
    super.key,
    this.selectedCloseDepositTypeItemData,
  });

  final CloseDepositTypeItemData closeDepositTypeItemData;
  final CloseDepositTypeItemData? selectedCloseDepositTypeItemData;
  final Function(CloseDepositTypeItemData closeDepositTypeItemData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selectedCloseDepositTypeItemData != null &&
                  closeDepositTypeItemData.id == selectedCloseDepositTypeItemData!.id
              ? context.theme.colorScheme.secondary
              : context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        onTap: () {
          returnDataFunction(closeDepositTypeItemData);
        },
        child: Row(
          children: [
            Radio(
                activeColor: context.theme.colorScheme.secondary,
                value: closeDepositTypeItemData,
                groupValue: selectedCloseDepositTypeItemData,
                onChanged: (CloseDepositTypeItemData? closeDepositTypeItemData) {
                  returnDataFunction(closeDepositTypeItemData!);
                }),
            Flexible(
              child: Text(
                closeDepositTypeItemData.title,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
