import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../util/theme/theme_util.dart';

class FilterWageRepaymentItemWidget extends StatelessWidget {
  const FilterWageRepaymentItemWidget(
      {required this.item, required this.selectedItem, required this.returnSelectedFunction, super.key, this.tail});

  final int item;
  final int? selectedItem;
  final String? tail;
  final Function(int) returnSelectedFunction;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = item == selectedItem;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          returnSelectedFunction(item);
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: isSelected ? context.theme.colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? context.theme.colorScheme.secondary : context.theme.disabledColor,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
          child: Center(
            child: Text('$item${tail ?? ''}',
                style: TextStyle(
                  color: isSelected ? context.theme.colorScheme.secondary : ThemeUtil.textTitleColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                )),
          ),
        ),
      ),
    );
  }
}
