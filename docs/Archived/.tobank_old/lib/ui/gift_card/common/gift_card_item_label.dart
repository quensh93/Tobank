import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/gift_card/response/list_message_gift_card_data.dart';
import '../../../util/theme/theme_util.dart';

class GiftCardItemLabelWidget extends StatelessWidget {
  const GiftCardItemLabelWidget({
    required this.messageData,
    required this.selectedMessageData,
    required this.returnDataFunction,
    super.key,
  });

  final MessageData? selectedMessageData;
  final MessageData messageData;
  final Function(MessageData messageData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        returnDataFunction(messageData);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: context.theme.dividerColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Row(
            children: [
              Radio<MessageData>(
                activeColor: context.theme.colorScheme.secondary,
                groupValue: selectedMessageData,
                value: messageData,
                onChanged: (MessageData? newValue) {
                  returnDataFunction(newValue!);
                },
              ),
              Flexible(
                child: Text(
                  messageData.description ?? '',
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    height: 1.6,
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
