import 'package:flutter/material.dart';

import '../../../../model/transfer/purpose_data.dart';
import '../../../../util/theme/theme_util.dart';

class TransactionPurposeItemWidget extends StatelessWidget {
  const TransactionPurposeItemWidget({
    required this.purposeData,
    required this.selectPurposeFunction,
    super.key,
  });

  final PurposeData purposeData;
  final Function(PurposeData transactionPurpose) selectPurposeFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        selectPurposeFunction(purposeData);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Text(
          purposeData.title,
          style: TextStyle(
            color: ThemeUtil.textTitleColor,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
