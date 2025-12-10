import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/invoice/bill_type_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class InvoiceTypeSelectorWidget extends StatelessWidget {
  const InvoiceTypeSelectorWidget({
    required this.billTypeData,
    required this.returnDataFunction,
    super.key,
  });

  final BillTypeData billTypeData;
  final Function(BillTypeData billTypeData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        returnDataFunction(billTypeData);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.dividerColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: Get.isDarkMode ? 1 : 0,
                shadowColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgIcon(Get.isDarkMode ? billTypeData.iconDark : billTypeData.icon),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(billTypeData.title,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
