import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/invoice/bill_type_data.dart';
import '../../../util/theme/theme_util.dart';

class BillTypeItemWidget extends StatelessWidget {
  const BillTypeItemWidget({
    required this.billTypeData,
    required this.selectedBillTypeData,
    required this.returnDataFunction,
    super.key,
  });

  final BillTypeData billTypeData;
  final BillTypeData selectedBillTypeData;
  final Function(BillTypeData billTypeData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        returnDataFunction(billTypeData);
      },
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        color: billTypeData.id == selectedBillTypeData.id
            ? context.theme.colorScheme.secondary
            : context.theme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Center(
            child: Text(
              billTypeData.title,
              style: TextStyle(
                color: billTypeData.id == selectedBillTypeData.id ? Colors.white : ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
