import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/common/operator_data.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class OperatorItemWidget extends StatelessWidget {
  const OperatorItemWidget({
    required this.operatorData,
    required this.returnDataFunction,
    super.key,
    this.selectedOperatorData,
  });

  final OperatorData operatorData;
  final OperatorData? selectedOperatorData;
  final Function(OperatorData operatorData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
      onTap: () {
        returnDataFunction(operatorData);
      },
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedOperatorData != null && operatorData.id == selectedOperatorData!.id
                ? context.theme.colorScheme.secondary
                : context.theme.dividerColor,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: context.theme.dividerColor, width: 0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  operatorData.icon!,
                  height: 24.0,
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                operatorData.title!,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (selectedOperatorData != null && operatorData.id == selectedOperatorData!.id)
              SvgIcon(
                SvgIcons.tickCircle,
                colorFilter: ColorFilter.mode(context.theme.colorScheme.secondary, BlendMode.srcIn),
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }
}
