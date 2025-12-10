import 'package:flutter/material.dart';

import '../../../../../../model/card_color_data.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../widget/svg/svg_icon.dart';

class CardColorItemWidget extends StatelessWidget {
  const CardColorItemWidget({
    required this.cardColorData,
    required this.index,
    required this.returnDataFunction,
    this.selectedCardColorData,
    super.key,
  });

  final CardColorData cardColorData;
  final int index;
  final CardColorData? selectedCardColorData;
  final Function(int index, CardColorData selectedCardColorData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        returnDataFunction(index, cardColorData);
      },
      child: Tooltip(
        message: cardColorData.cardName,
        child: Container(
          height: selectedCardColorData != null && selectedCardColorData!.cardId == cardColorData.cardId ? 40.0 : 24.0,
          width: selectedCardColorData != null && selectedCardColorData!.cardId == cardColorData.cardId ? 40.0 : 24.0,
          decoration: BoxDecoration(
            color: AppUtil.colorHexConvert(cardColorData.cardColor),
            shape: BoxShape.circle,
          ),
          child: selectedCardColorData != null && selectedCardColorData!.cardId == cardColorData.cardId
              ? const SvgIcon(
                  SvgIcons.check,
                  size: 30.0,
                )
              : null,
        ),
      ),
    );
  }
}
