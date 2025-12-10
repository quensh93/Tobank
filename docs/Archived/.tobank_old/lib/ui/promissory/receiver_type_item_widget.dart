import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/enums_constants.dart';
import '../../../util/theme/theme_util.dart';

class ReceiverTypeItemWidget extends StatelessWidget {
  const ReceiverTypeItemWidget({
    required this.title,
    required this.receiverType,
    required this.setSelectedReceiverType,
    required this.selectedReceiverType,
    super.key,
  });

  final String title;
  final PromissoryCustomerType? selectedReceiverType;
  final PromissoryCustomerType receiverType;
  final Function() setSelectedReceiverType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.0,
      child: InkWell(
        onTap: () {
          setSelectedReceiverType();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.theme.dividerColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Radio(
                activeColor: context.theme.colorScheme.secondary,
                value: receiverType,
                groupValue: selectedReceiverType,
                onChanged: (PromissoryCustomerType? value) {
                  setSelectedReceiverType();
                },
              ),
              Text(
                title,
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
