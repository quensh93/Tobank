import 'package:flutter/material.dart';

import '../../../../../model/bpms/bpms_warranty_data.dart';
import '../../../../../util/theme/theme_util.dart';

class WarrantyItemWidget extends StatelessWidget {
  const WarrantyItemWidget({
    required this.warrantyData,
    required this.returnDataFunction,
    super.key,
    this.selectedWarrantyData,
  });

  final BPMSWarrantyData warrantyData;
  final BPMSWarrantyData? selectedWarrantyData;
  final Function(BPMSWarrantyData warrantyData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        returnDataFunction(warrantyData);
      },
      child: Container(
        height: 48.0,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          onTap: () {
            returnDataFunction(warrantyData);
          },
          child: Center(
            child: Text(
              warrantyData.title,
              style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 14.0),
            ),
          ),
        ),
      ),
    );
  }
}
