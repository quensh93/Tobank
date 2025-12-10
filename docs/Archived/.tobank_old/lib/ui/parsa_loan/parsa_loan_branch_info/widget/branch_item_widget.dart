import 'package:flutter/material.dart';

import '../../../../../model/bpms/parsa_loan/response/branch_list_response_data.dart';
import '../../../../../util/theme/theme_util.dart';

class BankBranchItemWidget extends StatelessWidget {
  const BankBranchItemWidget({required this.bankBranchListData, required this.returnDataFunction, super.key});

  final BranchData bankBranchListData;
  final Function(BranchData bankBranchListData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        returnDataFunction(bankBranchListData);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${bankBranchListData.faTitle!} - ${bankBranchListData.code}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0, color: ThemeUtil.textTitleColor),
                ),
                const Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
