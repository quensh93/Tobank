import 'package:flutter/material.dart';

import '../../util/theme/theme_util.dart';

class KeyValueWidget extends StatelessWidget {
  const KeyValueWidget({
    required this.keyString,
    required this.valueString,
    super.key,
    this.valueFontSize,
    this.ltrDirection,
  });

  final String keyString;
  final String? valueString;
  final double? valueFontSize;
  final bool? ltrDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          keyString,
          style: TextStyle(
            color: ThemeUtil.textSubtitleColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            height: 1.4,
          ),
        ),
        Flexible(
          child: Text(
            valueString ?? '',
            style: TextStyle(
              color: ThemeUtil.textTitleColor,
              fontWeight: FontWeight.w600,
              fontSize: valueFontSize ?? 16.0,
              height: 1.4,
            ),
            textAlign: TextAlign.left,
            textDirection: ltrDirection == true ? TextDirection.ltr : TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}
