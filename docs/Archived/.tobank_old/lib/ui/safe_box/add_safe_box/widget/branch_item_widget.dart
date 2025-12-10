import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/safe_box/response/branch_list_response_data.dart';
import '../../../../../util/theme/theme_util.dart';

class BranchItemWidget extends StatelessWidget {
  const BranchItemWidget({
    required this.branchResult,
    required this.returnDataFunction,
    super.key,
    this.selectedBranchResult,
  });

  final BranchResult branchResult;
  final BranchResult? selectedBranchResult;
  final Function(BranchResult branchResult) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: selectedBranchResult != null && selectedBranchResult!.id == branchResult.id
              ? context.theme.colorScheme.secondary
              : context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        onTap: () {
          returnDataFunction(branchResult);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${branchResult.title!} - ${branchResult.code.toString()}',
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      branchResult.city!.name!,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
