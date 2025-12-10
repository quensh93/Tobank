import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/card/card_block_reason_data.dart';
import '../../../util/theme/theme_util.dart';

class CardBlockReasonItemWidget extends StatelessWidget {
  const CardBlockReasonItemWidget({
    required this.cardBlockReasonData,
    required this.selectedCardBlockReasonData,
    required this.returnDataFunction,
    required this.borderColor,
    super.key,
  });

  final CardBlockReasonData cardBlockReasonData;
  final CardBlockReasonData selectedCardBlockReasonData;
  final Function(CardBlockReasonData cardBlockReasonData) returnDataFunction;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.0,
      child: InkWell(
        onTap: () {
          returnDataFunction(cardBlockReasonData);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Radio(
                activeColor: context.theme.colorScheme.secondary,
                value: cardBlockReasonData,
                groupValue: selectedCardBlockReasonData,
                onChanged: (CardBlockReasonData? value) {
                  returnDataFunction(value!);
                },
              ),
              Text(
                cardBlockReasonData.title,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
