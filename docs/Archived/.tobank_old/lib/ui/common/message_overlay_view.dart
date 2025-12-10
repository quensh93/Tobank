import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/theme/theme_util.dart';

class MessageNotification extends StatelessWidget {
  const MessageNotification({
    required this.onReply,
    required this.message,
    required this.buttonText,
    super.key,
  });

  final VoidCallback onReply;
  final String message;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Card(
          color: context.theme.colorScheme.surface,
          elevation: 2,
          margin: const EdgeInsets.only(top: 8, left: 8.0, right: 8.0, bottom: 64.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.info_rounded,
                  color: ThemeUtil.primaryColor,
                  size: 32.0,
                ),
                Flexible(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      height: 1.6,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    onReply();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: context.theme.colorScheme.secondary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
