import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../util/theme/theme_util.dart';

class CBSReportTypeWidget extends StatelessWidget {
  const CBSReportTypeWidget({
    required this.title,
    required this.isSelected,
    required this.callback,
    super.key,
  });

  final String title;
  final bool isSelected;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      onTap: () {
        callback();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(8)),
          color: isSelected ? context.theme.colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
          border: Border.all(
            color: isSelected ? context.theme.colorScheme.secondary : context.theme.dividerColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? context.theme.colorScheme.secondary : ThemeUtil.textTitleColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
