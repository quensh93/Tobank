import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/bank_branch_list_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class BankBranchItemWidget extends StatelessWidget {
  const BankBranchItemWidget({required this.bankBranchListData, required this.returnDataFunction, super.key});

  final BankBranchListData bankBranchListData;
  final Function(BankBranchListData bankBranchListData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: InkWell(
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
              const Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      bankBranchListData.address ?? '',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0, color: ThemeUtil.textSubtitleColor),
                    ),
                  ),
                  SvgIcon(
                    SvgIcons.arrowLeft,
                    colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                    size: 32.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
