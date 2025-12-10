import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/promissory/promissory_finalized_role_type_filter_item_data.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';

class PromissoryRoleTypeFilterWidget extends StatelessWidget {
  const PromissoryRoleTypeFilterWidget({
    required this.filterItemData,
    required this.selectedPromissoryRoleType,
    required this.returnDataFunction,
    super.key,
  });

  final PromissoryFinalizedRoleTypeFilterItemData filterItemData;
  final PromissoryRoleType? selectedPromissoryRoleType;
  final Function(PromissoryFinalizedRoleTypeFilterItemData filterItemData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    final isSelected = filterItemData.promissoryRoleType == selectedPromissoryRoleType;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        splashColor: Colors.grey.withOpacity(0.1),
        onTap: () {
          returnDataFunction(filterItemData);
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? context.theme.colorScheme.secondary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? context.theme.colorScheme.secondary : Colors.grey.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12.0,
            ),
            child: Opacity(
              opacity: isSelected ? 1 : 0.5,
              child: Text(
                filterItemData.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : ThemeUtil.textTitleColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
