import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/transaction/transaction_service_data.dart';
import '../../util/theme/theme_util.dart';

class TransactionTypeWidget extends StatelessWidget {
  const TransactionTypeWidget({
    required this.transactionServiceData,
    required this.selectedItems,
    required this.returnDataFunction,
    super.key,
  });

  final TransactionServiceData transactionServiceData;
  final List<int> selectedItems;
  final Function(TransactionServiceData transactionServiceData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
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
          returnDataFunction(transactionServiceData);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(8)),
            color: selectedItems.contains(transactionServiceData.id)
                ? context.theme.colorScheme.secondary
                : Colors.transparent,
            border: Border.all(
              color: selectedItems.contains(transactionServiceData.id)
                  ? Colors.transparent
                  : context.theme.colorScheme.surface,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Opacity(
              opacity: selectedItems.contains(transactionServiceData.id) ? 1 : 0.5,
              child: Text(
                transactionServiceData.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedItems.contains(transactionServiceData.id) ? Colors.white : ThemeUtil.textSubtitleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
